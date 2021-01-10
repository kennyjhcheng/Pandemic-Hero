extends Node2D

export var pieceId = 1
var selected = false
var rest_point
var rest_nodes = []
export var positioned = false;

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")	
	rest_point = global_position
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		selected = true

func _physics_process(delta):
	if selected == true:
		global_position = lerp(global_position,get_global_mouse_position(),25*delta)
	else:
		
		global_position = lerp(global_position,rest_point,10*delta)

func _input(event):

	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:

			var shortest_dist = 75
			selected = false
			
			
			for child in rest_nodes:
				
				var distance = global_position.distance_to(child.global_position)
				
				if distance < shortest_dist:
					print(child.get_drop_zone_id())
					if (child.get_drop_zone_id() == pieceId) and (positioned==false):
						print(child,"CORRECT")
						
						child.select()
						rest_point = child.global_position
						shortest_dist = distance
						positioned = true
						get_tree().get_root().get_node("Puzzle3").puzzleCompletion+=1
						if get_tree().get_root().get_node("Puzzle3").puzzleCompletion <=16:
							$Correct.play()
						if get_tree().get_root().get_node("Puzzle3").puzzleCompletion >=17:
							
							get_tree().get_root().get_node("Puzzle3").continue()
					
						
					
		
				
				
		
