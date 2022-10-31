extends AudioStreamPlayer


onready var dragstarts := [preload("res://Assets/paper-dragstart0.wav"), 
					preload("res://Assets/paper-dragstart1.wav"),
					preload("res://Assets/paper-dragstart2.wav")]
onready var dragstops :=[
					preload("res://Assets/paper-dragstop0.wav"),
					preload("res://Assets/paper-dragstop1.wav"),
					preload("res://Assets/paper-dragstop2.wav")]
#onready var paper_open := preload("res://Assets/paper-turnpage1.wav")
#onready var paper_close := preload("res://Assets/paper-turnpage2.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	#play()
	pass # Replace with function body.

func play_random_dragstart():
	var i: int = randi() % dragstarts.size()
	if dragstarts[i]:
		stream = dragstarts[i]
	play()
	
func play_random_dragstop():
	var i: int = randi() % dragstops.size()
	if dragstops[i]:
		stream = dragstops[i]
	play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
