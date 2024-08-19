extends Node2D

@onready var cursor = $CharacterBody2D

func _process(delta):
	cursor.position = get_global_mouse_position()
