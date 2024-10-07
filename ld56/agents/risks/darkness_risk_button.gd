extends Area2D

#
var status: bool = true
@onready var sprite = $AnimatedSprite2D
@onready var world = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if status == true:
		sprite.play("on")
	else:
		sprite.play ("off")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		if evt.button_index == 1 and evt.pressed:
			for child in world.get_children():
				if child is DarknessRisk:
					status = true
					child.resolve()
