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

# Logica de arrastar e largar documentos

func init(nome, dob, sexo, cidade, rn):
	$Nome.text = nome
	$DOB.text = dob
	$Sexo.text = sexo
	$Cidade.text = cidade
	$RN.text = rn
	
func set_att(attribute, text):
	var att
	match attribute:
		0:
			$Nome.text = text
		1:
			$DOB.text = text
		2:
			$Sexo.text = text
		3:
			$Cidade.text = text
		4:
			$RN.text = text
		

func _input(event):
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
			
			# Determina quando o documento eh aberto ou fechado
	elif event is InputEventMouseMotion:
		if dragging:
			
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			if (newPosition.x >= 130 && newPosition.y >= -30) :
				#print(newPosition)
				for p in game_node.paper_stack:
					if p.chosen == true:
						open_paper()
			else:
				close_paper()

# Movimenta o objeto sendo arrastado a cada frame para a posicao do mouse			
func _physics_process(delta):
	if dragging:
		move_and_slide((newPosition - position) * Vector2(25, 25))
		
func _ready():
	pass #close_paper()

 ## mudar pra papeis diferentes
func open_paper():
	$OpenCollision.disabled = false
	$ClosedCollision.disabled = true
	
	$Closed.visible = false
	$image.visible = true
	$Nome.visible = true
	$DOB.visible = true
	$Sexo.visible = true
	$Cidade.visible = true
	$RN.visible = true
func close_paper():
	$OpenCollision.disabled = true
	$ClosedCollision.disabled = false
	
	$Closed.visible = true
	$image.visible = false
	$Nome.visible = false
	$DOB.visible = false
	$Sexo.visible = false
	$Cidade.visible = false
	$RN.visible = false
	

func chosen():
	chosen = true
	
func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false
