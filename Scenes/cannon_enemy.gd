extends Marker2D

@onready var projectile = preload("res://Scenes/projectile.tscn")

@export var num_bullets: int = 5
@export var bullet_speed: int = 1000
@export var vision_length: int = 200
@export var gun_range: int = 300
@export var warn_length = 300
@export var warn_width = 50
@export var damage: int = 10
@export var time_to_shoot: float = 1.0
@export var fire_rate: float = .5

@onready var warn_indicator = $Line2D
@onready var loading_timer = $CooldownTimer
@onready var firing_timer = $FiringTimer

var state: String = 'loading' : set = _on_state_change
var target: Node2D = null
var direction: Vector2 = Vector2.ZERO
var bullets_fired = 0;

func _ready():
	warn_indicator.add_point(Vector2(0, warn_length))
	warn_indicator.visible = true
	warn_indicator.width = warn_width
	firing_timer.wait_time = fire_rate
	loading_timer.wait_time = time_to_shoot
	pass

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
	newProjectile.global_position = global_position
	newProjectile.position = position
	newProjectile.add_to_group("enemy")
	get_parent().add_child.call_deferred(newProjectile)

func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		target = body
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
		state = 'loading'
