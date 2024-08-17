extends RigidBody2D

@export var thrusts = [0, 10, 50, 100, 200]

@onready var rocketPlumes = [
	$plume_1,
	$plume_2,
	$plume_3,
	$plume_4
]

var currentThrustIdx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	angular_damp = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(_delta):

	if (Input.is_action_pressed("space")):
		currentThrustIdx = 4 # (currentThrustIdx + 1) % len(thrusts)
		# for i in range(4):
		# 	rocketPlumes[i].visible = i == currentThrustIdx
		rocketPlumes[2].visible = true
	else:
		#all plumes off
		for i in range(4):
			rocketPlumes[i].visible = false

	if (Input.is_action_pressed("left")):
		apply_torque_impulse(100)

	if (Input.is_action_pressed("right")):
		apply_torque_impulse(-100)

	# Rotational damping

	# Get the orientation vector of the rigitbody 
	var orientation = -global_transform.y.normalized()
	var force = orientation * thrusts[currentThrustIdx]
	apply_central_force(force)
	pass
