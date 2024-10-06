class_name Bubble extends Node2D

@onready var bubble = $Bubble
@onready var action = $Bubble/Action

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_bubble_type(bubble_type):
	bubble.play(bubble_type)

func set_action_type(action_type):
	action.play(action_type)
