extends WeaponBase

# @onready var arm: Arm = get_parent() # TODO: this is delicate!
var arm = null
var targetGlobalPos = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("sword hit something")
