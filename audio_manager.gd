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

# Flags pentru a preveni recursivitate
var is_setting_up: bool = false
var buses_created: bool = false

func _ready() -> void:
	print("AudioManager inițializat")
	
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
	
	# Încarcă setările ÎNAINTE de setup buses
	load_settings()
	
	# Setup buses cu defer pentru a evita probleme de timing
	call_deferred("setup_audio_buses")

func setup_audio_buses() -> void:
	# Previne apeluri multiple
	if is_setting_up or buses_created:
		return
	
	is_setting_up = true
	print("Setup audio buses...")
	
	# Verifică și creează bus-urile dacă nu există
	var music_idx = AudioServer.get_bus_index(MUSIC_BUS)
	if music_idx == -1:
		AudioServer.add_bus()
		music_idx = AudioServer.bus_count - 1
		AudioServer.set_bus_name(music_idx, MUSIC_BUS)
		print("Bus Music creat la index:", music_idx)
	
	var sfx_idx = AudioServer.get_bus_index(SFX_BUS)
	if sfx_idx == -1:
		AudioServer.add_bus()
		sfx_idx = AudioServer.bus_count - 1
		AudioServer.set_bus_name(sfx_idx, SFX_BUS)
		print("Bus SFX creat la index:", sfx_idx)
	
	buses_created = true
	is_setting_up = false
	
	# Aplică volume-ul DOAR după ce bus-urile sunt create
	apply_volume()

func apply_volume() -> void:
	# Nu aplica volume dacă bus-urile nu sunt create
	if not buses_created:
		print("Buses nu sunt încă create, skip apply_volume")
		return
	
	var music_idx = AudioServer.get_bus_index(MUSIC_BUS)
	var sfx_idx = AudioServer.get_bus_index(SFX_BUS)
	
	if music_idx != -1:
		var db_value = linear_to_db(music_volume) if music_volume > 0.01 else -80.0
		AudioServer.set_bus_volume_db(music_idx, db_value)
		AudioServer.set_bus_mute(music_idx, music_volume < 0.01)
		print("Music volume aplicat:", music_volume, "db:", db_value)
	else:
		push_warning("Music bus nu există!")
	
	if sfx_idx != -1:
		var db_value = linear_to_db(sfx_volume) if sfx_volume > 0.01 else -80.0
		AudioServer.set_bus_volume_db(sfx_idx, db_value)
		AudioServer.set_bus_mute(sfx_idx, sfx_volume < 0.01)
		print("SFX volume aplicat:", sfx_volume, "db:", db_value)
	else:
		push_warning("SFX bus nu există!")

func set_music_volume(volume: float) -> void:
	music_volume = clamp(volume, 0.0, 1.0)
	# Aplică doar dacă bus-urile sunt gata
	if buses_created:
		apply_volume()

func set_sfx_volume(volume: float) -> void:
	sfx_volume = clamp(volume, 0.0, 1.0)
	# Aplică doar dacă bus-urile sunt gata
	if buses_created:
		apply_volume()

# Funcții pentru a reda muzică și sunete
func play_music(stream: AudioStream, loop: bool = true) -> void:
	if stream == null:
		push_warning("Stream de muzică null!")
		return
	
	if music_player == null:
		push_error("Music player nu există!")
		return
	
	# Doar schimbă muzica dacă e diferită
	if music_player.stream != stream:
		music_player.stop()
		music_player.stream = stream
	
	if not music_player.playing:
		music_player.play()
		print("Muzică pornită:", stream.resource_path if stream.resource_path else "unknown")

func stop_music() -> void:
	if music_player != null and music_player.playing:
		music_player.stop()
		print("Muzică oprită")

func play_sfx(stream: AudioStream) -> void:
	if stream == null:
		push_warning("Stream SFX null!")
		return
	
	# Găsește un player liber
	for player in sfx_players:
		if not player.playing:
			player.stream = stream
			player.play()
			return
	
	# Dacă toate sunt ocupate, folosește primul
	if sfx_players.size() > 0:
		sfx_players[0].stream = stream
		sfx_players[0].play()

# Salvare/Încărcare setări
func save_settings() -> void:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if save_file == null:
		push_error("Nu pot salva setările audio!")
		return
	
	var save_data = {
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"version": 1
	}
	save_file.store_var(save_data)
	save_file.close()
	print("Setări audio salvate: Music=", music_volume, " SFX=", sfx_volume)

func load_settings() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("Nu există fișier de setări audio, folosesc valorile implicite")
		return
	
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if save_file == null:
		push_error("Nu pot încărca setările audio!")
		return
	
	var save_data = save_file.get_var()
	save_file.close()
	
	if save_data == null or not save_data is Dictionary:
		push_warning("Fișier de setări audio corupt!")
		return
	
	music_volume = save_data.get("music_volume", 0.7)
	sfx_volume = save_data.get("sfx_volume", 0.8)
	
	# Asigură că valorile sunt valide
	music_volume = clamp(music_volume, 0.0, 1.0)
	sfx_volume = clamp(sfx_volume, 0.0, 1.0)
	
	print("Setări audio încărcate: Music=", music_volume, " SFX=", sfx_volume)
