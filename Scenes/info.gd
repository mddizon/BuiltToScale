extends ColorRect

@onready var bbLabel = $RichTextLabel
@export var system: String = 'navigation' : set = _set_text

const navigation = """
[i]Navigation[/i]
[img=32x32]res://Resources/Art/UI/keyboard_w.png[/img] - Engage Thruster
[img=32x32]res://Resources/Art/UI/keyboard_a.png[/img] - Turn Left
[img=32x32]res://Resources/Art/UI/keyboard_d.png[/img] - Turn Right
[img=32x32]res://Resources/Art/UI/mouse_right.png[/img] - Back to Ship
"""

const combat = """
[i]Combat[/i]
Move your mouse to swing weapons
[img=32x32]res://Resources/Art/UI/mouse_right.png[/img] - Change active hand
"""

const interior = """
[i]Interior[/i]
[img=32x32]res://Resources/Art/UI/keyboard_w.png[/img]/[img=32x32]res://Resources/Art/UI/keyboard_a.png[/img]/[img=32x32]res://Resources/Art/UI/keyboard_d.png[/img]/[img=32x32]res://Resources/Art/UI/keyboard_a.png[/img]
Move Around
[img=32x32]res://Resources/Art/UI/mouse_right.png[/img] - Activate System (when near)
"""

func _set_text(system):
	print('change system' + system)
	if system == 'navigation':
		bbLabel.bbcode_text = navigation
	if system == 'combat':
		bbLabel.bbcode_text = combat
	if system == 'interior':
		bbLabel.bbcode_text = interior

# Called when the node enters the scene tree for the first time.
func _ready():
	print('here')
	SignalBus.change_mode.connect(_on_change_mode)
	pass # Replace with function body.

func _on_change_mode(mode: String):
	print('mode')
	system = mode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
