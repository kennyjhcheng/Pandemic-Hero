extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_Puzzle1Portal_body_entered(body):
	animation_player.play("Body_Enter")
	$InstructionLabel.visible = true
	body.overPortal = true
#	print("on Portal: " + str(body.overPortal))


func _on_Puzzle1Portal_body_exited(body):
	animation_player.play("Idle")
	$InstructionLabel.visible = false
	body.overPortal = false
#	print("on Portal: " + str(body.overPortal))
	
#func _on_Puzzle1Portal_input_event(viewport, event, shape_idx):
#	print('ran')
#	if event is InputEventKey and event.pressed:
#		if event.is_action_pressed("ui_accept"):
#			print('changed scene')
#			get_tree().change_scene("res://Scenes/Puzzle 1/Alchemy.tscn")



