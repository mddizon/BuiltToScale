extends Node

@export var damage = 1
@export var hurtsPlayer = false
@export var hurtsEnemy = false
@export var hurtsAsteroid = false

var targetGroup = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if parent is Area2D:
		parent.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if not body.has_node("Health"):
		return
	var healthNode = body.get_node("Health")
	if (hurtsAsteroid && healthNode.isAsteroid) || (hurtsPlayer && healthNode.isPlayer) || (hurtsEnemy && healthNode.isEnemy):
		healthNode.take_damage(damage, self)
