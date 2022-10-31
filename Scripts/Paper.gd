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
			
			sound_player.play_random_dragstart()
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			
		elif Input.is_action_just_released("mouse_click") && dragging:
			dragging = false
			chosen = false
			sound_player.play_random_dragstop() 
			
			
	elif event is InputEventMouseMotion:
		if dragging:
			
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			if (newPosition.x >= 130 && newPosition.y >= -30) :
				#print(newPosition)
				for p in game_node.paper_stack:
					if p.chosen == true:
						#print(" chosen")
						open_paper()
			else:
				close_paper()
			
func _physics_process(delta):
	if dragging:
		move_and_slide((newPosition - position) * Vector2(30, 30))
		
func _ready():
	close_paper()

func open_paper():
	$OpenCollision.disabled = false
	$ClosedCollision.disabled = true
	
	$Closed.visible = false
	$image.visible = true
	$Nome.visible = true
	$DOB.visible = true
	$Sexo.visible = true
	$Cidade.visible = true

func close_paper():
	$OpenCollision.disabled = true
	$ClosedCollision.disabled = false
	
	$Closed.visible = true
	$image.visible = false
	$Nome.visible = false
	$DOB.visible = false
	$Sexo.visible = false
	$Cidade.visible = false
	
func chosen():
	chosen = true
	
func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false
