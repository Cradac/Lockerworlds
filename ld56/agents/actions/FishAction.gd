class_name FishAction extends AgentAction

func _init() -> void:
	time_spent = 1
	emoji = "fishing"
	
	possible_risks = [DrownRisk.new()]
