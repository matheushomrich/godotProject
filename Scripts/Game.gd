extends Node2D

var paper_stack = []

onready var paper_scene := preload("res://Scenes/Paper.tscn")
onready var make_paper_sound := preload("res://Assets/paper-spit.wav")
onready var pointsLabel = get_node("PointsLabel")

func _ready():
	get_tree().current_scene.add_child(pointsLabel)
	$PointsLabel.position += Vector2(820, 10)
	set_process_input(true)
func _input(event):
	if(Input.is_key_pressed(KEY_SPACE)):
		var paper := paper_scene.instance()
		paper.input_pickable = true
		$PointsLabel.points += 10
		$PointsLabel.get_node("label").text = str($PointsLabel.points)
		$AudioStreamPlayer.stream = make_paper_sound
		$AudioStreamPlayer.play()
		get_tree().current_scene.add_child(paper)
		add_paper(paper)
	

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
