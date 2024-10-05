class_name Agent extends CharacterBody2D

@onready
var debug = $DebugLable

@export
var movement_speed: float = 100.0

var updateTarget: bool = true
var movement_target_position: Vector2 = Vector2(randi_range(20,1100), randi_range(20,600))

var nav_agent_type = preload("res://AgentNav.tscn")
@onready var navigation_agent: NavigationAgent2D

@onready
var poi_array: Array[PointOfInterest] = get_parent().poi
	
func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	create_nav_agent()

	# Make sure to not await during _ready.
	actor_setup.call_deferred()
	
func create_nav_agent() -> void:
	var agent: NavigationAgent2D = nav_agent_type.instantiate()
	add_child(agent)

	agent.target_reached.connect(_on_target_reached)
	agent.velocity_computed.connect(_on_velocity_computed)
	navigation_agent = agent
	

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	debug.text = str(movement_target.x) + "," + str(movement_target.y)
	navigation_agent.target_position = movement_target
	navigation_agent.get_next_path_position()

func _physics_process(delta):
	
	#if navigation_agent.is_navigation_finished():
	#	print("Nav finished")
	#	return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	navigation_agent.velocity = velocity
	

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func _on_target_reached() -> void:
	
	navigation_agent.queue_free()
	create_nav_agent()
	var new_target = poi_array.pick_random().position
	
	set_movement_target(new_target)
