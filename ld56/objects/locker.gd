class_name Locker extends Node2D

@export var LOCKER_ID:int = 101
@export var LOCK_POSITION = [0,0,0,0]
@export var LOCK_CODE = [0,0,0,0]

@onready var label = $Locker/Locker/Tag/Label
@onready var lock = $Locker/Locker/Lock
@onready var texture = $Locker/Locker_Texture

signal locker_opened

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_locker_texture()
	generate_code()
	print("LOCK CODE:")
	print(LOCK_CODE)
	reset_lock_position()
	print("LOCK POSITION:")
	print(LOCK_POSITION)
	set_lock()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_locker_texture():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	texture.set_frame_and_progress(rng.randi_range(0,4), 0)

func generate_code():
	var rng = RandomNumberGenerator.new()
	for i in range(4):
		rng.randomize()
		LOCK_CODE[i-1] = rng.randi_range(0,9)

func reset_lock_position():
	lock.set_frame_and_progress(0,0)
	var rng = RandomNumberGenerator.new()
	while true:
		for i in range(4):
			rng.randomize()
			LOCK_POSITION[i-1] = rng.randi_range(0,9)
		if LOCK_POSITION != LOCK_CODE:
			break

func set_lock():
	var lock_children = lock.get_children()
	for i in range(4):
		i-=1
		if LOCK_POSITION[i]-1>=0:
			lock_children[i].get_node("lock_l").text=center_text(str(LOCK_POSITION[i]-1))
		else:
			lock_children[i].get_node("lock_l").text=center_text(str(9))
		lock_children[i].get_node("lock_c").text=center_text(str(LOCK_POSITION[i]))
		if LOCK_POSITION[i]+1<=9:
			lock_children[i].get_node("lock_r").text=center_text(str(LOCK_POSITION[i]+1))
		else:
			lock_children[i].get_node("lock_r").text=center_text(str(0))

func center_text(text):
	text = "[center]%s[/center]" % text
	return text

func check_code():
	if LOCK_CODE == LOCK_POSITION:
		print("richtig")
		SettingsAndSound.play_sfx("lock_open")
		lock.set_frame_and_progress(1,0)
		SettingsAndSound.play_sfx("locker_open")
		#locker_opened.emit()



func _lock_clicked(event: InputEvent, is_left: bool, index: int) -> void:
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		if evt.pressed && evt.button_index == 1:
			SettingsAndSound.play_sfx("lock_click")
			if is_left:
				LOCK_POSITION[index] = (LOCK_POSITION[index] + 1) % 10
			else:
				LOCK_POSITION[index] = (LOCK_POSITION[index] - 1) % 10
				if LOCK_POSITION[index] < 0:
					LOCK_POSITION[index] = 9
			set_lock()
			check_code()

func set_id_label():
	label.text=center_text(LOCKER_ID)


func _on_lock_animation_finished() -> void:
	locker_opened.emit()


#func _on_lock_frame_changed() -> void:
	#locker_opened.emit()
