extends Node

var current_scene = null

var world_scenes_paths: Array = ["res://aitest.tscn", "res://levels/main.tscn"]

var worlds: Array[World] = []

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

	for world_scene_path in world_scenes_paths:
		var scene = ResourceLoader.load(world_scene_path)
		var world: World = scene.instantiate()
		world.rendered = false
		worlds.append(world)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_world(idx: int) -> void:
	goto_world(worlds[idx])

func goto_scene(path):
	# Call deferred to fix potential crash or unexpected behavior of a running scene change
	_deferred_goto_scene.call_deferred(path)

func goto_world(world: World):
	# Call deferred to fix potential crash or unexpected behavior of a running scene change
	_deferred_goto_world.call_deferred(world)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene


func _deferred_goto_world(world):
	get_tree().root.remove_child(current_scene)

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(world)
	get_tree().current_scene = world
