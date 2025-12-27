extends Control

@export var main_menu_path: String = "res://Scenes/Meniuri/main_menu.tscn"

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Găsim butoanele automat
	var buttons = find_children("*Button", "Button", true, false)
	print("Butoane găsite în WinScreen:", buttons.size())
	
	for button in buttons:
		print("Buton găsit:", button.name)
		if "Restart" in button.name:
			button.pressed.connect(_on_restart_pressed)
			print("RestartButton conectat!")
		elif "MainMenu" in button.name or "Menu" in button.name:
			button.pressed.connect(_on_main_menu_pressed)
			print("MainMenuButton conectat!")

func _on_restart_pressed() -> void:
	print("Restart apăsat!")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	print("Main Menu apăsat!")
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu_path)
