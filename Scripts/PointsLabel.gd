extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$label.text = str(points)
	$label.add_color_override("font_color", Color(200, 200, 200))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
