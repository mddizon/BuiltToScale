extends WeaponBase

@onready var projectile = preload("res://Scenes/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	super._physics_process(delta)
	if Input.is_action_just_pressed("action"):
		fireBullet()
	queue_redraw()
		
func fireBullet():
	var mouse = get_local_mouse_position()
	var angle = get_angle_to(mouse)
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
	draw_circle(Vector2.ZERO, 30, Color.GREEN)
	var mouse = get_global_mouse_position()
	var angle = global_position.angle_to(mouse)
	draw_line(position, (Vector2.LEFT * 100).rotated(angle), Color.GREEN, 2)
