extends KinematicBody2D

var draggingDistance
var dir
var dragging
var newPosition = Vector2()

var mouse_in = false
var chosen = false

onready var sound_player = get_node("/root/Game/AudioStreamPlayer")
onready var game_node = get_node("/root/Game")

onready var closed = preload("res://Assets/passport-closed.jpg")
onready var open = preload("res://Assets/passport.png")

func _input(event):
	#input_pickable = true
	if event is InputEventMouseButton:
		if chosen and event.is_pressed() and mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			
			sound_player.play_random_sound()
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			
		else:
			dragging = false
			chosen = false
			
			
	elif event is InputEventMouseMotion:
		if dragging:
			
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			if (newPosition.x >= 300) :
				
				for p in game_node.paper_stack:
					if p.chosen == true:
						#print(" chosen")
						$image.texture = closed
						$Label2.visible = false
			else:
				$image.texture = open
				$Label2.visible = true
			
func _physics_process(delta):
	if dragging:
		move_and_slide((newPosition - position) * Vector2(30, 30))


func chosen():
	chosen = true
	
func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false
