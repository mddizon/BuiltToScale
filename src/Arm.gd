extends RigidBody2D

@onready var hand = $hand
@onready var shoulder = $shoulder

var mouseAngleUpperLimit = PI / 2
var mouseAngleLowerLimit = -PI / 2
const mouseAngleBuffer = 0.2
@export var righty = false
@export var enabled = false

var mouse_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	mouse_pos = get_local_mouse_position()
	queue_redraw()

	if mouse_pos.length() < hand.position.length():
		return
	if not enabled:
		return
	#Get the angle between the shoulder positon and mouse_pos
	var angleToHand = Vector2.ZERO.angle_to_point(hand.position)
	var angleToMouse = Vector2.ZERO.angle_to_point(mouse_pos)
	
	var parentMouse = get_parent().get_local_mouse_position()
	var parentAngle = Vector2.ZERO.angle_to_point(parentMouse)
	print(parentAngle)

	var b = 0.1
	if (righty and (parentAngle < mouseAngleLowerLimit + b or parentAngle > mouseAngleUpperLimit - b)):
		return
	if (not righty and (
		(parentAngle > mouseAngleLowerLimit - b and parentAngle < 0.0) or
		(parentAngle < mouseAngleUpperLimit + b and parentAngle > 0.0))):
		return

	var angleDelta = angleToHand - angleToMouse
	#print("%s, %s, %s", [angleToHand, angleToMouse, angleDelta])
	#if abs(angleDelta) > 0.3:
	var forceDirection = Vector2(hand.position.y, hand.position.x).normalized()
	var force = forceDirection * 60 * angleDelta
	apply_impulse(force, hand.position)
	apply_impulse(-force, shoulder.position)
	
func _draw():
	var angleToHand = Vector2.ZERO.angle_to_point(hand.position)
	var angleToMouse = Vector2.ZERO.angle_to_point(mouse_pos)
	var angleDelta = angleToHand - angleToMouse
	var forceDirection = Vector2(hand.position.y, hand.position.x).normalized()
	draw_line(Vector2.ZERO, hand.position, Color.GREEN, 5.0)
	draw_line(hand.position, hand.position + (forceDirection * angleDelta * 200), Color.RED, 5.0)

	draw_circle(mouse_pos, 30, Color.BLUE)
