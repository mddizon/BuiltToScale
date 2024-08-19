extends Node2D

@onready var interior = $Exterior/PlayerShip/ShipInterior
@onready var exterior = $Exterior
@onready var spaceCamera = $Exterior/PlayerShip/Camera2D
@onready var spaceship = $Exterior/PlayerShip
@onready var current_scene = "exterior"

@export var zoom_inputs = 3
@export var zoom_level_interior = Vector2(3, 3)
@export var zoom_level_exterior = Vector2(0.5, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioController.start_music()
	spaceCamera.set_target_zoom(zoom_level_interior)
	SignalBus.change_mode.connect(_on_change_mode)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("zoom-out")):
		if GlobalGameState.invert_zoom:
			_dec_zoom()
		else:
			_inc_zoom()
	elif (Input.is_action_just_pressed("zoom-in")):
		if GlobalGameState.invert_zoom:
			_inc_zoom()
		else:
			_dec_zoom()

	if (abs(GlobalGameState.current_zoom_inputs) >= zoom_inputs):
		if (GlobalGameState.current_zoom_inputs > 0):
			#_handle_zoom("zoom-out")
			pass
		else:
			#_handle_zoom("zoom-in")
			pass

func _inc_zoom():
	if (GlobalGameState.current_zoom_inputs < 0):
		GlobalGameState.current_zoom_inputs = 1
	else:
		GlobalGameState.current_zoom_inputs += 1

func _dec_zoom():
	if (GlobalGameState.current_zoom_inputs > 0):
		GlobalGameState.current_zoom_inputs = -1
	else:
		GlobalGameState.current_zoom_inputs -= 1

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
	AudioController.go_inside()
	spaceCamera.set_target_zoom(zoom_level_interior)
	current_scene = "interior"
	spaceship.disableArms()

func zoomToExterior():
	interior.visible = false
	spaceCamera.set_target_zoom(zoom_level_exterior)
	current_scene = "exterior"

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_title.tscn")
	AudioController.play_back_button()

func _on_change_mode(mode):
	if (mode == 'interior'):
		zoomToInterior()
	elif (mode == 'exterior'):
		zoomToExterior()
	elif (mode == 'navigation'):
		zoomToInterior()
		pass
