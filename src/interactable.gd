extends Sprite2D

@export var action_name: String
@export var threshhold_distance: float = 130
@export_multiline var description: String = "Add description here"

var player: CharacterBody2D
var player_near = false
@onready var text_container = $CanvasLayer/ColorRect3
@onready var text_description = $CanvasLayer/ColorRect3/RichTextLabel

signal interacted(action_name: String)

func _ready():
	add_to_group("interactable")
	player = get_parent().get_node("InteriorCharacter")
	text_container.visible = false
	text_description.text = description
	assert(player, "Player not found")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_near and Input.is_action_just_pressed("action"):
		emit_signal("interacted", action_name)

func is_player_near():
	var pos1 = player.position
	var pos2 = position
	var dist = pos1.distance_to(pos2)
	# print(dist)
	return dist < threshhold_distance

func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		player_near = true
		text_container.visible = true
		modulate = Color(1, 1, 1, .5)

func _on_area_2d_body_exited(body):
	if body.is_in_group('player'):
		player_near = false
		text_container.visible = false
		modulate = Color(1, 1, 1, 1)
