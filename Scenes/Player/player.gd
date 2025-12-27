extends CharacterBody2D
class_name Player

signal healthChanged(current_health: int, max_health: int)

# Mișcare
var direction: Vector2 = Vector2.ZERO
var speed: float = 400.0

# Viață
var health: int = 100
var max_health: int = 100
var can_take_damage: bool = true

# Noduri
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_timer: Timer = $DamageTimer
@onready var spawn_point: Marker2D = $Marker2D

# Poziție fixă a spawn-ului
var fixed_spawn_position: Vector2

func _ready() -> void:
	# Salvăm poziția inițială a spawn_point pentru a fi constantă
	if spawn_point != null:
		fixed_spawn_position = spawn_point.global_position
	else:
		# Dacă nu există spawn_point, folosește poziția actuală a player-ului
		fixed_spawn_position = global_position
		push_warning("Marker2D not found! Using player's initial position as spawn point.")
	
	# Conectăm timer-ul
	if damage_timer != null:
		damage_timer.timeout.connect(_on_DamageTimer_timeout)
	else:
		push_warning("DamageTimer not found! Please add a Timer node named 'DamageTimer' as a child of Player.")
	
	# Emite semnalul inițial pentru UI
	emit_signal("healthChanged", health, max_health)

func _physics_process(delta: float) -> void:
	# Mișcare
	direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = speed * direction
	
	# Animații
	if direction != Vector2.ZERO:
		if animated_sprite != null:
			animated_sprite.play("Walk")
			# Flip sprite based on direction
			if direction.x < 0:
				animated_sprite.flip_h = true
			elif direction.x > 0:
				animated_sprite.flip_h = false
	else:
		if animated_sprite != null:
			animated_sprite.play("Idle")
	
	move_and_slide()
	check_damage()

# Damage cu cooldown
func check_damage() -> void:
	if not can_take_damage:
		return
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision == null:
			continue
			
		var collider = collision.get_collider()
		if collider != null and collider.is_in_group("damage"):
			take_damage(5)
			break

# Funcție separată pentru a primi damage
func take_damage(amount: int) -> void:
	if not can_take_damage:
		return
	
	health -= amount
	health = max(health, 0)  # Asigură-te că nu merge sub 0
	emit_signal("healthChanged", health, max_health)
	print("Damage! Viata: ", health, "/", max_health)
	
	can_take_damage = false
	if damage_timer != null:
		damage_timer.start()
	
	if health <= 0:
		die()

# Timer expiră → putem lua din nou damage
func _on_DamageTimer_timeout() -> void:
	can_take_damage = true

# Moarte + respawn
func die() -> void:
	print("Player mort! Respawning...")
	# Oprește mișcarea
	velocity = Vector2.ZERO
	# Poți adăuga aici o animație de moarte dacă vrei
	respawn()

# Respawn la poziție fixă
func respawn() -> void:
	health = max_health
	can_take_damage = true
	velocity = Vector2.ZERO
	global_position = fixed_spawn_position
	emit_signal("healthChanged", health, max_health)
	print("Respawn complet! Viata: ", health, "/", max_health)

# Funcție utilă pentru heal (opțional)
func heal(amount: int) -> void:
	health += amount
	health = min(health, max_health)  # Nu depășește max_health
	emit_signal("healthChanged", health, max_health)
	print("Heal! Viata: ", health, "/", max_health)
