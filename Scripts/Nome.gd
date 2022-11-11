extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var names = ["Geyer, Gustavo", "Ryu, Hojin", "Horlmreich, Matheus", "Molon, Lucca"]

# Seta um nome aleatorio da lista
func set_random_name():
	var i: int = randi() % names.size()
	if names[i]:
		text = names[i]
# Called when the node enters the scene tree for the first time.
func _ready():
	set_random_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
