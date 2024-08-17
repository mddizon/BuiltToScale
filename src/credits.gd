extends Control



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_title.tscn");
	AudioController.play_back_button()
