extends Node

@export var damage = 1
@export var hurtsPlayer = false
@export var hurtsEnemy = false
@export var hurtsAsteroid = false

@export var hitParticle = preload("res://Scenes/hit_flash.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if parent is Area2D:
		parent.body_entered.connect(_on_body_entered_area)
	if parent is RigidBody2D:
		parent.body_entered.connect(_on_body_entered_rigidBody)

func _on_body_entered_rigidBody(body):
	commonBodyEntered(body)

func _on_body_entered_area(body):
	var parent = get_parent() as Area2D
	var space_state = parent.get_world_2d().direct_space_state
	var parameters = PhysicsShapeQueryParameters2D.new()
	parameters.shape = parent.get_node("CollisionShape2D").get_shape()
	parameters.transform = parent.get_global_transform()
	parameters.exclude = [self]
	parameters.collide_with_areas = true
	var result = space_state.collide_shape(parameters)
	if (result.size() > 0):
		var hit = result[0]
		var particle = hitParticle.instantiate()
		particle.global_position = hit
		particle.emitting = true
		if not GlobalGameState.is_game_over:
			get_tree().current_scene.add_child(particle)

	commonBodyEntered(body)

func commonBodyEntered(body):
	if not body.has_node("Health"):
		return
	var healthNode = body.get_node("Health")
	if (hurtsAsteroid && healthNode.isAsteroid) || (hurtsPlayer && healthNode.isPlayer) || (hurtsEnemy && healthNode.isEnemy):
		healthNode.take_damage(damage, self)
