extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cities = ["Pelotas", "Gramado", "Alvorada", "Sao Leopoldo"]
func set_random_city():
	var i: int = randi() % cities.size()
	if cities[i]:
		text = cities[i]
# Called when the node enters the scene tree for the first time.
func _ready():
	set_random_city()
	#text = "Marcelo Cohen"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
