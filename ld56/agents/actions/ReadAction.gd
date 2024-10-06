class_name ReadAction extends AgentAction

func _init() -> void:
	time_spent = 15
	emoji = "📔"
	
	possible_risks = [DarknessRisk.new(),ElectrocutionRisk.new()]
