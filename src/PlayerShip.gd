extends RigidBody2D

signal interacted(action_name: String)

@onready var sword = preload("res://Scenes/sword.tscn")
@onready var gun = preload("res://Scenes/gun.tscn")

@export var thrusts = [0, 100, 500, 1000, 2000]
@export var rotation_speed = 1000
@export var zoom_level_interact = Vector2(2, 2);
@export var zoom_level_exterior = Vector2(5, 5);

@onready var rocketPlumes = [
	$plume_1,
	$plume_2,
	$plume_3,
	$plume_4
]

@onready var leftArm = $LeftArm
@onready var rightArm = $RightArm
@onready var leftBicep = $LeftBicep
@onready var rightBicep = $RightBicep
@onready var leftForearm = $LeftBicep/LeftForearm
@onready var rightForearm = $RightBicep/RightForearm
@onready var healthComponent = $Health

var currentThrustIdx = 0
var controlsDisabled = true;
var combatEnabled = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	angular_damp = 1
	SignalBus.player_damage_taken.connect(on_damage)
	SignalBus.weapon_picked.connect(_on_weapon_picked)
	healthComponent.health = GlobalGameState.player_health
	body_entered.connect(_on_body_entered)
	contact_monitor = true
	max_contacts_reported = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("secondary_action"):
		leftArm.enabled = not leftArm.enabled
		rightArm.enabled = not rightArm.enabled
	pass

func _physics_process(_delta):
	if not controlsDisabled:
		if Input.is_action_pressed("up"):
			burn_engine(false)
		if Input.is_action_just_released("up"):
			burn_engine(true)
		if Input.is_action_pressed("left"):
			turn(true)
		if Input.is_action_pressed("right"):
			turn(false)
	
	if not controlsDisabled or combatEnabled:
		if Input.is_action_just_pressed("down"):
			SignalBus.change_mode.emit('interior')
			combatEnabled = false
			controlsDisabled = true
			disableArms()

	#Move Biceps here
	if combatEnabled:
		leftBicep.rotation = global_position.angle_to_point(leftArm.global_position) - rotation
		leftForearm.look_at(leftArm.global_position)
		leftForearm.rotation -= deg_to_rad(180)
	if combatEnabled:
		rightBicep.rotation = global_position.angle_to_point(rightArm.global_position) - deg_to_rad(180) - rotation
		rightForearm.look_at(rightArm.global_position)

	# Get the orientation vector of the rigitbody 
	var orientation = -global_transform.y.normalized()
	var force = orientation * thrusts[currentThrustIdx]
	apply_central_force(force)
	pass

func _update_camera(released):
	if (released):
		$Camera2D.set_target_zoom(zoom_level_exterior)
	else:
		$Camera2D.set_target_zoom(zoom_level_interact)

func burn_engine(released: bool):
	if (not released):
		currentThrustIdx = 4 # (currentThrustIdx + 1) % len(thrusts)
		# for i in range(4):
		# 	rocketPlumes[i].visible = i == currentThrustIdx
		#rocketPlumes[2].visible = true
		$Plume.visible = true
		AudioController.play_engine(true)
	else:
		currentThrustIdx = 0
		##all plumes off
		#for i in range(4):
			#rocketPlumes[i].visible = false
		$Plume.visible = false
		AudioController.play_engine(false)

func turn(isLeft: bool):
	if isLeft:
		apply_torque_impulse(-rotation_speed)
	else:
		apply_torque_impulse(rotation_speed)

func _on_body_entered(body):
	print("player hit something!")
	AudioController.play_game_sound('collision_ship')
	SignalBus.player_collision.emit(body)

func on_damage(damage):
	AudioController.play_game_sound('ship_damage')
	print('im hit')
	

func enableArms():
	$LeftBicep.visible = true
	$RightBicep.visible = true
	leftForearm.visible = true
	rightForearm.visible = true
	if leftArm.get_parent() != self:
		add_child(leftArm)
	if rightArm.get_parent() != self:
		add_child(rightArm)
	leftArm.visible = true
	rightArm.visible = true
	leftArm.enabled = false
	rightArm.enabled = true

func disableArms():
	$LeftBicep.visible = false
	$RightBicep.visible = false
	rightForearm.visible = false
	leftForearm.visible = false
	if leftArm.get_parent() == self:
		remove_child(leftArm)
	if rightArm.get_parent() == self:
		remove_child(rightArm)
	#rightArm.disabled = true
	#leftArm.disabled = true

func _on_ship_interior_enable_flight_controls():
	controlsDisabled = false
	combatEnabled = false
	$ShipInterior.visible = false
	$Camera2D.set_target_zoom(Vector2(0.5, 0.5))
	disableArms()

func _on_ship_interior_enable_combat():
	controlsDisabled = true
	combatEnabled = true
	$ShipInterior.visible = false
	$Camera2D.set_target_zoom(Vector2(0.5, 0.5))
	enableArms()

func _on_weapon_picked(weapon, is_right):
	print('weapon_picked')
	print(weapon + str(is_right))
	var new_weapon = _make_new_weapon(weapon, is_right)
	if is_right:
		var arm = rightArm.get_child(2)
		rightArm.remove_child(arm)
		rightArm.call_deferred('add_child', new_weapon)
	else:
		var arm = leftArm.get_child(2)
		leftArm.remove_child(arm)
		leftArm.call_deferred('add_child', new_weapon)
	
func _make_new_weapon(weapon, is_right):
	if (weapon == 'sword'):
		return sword.instantiate()
	elif (weapon == 'blaster'):
		var gun = gun.instantiate()
		gun.is_right = is_right
		return gun
