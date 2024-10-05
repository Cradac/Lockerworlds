extends Node2D

@export var LOCKER_ID:int = 101
@export var LOCK_POSITION = [0,0,0,0]
@export var LOCK_CODE = [0,0,0,0]

@onready var label = $Locker/Tag/Label
@onready var lock = $Locker/Lock
@onready var texture = $Locker_Texture


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_locker_texture()
	generate_code()
	print("LOCK CODE:")
	print(LOCK_CODE)
	reset_lock_position()
	print("LOCK POSITION:")
	print(LOCK_POSITION)
	label.text=center_text(LOCKER_ID)
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
