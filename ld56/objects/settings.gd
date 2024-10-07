extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$music_slider.value = SettingsAndSound.music_volume
	$sound_slider.value = SettingsAndSound.sound_volume
	$master_slider.value = SettingsAndSound.master_volume
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("settings"):
		SettingsAndSound.settingsOpen = false
		get_parent().remove_child(get_node(self.get_path()))

func _on_button_close_pressed() -> void:
	SettingsAndSound.settingsOpen = false
	get_parent().remove_child(get_node(self.get_path()))


func _on_button_exit_pressed() -> void:
	SettingsAndSound.settingsOpen = false
	get_tree().quit()


func _on_music_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		SettingsAndSound.set_music_volume($music_slider.value)


func _on_master_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		SettingsAndSound.set_master_volume($master_slider.value)


func _on_sound_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		SettingsAndSound.set_sound_volume($sound_slider.value)
		SettingsAndSound.play_sfx("lock_click")
