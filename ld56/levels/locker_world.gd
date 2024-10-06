extends Node2D

var WORLD_1_LOCKER = null
var WORLD_2_LOCKER = null

@onready var lockers = self.get_node("Lockers").get_children()
@onready var post_its = self.get_node("PostIts").get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assign_locker_ids()
	select_action_lockers()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func assign_locker_ids():
	var rng = RandomNumberGenerator.new()
	for locker in lockers:
		rng.randomize()
		locker.LOCKER_ID = rng.randi_range(100,999)
		print(locker.LOCKER_ID)
		locker.set_locker_id()

func select_action_lockers():
	WORLD_1_LOCKER = lockers.pick_random()
	post_its[0].assign_locker(WORLD_1_LOCKER)
	print(WORLD_1_LOCKER.name)
	
	WORLD_2_LOCKER = lockers.pick_random()
	post_its[1].assign_locker(WORLD_2_LOCKER)
	print(WORLD_2_LOCKER.name)
