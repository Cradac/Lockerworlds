extends TileMapLayer

@export var next_layer: TileMapLayer

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if next_layer:
		if coords in next_layer.get_used_cells():
			var is_obstacle = next_layer.get_cell_tile_data(coords).get_custom_data("obstacle")
			if is_obstacle:
				return true
	return false
	
func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_navigation_polygon(0, null)
	pass
