extends Camera2D

# Define the target zoom level and smoothing speed
var target_zoom: Vector2 = Vector2(1, 1)
var zoom_speed: float = 5.0  # Higher values result in faster zooming

func _ready():
	# Initialize the target zoom
	zoom = target_zoom

func _process(delta: float):
	# Smoothly interpolate the zoom towards the target zoom
	zoom = lerp(zoom, target_zoom, zoom_speed * delta)

# Function to set the target zoom (can be called from other scripts)
func set_target_zoom(new_zoom: Vector2):
	target_zoom = new_zoom
