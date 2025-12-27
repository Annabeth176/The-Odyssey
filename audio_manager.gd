extends Node

const SAVE_PATH = "user://audio_settings.dat"

# Volume settings (0.0 to 1.0)
var music_volume: float = 0.7
var sfx_volume: float = 0.8

# Audio buses
const MUSIC_BUS = "Music"
const SFX_BUS = "SFX"

# Audio players
var music_player: AudioStreamPlayer
var sfx_players: Array[AudioStreamPlayer] = []

func _ready() -> void:
	# Creează music player
	music_player = AudioStreamPlayer.new()
	music_player.bus = MUSIC_BUS
	add_child(music_player)
	
	# Creează pool de SFX players (pentru multiple sunete simultan)
	for i in range(8):
		var player = AudioStreamPlayer.new()
		player.bus = SFX_BUS
		add_child(player)
		sfx_players.append(player)
	
	load_settings()
	setup_audio_buses()

func setup_audio_buses() -> void:
	# Verifică și creează bus-urile dacă nu există
	var music_idx = AudioServer.get_bus_index(MUSIC_BUS)
	if music_idx == -1:
		AudioServer.add_bus()
		AudioServer.set_bus_name(AudioServer.bus_count - 1, MUSIC_BUS)
	
	var sfx_idx = AudioServer.get_bus_index(SFX_BUS)
	if sfx_idx == -1:
		AudioServer.add_bus()
		AudioServer.set_bus_name(AudioServer.bus_count - 1, SFX_BUS)
	
	apply_volume()

func apply_volume() -> void:
	var music_idx = AudioServer.get_bus_index(MUSIC_BUS)
	var sfx_idx = AudioServer.get_bus_index(SFX_BUS)
	
	if music_idx != -1:
		AudioServer.set_bus_volume_db(music_idx, linear_to_db(music_volume))
		AudioServer.set_bus_mute(music_idx, music_volume < 0.01)
	
	if sfx_idx != -1:
		AudioServer.set_bus_volume_db(sfx_idx, linear_to_db(sfx_volume))
		AudioServer.set_bus_mute(sfx_idx, sfx_volume < 0.01)

func set_music_volume(volume: float) -> void:
	music_volume = clamp(volume, 0.0, 1.0)
	apply_volume()

func set_sfx_volume(volume: float) -> void:
	sfx_volume = clamp(volume, 0.0, 1.0)
	apply_volume()

# Funcții pentru a reda muzică și sunete
func play_music(stream: AudioStream, loop: bool = true) -> void:
	if music_player.stream != stream:
		music_player.stream = stream
		music_player.play()

func stop_music() -> void:
	music_player.stop()

func play_sfx(stream: AudioStream) -> void:
	# Găsește un player liber
	for player in sfx_players:
		if not player.playing:
			player.stream = stream
			player.play()
			return

# Salvare/Încărcare setări
func save_settings() -> void:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if save_file:
		var save_data = {
			"music_volume": music_volume,
			"sfx_volume": sfx_volume
		}
		save_file.store_var(save_data)
		save_file.close()

func load_settings() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if save_file:
			var save_data = save_file.get_var()
			music_volume = save_data.get("music_volume", 0.7)
			sfx_volume = save_data.get("sfx_volume", 0.8)
			save_file.close()
			apply_volume()
