extends Node

#music players
var locker_music : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level1_music : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level1_music_attention : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level2_music : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var level2_music_attention : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

#volumes
var sound_volume : float = 0.8
var music_volume : float = 0.8

var active_music : AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_music()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_music():
	print("music innnit")
	locker_music.stream = preload("res://sounds/lockerworld_music.wav")
	level1_music.stream = preload("res://sounds/lvl1_normal.wav")
	level1_music_attention.stream = preload("res://sounds/lvl1_attention.wav")
	level2_music.stream = preload("res://sounds/lvl2_normal.wav")
	level2_music_attention.stream = preload("res://sounds/lvl2_attention.wav")
	locker_music.bus = &"Master/Music"
	level2_music.bus = &"Master/Music"
	level2_music_attention.bus = &"Master/Music"
	locker_music.bus = &"Master/Music"
	locker_music.play()
	get_tree().root.add_child(locker_music)
	
func switch_music(player : AudioStreamPlayer2D):
	var current_song_position = active_music.get_playback_position()
	#player.volume_db = -80.0 ### start silent
	player.play( current_song_position )
	active_music = player
	
