extends StaticBody2D
class_name WeaponBase

@onready var ship = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#Always rotate to point our rectangular body away from the ship
	var shipPosition = ship.global_position
	var direction = shipPosition - global_position
	var angle = direction.angle()
	rotation = angle
