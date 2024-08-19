extends Control

@onready var settings = preload("res://Scenes/settings_panel.tscn")

func _on_start_game_button_pressed():
	GlobalGameState.player_health = 100
	GlobalGameState.is_game_over = false	
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	AudioController.play_confirm_button()

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	AudioController.play_click_button()


func _on_settings_button_pressed():
	get_tree().root.add_child(settings.instantiate())
	AudioController.play_click_button()
