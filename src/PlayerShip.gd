extends RigidBody2D

signal interacted(action_name: String)

@export var thrusts = [0, 10, 50, 100, 200]
@export var rotation_speed = 100

@onready var rocketPlumes = [
	$plume_1,
	$plume_2,
	$plume_3,
	$plume_4
]

var currentThrustIdx = 0
var controlsDisabled = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	angular_damp = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):

	# Get the orientation vector of the rigitbody 
	var orientation = -global_transform.y.normalized()
	var force = orientation * thrusts[currentThrustIdx]
	apply_central_force(force)
	pass


func _on_ship_interior_engine_interacted(released):
	if (not released):
		currentThrustIdx = 4 # (currentThrustIdx + 1) % len(thrusts)
		# for i in range(4):
		# 	rocketPlumes[i].visible = i == currentThrustIdx
		rocketPlumes[2].visible = true
	else:
		#all plumes off
		for i in range(4):
			rocketPlumes[i].visible = false

func _on_ship_interior_turn_left(released):
	if not released:
		apply_torque_impulse(-rotation_speed)

func _on_ship_interior_turn_right(released):
	if not released:
		apply_torque_impulse(rotation_speed)
