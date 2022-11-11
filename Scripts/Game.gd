extends Node2D


var paper_stack = []
var rand_generate = RandomNumberGenerator.new()
onready var pointsLabel = get_node("PointsLabel")

#### Assets ####
onready var paper_scene := preload("res://Scenes/Paper.tscn")
onready var bad_paper := preload("res://Scenes/Paper_ID.tscn")
onready var make_paper_sound := preload("res://Assets/paper-spit.wav")
onready var ambience := preload("res://Assets/airport_ambience.ogg")
#onready var paper
var allowed = true
var correct
onready var currPaper

func _ready():
	$PointsLabel.position += Vector2(820, 10)
	set_process_input(true)
	
func _input(event):
	var type
	
	if(Input.is_key_pressed(KEY_SPACE) && allowed):
		var p1 = spawn_paper("bad")
		var p2 = spawn_paper("good")
		
		p2.set_rn(p1.get_rn()) 		
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
#	if(Input.is_key_pressed(KEY_1) && !allowed):
#		accept_paper(currPaper)
#	elif(Input.is_key_pressed(KEY_2) && !allowed):
#		deny_paper(currPaper)

func accept_paper(paper):
	if(correct):
		$PointsLabel.points += 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	else:
		$PointsLabel.points -= 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	erase_paper(paper)
	allowed = true
	
func deny_paper(paper):
	if(!correct):
		$PointsLabel.points += 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	else:
		$PointsLabel.points -= 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	erase_paper(paper)
	allowed = true

func spawn_paper(type):
	var paper
	if(type == "bad"):
		paper = bad_paper.instance()
	else:
		paper = paper_scene.instance()
	paper.input_pickable = true
	$AudioStreamPlayer.stream = make_paper_sound
	$AudioStreamPlayer.play()
	get_tree().current_scene.add_child(paper)
	add_paper(paper)
	return paper
	#print(paper)

func add_paper(paper):
	paper_stack.append(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		
		count += 1
		
func erase_paper(paper):
	paper_stack.erase(paper)
	paper.queue_free()
	
	
func push_paper_to_top(paper):
	paper_stack.erase(paper)
	add_paper(paper)
