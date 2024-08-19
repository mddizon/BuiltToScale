extends WeaponBase

@onready var projectile = preload("res://Scenes/player_projectile.tscn")
@onready var debug = false
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#super._physics_process(delta) # keeping this stable for calculations below
	var mouse = get_local_mouse_position()
	var meToMouse = position - mouse
	var normalAngle = meToMouse.angle()
	var angle = normalAngle - PI / 2
	if (angle < -PI):
		angle += 2 * PI
	sprite.rotation = normalAngle

	if Input.is_action_just_pressed("action"):
		fireBullet(angle)
	
	if debug:
		queue_redraw()
		
func fireBullet(angle):
	
	var newProjectile = projectile.instantiate()
	newProjectile.rotation = angle
	newProjectile.global_position = global_position
	newProjectile.add_to_group("player_projectile")
	ship.get_parent().add_child.call_deferred(newProjectile)
	var collider = newProjectile as Area2D

	collider.set_collision_mask_value(1, false)
	collider.set_collision_mask_value(2, false)
	collider.set_collision_mask_value(3, true)
	collider.set_collision_mask_value(4, false)

func _draw():
	if not debug:
		return

	draw_circle(Vector2.ZERO, 30, Color.GREEN)
	var mouse = get_local_mouse_position()
	draw_line(position, mouse, Color.GREEN, 2)
