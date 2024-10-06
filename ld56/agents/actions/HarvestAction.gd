class_name HarvestAction extends AgentAction

func _init() -> void:
	time_spent = 15
	emoji = "🍑"
	
	possible_risks = [DroughtRisk.new()]
