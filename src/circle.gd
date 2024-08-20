extends Control

func _draw():
	var position = Vector2(100, 100)
	var radius = 50
	var color = Color(1, 0, 0)  # Red color
	draw_circle(position, radius, color)

func _ready():
	_draw()
