extends Label


var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(points)
	add_color_override("font_color", Color(200, 200, 200))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
