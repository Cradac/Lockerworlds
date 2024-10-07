class_name World extends Node2D

var moral_damage: int = 0
var current_dps: int = 0

@onready var agents: AgentHandler = $AgentHandler
@onready var tileMap: TileMapLayer = $layer1
@onready var debug: Label = $Label

@onready var timer: Timer = $Timer

@onready var darknessRiskButton: Area2D = $DarknessRiskButton
@onready var overlay: Control = $Overlay

var rendered: bool = true

var poi_array: Array[PointOfInterest] = []
var active_poi_array: Array[PointOfInterest] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var cellPositions: Array[Vector2i] = tileMap.get_used_cells()
	for position in cellPositions:
		var tileData: TileData = tileMap.get_cell_tile_data(position)
		var customData: String = tileData.get_custom_data("poi_type") as String

		if customData != null and not customData.is_empty():
			var global_pos = tileMap.get_parent().to_global(tileMap.map_to_local(position))
			poi_array.append(PointOfInterest.new(customData, global_pos, self))

	active_poi_array = poi_array.duplicate()

	timer.timeout.connect(_on_second_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_valid_poi() -> PointOfInterest:
	if active_poi_array.is_empty():
		print("No active PoI available")
		return null
	else:
		return active_poi_array.pick_random()

func update_poi_status(poi: PointOfInterest) -> void:
	if poi.disabled:
		var index = active_poi_array.find(poi)
		if index != -1:
			active_poi_array.remove_at(index)
			print("Removed PoI from active PoIs")
	else:
		active_poi_array.append(poi)

func add_moral_dps(morale_dps: int) -> void:
	current_dps += morale_dps

func remove_moral_dps(morale_dps: int) -> void:
	current_dps = max(current_dps-morale_dps, 0)

func _on_second_timeout() -> void:
	#moral_damage += current_dps
	debug.text = "Total: "+ str(moral_damage) + " DPS: "+str(current_dps)

func set_rendered(rendered: bool) -> void:
	self.rendered = rendered

func _on_back_button_pressed() -> void:
	Simulation.switch_to_locker()
