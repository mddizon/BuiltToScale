extends Node2D

signal interacted(action_name: String)

# Listens for interaction events and triggers them
func _ready():
	# Connects the interacted signal to the interaction controller
	pass

func interacted_with_object(action_name: String):
	print("Interacted with object: " + action_name)
