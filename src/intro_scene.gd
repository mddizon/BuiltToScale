extends Control

var music_sound

# Called when the node enters the scene tree for the first time.
func _ready():
	music_sound = AudioController.get_music_volume()
	AudioController.set_music_volume(music_sound - 20)
	AudioController.play_intro_sound()
	$AnimationPlayer.play("intro")
	pass # Replace with function body.

func _on_button_pressed():
	GlobalGameState.player_health = 100
	GlobalGameState.is_game_over = false
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	AudioController.set_music_volume(music_sound)
	AudioController.play_start_game_button()
