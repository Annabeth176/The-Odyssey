extends AnimatedSprite2D

func _ready():
	frame = randi() % sprite_frames.get_frame_count("fire")
	play("fire")
