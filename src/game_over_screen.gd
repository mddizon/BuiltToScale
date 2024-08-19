extends Control

@onready var settings = preload("res://Scenes/settings_panel.tscn")

func _on_retry_pressed():
	GlobalGameState.player_health = 100
	GlobalGameState.is_game_over = false
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	AudioController.play_confirm_button()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_title.tscn");
	AudioController.stop_music()
	AudioController.play_back_button()

