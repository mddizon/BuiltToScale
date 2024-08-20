extends Control

var left = 'sword'
var right = 'blaster'

func _on_sword_pressed(is_right):
	print('sword picked' + str(is_right))
	if is_right:
		right = 'sword'
	else:
		left = 'sword'

func _on_blaster_pressed(is_right):
	print('blaster picked' + str(is_right))
	if is_right:
		right = 'blaster'
	else:
		left = 'blaster'

func _on_shield_pressed(is_right):
	print('shield picked' + str(is_right))
	if is_right:
		right = 'shield'
	else:
		left = 'shield'

func _on_button_pressed():
	AudioController.play_start_game_button()
	SignalBus.change_mode.emit('interior')
	SignalBus.weapon_picked.emit(left, false)
	SignalBus.weapon_picked.emit(right, true)
