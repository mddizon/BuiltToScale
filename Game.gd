extends Node2D

@onready var interior = $Exterior/PlayerShip/ShipInterior
@onready var exterior = $Exterior
@onready var spaceCamera = $Exterior/PlayerShip/Camera2D
@onready var spaceship = $Exterior/PlayerShip
@onready var current_scene = "exterior"
@onready var zoom_inputs = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("zoom-out")):
		if (GlobalGameState.current_zoom_inputs < 0):
			GlobalGameState.current_zoom_inputs = 1
		else:
			GlobalGameState.current_zoom_inputs += 1
	elif (Input.is_action_just_pressed("zoom-in")):
		if (GlobalGameState.current_zoom_inputs > 0):
			GlobalGameState.current_zoom_inputs = -1
		else:
			GlobalGameState.current_zoom_inputs -= 1

	if (abs(GlobalGameState.current_zoom_inputs) >= zoom_inputs):
		if (GlobalGameState.current_zoom_inputs > 0):
			_handle_zoom("zoom-out")
		else:
			_handle_zoom("zoom-in")

func _handle_zoom(direction: String):
	GlobalGameState.current_zoom_inputs = 0
	if current_scene == "exterior" and direction == "zoom-in":
		zoomToInterior()
	elif current_scene == "exterior" and direction == "zoom-out":
		print("Already in exterior")
		pass
	elif current_scene == "interior" and direction == "zoom-in":
		print("Already in interior")
		print("Potentially zoom in more")
		pass
	elif current_scene == "interior" and direction == "zoom-out":
		zoomToExterior()
		pass

func zoomToInterior():
	interior.visible = true
	spaceCamera.zoom = Vector2(5, 5)
	spaceship.controlsDisabled = true
	current_scene = "interior"


func zoomToExterior():
	interior.visible = false
	spaceship.controlsDisabled = false
	spaceCamera.zoom = Vector2(0.5, 0.5)
	current_scene = "exterior"

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_title.tscn")
	AudioController.play_back_button()
