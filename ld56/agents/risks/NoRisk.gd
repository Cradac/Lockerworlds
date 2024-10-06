class_name NoRisk extends Risk

func _init() -> void:
	morale_damage_per_second = 0
	emoji = ""
	chance = 0.0
	alert_range = 0
	
func trigger(poi: PointOfInterest, action_time: int) -> void:
	return
	
func resolve() -> void:
	return
