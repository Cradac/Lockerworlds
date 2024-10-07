class_name ElectrocutionRisk extends Risk

func _init() -> void:
	morale_damage_per_second = 10
	emoji = "power"
	chance = 0.3
	alert_range = 100
	
	visual_scene = preload("res://agents/risks/ElecticutionRiskVisual.tscn")
	
func trigger(poi: PointOfInterest, action_time: int) -> void:
	# Todo
	super(poi, action_time)
	
func resolve() -> void:
	super()
	
func _on_timeout() -> void:	
	SettingsAndSound.play_sfx("electrocute")
	super()
