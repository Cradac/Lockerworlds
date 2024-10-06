class_name AgentAction extends Node2D

var time_spent: int = 5
var emoji: String = "⁉️"
var poi: PointOfInterest

var possible_risks: Array[Risk] = []

func do_action_at(poi: PointOfInterest) -> int:
	self.position = poi.position
	self.poi = poi
	check_risk_occurance()
	return time_spent

func check_risk_occurance() -> Risk:
	if not possible_risks.is_empty() && not poi.triggerd:
		for risk in possible_risks:
			if randf() < risk.chance:
				risk.trigger(poi, time_spent)
				return risk
	return NoRisk.new()
