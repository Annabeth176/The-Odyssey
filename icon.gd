extends Sprite2D


var pos:Vector2 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = pos
	pos += Vector2(2,1)
