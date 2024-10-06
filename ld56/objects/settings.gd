extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$music_slider.value = SettingsAndSound.music_volume
	$sound_slider.value = SettingsAndSound.sound_volume
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("settings"):
		pass


func _on_sound_slider_changed() -> void:
	SettingsAndSound.sound_volume = $sound_slider.value


func _on_music_slider_changed() -> void:
	SettingsAndSound.music_volume = $music_slider.value


func _on_button_close_pressed() -> void:
	pass # Replace with function body.


func _on_button_exit_pressed() -> void:
	pass # Replace with function body.
