extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var line_poly = Geometry2D.offset_polyline(points, .5)
	
	for poly in line_poly:
		var col = CollisionPolygon2D.new()
		col.polygon = poly
		get_parent().add_child.call_deferred(col)
