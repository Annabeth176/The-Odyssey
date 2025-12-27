extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	#Conectam butonul Start daca exista
	if has_node("Panel/VBoxContainer/StartButton"):
		$Panel/VBoxContainer/StartButton.pressed.connect(_on_start_pressed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_on_start_pressed()

func _on_start_pressed() -> void:
	visible = false
	get_tree().paused = false
