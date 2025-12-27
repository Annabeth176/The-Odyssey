extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Pornește muzica de adventure
	var level1_music = preload("res://Audio/Music/Level1.mp3")
	level1_music.loop = true
	AudioManager.play_music(level1_music)
