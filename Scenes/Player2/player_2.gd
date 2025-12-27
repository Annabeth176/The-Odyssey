extends CharacterBody2D 

const GRAVITY : int = 4200 
const JUMP_SPEED : int = -1600  # Redus de la -1800

func _physics_process(delta): 
	velocity.y += GRAVITY * delta 
	if is_on_floor(): 
		$Run.disabled = false 
		if Input.is_action_pressed("ui_accept"): 
			velocity.y = JUMP_SPEED 
		elif Input.is_action_pressed("ui_down"): 
			$AnimatedSprite2D.play("Drop") 
			$Run.disabled = true 
		else: 
			$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Walk")
	move_and_slide()
