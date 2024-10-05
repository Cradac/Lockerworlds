class_name Risk extends Node2D

var morale_damage_per_second: int = 5
var emoji: String = "⚠️"
var chance: float = 0.05

var alert_range: int = 300

@onready var timer: Timer = $Timer

func _ready() -> void:
	pass

func trigger(position: Vector2i, action_time: int) -> void:
	# Randomise Trigger Time for Risk
	self.position = position
	Engine.get_main_loop().current_scene.add_child(self)
	timer = Timer.new()
	get_tree().create_timer(randi_range(int(action_time*0.2), int(action_time*0.9))).timeout.connect(_on_timeout)
	
func resolve() -> void:
	timer.stop()
	
func _on_timeout() -> void:
	timer.start(-1)
	alert_agents()
	
func alert_agents() -> void:
	get_tree().call_group("agents", "alert_to_risk", self)
	pass # TODO alert and interupt close agents
