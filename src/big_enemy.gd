extends RigidBody2D

@onready var healthbar = $Healthbar

# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.init_health($Health.health)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_weakspot_died():
	$Health.take_damage(1, self)
	healthbar.health -= 1
	if healthbar.health <= 0:
		SignalBus.enemy_died.emit()
