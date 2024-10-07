class_name PraiseAction extends AgentAction

func _init() -> void:
	time_spent = 1
	emoji = "praying"
	
	possible_risks = [GodotzillaRisk.new()]
