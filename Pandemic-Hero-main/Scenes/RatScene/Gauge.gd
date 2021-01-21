extends Node2D
var hand
var wait = 0
var speed = 0
func _ready():
	hand = get_node("meterHand")
	

func _physics_process(delta): 
	wait = wait + delta
	print(wait)
	if wait > 0.1:
		if Input.is_action_pressed("left_click"):
			speed = speed +delta
			hand.set_rot(speed)
			wait = 0 
