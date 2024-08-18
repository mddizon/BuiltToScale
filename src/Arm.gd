extends RigidBody2D

@onready var hand = $hand
@onready var shoulder = $shoulder

var mouse_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	#Get the angle between the shoulder positon and mouse_pos
	var angleToHand = position.angle_to_point(hand.position)
	var angleToMouse = position.angle_to_point(mouse_pos)
	print(angleToHand, angleToMouse)
	var angleDelta = angleToHand - angleToMouse # Set the target velocity of the arm motor to point at the mouse_pos
	if abs(angleDelta) > 0.3:
		var forceDirection = Vector2(hand.position.y, hand.position.x).normalized()
		var force = forceDirection * 60 * angleDelta
		apply_impulse(force, hand.position)
		apply_impulse(-force, shoulder.position)

	mouse_pos = get_local_mouse_position()
	queue_redraw()
	
func _draw():
	var angleToHand = position.angle_to_point(hand.position)
	var angleToMouse = position.angle_to_point(mouse_pos)
	var angleDelta = angleToHand - angleToMouse

	var forceDirection = Vector2(hand.position.y, hand.position.x).normalized()
	draw_line(Vector2.ZERO, hand.position, Color.GREEN, 5.0)
	draw_line(hand.position, hand.position + (forceDirection * angleDelta * 200), Color.RED, 5.0)

	draw_circle(mouse_pos, 30, Color.BLUE)
