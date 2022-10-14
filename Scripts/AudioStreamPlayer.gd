extends AudioStreamPlayer


onready var sounds := [preload("res://Assets/paper-dragstart0.wav"), 
					preload("res://Assets/paper-dragstart1.wav"),
					preload("res://Assets/paper-dragstart2.wav"),
					preload("res://Assets/paper-dragstop0.wav"),
					preload("res://Assets/paper-dragstop1.wav"),
					preload("res://Assets/paper-dragstop2.wav")]

# Called when the node enters the scene tree for the first time.
func _ready():
	#play()
	pass # Replace with function body.

func play_random_sound():
	var i: int = randi() % sounds.size()
	if sounds[i]:
		stream = sounds[i]
	play()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
