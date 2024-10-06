class_name DroughtRisk extends Risk

func _init() -> void:
	morale_damage_per_second = 10
	emoji = "hunger"
	chance = 0.5
	alert_range = 100
	
	visual_scene = preload("res://agents/risks/DrownRiskVisual.tscn")
	
func trigger(poi: PointOfInterest, action_time: int) -> void:
	# Todo
	super(poi, action_time)
	
func resolve() -> void:
	super()
	
func _on_timeout() -> void:	
	
	super()
