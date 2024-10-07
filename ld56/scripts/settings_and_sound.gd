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
var music_volume : float = 0.8
var master_volume : float = 0.5

var settingsOpen : bool = false
var current_world : int = 0
var current_index = 1

var active_music : AudioStreamPlayer2D = locker_music
var sound_dict = {}

func set_music(lvl : int, drama : bool):
	if music_arr == []:
		return
	current_world = lvl
	if lvl == 0:
		switch_music(music_arr[current_index],music_arr[0])
		#music_arr[0]
		current_index = 0
	if lvl == 1:
		if drama:
			switch_music(music_arr[current_index],music_arr[2])
			#music_arr[2].volume_db = 0.0
			current_index = 2
		else:
			switch_music(music_arr[current_index],music_arr[1])
			#music_arr[1].volume_db = 0.0
			current_index = 1
	else:
		if drama:
			switch_music(music_arr[current_index],music_arr[4])
			#music_arr[4].volume_db = 0.0
			current_index = 4
		else:
			switch_music(music_arr[current_index],music_arr[3])
			#music_arr[3].volume_db = 0.0
			current_index = 3

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
	AudioServer.set_bus_volume_db(0, linear_to_db(master_volume))
	AudioServer.set_bus_volume_db(1, linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(sound_volume))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sfx(name : String):
	sound_dict[name].play()

func init_sound():
	sound_dict = {
		"electrocute": preload("res://sounds/electrocute.wav"),
		"lock_click": preload("res://sounds/lock_click.wav"),
		"lock_open": preload("res://sounds/lock_open.wav"),
		"drought": preload("res://sounds/drought.wav"),
		"locker_open": preload("res://sounds/locker_open.wav"),
		"darkness": preload("res://sounds/darkness.wav"),
		"drown": preload("res://sounds/drown.wav"),
		"fire": preload("res://sounds/fire.wav")
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
		#mus.volume_db = -80.0
		#mus.play()
	music_arr[1].play
	
func switch_music(oldplayer : AudioStreamPlayer2D, newplayer : AudioStreamPlayer2D, ):
	var current_song_position = oldplayer.get_playback_position()
	oldplayer.stop()
	newplayer.play( current_song_position )
	
	
