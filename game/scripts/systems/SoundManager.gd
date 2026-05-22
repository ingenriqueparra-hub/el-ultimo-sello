class_name SoundManager
extends RefCounted

static func create_player(parent: Node) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	parent.add_child(player)
	return player

static func play_approve(player: AudioStreamPlayer) -> void:
	player.stream = _tone(440.0, 0.10, 2.5)
	player.volume_db = -8.0
	player.play()

static func play_reject(player: AudioStreamPlayer) -> void:
	player.stream = _sweep(380.0, 170.0, 0.14)
	player.volume_db = -6.0
	player.play()

static func play_hold(player: AudioStreamPlayer) -> void:
	player.stream = _tone(300.0, 0.10, 1.5)
	player.volume_db = -10.0
	player.play()

static func play_alert(player: AudioStreamPlayer) -> void:
	player.stream = _tone(900.0, 0.06, 4.0)
	player.volume_db = -4.0
	player.play()

static func play_scan(player: AudioStreamPlayer) -> void:
	player.stream = _sweep(180.0, 700.0, 0.25)
	player.volume_db = -14.0
	player.play()

static func _tone(freq: float, duration: float, decay: float) -> AudioStreamWAV:
	const RATE := 22050
	var n := int(duration * RATE)
	var data := PackedByteArray()
	data.resize(n * 2)
	for i in range(n):
		var env := pow(1.0 - float(i) / float(n), decay)
		var s := int(20000.0 * env * sin(TAU * freq * float(i) / RATE))
		s = clampi(s, -32767, 32767)
		data[i * 2]     = s & 0xFF
		data[i * 2 + 1] = (s >> 8) & 0xFF
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = RATE
	wav.stereo = false
	wav.data = data
	return wav

# Phase-coherent frequency sweep (chirp)
static func _sweep(f_start: float, f_end: float, duration: float) -> AudioStreamWAV:
	const RATE := 22050
	var n := int(duration * RATE)
	var data := PackedByteArray()
	data.resize(n * 2)
	var phase := 0.0
	for i in range(n):
		var p := float(i) / float(n)
		var freq := f_start + (f_end - f_start) * p
		phase += TAU * freq / RATE
		var env := 1.0 - p * 0.6
		var s := int(16000.0 * env * sin(phase))
		s = clampi(s, -32767, 32767)
		data[i * 2]     = s & 0xFF
		data[i * 2 + 1] = (s >> 8) & 0xFF
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = RATE
	wav.stereo = false
	wav.data = data
	return wav
