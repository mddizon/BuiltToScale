extends WeaponBase

# @onready var arm: Arm = get_parent() # TODO: this is delicate!
var arm = null
var targetGlobalPos = Vector2.ZERO
@onready var hitarea = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	hitarea.body_entered.connect(_on_hit)
	hitarea.area_entered.connect(_on_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hit(body):
	print("sword hit something")
	AudioController.play_game_sound("sword_hit")
	SignalBus.do_screen_shake.emit(true)
