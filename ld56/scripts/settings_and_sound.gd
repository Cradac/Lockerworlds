extends Node

#music players
var locker_music : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level1_music : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level1_music_attention : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level2_music : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level2_music_attention : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var sound_player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var music_arr : Array[AudioStreamPlayer2D] = []
#volumes
var sound_volume : float = 0.8
var music_volume : float = 0.0
var master_volume : float = 0.8

var active_music : AudioStreamPlayer2D = null
var sound_dict = {}

func set_master_volume(vol : float):
	master_volume = vol
	AudioServer.set_bus_volume_db(0, linear_to_db(vol))

func set_music_volume(vol : float):
	music_volume = vol
	print(AudioServer.get_bus_index("Music"))
	AudioServer.set_bus_volume_db(1, linear_to_db(vol))
	
func set_sound_volume(vol : float):
	sound_volume = vol
	AudioServer.set_bus_volume_db(2, linear_to_db(vol))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_music()
	init_sound()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sfx(name : String):
	sound_dict[name].play()

func init_sound():
	sound_dict = {
		"eletrocute": preload("res://sounds/electrocute.wav"),
		"lock_click": preload("res://sounds/lock_click.wav"),
		"lock_open": preload("res://sounds/lock_open.wav"),
		"drought": preload("res://sounds/drought.wav")
	}
	for sound_key in sound_dict:
		var strim = AudioStreamPlayer2D.new()
		strim.stream = sound_dict[sound_key] #sound is packaged  wav
		sound_dict[sound_key] = strim #sound is audiostreamplayer2D
		add_child(sound_dict[sound_key])
		sound_dict[sound_key].bus = &"SFX"
		
	
func init_music():
	locker_music.stream = preload("res://sounds/lockerworld_music.wav")
	level1_music.stream = preload("res://sounds/lvl1_normal.wav")
	level1_music_attention.stream = preload("res://sounds/lvl1_attention.wav")
	level2_music.stream = preload("res://sounds/lvl2_normal.wav")
	level2_music_attention.stream = preload("res://sounds/lvl2_attention.wav")
	music_arr.append(locker_music)
	music_arr.append(level1_music)
	music_arr.append(level1_music_attention)
	music_arr.append(level2_music)
	music_arr.append(level2_music_attention)
	for mus in music_arr:
		add_child(mus)
		mus.bus = &"Music"
		mus.volume_db = -80.0
		mus.play()
	level1_music.volume_db = 10
	
func switch_music(player : AudioStreamPlayer2D):
	var current_song_position = active_music.get_playback_position()
	#player.volume_db = -80.0 ### start silent
	player.play( current_song_position )
	active_music = player
	
