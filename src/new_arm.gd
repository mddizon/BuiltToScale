extends RigidBody2D

@export var righty = false
@export var enabled = false
@export var drawDebug = false

var armLength: float
@onready var ship = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	var shipPosition = to_local(ship.global_position)
	armLength = shipPosition.length()
	set_linear_damp(20.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var mouse_pos: Vector2
var ship_relative_pos: Vector2

func _physics_process(delta):
	if (enabled or mouse_pos == Vector2.ZERO or ship_relative_pos == Vector2.ZERO):
		mouse_pos = get_global_mouse_position()
		ship_relative_pos = (mouse_pos - ship.global_position).normalized() * armLength
		pass

	var globalHandPos = ship.global_position + ship_relative_pos

	var shipRelative = ship.to_local(globalHandPos)
	var isRight = shipRelative.x > 0
	if (isRight and righty) or (not isRight and not righty):
		var localHandPos = to_local(globalHandPos)
		apply_central_impulse(localHandPos * 5)
	else:
		shipRelative.x = -shipRelative.x
		var localHandPos = to_local(ship.to_global(shipRelative))
		apply_central_impulse(localHandPos * 5)

	if (drawDebug):
		queue_redraw()
	
	
func _draw():
	if (not drawDebug):
		return

	var globalHandPos = ship.global_position + ship_relative_pos
	var shipRelative = ship.to_local(globalHandPos)
	var isRight = shipRelative.x > 0
	if (isRight and righty) or (not isRight and not righty):
		var localHandPos = to_local(globalHandPos)
		draw_circle(localHandPos, 30, Color.GREEN)
	else:
		shipRelative.x = -shipRelative.x
		var localHandPos = to_local(ship.to_global(shipRelative))
		draw_circle(localHandPos, 30, Color.RED)

	draw_circle(to_local(mouse_pos), 30, Color.BLUE)
