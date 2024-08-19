extends RigidBody2D

@onready var healthbar = $Healthbar

# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.init_health($Health.health)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_health_health_changed(new_value):
	healthbar.health = new_value
	pass # Replace with function body.
