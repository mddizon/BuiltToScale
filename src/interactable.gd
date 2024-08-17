extends Sprite2D

@export var action_name: String
@export var threshhold_distance: float = 130

var player: CharacterBody2D
@onready var label = $Label

signal interacted(action_name: String)

func _ready():
	add_to_group("interactable")
	player = get_parent().get_node("InteriorCharacter")
	label.text = action_name
	label.visible = false
	assert(player, "Player not found")
	# Connects the interacted signal to the interaction controller
	self.connect("interacted", InteractionController.interacted_with_object)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_near = is_player_near();
	label.visible = player_near
	if player_near:
		modulate = Color(1, 1, 1, .5)
	else:
		modulate = Color(1, 1, 1, 1)
	if player_near and Input.is_action_just_pressed("action"):
		emit_signal("interacted", action_name)

func is_player_near():
	var pos1 = player.position
	var pos2 = position
	var dist = pos1.distance_to(pos2)
	# print(dist)
	return dist < threshhold_distance
