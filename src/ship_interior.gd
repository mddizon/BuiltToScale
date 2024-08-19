extends Node2D

signal enable_flight_controls()
signal enable_combat()
signal swap_left_weapon(weapon_name: String)
signal swap_right_weapon(weapon_name: String)

var current_system = null : set = _set_system;

func _on_weapons_locker_interacted(_action_name):
	if not current_system == "weapons":
		AudioController.play_game_sound('activated')
		current_system = "weapons"

func _on_engines_interacted(_action_name):
	if not current_system == "engines":
		AudioController.play_game_sound('activated')
		current_system = "engines"

func _ready():
	SignalBus.change_mode.connect(_on_change_mode)

func _process(_delta):
	if not visible:
		return
	
	if current_system == null:
		$InteriorCharacter.player_movement()
	elif current_system == "engines":
		if Input.is_action_pressed("action"):
			emit_signal("engine_interacted", false)
		elif Input.is_action_just_released("action"):
			emit_signal("engine_interacted", true)
			
func _set_system(new_system):
	if new_system == current_system:
		return
	
	print(str(current_system) + '->' + str(new_system))
	if current_system == 'combat' || current_system == 'pilot':
		AudioController.go_inside()

	current_system = new_system

func _on_change_mode(mode):
	if mode == 'interior':
		current_system = null

func _on_pilot_interacted(action_name):
	if not current_system == 'pilot':
		AudioController.play_game_sound('activated')
		current_system = "pilot"
		SignalBus.change_mode.emit('navigation')
		emit_signal("enable_flight_controls")

func _on_combat_interacted(action_name):
	if not current_system == "combat":
		AudioController.go_outside()
		AudioController.play_game_sound('activated')
		SignalBus.change_mode.emit('combat')
		emit_signal("enable_combat")
		current_system = "combat"
