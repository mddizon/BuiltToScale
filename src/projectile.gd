extends Area2D

@export var speed = 1000
@export var damage = 1
@export var spawn_particle: PackedScene

func _ready():
	#Instantiate the spawn particle
	var particle = spawn_particle.instantiate()
	particle.global_position = global_position
	particle.rotation = global_rotation
	particle.emitting = true
	get_tree().current_scene.add_child(particle)

	pass

func _physics_process(delta):
	position += Vector2.DOWN.rotated(rotation) * speed * delta

func _on_life_timer_timeout():
	die()

func die() -> void:
	queue_free()

func _on_body_entered(body):
	die()
