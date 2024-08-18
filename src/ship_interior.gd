extends Node2D

signal enable_flight_controls()
signal enable_combat()
signal swap_left_weapon(weapon_name: String)
signal swap_right_weapon(weapon_name: String)

var current_system = null;

func _on_weapons_locker_interacted(_action_name):
	current_system = "weapons"

func _on_engines_interacted(_action_name):
	current_system = "engines"

func _process(_delta):
	if not visible:
		return
	
	if current_system == null:
		$InteriorCharacter.player_movement()
	elif current_system == "weapons":
		print("Weapons system")
	elif current_system == "engines":
		if Input.is_action_pressed("action"):
			emit_signal("engine_interacted", false)
		elif Input.is_action_just_released("action"):
			emit_signal("engine_interacted", true)
			current_system = null
	elif current_system == "pilot":
		if Input.is_action_just_pressed("secondary_action"):
			current_system = null
	elif current_system == "combat":
		if Input.is_action_just_pressed("secondary_action"):
			current_system = null

func _on_pilot_interacted(action_name):
	current_system = "pilot"
	emit_signal("enable_flight_controls")

func _on_combat_interacted(action_name):
	current_system = "combat"
