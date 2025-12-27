extends Node

const SAVE_PATH = "user://game_save.dat"

var level_2_unlocked: bool = false

func _ready() -> void:
	load_game()

func unlock_level_2() -> void:
	level_2_unlocked = true
	save_game()
	print("Level 2 deblocat!")

func is_level_2_unlocked() -> bool:
	return level_2_unlocked

func save_game() -> void:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if save_file:
		var save_data = {
			"level_2_unlocked": level_2_unlocked
		}
		save_file.store_var(save_data)
		save_file.close()
		print("Joc salvat!")

func load_game() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if save_file:
			var save_data = save_file.get_var()
			level_2_unlocked = save_data.get("level_2_unlocked", false)
			save_file.close()
			print("Joc încărcat! Level 2 unlocked:", level_2_unlocked)
	else:
		print("Nu există save file. Level 2 blocat.")

func reset_progress() -> void:
	level_2_unlocked = false
	save_game()
