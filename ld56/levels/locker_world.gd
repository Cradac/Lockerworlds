extends Node2D

var WORLD_1_LOCKER: Locker = null
var WORLD_2_LOCKER: Locker = null

var locker_ids = []



@onready var lockers = self.get_node("Lockers").get_children()
@onready var post_its = self.get_node("PostIts").get_children()
@onready var camera_pos = $Camera2D.global_transform

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assign_locker_ids()
	select_action_lockers()
	get_viewport().physics_object_picking_first_only = true
	get_viewport().physics_object_picking_sort = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$Area2D_click_overlap.set_positi
	pass

func assign_locker_ids():
	var rng = RandomNumberGenerator.new()
	for locker in lockers:
		rng.randomize()
		var locker_id = 0
		while true:
			locker_id = rng.randi_range(100,999)
			if locker_id not in locker_ids:
				locker_ids.append(locker_id)
				print(locker_id)
				break
		locker.LOCKER_ID = locker_id
		locker.set_id_label()


func select_action_lockers():
	var possible_lockers = lockers.duplicate()
	
	WORLD_1_LOCKER = possible_lockers.pick_random()
	post_its[0].assign_locker(WORLD_1_LOCKER)
	WORLD_1_LOCKER.locker_opened.connect(_on_locker_1_open);
	print(WORLD_1_LOCKER.name)
	possible_lockers.remove_at(possible_lockers.find(WORLD_1_LOCKER))

	WORLD_2_LOCKER = possible_lockers.pick_random()
	post_its[1].assign_locker(WORLD_2_LOCKER)
	WORLD_2_LOCKER.locker_opened.connect(_on_locker_2_open);
	print(WORLD_2_LOCKER.name)

func _on_locker_1_open(colour: int) -> void:
	Simulation.switch_world(0, colour)

func _on_locker_2_open(colour: int) -> void:
	Simulation.switch_world(1, colour)


func _on_locker_input_event(viewport: Node, event: InputEvent, shape_idx: int, index: int) -> void:
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		var tween = get_tree().create_tween().set_parallel(true)
		print("locker")
		if evt.button_index == 1 and evt.pressed:
			if $Camera2D.zoom == Vector2(1,1):
				tween.tween_property($Camera2D,"global_transform",lockers[index].get_child(0).global_transform,0.25)
				tween.tween_property($Camera2D,"zoom",Vector2(6,6),0.25)
			else:
				return

func _on_post_it_note_input_event(viewport: Node, event: InputEvent, shape_idx: int, index: int) -> void:
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		var tween = get_tree().create_tween().set_parallel(true)
		if evt.button_index == 1 and evt.pressed:
			if $Camera2D.zoom == Vector2(1,1):
				tween.tween_property($Camera2D,"global_transform",post_its[index].get_child(0).global_transform,0.25)
				tween.tween_property($Camera2D,"zoom",Vector2(9,9),0.25)
			else:
				return


func _zclick_background(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		var tween = get_tree().create_tween().set_parallel(true)
		if evt.button_index == 1 and evt.pressed:
			if $Camera2D.zoom != Vector2(1,1):
				tween.tween_property($Camera2D,"zoom",Vector2(1,1),0.25)
				tween.tween_property($Camera2D,"global_transform",camera_pos,0.25)
