extends Node2D

@onready var back_button_sounds = preload("res://Resources/Sound/SFX/back_button_randomizer.tres")
@onready var click_button_sounds = preload("res://Resources/Sound/SFX/click_sound_randomizer.tres")
@onready var lose_game_music = preload("res://Resources/Sound/SFX/gmtk lose.ogg")
@onready var win_music = preload("res://Resources/Sound/SFX/gmtk win.ogg")
@onready var confirm_sound = preload("res://Resources/Sound/SFX/gmtk confirm selection.ogg")
@onready var confirm_sounds = preload("res://Resources/Sound/SFX/confirm_randomizer.tres")
@onready var start_game = preload("res://Resources/Sound/SFX/gmtk vo excellent.ogg")
@onready var crazy_arms = preload("res://Resources/Sound/SFX/gmtk vo crazy arms.ogg")
@onready var menu_music = preload("res://Resources/Sound/Music/gmtk menu theme.ogg")
@onready var here_we_go = preload("res://Resources/Sound/SFX/gmtk vo start.ogg")
@onready var activated = preload("res://Resources/Sound/SFX/gmtk battlestation activated.ogg")
@onready var intro = preload("res://Resources/Sound/SFX/gmtk vo its 2024 akimbo.ogg")
@onready var thank_you = preload("res://Resources/Sound/SFX/gmtk vo thank you for saving us.ogg")

@onready var ship_damage = preload("res://Resources/Sound/SFX/gmtk ship damage.ogg")
@onready var ship_engine = preload("res://Resources/Sound/SFX/gmtk ship engine.ogg") # continous?
@onready var sword_hit = preload("res://Resources/Sound/SFX/gmtk sword.ogg")
@onready var gun_fire = preload("res://Resources/Sound/SFX/gmtk gun.ogg")
@onready var enemy_laser = preload("res://Resources/Sound/SFX/gmtk enemy laser.ogg")
@onready var enemy_damage = preload("res://Resources/Sound/SFX/gmtk enemy damage.ogg")
@onready var collision_asteroid = preload("res://Resources/Sound/SFX/gmtk collision asteroid.ogg")
@onready var collision_ship = preload("res://Resources/Sound/SFX/gmtk collision ship.ogg")
@onready var footstep = preload("res://Resources/Sound/SFX/gmtk footstep.ogg")
@onready var growing_scream = preload("res://Resources/Sound/SFX/gmtk growing scream.ogg")

@onready var exterior_music = $ExteriorMusicPlayer
@onready var interior_music = $InteriorMusicPlayer
@onready var animation_player = $AnimationPlayer
@onready var game_sounds = $GameSounds
@onready var game_sounds_2 = $GameSoundsChannel2

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
	$UISounds.stream = confirm_sounds
	$UISounds.play()
	
func play_intro_sound():
	game_sounds_2.stream = intro
	game_sounds_2.play()

func play_click_button():
	$UISounds.stream = click_button_sounds
	$UISounds.play()
	
func play_lose_music():
	$UISounds.stream = lose_game_music
	$UISounds.play()

func play_win_music():
	$UISounds.stream = win_music
	$UISounds.play()

func set_music_volume(vol: float):
	max_music_volume = vol
	$ExteriorMusicPlayer.volume_db = vol
	$InteriorMusicPlayer.volume_db = vol
	$MusicPlayer.volume_db = vol
	var inside_anim = $AnimationPlayer.get_animation("go_inside")
	var outside_anim = $AnimationPlayer.get_animation("go_outside")
	inside_anim.track_set_key_value(1, 1, max_music_volume)
	inside_anim.track_set_key_value(0, 0, max_music_volume)
	outside_anim.track_set_key_value(0, 1, max_music_volume)
	outside_anim.track_set_key_value(1, 0, max_music_volume)

func set_sfx_volume(vol: float):
	max_sound_volume = vol
	game_sounds.volume_db = vol
	game_sounds_2.volume_db = vol
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
	#$ExteriorMusicPlayer.play()
	#$InteriorMusicPlayer.play()

func start_menu():
	$MusicPlayer.play()

func stop_music():
	$ExteriorMusicPlayer.stop()
	$InteriorMusicPlayer.stop()

func pause_music():
	$ExteriorMusicPlayer.playing = false
	$InteriorMusicPlayer.playing = false

func play_game_sound(sound_name):
	AudioStreamPolyphonic.play_game_sound(sound_name)
	if sound_name == 'activated':
		game_sounds_2.stream = activated
	if sound_name == 'thank_you':
		game_sounds_2.stream = thank_you
	if sound_name == 'ship_damage':
		game_sounds_2.stream = ship_damage
	if sound_name == 'ship_engine':
		game_sounds_2.stream = ship_engine
	if sound_name == 'sword_hit':
		game_sounds_2.stream = sword_hit
	if sound_name == 'gun_fire':
		game_sounds_2.stream = gun_fire
	if sound_name == 'enemy_laser':
		game_sounds_2.stream = enemy_laser
	if sound_name == 'enemy_damage':
		game_sounds_2.stream = enemy_damage
	if sound_name == 'collision_asteroid':
		game_sounds_2.stream = collision_asteroid
	if sound_name == 'collision_ship':
		game_sounds_2.stream = collision_ship
	if sound_name == 'footstep':
		game_sounds_2.stream = footstep
	if sound_name == 'growing_scream':
		game_sounds_2.stream = growing_scream
	game_sounds_2.play()
	
func _on_change_mode(mode):
	if mode == 'combat':
		game_sounds.stream = crazy_arms
		game_sounds.play()
