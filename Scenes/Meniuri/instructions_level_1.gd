extends Control

func _ready() -> void:
	visible = true
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Conectăm butonul Start dacă există
	if has_node("Panel/VBoxContainer/StartButton"):
		$Panel/VBoxContainer/StartButton.pressed.connect(_on_start_pressed)

func _process(delta: float) -> void:
	# Sau poate începe cu orice tastă
	if Input.is_action_just_pressed("ui_accept"):
		_on_start_pressed()

func _on_start_pressed() -> void:
	visible = false
	get_tree().paused = false
