extends Node2D

signal engine_interacted(released: bool)
signal turn_right(released: bool)
signal turn_left(released: bool)
signal swap_left_weapon(weapon_name: String)
signal swap_right_weapon(weapon_name: String)

var current_system = null;

func _on_weapons_locker_interacted(_action_name):
	current_system = "weapons"

func _on_engines_interacted(_action_name):
	current_system = "engines"

func _on_navigation_left_interacted(action_name):
	current_system = "left_nav"

func _on_navigation_right_interacted(action_name):
	current_system = "right_nav"

func _process(_delta):
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
	elif current_system == "left_nav":
		if Input.is_action_pressed("action"):
			emit_signal("turn_left", false)
		elif Input.is_action_just_released("action"):
			emit_signal("turn_left", true)
			current_system = null
	elif current_system == "right_nav":
		if Input.is_action_pressed("action"):
			emit_signal("turn_right", false)
		elif Input.is_action_just_released("action"):
			emit_signal("turn_right", true)
			current_system = null
