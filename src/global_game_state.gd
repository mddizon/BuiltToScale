extends Node2D

var invert_zoom = false
var is_game_over = false
var current_zoom_inputs = 0
var player_health = 100

func reset_game():
	is_game_over = false
	player_health = 100
