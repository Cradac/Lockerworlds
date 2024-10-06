extends Area2D

var bottom_right_corner = Vector2(1920,1080)

const SPEED = 600
var dir = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	controller(delta)
	var future_position = get_global_mouse_position()
	self.global_position = future_position
	var angle = future_position.angle_to_point(bottom_right_corner)
	self.set_global_rotation(angle)
	
	
	
func controller(delta):
	var movement = Vector2(0,0)
	if Input.is_action_just_pressed("action"):
		var JoyClick = InputEventMouseButton.new()
		JoyClick.button_index = MOUSE_BUTTON_LEFT
		print("global")
		print(get_global_mouse_position())
		print("viewport")
		print(get_viewport().get_mouse_position())
		JoyClick.position = get_viewport().get_mouse_position()
		JoyClick.pressed = true
		Input.parse_input_event(JoyClick)
	
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		
	if abs(dir.x) == 1 and abs(dir.y) == 1:
		dir = dir.normalized()
		
	
	movement = SPEED * dir * delta
	if (movement):
		get_viewport().warp_mouse(get_viewport().get_mouse_position() + movement)
