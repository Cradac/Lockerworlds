class_name Agent extends CharacterBody2D

@onready var debug = $DebugLable
@onready var timer: Timer = $Timer

enum GENDER {
	Purple,
	Girl,
	Boy
}
@export var gender: GENDER
@onready var purple_skin = $Purple
@onready var boy_skin = $Boy
@onready var girl_skin = $Girl

@export
var movement_speed: float = 100.0

var movement_target_position: Vector2 = Vector2(randi_range(20,1100), randi_range(20,600))

var nav_agent_type = preload("res://agents/AgentNav.tscn")
@onready var navigation_agent: NavigationAgent2D



var world: World
var target_poi: PointOfInterest

	
func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	create_nav_agent()
	gender_reassignment_surgery()

	world = get_parent().world
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
	#debug.text = str(movement_target.x) + "," + str(movement_target.y)
	navigation_agent.target_position = movement_target
	navigation_agent.get_next_path_position()

func _physics_process(delta):
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	navigation_agent.velocity = velocity
	

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	var sprite = null
	match self.gender:
		GENDER.Purple:
			sprite = purple_skin
		GENDER.Boy:
			sprite = boy_skin
		GENDER.Girl:
			sprite = girl_skin
	if velocity.length_squared() <= 50:
		sprite.play("idle")
	else:
		turn_animation(velocity.angle(), sprite)
	move_and_slide()

func _on_target_reached() -> void:
	if target_poi:
		# Trigger PoI Action
		var possible_actions: Array = target_poi.possible_actions.get(target_poi.poi_type) as Array
		var action_class = possible_actions.pick_random()
		var action: AgentAction = action_class.new() as AgentAction
		
		var timeout: int = action.do_action_at(target_poi)
		debug.text = action.emoji
		timer.start(timeout)
		return
	else:
		set_new_target()
		

func set_new_target():
	navigation_agent.queue_free()
	create_nav_agent()
	target_poi = world.get_valid_poi()
	if target_poi == null:
		debug.text = "no PoI"
		set_movement_target(get_random_pos())
	else:
		debug.text = ""
		set_movement_target(target_poi.position)

func _on_timer_timeout() -> void:
	set_new_target()
	
func alert_to_risk(risk: Risk) -> void:
	var distance = self.position.distance_to(risk.position)
	#print("Got alerted to risk with distance "+str(distance))
	if distance < risk.alert_range:
		debug.text = risk.emoji
		timer.stop()
		
		navigation_agent.queue_free()
		create_nav_agent()
		target_poi = null		
		set_movement_target(get_random_pos())
	
func get_random_pos() -> Vector2:
	return Vector2(randi_range(20,1100), randi_range(20,600))


func gender_reassignment_surgery():
	self.gender = self.GENDER.values().pick_random()
	match self.gender:
		GENDER.Purple:
			purple_skin.show()
			boy_skin.hide()
			girl_skin.hide()
		GENDER.Boy:
			purple_skin.hide()
			boy_skin.show()
			girl_skin.hide()
		GENDER.Girl:
			purple_skin.hide()
			boy_skin.hide()
			girl_skin.show()

func turn_animation(angle: float, sprite: AnimatedSprite2D):
	if angle > -PI/8 and angle < PI/8:
		sprite.play("walk_r")
	elif angle >= PI/8 and angle < 3*PI/8:
		sprite.play("walk_br")
	elif angle >= 3*PI/8 and angle < 5*PI/8:
		sprite.play("walk_b")
	elif angle >= 5*PI/8 and angle < 7*PI/8:
		sprite.play("walk_bl")
	elif angle <= -PI/8 and angle > -3*PI/8:
		sprite.play("walk_tr")
	elif angle <= -3*PI/8 and angle > -5*PI/8:
		sprite.play("walk_t")
	elif angle <= -5*PI/8 and angle > -7*PI/8:
		sprite.play("walk_tl")
	elif angle >= 7*PI/8 or angle <= -7*PI/8:
		sprite.play("walk_l")
