class_name AgentHandler extends Node

@export
var amount_spawned = 10
@export
var spread = 100

@export var spawn_point: Vector2

var agent = preload("res://agents/Agent.tscn")

var world: World
var agents: Array[Agent] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	world = get_parent()
	for i in amount_spawned:
		var newAgent = agent.instantiate()
		var spawn = spawn_point + Vector2(randf_range(-1, 1)*spread, randf_range(-1, 1)*spread)
		newAgent.position += spawn
		add_child(newAgent)
		agents.append(newAgent)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO if not rendered: Simulate Actions
	# Simulate via teleporting Agents to PoIs and triggering actions
	# Probably simulate in extra Timer _timeouts
	pass
