extends Node2D

@onready var label = $PostItNote/Label
var assigned_locker = null

var TEXT = "the code for locker [i]%s[/i] is: [b]%s[/b]"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_text():
	label.text = TEXT % [assigned_locker.LOCKER_ID, "".join(assigned_locker.LOCK_CODE)]

func assign_locker(locker):
	assigned_locker = locker
	set_text()
