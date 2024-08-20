extends Sprite2D

var arm = null
@export var is_right: bool

var angle = 0
var targetGlobalPos = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	arm = get_parent()
	pass # Replace with function body.

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
		look_at(targetGlobalPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
