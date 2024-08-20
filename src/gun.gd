extends WeaponBase

@export var recoil = 500
@export var fireRate = 0.2
@export var recoilTarget: RigidBody2D
@export var is_right: bool

@onready var projectile = preload("res://Scenes/player_projectile.tscn")
@onready var debug = false
@onready var sprite = $Sprite2D
# @onready var arm: Arm = get_parent() # TODO: this is delicate!
var arm = null

var remainingDelay = 0
var angle = 0
var targetGlobalPos = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	arm = get_parent()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (remainingDelay > 0):
		remainingDelay -= delta
	if (remainingDelay < 0):
		remainingDelay = 0
	pass

func _physics_process(delta):
	if arm.enabled:
		var mouse = get_local_mouse_position()
		var meToMouse = position - mouse
		var normalAngle = meToMouse.angle()
		angle = normalAngle - PI / 2
		if (angle < -PI):
			angle += 2 * PI
		targetGlobalPos = get_global_mouse_position()
		var shipPos = get_parent().get_parent().global_position
		#sprite.rotation =  global_position.angle_to_point(targetGlobalPos)
		sprite.look_at(targetGlobalPos)
		if not is_right:
			sprite.rotation -= deg_to_rad(180)

	if Input.is_action_just_pressed("action") and remainingDelay == 0:
		fireBullet()
	
	if debug:
		queue_redraw()
		
func fireBullet():
	var newProjectile = projectile.instantiate()
	newProjectile.rotation = global_position.angle_to_point(targetGlobalPos) - deg_to_rad(90)
	newProjectile.global_position = $Sprite2D/Marker2D.global_position
	newProjectile.add_to_group("player_projectile")
	ship.get_parent().add_child.call_deferred(newProjectile)
	var collider = newProjectile as Area2D

	collider.set_collision_mask_value(1, false)
	collider.set_collision_mask_value(2, false)
	collider.set_collision_mask_value(3, true)
	collider.set_collision_mask_value(4, false)

	remainingDelay = fireRate

	if recoilTarget:
		var recoilDirection = targetGlobalPos - global_position
		recoilTarget.apply_impulse(-recoilDirection.normalized() * recoil, global_position - recoilTarget.global_position)

func _draw():
	if not debug:
		return

	draw_circle(Vector2.ZERO, 30, Color.GREEN)
	var mouse = get_local_mouse_position()
	draw_line(position, mouse, Color.GREEN, 2)
