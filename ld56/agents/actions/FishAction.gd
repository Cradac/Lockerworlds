class_name FishAction extends AgentAction

func _init() -> void:
	time_spent = 30
	emoji = "🐟"
	
	possible_risks = [DrownRisk.new()]
