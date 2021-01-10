extends Sprite

var mouseHeld = false
var gameStart = false
func _process(delta):
	if get_tree().get_root().get_node("RatScene").inputAllowed:
		global_position = lerp(global_position,get_global_mouse_position(),75*delta)
	if mouseHeld:
		
		get_tree().get_root().get_node("RatScene").moveHandToTheRight()
	else :
		get_tree().get_root().get_node("RatScene").lerpHandToZero()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			
			mouseHeld=false
			
		else:
			mouseHeld =true
			#If we wanna make it easier for the player we can increase the number 15 to something greater
			if get_node("../Path/PathFollow2D/Sprite").global_position.distance_to(global_position)<15:
				gameStart = true
				get_node("../Path").attachMouseToHand()
				
