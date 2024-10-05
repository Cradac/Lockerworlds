class_name FireRisk extends Risk

func _init() -> void:
	morale_damage_per_second = 10
	emoji = "🔥"
	chance = 0.3
	alert_range = 450
	
func trigger(position: Vector2i, action_time: int) -> void:
	# Todo 
	super(position, action_time)
	
func resolve() -> void:
	super()
	
func _on_timeout() -> void:
	# TODO Create Fire Sprites
	super()
