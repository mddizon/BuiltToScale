extends RigidBody2D
class_name Arm

@onready var left_hand = preload("res://Resources/Art/Arms/Hand-Fist_L.png")
@onready var right_hand = preload("res://Resources/Art/Arms/Hand-Fist_R.png")

@export var righty = true : set = _set_hand
@export var enabled = false
@export var drawDebug = false
@export var armSpeedMultiplier = 5

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

func _set_hand(is_right):
	righty = is_right
	print(is_right)
	if righty:
		$Sprite2D.texture = load("res://Resources/Art/Arms/Hand-Fist_L.png")
	else:
		$Sprite2D.texture = load("res://Resources/Art/Arms/Hand-Fist_R.png")

var mouse_pos: Vector2
var ship_relative_pos: Vector2

func _physics_process(delta):
	if (enabled or mouse_pos == Vector2.ZERO or ship_relative_pos == Vector2.ZERO):
		mouse_pos = get_global_mouse_position()
		ship_relative_pos = (mouse_pos - ship.global_position).normalized() * armLength

	var globalHandPos = ship.global_position + ship_relative_pos

	var shipRelative = ship.to_local(globalHandPos)
	var isRight = shipRelative.x > 0
	if (isRight and righty) or (not isRight and not righty):
		var globalOffsetFromHand = globalHandPos - global_position
		apply_central_impulse(globalOffsetFromHand * armSpeedMultiplier)
	else:
		shipRelative.x = -shipRelative.x
		var globalOffsetFromHand = ship.to_global(shipRelative) - global_position
		apply_central_impulse(globalOffsetFromHand * armSpeedMultiplier)

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
		draw_line(Vector2.ZERO, localHandPos, Color.GREEN, 1.0)
	else:
		shipRelative.x = -shipRelative.x
		var localHandPos = to_local(ship.to_global(shipRelative))
		draw_circle(localHandPos, 30, Color.RED)
		draw_line(Vector2.ZERO, localHandPos, Color.RED, 1.0)

	draw_circle(to_local(mouse_pos), 30, Color.BLUE)
