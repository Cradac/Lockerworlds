class_name CookAction extends AgentAction

func _init() -> void:
	time_spent = 1
	emoji = "cooking"
	
	possible_risks = [FireRisk.new()]
