extends Line2D


var point 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	point = global_position
	add_point(point)
