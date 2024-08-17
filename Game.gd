extends Node2D

var interior = preload("res://Scenes/ship_interior.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print('process' + str(_delta))
	if (Input.is_action_just_pressed("zoom-out")):
		#render interior on top of the current scene
		get_tree().root.add_child(interior)
		z_index = -5
		interior.z_index = 0
	elif (Input.is_action_just_pressed("zoom-in")):
		interior.z_index = -5
		z_index = 0
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui_title.tscn")
	AudioController.play_back_button()
