extends Node

var current_scene = null

var world_scenes_paths: Array = ["res://levels/level1.tscn", "res://levels/level2.tscn"]
var locker_world

var worlds: Array[World] = []

var starting_moral = 50000
var regenaration_rate = 50
var simulated_action_chance = 0.05

var timer: Timer
var simulation_active: bool = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1) # This is the Locker World on Startup!
	locker_world = current_scene
	
	for world_scene_path in world_scenes_paths:
		var scene = ResourceLoader.load(world_scene_path)
		var world: World = scene.instantiate()
		worlds.append(world)
		

	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_tick_simulation)
	timer.start()
	
	showcase_worlds()
	#switch_world(0)
	

func get_remaining_moral() -> int:
	var damage = 0
	for world in worlds:
		damage += world.moral_damage
	return starting_moral - damage
	
func _tick_simulation() -> void:
	if not simulation_active:
		return
	for world in worlds:
		# Simulate actions if needed
		if not world.rendered:
			world.do_simulation_tick()
		
		# Apply regeneration
		world.moral_damage += world.current_dps
		world.moral_damage = max(world.moral_damage - regenaration_rate, 0)
	
	check_moral()

func check_moral() -> void:
	var remaining = get_remaining_moral()
	if remaining < 0:
		print("Game over!")
		get_tree().paused = true
	else:
		print("Remaining Moral: ", remaining)

func showcase_worlds():
	print("start showcase")
	switch_world(0)
	# TODO Show Message!
	await get_tree().create_timer(5.0).timeout
	switch_world(1)
	# TODO Show Message!
	await get_tree().create_timer(5.0).timeout
	# TODO Show Message!
	switch_to_locker()
	print("end")
	simulation_active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_world(idx: int) -> void:
	goto_world(worlds[idx])
	
	
func switch_to_locker() -> void:
	print("Go to locker world")
	goto_world(locker_world)

func goto_scene(path):
	# Call deferred to fix potential crash or unexpected behavior of a running scene change
	_deferred_goto_scene.call_deferred(path)

func goto_world(world):
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
	if current_scene is World:
		current_scene.set_rendered(false)
		#current_scene.set_rendered()
	
	current_scene = world

	if current_scene is World:
			world.set_rendered(true)
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(world)
	get_tree().current_scene = world
	
	
