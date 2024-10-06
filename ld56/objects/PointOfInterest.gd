class_name PointOfInterest extends Node2D

var poi_type: POI_TYPE
var tileMap: TileMapLayer
var world: World

var disabled: bool = false
var triggerd: bool = false

func _init(type: String, pos: Vector2i, world: World) -> void:
	poi_type = POI_TYPE.get(type.to_upper())
	global_position = pos
	self.tileMap = world.tileMap
	self.world = world
	
	

enum POI_TYPE {
	CAMPFIRE, GARDEN, LAMP, RIVER, GODOTZILLA
}

var possible_actions: Dictionary = {
	POI_TYPE.CAMPFIRE: [CookAction, ChillAction],
	POI_TYPE.RIVER: [ChillAction, FishAction],
	POI_TYPE.GARDEN: [ChillAction, HarvestAction],
	POI_TYPE.LAMP: [ChillAction, ReadAction]
}

func set_disabled(disabled: bool):
	if disabled:
		print("Disabling PoI")
	else:
		triggerd = false
		print("Enabling PoI")
	self.disabled = disabled
	world.update_poi_status(self)
