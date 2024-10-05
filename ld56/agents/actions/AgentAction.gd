class_name AgentAction extends Node

var time_spent: int = 5
var emoji: String = "⁉️"
var position: Vector2i

var possible_risks: Array[Risk] = []

func do_action_at(position: Vector2i) -> int:
	self.position = position
	check_risk_occurance()
	return time_spent

func check_risk_occurance() -> Risk:
	if not possible_risks.is_empty():
		for risk in possible_risks:
			if randf() < risk.chance:
				risk.trigger(position, time_spent)
				return risk
	return NoRisk.new()
