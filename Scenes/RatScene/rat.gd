extends KinematicBody2D


const SPEED = Vector2(120,0)
const ACCELERATION = 500
const FRICTION = 500
const gravity = 4000.0
var velocity = Vector2.ZERO
var rightFaced = false

var direction
var go_right = true

var moving = false
var points = [
	Vector2(868.368,121.737),
	Vector2(93.234,346.478),
	Vector2(920.653,407.294),
	Vector2(79.196,4121.622),
	Vector2(311.127,422.85),
]
var target = points[1]

func _ready():
	pass
		
	
func _physics_process(delta):
	
	pass
	

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
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

	
#	var direction = get_direction()
#	velocity = calculate_move_velocity(velocity,direction,SPEED)
#	velocity = move_and_slide(velocity,Vector2.UP)
#
#	if moving == false:
#		var random_number = randi()% 5
#		target = points[random_number]
#		print("GG",target,position.distance_to(target))
#		move_and_collide(Vector2(10,10))
#		moving = true
#	if position == target:
#
#
#		moving = false	
#		print("GG2",target,position.distance_to(target))
#


