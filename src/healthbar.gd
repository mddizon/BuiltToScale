extends ProgressBar

var health = 0 : set = _set_health

func init_health(_health):
	health = _health
	max_value = _health
	value = _health
	$Damagebar.max_value = _health
	$Damagebar.value = _health

func _set_health(new_health):
	var prev_health = health

	health = min(max_value, new_health)
	value = health

	if health < prev_health:
		$HealthWaitTimer.start()
	else:
		$Damagebar.value = health
	
func _on_health_wait_timer_timeout():
	$Damagebar.value = health
