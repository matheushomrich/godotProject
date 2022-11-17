extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Gera uma data de expedicao aleatoria           
var rand_generate = RandomNumberGenerator.new()
func set_random_date():
	rand_generate.randomize()
	var d = rand_generate.randi_range(1, 30)
	var m = rand_generate.randi_range(1, 12)
	var y = rand_generate.randi_range(1950, 1970)
	
	text = str(y) + "."+ str(m) +"." + str(d)
# Called when the node enters the scene tree for the first time.
func _ready():
	set_random_date()
	#text = "Marcelo Cohen"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
