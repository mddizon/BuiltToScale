extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 15;
	$VBoxContainer/MusicSlider.value = AudioController.get_music_volume()
	$VBoxContainer/SFXSlider.value = AudioController.get_sfx_volume()
	print(GlobalGameState.invert_zoom)
	if GlobalGameState.invert_zoom:
		$VBoxContainer/AwayOut.button_pressed = true
	else:
		$VBoxContainer/AwayIn.button_pressed = true

func _on_away_out_toggled(toggled_on):
	if (toggled_on):
		print("Away out toggled on")
		GlobalGameState.invert_zoom = true

func _on_sfx_slider_value_changed(value):
	$VBoxContainer/SFXLabel.text = "SFX Volume: " + str(value) + "db"
	AudioController.set_sfx_volume(value)

func _on_music_slider_value_changed(value):
	$VBoxContainer/MusicLabel.text = "Music Volume: " + str(value) + "db"
	AudioController.set_music_volume(value)

func _on_button_pressed():
	print(GlobalGameState.invert_zoom)
	queue_free()

func _on_away_in_toggled(toggled_on):
	if (toggled_on):
		print("Away in toggled on")
		GlobalGameState.invert_zoom = false
