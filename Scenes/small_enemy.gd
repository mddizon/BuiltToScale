extends RigidBody2D

@onready var projectile = preload("res://Scenes/projectile.tscn")

@export var vision_length: int = 200
@export var gun_range: int = 300
@export var rotation_speed: float = 0.01 # must be between 0 and 1
@export var warn_length = 300
@export var warn_width = 50
@export var damage: int = 10
@export var num_bullets: int = 1
@export var time_to_shoot: float = 1.0
@export var fire_rate: float = .5

@onready var gun_ray = $RayCast2D
@onready var warn_indicator = $Line2D
@onready var loading_timer = $LoadingTimer
@onready var firing_timer = $FiringTimer
@onready var sensor_area = $Area2D/CollisionShape2D

var state: String = 'idle' : set = _on_state_change
var target: Node2D = null
var direction: Vector2 = Vector2.ZERO
var bullets_fired = 0;

func _ready():
	sensor_area.shape.radius = vision_length
	gun_ray = $RayCast2D
	gun_ray.target_position.y = gun_range
	state = 'idle'
	warn_indicator.add_point(Vector2(0, warn_length))
	warn_indicator.visible = false
	warn_indicator.width = warn_width
	pass

func _physics_process(delta):
	if target && (state == 'targetting' || state == 'loading'):
		rotation = lerp_angle(rotation, position.angle_to_point(target.global_position) - deg_to_rad(90), rotation_speed)
	if target && state == 'targetting' && gun_ray.is_colliding() && gun_ray.get_collider().is_in_group('player'):
		state = 'loading'

func _on_state_change(new_state):
	if new_state == state:
		return
	elif new_state == 'loading':
		warn_indicator.visible = true
		loading_timer.start()
	elif new_state == 'firing':
		bullets_fired = 0
		firing_timer.start()
	state = new_state

func shoot():
	warn_indicator.visible = false
	var newProjectile = projectile.instantiate()
	newProjectile.rotation = global_rotation
	newProjectile.global_position = $Marker2D.global_position
	newProjectile.add_to_group("enemy")
	get_parent().add_child.call_deferred(newProjectile)

func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		target = body
		gun_ray.enabled = true
		state = 'targetting'

func _on_area_2d_body_exited(body):
	if body.is_in_group('player'):
		target = null
		state = 'idle'

func _on_loading_timer_timeout():
	state = 'firing'

func _on_firing_timer_timeout():
	if bullets_fired < num_bullets:
		shoot()
		bullets_fired += 1
	else:
		firing_timer.stop()
		if target:
			state = 'targetting'
		else:
			state = 'idle'
