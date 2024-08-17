extends Node2D

@onready var interior = preload("res://Scenes/ship_interior.tscn").instantiate()
@onready var exterior = preload("res://Scenes/exterior.tscn").instantiate()
@onready var current_scene = "exterior"
@onready var zoom_inputs = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.add_child(interior)
	get_tree().root.add_child(exterior)
	exterior.z_index = 0
	interior.z_index = -10
	interior.visible = false
	current_scene = "exterior"

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
	var exterior_ship_transform = exterior.get_ship_position();
	interior.position = exterior_ship_transform
	interior.visible = true
	interior.z_index = 10
	exterior.z_index = -10
	current_scene = "interior"

func zoomToExterior():
	var exterior_ship_transform = exterior.get_ship_position();
	interior.position = exterior_ship_transform
	interior.visible = false
	exterior.z_index = 10
	interior.z_index = -10
	current_scene = "exterior"

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_title.tscn")
	AudioController.play_back_button()
