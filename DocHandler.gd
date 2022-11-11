extends Node2D



var rand_generate = RandomNumberGenerator.new()
onready var paper := preload("res://Scenes/Paper.tscn")
onready var paper_id := preload("res://Scenes/Paper_ID.tscn")
var points = 0
onready var first_names_m = ["Gustavo", "Hojin", "Matheus", "Lucca", "Marcelo"]
onready var first_names_f = ["Larissa", "Julia", "Rafaela", "Barbara", "Catharina"]
onready var last_names =  ["Geyer", "Ryu", "Holmsreich", "Molon", "Cohen"]
# Seta um nome aleatorio da lista
# Called when the node enters the scene tree for the first time.
func _ready():
	$label.text = str(points)
	$label.add_color_override("font_color", Color(200, 200, 200))
	
func spawn_doc_set(valid):
	var papers
	#var p1 = spawn_paper("bad")
	#var p2 = spawn_paper("good")
		
	#p2.set_rn(p1.get_rn()) 		
#		rand_generate.randomize()
#		var t = rand_generate.randi_range(0, 1)
#		if(t == 0):
#			type = "good"
#			#print("DEBUG - Spawned good paper")
#			correct = true
#		else:
#			type = "bad"
#			#print("DEBUG - Spawned bad paper")
#			correct = false
#		currPaper = spawn_paper(type)
#		#allowed = false
#		print(str(currPaper.get_instance_id()))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func generate_id():
	rand_generate.randomize()
	return str(self.get_instance_id())+str(rand_generate.randi_range(100, 999))
	
func generate_date(type):
	rand_generate.randomize()
	var d = rand_generate.randi_range(1, 30)
	var m = rand_generate.randi_range(1, 12)
	var y
	if(type == "dob"):
		y = rand_generate.randi_range(1910, 1953)
	else:
		y = rand_generate.randi_range(1960, 1971)
	return str(y) + "."+ str(m) +"." + str(d)

func generate_name(sexo):
	var first_name
	var last_name
	if(sexo == "m"): 
		var i: int = randi() % first_names_m.size()
		if first_names_m[i]:
			first_name = first_names_m[i]
	else:
		var i: int = randi() % first_names_f.size()
		if first_names_f[i]:
			first_name = first_names_f[i]
	
	var i: int = randi() % last_names.size()
	if last_names[i]:
		last_name = last_names[i]
	return [first_name, last_name]
	

func spawn_paper(type):
	var paper
	if(type == "bad"):
		paper = paper_id.instance()
	else:
		paper = paper.instance()
	paper.input_pickable = true
	
	return paper
	#print(paper)
	

