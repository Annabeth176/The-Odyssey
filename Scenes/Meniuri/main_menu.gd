extends Control

var level1_path: String = "res://Scenes/Levels/level1.tscn"
var level2_path: String = "res://Scenes/Levels/level_2.tscn"

func _ready() -> void:
	var menu_music = preload("res://Audio/Music/Menu.mp3")
	menu_music.loop = true
	AudioManager.play_music(menu_music)
	$VBoxContainer/StartButton.pressed.connect(_on_start_pressed)
	$VBoxContainer/Level2Button.pressed.connect(_on_level2_pressed)
	
	# Buton Settings (dacă există)
	if has_node("VBoxContainer/SettingsButton"):
		$VBoxContainer/SettingsButton.pressed.connect(_on_settings_pressed)
	
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)
	
	# Buton de reset (opțional, pentru debug)
	if has_node("VBoxContainer/ResetButton"):
		$VBoxContainer/ResetButton.pressed.connect(_on_reset_pressed)
	
	# Verificăm dacă Level 2 e deblocat
	update_level2_button()

func update_level2_button() -> void:
	if SaveManager.is_level_2_unlocked():
		$VBoxContainer/Level2Button.disabled = false
		$VBoxContainer/Level2Button.text = "Level 2"
	else:
		$VBoxContainer/Level2Button.disabled = true
		$VBoxContainer/Level2Button.text = "Level 2 (Locked)"

func _on_reset_pressed() -> void:
	SaveManager.reset_progress()
	update_level2_button()
	print("Progres resetat!")

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(level1_path)

func _on_level2_pressed() -> void:
	get_tree().change_scene_to_file(level2_path)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	# Arată settings menu dacă există în scenă
	if has_node("SettingsMenu"):
		$SettingsMenu.show_settings()
