extends Node

const SFX_POOL_SIZE: int = 16
const PITCH_RANGE: Vector2 = Vector2(0.92, 1.08)
const MIN_VOLUME_DB: float = -80.0

var _sfx_pool: Array[AudioStreamPlayer2D] = []
var _ui_player: AudioStreamPlayer
var _music_player: AudioStreamPlayer
var _music_tween: Tween


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	for _i in SFX_POOL_SIZE:
		var player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		player.bus = &"SFX"
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		add_child(player)
		_sfx_pool.append(player)

	_ui_player = AudioStreamPlayer.new()
	_ui_player.bus = &"UI"
	_ui_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(_ui_player)

	_music_player = AudioStreamPlayer.new()
	_music_player.bus = &"Music"
	_music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(_music_player)

	get_tree().node_added.connect(_on_node_added)


func play_sfx(source: Variant, at_position: Vector2, volume_db: float = 0.0) -> void:
	var stream: AudioStream = _pick(source)
	if stream == null:
		return

	var player: AudioStreamPlayer2D = _get_free_player()
	player.stream = stream
	player.global_position = at_position
	player.volume_db = volume_db
	player.pitch_scale = randf_range(PITCH_RANGE.x, PITCH_RANGE.y)
	player.play()


func play_ui(source: Variant, volume_db: float = 0.0) -> void:
	var stream: AudioStream = _pick(source)
	if stream == null:
		return
	_ui_player.stream = stream
	_ui_player.volume_db = volume_db
	_ui_player.play()


func play_music(stream: AudioStream, fade_time: float = 1.0, loop: bool = true) -> void:
	if stream == null:
		return
	if _music_player.stream == stream && _music_player.playing:
		return

	_set_stream_loop(stream, loop)

	if _music_tween:
		_music_tween.kill()

	_music_player.stream = stream
	_music_player.volume_db = -40.0
	_music_player.play()

	_music_tween = create_tween()
	_music_tween.tween_property(_music_player, "volume_db", 0.0, fade_time)


func stop_music(fade_time: float = 1.0) -> void:
	if !_music_player.playing:
		return

	if _music_tween:
		_music_tween.kill()

	_music_tween = create_tween()
	_music_tween.tween_property(_music_player, "volume_db", MIN_VOLUME_DB, fade_time)
	_music_tween.tween_callback(_music_player.stop)


func set_bus_volume(bus_name: StringName, linear_volume: float) -> void:
	var index: int = AudioServer.get_bus_index(bus_name)
	if index < 0:
		return
	var volume_db: float = linear_to_db(clampf(linear_volume, 0.0, 1.0))
	AudioServer.set_bus_volume_db(index, maxf(volume_db, MIN_VOLUME_DB))


func get_bus_volume(bus_name: StringName) -> float:
	var index: int = AudioServer.get_bus_index(bus_name)
	if index < 0:
		return 0.0
	return db_to_linear(AudioServer.get_bus_volume_db(index))


func set_bus_muted(bus_name: StringName, muted: bool) -> void:
	var index: int = AudioServer.get_bus_index(bus_name)
	if index < 0:
		return
	AudioServer.set_bus_mute(index, muted)


func is_bus_muted(bus_name: StringName) -> bool:
	var index: int = AudioServer.get_bus_index(bus_name)
	return index >= 0 && AudioServer.is_bus_mute(index)


func _pick(source: Variant) -> AudioStream:
	if source is AudioStream:
		return source
	if source is Array && !source.is_empty():
		return source.pick_random()
	return null


func _get_free_player() -> AudioStreamPlayer2D:
	for player: AudioStreamPlayer2D in _sfx_pool:
		if !player.playing:
			return player
	return _sfx_pool.front()


func _set_stream_loop(stream: AudioStream, loop: bool) -> void:
	if stream is AudioStreamOggVorbis:
		stream.loop = loop
	elif stream is AudioStreamWAV:
		stream.loop_mode = AudioStreamWAV.LOOP_FORWARD if loop else AudioStreamWAV.LOOP_DISABLED


func _on_node_added(node: Node) -> void:
	if node is not BaseButton:
		return

	if node.has_meta(&"sfx_hooked"):
		return
	node.set_meta(&"sfx_hooked", true)

	node.pressed.connect(play_ui.bind(SoundLibrary.UI_CLICK))
	node.mouse_entered.connect(play_ui.bind(SoundLibrary.UI_HOVER, -6.0))
