class_name Risk extends Node2D

var morale_damage_per_second: int = 5
var emoji: String = "⚠️"
var chance: float = 0.05

var alert_range: int = 300
var poi: PointOfInterest

var visual_scene = load("res://agents/risks/Risk.tscn")
var visuals: Area2D


func _ready() -> void:
	pass

func trigger(poi: PointOfInterest, action_time: int) -> void:
	# Randomise Trigger Time for Risk
	self.poi = poi
	self.position = poi.position
	poi.world.add_child(self)
	poi.triggerd = true
	
	# This trigger function gets called immediately when agent starts action. Delay real trigger to feel better
	var trigger_delay = randi_range(int(action_time*0.2), int(action_time*0.9))
	get_tree().create_timer(trigger_delay).timeout.connect(_on_timeout)
	
func resolve() -> void:
	remove_child(visuals)
	poi.set_disabled(false)
	poi.world.remove_moral_dps(morale_damage_per_second)
	pass
	
func _on_timeout() -> void:
	poi.world.add_moral_dps(morale_damage_per_second)
	poi.set_disabled(true)
	visuals = visual_scene.instantiate()
	visuals.z_index = 51 # overlay z index ++

	visuals.input_event.connect(_on_visual_input_event)
	add_child(visuals)
	
	alert_agents()
	
func alert_agents() -> void:
	if poi.world.rendered:
		get_tree().call_group("agents", "alert_to_risk", self)
	
func _on_visual_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	print(event)
	if event is InputEventMouseButton:
		resolve()
	pass
