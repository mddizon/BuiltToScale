extends Node2D

@onready var back_button_sounds = preload("res://Resources/Sound/SFX/back_button_randomizer.tres")
@onready var click_button_sounds = preload("res://Resources/Sound/SFX/back_button_randomizer.tres")
@onready var lose_game_music = preload("res://Resources/Sound/SFX/gmtk lose.ogg")

@onready var exterior_music = $ExteriorMusicPlayer
@onready var interior_music = $InteriorMusicPlayer
@onready var animation_player = $AnimationPlayer

@onready var mutex_animation_playing = false

func play_back_button():
	$UISounds.stream = back_button_sounds
	$UISounds.play()

func play_click_button():
	$UISounds.stream = click_button_sounds
	$UISounds.play()
	
func play_lose_music():
	$UISounds.stream = lose_game_music
	$UISounds.play()

func set_music_volume(vol: float):
	$ExteriorMusicPlayer.volume_db = vol

func set_sfx_volume(vol: float):
	$UISounds.volume_db = vol
	
func get_music_volume():
	return $ExteriorMusicPlayer.volume_db
	
func get_sfx_volume():
	return $UISounds.volume_db

func go_inside():
	print('going inside')
	$AnimationPlayer.play("go_inside")
	
func go_outside():
	print('going outside')
	$AnimationPlayer.play("go_outside")

func start_music():
	$ExteriorMusicPlayer.play()
	$InteriorMusicPlayer.play()

func pause_music():
	$ExteriorMusicPlayer.playing = false
	$InteriorMusicPlayer.playing = false
