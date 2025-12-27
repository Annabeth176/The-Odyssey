extends Control

@export var main_menu_path: String = "res://Scenes/Meniuri/main_menu.tscn"

func _ready() -> void:
	# Ascundem meniul la început
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  # Funcționează chiar și când jocul e pausat
	
	# Conectăm butoanele
	$Panel/VBoxContainer/ResumeButton.pressed.connect(_on_resume_pressed)
	$Panel/VBoxContainer/RestartButton.pressed.connect(_on_restart_pressed)
	$Panel/VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_pressed)

func _process(delta: float) -> void:
	# Apăsăm ESC pentru a pausa/resuma
	if Input.is_action_just_pressed("ui_cancel"):  # ESC
		toggle_pause()

func toggle_pause() -> void:
	visible = !visible
	get_tree().paused = visible

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu_path)
