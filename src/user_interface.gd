extends CanvasLayer

@onready var game_over_screen = preload("res://Scenes/game_over_screen.tscn")
@onready var win_screen = preload("res://Scenes/win.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.player_damage_taken.connect(damage_taken)
	$Healthbar.init_health(GlobalGameState.player_health)
	SignalBus.enemy_died.connect(_update_remaining)
	$Remaining/Label2.text = str(GlobalGameState.num_enemies)
	SignalBus.change_mode.connect(_on_change_mode)
	#var shader_material = ShaderMaterial.new()
	#shader_material.set_shader_param("screen_texture", get_viewport().get_texture())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func damage_taken(_damage: int):
	GlobalGameState.player_health -= _damage
	$Healthbar.health = GlobalGameState.player_health
	if GlobalGameState.player_health <= 0 and GlobalGameState.is_game_over == false:
		GlobalGameState.is_game_over = true
		# load game over screen
		get_tree().call_deferred('change_scene_to_packed', game_over_screen)
	#$GlitchScreen.material = glitch_material
	
func _update_remaining():
	GlobalGameState.num_enemies -= 1
	$Remaining/Label2.text = str(GlobalGameState.num_enemies)
	if GlobalGameState.num_enemies <= 0 and GlobalGameState.is_game_over == false:
		GlobalGameState.is_game_over = true
		get_tree().call_deferred('change_scene_to_packed', win_screen)

func _on_change_mode(mode):
	if mode == 'weapons':
		$WeaponPicker.visible = true
	else:
		$WeaponPicker.visible = false
