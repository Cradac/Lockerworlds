class_name AgentHandler extends Node

@export
var amount_spawned = 10
@export
var spread = 100

var agent = preload("res://agents/Agent.tscn")

var world: World

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	world = get_parent()
	for i in amount_spawned:
		var newAgent = agent.instantiate()
		newAgent.position += Vector2(randf_range(-1, 1)*spread, randf_range(-1, 1)*spread)
		add_child(newAgent)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO if not rendered: Simulate Actions
	# Simulate via teleporting Agents to PoIs and triggering actions
	# Probably simulate in extra Timer _timeouts
	pass
