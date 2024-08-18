extends CanvasLayer

@onready var glitch_material = preload("res://Resources/Art/shaders/static_glitch_shader_mat.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.player_damage_taken.connect(damage_taken)
	$Healthbar.init_health(GlobalGameState.player_health)
	#var shader_material = ShaderMaterial.new()
	#shader_material.set_shader_param("screen_texture", get_viewport().get_texture())

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func damage_taken(_damage: int):
	GlobalGameState.player_health -= _damage	
	$Healthbar.health = GlobalGameState.player_health
	
	#$GlitchScreen.material = glitch_material
