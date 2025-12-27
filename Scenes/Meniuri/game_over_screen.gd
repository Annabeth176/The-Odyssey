extends Control

@export var main_menu_path: String = "res://Scenes/Meniuri/main_menu.tscn"

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Găsim butoanele automat
	var buttons = find_children("*Button", "Button", true, false)
	
	for button in buttons:
		if "Restart" in button.name or "Retry" in button.name:
			button.pressed.connect(_on_restart_pressed)
		elif "MainMenu" in button.name or "Menu" in button.name:
			button.pressed.connect(_on_main_menu_pressed)

func show_game_over(final_score: int = 0) -> void:
	visible = true
	# Actualizează scorul dacă există label
	if has_node("Panel/VBoxContainer/ScoreLabel"):
		$Panel/VBoxContainer/ScoreLabel.text = "Score: " + str(final_score)

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu_path)
