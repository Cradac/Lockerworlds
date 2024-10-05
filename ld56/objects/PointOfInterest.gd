class_name PointOfInterest extends Node

var poi_type: POI_TYPE
var position: Vector2i

func _init(type: String, pos: Vector2i) -> void:
	poi_type = POI_TYPE.get(type.to_upper())
	position = pos
	
	

enum POI_TYPE {
	CAMPFIRE, GARDEN, LAMP, RIVER, GODOTZILLA
}

var possible_actions: Dictionary = {
	POI_TYPE.CAMPFIRE: [CookAction, ChillAction],
	POI_TYPE.RIVER: [ChillAction]
}
