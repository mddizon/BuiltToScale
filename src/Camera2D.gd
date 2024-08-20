extends Camera2D

# Define the target zoom level and smoothing speed
var target_zoom: Vector2 = Vector2(1, 1)
var zoom_speed: float = 5.0 # Higher values result in faster zooming

var trauma = 0
@export var trauma_decay = 3
@export var impact_trauma = 5
@export var damage_trauma = 5
@export var max_trauma = 5

@onready var noise = FastNoiseLite.new()
var noise_x = 0

func _ready():
	# Initialize the target zoom
	zoom = target_zoom

	SignalBus.player_collision.connect(_on_impact)
	SignalBus.player_damage_taken.connect(_on_player_damaged)

	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()
	noise.fractal_octaves = 2

func _process(delta: float):
	# Smoothly interpolate the zoom towards the target zoom
	zoom = lerp(zoom, target_zoom, zoom_speed * delta)

	# Screen shake
	if (trauma > 0):
		print("trauma ", trauma)
		trauma = max(0, trauma - (trauma_decay * delta))
		print("trauma ", trauma)
		# Calculate the screen shake
		var shake = pow(trauma, 3)
		# Set the camera's offset to a random value within the shake range
		noise_x += 1
		var x = noise.get_noise_1d(noise_x) * shake
		var y = noise.get_noise_1d(noise_x * 7) * shake
		var rot = noise.get_noise_1d(noise_x * 11) * shake
		print("shake ", x, y, rot)
		offset = Vector2(x, y)
		rotation = rot
		# Apply the offset to the camera's position

# Function to set the target zoom (can be called from other scripts)
func set_target_zoom(new_zoom: Vector2):
	target_zoom = new_zoom


func _on_impact(other: Node):
	trauma = min(max_trauma, trauma + impact_trauma)

func _on_player_damaged(damage):
	trauma = min(max_trauma, trauma + damage_trauma)
