extends Control

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/exterior.tscn")
	AudioController.play_click_button()

func _on_go_to_ship_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ship_interior.tscn")
	AudioController.play_click_button()

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	AudioController.play_click_button()
