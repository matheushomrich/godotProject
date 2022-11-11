extends KinematicBody2D

var draggingDistance
var dir
var dragging
var newPosition = Vector2()


var mouse_in = false
var chosen = false

onready var sound_player = get_node("/root/Game/AudioStreamPlayer")
onready var game_node = get_node("/root/Game")

onready var closed = preload("res://Assets/ID_closed.png")
onready var open_back = preload("res://Assets/ID_back.png")

# Logica de arrastar e largar documentos

func init(nome, dob, sexo, cidade_natal, rn, doe):
	$Nome.text = nome
	$DOB.text = dob
	$DOE.text = doe
	$Sexo.text = sexo
	$Cidade_Natal.text = cidade_natal
	$RN.text = rn

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
			if (newPosition.x >= 120 && newPosition.y >= -100) :
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
	close_paper()

 ## mudar pra papeis diferentes
func open_paper():
	$OpenCollision.disabled = false
	$ClosedCollision.disabled = true
	
	$Closed.visible = false
	$image.visible = true
	$Nome.visible = true
	$DOB.visible = true
	$DOE.visible = true
	$Cidade_Natal.visible = true
	$RN.visible = true
	
func close_paper():
	$OpenCollision.disabled = true
	$ClosedCollision.disabled = false
	
	$Closed.visible = true
	$image.visible = false
	$Nome.visible = false
	$DOB.visible = false
	$DOE.visible = false
	$Cidade_Natal.visible = false
	$RN.visible = false
	
func get_rn():
	return $RN.text
	
func chosen():
	chosen = true
	
func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false
