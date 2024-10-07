class_name ReadAction extends AgentAction

func _init() -> void:
	time_spent = 1
	emoji = "light"
	
	possible_risks = [DarknessRisk.new(),ElectrocutionRisk.new()]
