extends Label


var rand_generate = RandomNumberGenerator.new()

func _ready():
	generate_id()

func generate_id():
	rand_generate.randomize()
	text = str(self.get_instance_id())+str(rand_generate.randi_range(100, 999))
	
