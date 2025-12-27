extends TextureProgressBar

@export var player: Player  # poți seta manual

func _ready():
	if player == null:
		player = find_player_recursively(get_tree().current_scene)
	
	if player != null:
		connect_health_signal()
	else:
		get_tree().node_added.connect(Callable(self, "_on_node_added"))

func _on_node_added(node: Node) -> void:
	if player == null and node is Player:
		player = node
		connect_health_signal()
		get_tree().node_added.disconnect(Callable(self, "_on_node_added"))

# Funcție recursivă pentru a găsi Player-ul
func find_player_recursively(node: Node) -> Player:
	if node == null:
		return null
	if node is Player:
		return node
	for child in node.get_children():
		if child is Node:
			var result = find_player_recursively(child)
			if result != null:
				return result
	return null

func connect_health_signal() -> void:
	if player != null:
		player.healthChanged.connect(Callable(self, "_on_health_changed"))
		_on_health_changed(player.health, player.max_health)

func _on_health_changed(current_health: int, max_health: int) -> void:
	value = current_health
	max_value = max_health
