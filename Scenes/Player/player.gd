extends CharacterBody2D
class_name Player

signal healthChanged(current_health: int, max_health: int)  # trimitem viața curentă și maximul

# Mișcare
var direction: Vector2 = Vector2.ZERO
var speed: float = 400.0

# Viață
var health: int = 100
var max_health: int = 100
var can_take_damage: bool = true  # flag cooldown damage

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
		# Dacă nu există spawn_point, folosește coordonate implicite
		fixed_spawn_position = Vector2(100, 200)

	# Conectăm timer-ul
	if damage_timer != null:
		damage_timer.timeout.connect(Callable(self, "_on_DamageTimer_timeout"))
	else:
		push_warning("DamageTimer not found! Please add a Timer node named 'DamageTimer' as a child of Player.")

	# Respawn la început
	respawn()

func _process(delta: float) -> void:
	# Mișcare
	direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = speed * direction
	
	if direction != Vector2.ZERO:
		if animated_sprite != null:
			animated_sprite.play("Walk")
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
		var collider = get_slide_collision(i).get_collider()
		if collider != null and collider.is_in_group("damage"):
			health -= 5
			emit_signal("healthChanged", health, max_health)
			print("Damage! Viata:", health)
			can_take_damage = false
			if damage_timer != null:
				damage_timer.start()
			if health <= 0:
				die()
			break

# Timer expiră → putem lua din nou damage
func _on_DamageTimer_timeout() -> void:
	can_take_damage = true

# Moarte + respawn
func die() -> void:
	print("Player mort!")
	respawn()

# Respawn la poziție fixă
func respawn() -> void:
	health = max_health
	can_take_damage = true
	emit_signal("healthChanged", health, max_health)
	global_position = fixed_spawn_position
