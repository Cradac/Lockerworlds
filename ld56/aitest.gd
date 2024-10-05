extends Node2D


@export
var amount_spawned = 10
@export
var spread = 100

var agent = preload("res://Agent.tscn")

@onready
var tileMap: TileMapLayer = $TileMapLayer

var poi: Array[PointOfInterest] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var cellPositions: Array[Vector2i] = tileMap.get_used_cells()
	for position in cellPositions:
		var tileData: TileData = tileMap.get_cell_tile_data(position)
		var customData = tileData.get_custom_data("poi_type")
		
		if customData != null:
			var global_pos = to_global(tileMap.map_to_local(position))
			poi.append(PointOfInterest.new(customData, global_pos))
	
	
	for i in amount_spawned:
		var newAgent = agent.instantiate()
		newAgent.position += Vector2(randf_range(-1, 1)*spread, randf_range(-1, 1)*spread)
		add_child(newAgent)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
