extends Node2D


#onready var pointsLabel = get_node("PointsLabel")
onready var id_scene := preload("res://Scenes/Paper_ID.tscn")
onready var passport_scene := preload("res://Scenes/Paper.tscn")
#### Assets ####
onready var make_paper_sound := preload("res://Assets/paper-spit.wav")
onready var ambience := preload("res://Assets/airport_ambience.ogg")
onready var doc_handler = get_node($DocHandler.get_path())

#onready var paper
var paper_stack = []
var allowed = true
var correct
onready var currPaper

func _ready():
	#$DocHandler.position += Vector2(820, 10)
	set_process_input(true)
	
func _input(event):
	var type
	
	if(Input.is_key_pressed(KEY_SPACE) && allowed):
		var papers = doc_handler.create_entrant("valid")
		something(papers[0])
		something(papers[1])
#		print(papers[0])
	if(Input.is_key_pressed(KEY_1) && !allowed):
		accept_paper(currPaper)
	elif(Input.is_key_pressed(KEY_2) && !allowed):
		deny_paper(currPaper)

func accept_paper(paper):
	if(correct):
		$PointsLabel.points += 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	else:
		$PointsLabel.points -= 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	#erase_paper(paper)
	allowed = true
	
func deny_paper(paper):
	if(!correct):
		$PointsLabel.points += 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	else:
		$PointsLabel.points -= 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
	#erase_paper(paper)
	allowed = true
func add_paper(paper):
	paper_stack.append(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		count += 1

func something(paper):
	get_tree().current_scene.add_child(paper)
	add_paper(paper)

func erase_paper(paper):
	paper_stack.erase(paper)
	paper.queue_free()
	
	
func push_paper_to_top(paper):
	paper_stack.erase(paper)
	add_paper(paper)


