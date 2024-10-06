extends Area2D

var bottom_right_corner = Vector2(1920,1080)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var future_position = get_global_mouse_position()
	self.global_position = future_position
	var angle = future_position.angle_to_point(bottom_right_corner)
	self.set_global_rotation(angle)
