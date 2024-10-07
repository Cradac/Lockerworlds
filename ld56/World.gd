class_name World extends Node2D

var moral_damage: int = 0
var current_dps: int = 0

@onready var agents: AgentHandler = $AgentHandler
@onready var tileMap: TileMapLayer = $layer1

@onready var timer: Timer = $Timer

@onready var darknessRiskButton: Area2D = $DarknessRiskButton
@onready var overlay: Control = $Overlay
@onready var overlaySprite: AnimatedSprite2D = $OverlaySprite

var rendered: bool = true
var colour: int = 0

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
	
	agents.spawn_agents()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	overlaySprite.set_frame_and_progress(colour, 0)

func get_valid_poi() -> PointOfInterest:
	if not Simulation.simulation_active:
		return null
	if active_poi_array.is_empty():
		print("No active PoI available")
		return null
	else:
		var poi = active_poi_array.pick_random()
		if poi.world.darknessRiskButton.status:
			return poi
		else:
			return null 

func update_poi_status(poi: PointOfInterest) -> void:
	if poi.disabled:
		var index = active_poi_array.find(poi)
		if index != -1:
			active_poi_array.remove_at(index)
			print("Removed PoI from active PoIs")
	else:
		active_poi_array.append(poi)

func add_moral_dps(morale_dps: int) -> void:
	print("Added moral dps ", morale_dps)
	current_dps += morale_dps

func remove_moral_dps(morale_dps: int) -> void:
	print("Removed dps ", morale_dps)
	current_dps = max(current_dps-morale_dps, 0)

func do_simulation_tick() -> void:
	#moral_damage += current_dps
	#debug.text = "Total: "+ str(moral_damage) + " DPS: "+str(current_dps)
	if not rendered:
		# Simulate Actions
		for agent in agents.agents:
			if agent.busy == 0:
				if randf() < Simulation.simulated_action_chance:
					var poi = get_valid_poi()
					if poi == null:
						continue
					var possible_actions: Array = poi.possible_actions.get(poi.poi_type)
					var action_class = possible_actions.pick_random()
					var action: AgentAction = action_class.new() as AgentAction

					agent.busy = action.do_action_at(poi)
					print("Simulating action", action)
			else:
				agent.busy -= 1

func set_rendered(rendered: bool) -> void:
	self.rendered = rendered

func _on_back_button_pressed() -> void:
	Simulation.switch_to_locker()
	
