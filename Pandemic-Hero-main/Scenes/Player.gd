extends KinematicBody2D

const SPEED = Vector2(180,0)
const ACCELERATION = 500
const FRICTION = 500
const gravity = 4000.0
var velocity = Vector2.ZERO
export var rightFaced = false
var overPortal = false
var overHandWashPoster = false
var overReadBookPoster = false
var simulatedKeyPress = null

onready var animationPlayer =  $AnimationPlayer
var handleInput = true

enum STATES {
  MoveRight,
  MoveLeft,
  Climb,
  Idle
}
onready var state = STATES.Idle



func _ready():
	simulatedKeyPress = InputEventKey.new()

func _physics_process(delta):
	if handleInput==false:
		if rightFaced == true:
			animationPlayer.play("IdleRight")
		else:
			animationPlayer.play("IdleLeft")
		return
	var direction = get_direction()
	velocity = calculate_move_velocity(velocity,direction,SPEED)
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if velocity != Vector2.ZERO or state!=STATES.Idle:
		
		if velocity > Vector2(0,0) or state==STATES.MoveRight:
			
			$AnimatedSprite.set_animation("WalkRight") 
			rightFaced = true
			animationPlayer.play("WalkRight")
			
		elif velocity < Vector2(0,0) or state==STATES.MoveLeft:
			
			rightFaced = false
			$AnimatedSprite.set_animation("WalkLeft") 
			animationPlayer.play("WalkLeft")
			
	else: 
		if !rightFaced:
			$AnimatedSprite.set_animation("WalkLeft") 
			animationPlayer.play("IdleLeft")
			
		else:
			$AnimatedSprite.set_animation("WalkRight") 
			animationPlayer.play("IdleRight")
			


func _input(event):
	
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			var local_event = make_input_local(event)
				
			if local_event.position.x > 100:
				
				state = STATES.MoveRight
				
			elif local_event.position.x < -100:
				state = STATES.MoveLeft
				
			
		else:
			state = STATES.Idle
		
			
	


func get_direction(right=null,left=null) -> Vector2:
	if state==STATES.Idle:
		return Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			-1.0 if is_on_floor() else 0.0
		)
	else:
		if state == STATES.MoveLeft:
			
			return Vector2(
			-1,
			-1.0 if is_on_floor() else 0.0
			)
		else:
			return Vector2(
			1,
			-1.0 if is_on_floor() else 0.0
			)



func calculate_move_velocity(
	linear_velocity:Vector2,
	direction:Vector2,
	speed:Vector2
) -> Vector2:
	var new_velocity : = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity

func moveRight():
	simulatedKeyPress.scancode = KEY_RIGHT
	simulatedKeyPress.pressed = true # change to false to simulate a key release
	Input.parse_input_event(simulatedKeyPress)
	
func moveLeft():
	
	simulatedKeyPress.scancode = KEY_LEFT
	simulatedKeyPress.pressed = true # change to false to simulate a key release
	Input.parse_input_event(simulatedKeyPress)
	
func stopMove():
	simulatedKeyPress.pressed = false
	Input.parse_input_event(simulatedKeyPress)



func pauseUserInput():
	handleInput = false



func continueUserInput():
	handleInput= true
