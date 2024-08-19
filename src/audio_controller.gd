extends Node2D

@onready var back_button_sounds = preload("res://Resources/Sound/SFX/back_button_randomizer.tres")
@onready var click_button_sounds = preload("res://Resources/Sound/SFX/back_button_randomizer.tres")
@onready var lose_game_music = preload("res://Resources/Sound/SFX/gmtk lose.ogg")
@onready var confirm_sound = preload("res://Resources/Sound/SFX/gmtk confirm selection.ogg")
@onready var start_game = preload("res://Resources/Sound/SFX/gmtk vo akimbo we need you.ogg")
@onready var crazy_arms = preload("res://Resources/Sound/SFX/gmtk vo crazy arms.ogg")
@onready var menu_music = preload("res://Resources/Sound/Music/gmtk menu theme.ogg")
@onready var here_we_go = preload("res://Resources/Sound/SFX/gmtk vo start.ogg")

@onready var exterior_music = $ExteriorMusicPlayer
@onready var interior_music = $InteriorMusicPlayer
@onready var animation_player = $AnimationPlayer
@onready var game_sounds = $GameSounds

@onready var mutex_animation_playing = false
var max_music_volume = 0
var max_sound_volume = 0

func _ready():
	SignalBus.change_mode.connect(_on_change_mode)

func play_back_button():
	$UISounds.stream = back_button_sounds
	$UISounds.play()

func play_confirm_button():
	$UISounds.stream = confirm_sound
	$UISounds.play()

func play_start_game_button():
	$UISounds.stream = start_game
	$UISounds.play()

func play_click_button():
	$UISounds.stream = click_button_sounds
	$UISounds.play()
	
func play_lose_music():
	$UISounds.stream = lose_game_music
	$UISounds.play()

func set_music_volume(vol: float):
	max_music_volume = vol
	$ExteriorMusicPlayer.volume_db = vol
	$InteriorMusicPlayer.volume_db = vol
	var inside_anim = $AnimationPlayer.get_animation("go_inside")
	var outside_anim = $AnimationPlayer.get_animation("go_outside")
	inside_anim.track_set_key_value(1, 1, max_music_volume)
	inside_anim.track_set_key_value(0, 0, max_music_volume)
	outside_anim.track_set_key_value(0, 1, max_music_volume)
	outside_anim.track_set_key_value(1, 0, max_music_volume)

func set_sfx_volume(vol: float):
	max_sound_volume = vol
	game_sounds.volume_db = vol
	$UISounds.volume_db = vol
	
func get_music_volume():
	return $ExteriorMusicPlayer.volume_db
	
func get_sfx_volume():
	return $UISounds.volume_db

func go_inside():
	$AnimationPlayer.play("go_inside")
	
func go_outside():
	$AnimationPlayer.play("go_outside")

func start_music():
	$MusicPlayer.stop()
	$ExteriorMusicPlayer.play()
	$InteriorMusicPlayer.play()

func start_menu():
	$MusicPlayer.play()

func stop_music():
	$ExteriorMusicPlayer.stop()
	$InteriorMusicPlayer.stop()

func pause_music():
	$ExteriorMusicPlayer.playing = false
	$InteriorMusicPlayer.playing = false
	
func _on_change_mode(mode):
	if mode == 'combat':
		game_sounds.stream = crazy_arms
		game_sounds.play()
