extends Area2D

@export var speed = 1000
@export var damage = 10

func _ready():
	pass

func _physics_process(delta):
	position += Vector2.UP.rotated(rotation) * speed * delta

func _on_life_timer_timeout():
	die()

func die() -> void:
	queue_free()

func _on_body_entered(body):
	if is_in_group("enemy") and body.is_in_group("player"):
		SignalBus.player_damage_taken.emit(damage)
	if is_in_group("player_projectile") and body.is_in_group("enemy"):
		print("Enemy hit")
		pass
	die()
