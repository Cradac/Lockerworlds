class_name DarknessRisk extends Risk

func _init() -> void:
	morale_damage_per_second = 10
	emoji = "darkness"
	chance = 0.3
	alert_range = 1000
	
	visual_scene = preload("res://agents/risks/DarknessRiskVisual.tscn")
	#risk_button = load("res://agents/risks/DarknessRiskButton.tscn")
	
func trigger(poi: PointOfInterest, action_time: int) -> void:
	super(poi, action_time)
	
func resolve() -> void:
	super()
	
func _on_timeout() -> void:	
	super()

func _on_visual_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	pass
