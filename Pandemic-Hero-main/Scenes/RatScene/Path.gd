extends Path2D


onready var follow = get_node("PathFollow2D")
var mouseCaught = false

func _ready():
	set_process(true)
	



func _process(delta):
	if get_tree().get_root().get_node("RatScene").inputAllowed==false:
		return
	if mouseCaught :
		$PathFollow2D/Sprite.global_position = lerp($PathFollow2D/Sprite.global_position,get_global_mouse_position(),25*delta)
	else:
		follow.set_offset(follow.get_offset() + 900*delta)

func attachMouseToHand():
	mouseCaught = true
