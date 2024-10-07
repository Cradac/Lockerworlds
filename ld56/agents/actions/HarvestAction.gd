class_name HarvestAction extends AgentAction

func _init() -> void:
	time_spent = 1
	emoji = "harvesting"
	
	possible_risks = [DroughtRisk.new()]
