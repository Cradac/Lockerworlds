class_name FishAction extends AgentAction

func _init() -> void:
	time_spent = 15
	emoji = "fishing"
	
	possible_risks = [DrownRisk.new()]
