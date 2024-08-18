extends Node2D

@onready var projectile = preload("res://Scenes/projectile.tscn")

var can_shoot = false;

func _ready():
	$AnimationPlayer.play("fade_in")
	pass

func shoot():
	# create a new projectile instance and give it the cannon position
	var newProjectile = projectile.instantiate()
	newProjectile.rotation = global_rotation
	newProjectile.global_position = global_position
	get_parent().add_child.call_deferred(newProjectile)

func _on_shot_timer_timeout():
	shoot();

func _on_windup_timer_timeout():
	$CooldownTimer.stop()
	$ActiveTimer.start()
	$ShotTimer.start()
	$AnimationPlayer.play("fade_out")
	
func _on_active_timer_timeout():
	$ShotTimer.stop()
	$CooldownTimer.start()
	$ActiveTimer.stop()
	$AnimationPlayer.play("fade_in")
