extends Area2D

# Calea către nivelul 2 (runner-ul)
@export var next_level_path: String = "res://Scenes/Levels/level_2.tscn"

func _ready() -> void:
	# Conectăm semnalul când playerul intră în portal
	body_entered.connect(_on_body_entered)
	print("Portal ready! Calea: ", next_level_path)

func _on_body_entered(body: Node2D) -> void:
	print("Ceva a intrat în portal: ", body.name)
	# Verificăm dacă e player-ul
	if body is Player:
		print("E player-ul! Schimbare scenă...")
		# Verificăm dacă fișierul există
		if ResourceLoader.exists(next_level_path):
			# Salvăm progresul - Level 1 completat!
			SaveManager.unlock_level_2()
			get_tree().change_scene_to_file(next_level_path)
		else:
			print("EROARE: Scena nu există la calea: ", next_level_path)
