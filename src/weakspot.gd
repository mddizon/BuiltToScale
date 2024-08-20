extends RigidBody2D

signal died

@onready var healthbar = $Healthbar

func _ready():
	healthbar.init_health($Health.health)
	pass

func _on_health_health_changed(new_value):
	if new_value <= 0:
		emit_signal('died')
	healthbar.health = new_value
