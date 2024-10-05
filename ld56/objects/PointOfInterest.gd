class_name PointOfInterest extends Node

var poi_type: String
var position: Vector2i

func _init(type: String, pos: Vector2i) -> void:
	poi_type = type
	position = pos
