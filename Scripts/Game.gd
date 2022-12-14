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
	
	if($RejectButton/TextureButton.pressed && !allowed):
		deny_paper(currPaper)
	if($AcceptButton/TextureButton.pressed && !allowed):
		accept_paper(currPaper)
				
	
	if(Input.is_key_pressed(KEY_SPACE) && allowed):
		var papers = doc_handler.spawn_doc_set_1(false)
		reg_instances(papers)

func accept_paper(paper):
	if(correct):
		$DocHandler.points += 10
		$DocHandler.get_node("label").text = str($DocHandler.points)
	else:
		$DocHandler.points -= 10
		$DocHandler.get_node("label").text = str($DocHandler.points)
	#erase_paper(paper)
	allowed = true
	
func deny_paper(paper):
	if(!correct):
		$DocHandler.points += 10
		$DocHandler.get_node("label").text = str($DocHandler.points)
	else:
		$DocHandler.points -= 10
		$DocHandler.get_node("label").text = str($DocHandler.points)
	#erase_paper(paper)
	allowed = true
func add_paper(paper):
	paper_stack.append(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		count += 1

func reg_instances(papers):
	for p in papers:
		get_tree().current_scene.add_child(p)
		add_paper(p)

func erase_paper(paper):
	paper_stack.erase(paper)
	paper.queue_free()
	
	
func push_paper_to_top(paper):
	paper_stack.erase(paper)
	add_paper(paper)


