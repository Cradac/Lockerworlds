extends Node

var current_scene = null

var world_scenes_paths: Array = ["res://levels/level1.tscn", "res://levels/level2.tscn"]
var locker_world

var worlds: Array[World] = []

var starting_moral = 50000
var regenaration_rate = 40
var simulated_action_chance = 0.2

var progressed_time = 0
var time_to_reach = 180

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
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	
	showcase_worlds()
	
	

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
	progressed_time += 1
	if progressed_time == time_to_reach:
		print("You won!")
		goto_game_over(true)

func check_moral() -> void:
	var remaining = get_remaining_moral()
	if remaining < 0:
		print("Game over!")
		goto_game_over(false)
	else:
		print("Remaining Moral: ", remaining)

func showcase_worlds():
	print("start showcase")
	switch_world(0, 0)
	
	var text1_scene = preload("res://objects/tutorial1.tscn")
	var text1 = text1_scene.instantiate()
	get_tree().root.add_child.call_deferred(text1)
	await get_tree().create_timer(10.0).timeout
	get_tree().root.remove_child(text1)
	switch_world(1, 0)
	
	var text2_scene = preload("res://objects/tutorial2.tscn")
	var text2 = text2_scene.instantiate()
	get_tree().root.add_child(text2)
	await get_tree().create_timer(10.0).timeout
	get_tree().root.remove_child(text2)
	
	switch_to_locker()
	print("end showcase")
	#switch_world(0)
	simulation_active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_world(idx: int, colour: int) -> void:
	worlds[idx].colour = colour
	SettingsAndSound.set_music(1 + 2*idx) #dirty and hacky but time lul
	goto_world(worlds[idx])
	
	
func switch_to_locker() -> void:
	SettingsAndSound.set_music(0) #ich bin ein Ziegelstein
	goto_world(locker_world)

func goto_game_over(won: bool):
	# Call deferred to fix potential crash or unexpected behavior of a running scene change
	simulation_active = false
	_deferred_game_over.call_deferred(won)
	SettingsAndSound.set_music(0)

func goto_world(world):
	# Call deferred to fix potential crash or unexpected behavior of a running scene change
	_deferred_goto_world.call_deferred(world)

func _deferred_game_over(won: bool):
	# It is now safe to remove the current scene.
	if not current_scene == null:
		current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load("res://objects/GameOver.tscn")

	# Instance the new scene.
	var overlay: Control = s.instantiate()
	var success_text: RichTextLabel = overlay.get_child(0)
	if won:
		success_text.text = "[center]You won![/center]"
	else:
		success_text.text = "[center]You lost![/center]"

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(overlay)
	get_tree().current_scene = overlay


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
	
	
