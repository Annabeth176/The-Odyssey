extends Control

@onready var music_slider: HSlider = $Panel/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $Panel/VBoxContainer/SFXSlider
@onready var back_button: Button = $Panel/VBoxContainer/BackButton

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	#Incarca setarile salvate
	music_slider.value = AudioManager.music_volume * 100
	sfx_slider.value = AudioManager.sfx_volume * 100

	#Conectam controalele
	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	back_button.pressed.connect(_on_back_pressed)

func show_settings() -> void:
	visible =true

func _on_music_changed(value: float) -> void:
	AudioManager.set_music_volume(value / 100.0)
	
func _on_sfx_changed(value: float) -> void:
	AudioManager.set_sfx_volume(value / 100.0)
	
func _on_back_pressed() -> void:
	AudioManager.save_settings()
	visible = false
