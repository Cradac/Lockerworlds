extends Node2D


@export
var amount_spawned = 10
@export
var spread = 100

var agent = preload("res://Agent.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in amount_spawned:
		var newAgent = agent.instantiate()
		newAgent.position += Vector2(randf_range(-1, 1)*spread, randf_range(-1, 1)*spread)
		add_child(newAgent)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
