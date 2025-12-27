extends Node2D

var table_scene = preload("res://Scenes/Obstacole/Table/table.tscn")
var vase_scene = preload("res://Scenes/Obstacole/Vase/vase.tscn")
var arrow_scene = preload("res://Scenes/Obstacole/Arrow/arrow.tscn")
var obstacle_types := [table_scene, vase_scene]
var obstacles : Array = []
var arrow_heights := [350, 450, 500]
const PLAYER2_START_POS := Vector2(150, 520)
const CAM_START_POS := Vector2(576, 324)
var difficulty : int
const MAX_DIFFICULTY : int = 2
var score : int
const SCORE_MODIFIER : int = 10
const WINNING_SCORE : int = 15000
var speed : float
const START_SPEED : float = 10.0
const MAX_SPEED : int = 25
const SPEED_MODIFIER : int = 5000
var screen_size : Vector2
var graund_height : int
var game_running : bool
var last_obs : Node2D = null
var ground_offset : float = 0.0

func _ready() -> void:
	screen_size = get_window().size
	graund_height = $Graund.get_node("Sprite2D").texture.get_height()
	var runner_music = preload("res://Audio/Music/Level2.mp3")
	runner_music.loop = true
	AudioManager.play_music(runner_music)
	new_game()

func new_game():
	score = 0
	$ScoreLabel.text = "Score: 0"
	game_running = false
	get_tree().paused = false
	difficulty = 0
	ground_offset = 0.0
	last_obs = null  # Inițializează last_obs
	
	# Curăță obstacolele existente
	for obs in obstacles:
		obs.queue_free()
	obstacles.clear()
	
	$Player2.position = PLAYER2_START_POS
	$Player2.velocity = Vector2(0, 0)
	$Camera2D.position = CAM_START_POS
	$Graund.position = Vector2(0, 0)
	
	# Ascunde ecranele
	if has_node("WinScreen"):
		$WinScreen.visible = false
	if has_node("GameOverScreen"):
		$GameOverScreen.visible = false

func _process(delta: float) -> void:
	if game_running:
		speed = START_SPEED + score / SPEED_MODIFIER
		speed = min(speed, MAX_SPEED)
		adjust_difficulty()
		generate_obs()
		
		# Mută ground-ul pentru efect de scroll infinit
		ground_offset += speed
		$Graund.position.x -= speed
		if ground_offset > screen_size.x:
			$Graund.position.x += screen_size.x
			ground_offset = 0
		
		# Mută toate obstacolele spre stânga
		for obs in obstacles:
			# Săgețile se mișcă mai repede
			if obs.name.begins_with("Arrow"):
				obs.position.x -= speed * 1.1
			else:
				obs.position.x -= speed
		
		score += speed
		
		# Verifică dacă a câștigat
		if score >= WINNING_SCORE:
			game_won()
			return
		
		# Actualizează scorul pe ecran
		$ScoreLabel.text = "Score: " + str(int(score))
		
		# Șterge obstacolele care au ieșit din ecran (la stânga)
		for obs in obstacles.duplicate():
			if obs.position.x < -100:
				remove_obs(obs)
	else:
		if Input.is_action_just_pressed("ui_accept"):
			game_running = true

func generate_obs():
	# Verifică dacă trebuie să genereze obstacole
	if obstacles.is_empty():
		spawn_obstacle_group()
	elif last_obs != null and last_obs.position.x < screen_size.x - randi_range(500, 700):
		spawn_obstacle_group()

func spawn_obstacle_group():
	var obs_type = obstacle_types[randi() % obstacle_types.size()]
	var num_obs = randi() % 3 + 1  # 1, 2, sau 3 obstacole
	
	for i in range(num_obs):
		var obs = obs_type.instantiate()
		var sprite = obs.get_node("Sprite2D")
		var obs_height = sprite.texture.get_height()
		var obs_scale = sprite.scale
		var obs_width = (sprite.texture.get_width() - 350) * obs_scale.x
		var obs_x : int = screen_size.x + (i * obs_width)
		var obs_y : int = screen_size.y - graund_height - (obs_height * obs_scale.y) / 4
		last_obs = obs
		add_obs(obs, obs_x, obs_y)
	
	# Săgeți apar după un scor minim
	if difficulty >= 1 and randi() % 3 == 0:
		var arrow = arrow_scene.instantiate()
		var arrow_x : int = screen_size.x + 200
		var arrow_y : int = arrow_heights[randi() % arrow_heights.size()]
		add_obs(arrow, arrow_x, arrow_y)

func add_obs(obs: Node2D, x: int, y: int):
	obs.position = Vector2(x, y)
	# Verifică dacă nu e deja conectat pentru a evita conexiuni multiple
	if not obs.body_entered.is_connected(hit_obs):
		obs.body_entered.connect(hit_obs)
	add_child(obs)
	obstacles.append(obs)

func remove_obs(obs):
	if obs != null and is_instance_valid(obs):
		obs.queue_free()
		obstacles.erase(obs)

func hit_obs(body):
	if body.name == "Player2":
		game_over()

func adjust_difficulty():
	difficulty = score / SCORE_MODIFIER
	difficulty = min(difficulty, MAX_DIFFICULTY)

func game_over():
	get_tree().paused = true
	game_running = false
	print("GAME OVER! Scor final:", int(score))
	
	# Arată ecranul de game over
	if has_node("GameOverScreen"):
		$GameOverScreen.show_game_over(int(score))
	else:
		print("ATENȚIE: GameOverScreen nu există în scenă!")

func game_won():
	get_tree().paused = true
	game_running = false
	print("VICTORIE! Scor final:", int(score))
	
	# Arată ecranul de victorie
	if has_node("WinScreen"):
		$WinScreen.visible = true
	else:
		print("ATENȚIE: WinScreen nu există în scenă!")
