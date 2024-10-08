extends Control

@export var skip_intro = false
@onready var settings = preload("res://Scenes/settings_panel.tscn")

func _ready():
	AudioController.start_menu()

func _on_start_game_button_pressed():
	if (skip_intro):
		GlobalGameState.player_health = 100
		GlobalGameState.is_game_over = false
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
		AudioController.play_start_game_button()
	else:
		get_tree().change_scene_to_file("res://Scenes/intro_scene.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	AudioController.play_click_button()


func _on_settings_button_pressed():
	get_tree().root.add_child(settings.instantiate())
	AudioController.play_click_button()
