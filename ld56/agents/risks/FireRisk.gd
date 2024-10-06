class_name FireRisk extends Risk

func _init() -> void:
	morale_damage_per_second = 10
	emoji = "🔥"
	chance = 1
	alert_range = 450
	
	visual_scene = preload("res://agents/risks/FireRiskVisual.tscn")
	
func trigger(poi: PointOfInterest, action_time: int) -> void:
	# Todo
	super(poi, action_time)
	
func resolve() -> void:
	super()
	
func _on_timeout() -> void:
	# TODO Create Fire Sprites
	
	super()
