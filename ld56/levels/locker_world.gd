extends Node2D

var WORLD_1_LOCKER = null
var WORLD_2_LOCKER = null

var locker_ids = []



@onready var lockers = self.get_node("Lockers").get_children()
@onready var post_its = self.get_node("PostIts").get_children()
@onready var camera_pos = $Camera2D.global_transform

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
	WORLD_1_LOCKER = lockers.pick_random()
	post_its[0].assign_locker(WORLD_1_LOCKER)
	print(WORLD_1_LOCKER.name)
	
	WORLD_2_LOCKER = lockers.pick_random()
	post_its[1].assign_locker(WORLD_2_LOCKER)
	print(WORLD_2_LOCKER.name)
	


func _on_locker_input_event(viewport: Node, event: InputEvent, shape_idx: int, index: int) -> void:
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		var tween = get_tree().create_tween()
		if evt.button_index == 1 and evt.pressed:
			if $Camera2D.zoom == Vector2(1,1):
				$Camera2D.global_transform = lockers[index].get_child(0).global_transform
				tween.tween_property($Camera2D,"zoom",Vector2(6,6),1)
				#$Camera2D.zoom =  $Camera2D.zoom.lerp(Vector2(6,6),0.6)
			else:
				$Camera2D.zoom 
				#$Camera2D.zoom = Vector2(1,1)
				tween.tween_property($Camera2D,"zoom",Vector2(1,1),1)
				#tween.tween_property($Camera2D,"global_transform",camera_pos,1)
				$Camera2D.global_transform = camera_pos
