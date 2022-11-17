extends Node2D



var rand_generate = RandomNumberGenerator.new()
onready var paper_passport := preload("res://Scenes/Paper.tscn")
onready var paper_id := preload("res://Scenes/Paper_ID.tscn")
var points = 0
onready var first_names_m = ["Gustavo", "Hojin", "Matheus", "Lucca", "Marcelo"]
onready var first_names_f = ["Larissa", "Julia", "Rafaela", "Barbara", "Catharina"]
onready var last_names =  ["Geyer", "Ryu", "Holmsreich", "Molon", "Cohen"]

var cities = ["Pelotas", "Gramado", "Alvorada", "Sao Leopoldo", "Porto Alegre"]

# Seta um nome aleatorio da lista
# Called when the node enters the scene tree for the first time.
func _ready():
	$label.text = str(points)
	$label.add_color_override("font_color", Color(200, 200, 200))
	
func create_entrant(valid):
	rand_generate.randomize()
	var entrant
	
	if (randf() > 0.5): # 50/50 entre gerar homem ou mulher
		entrant = spawn_doc_set_1("M")
	else:
		entrant = spawn_doc_set_1("F")
	
	return entrant
#	

func generate_random_city():
	rand_generate.randomize()
	var city
	var i: int = randi() % cities.size()
	if cities[i]: 
		city = cities[i]
	return city

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
	if(sexo == "M"): 
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
	

func spawn_doc_set_1(sex):
	var passport
	var id
	
	var name_array = generate_name(sex)
	var dob = generate_date("dob")
	var iss = generate_random_city()
	var nat = generate_random_city()
	var rn = generate_id()
	var doe = generate_date("doe")
	
	
	id = paper_id.instance()
	id.init(str(name_array[0]+" "+name_array[1]), #fazer isso no init!!
	dob,  
	nat, 
	rn, 
	doe)
	
	passport = paper_passport.instance()
	passport.init(str(name_array[1]+", "+name_array[0]), dob, sex, iss, rn)
	
	passport.input_pickable = true
	id.input_pickable = true
	
	return [passport, id]
	#print(paper)
	

