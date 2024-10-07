class_name CookAction extends AgentAction

func _init() -> void:
	time_spent = 15
	emoji = "cooking"
	
	possible_risks = [FireRisk.new()]
