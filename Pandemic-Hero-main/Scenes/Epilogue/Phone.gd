extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_Puzzle1Portal_body_entered(body):
	animation_player.play("Body_Enter")
	$InstructionLabel.visible = true
	body.overPortal = true
	print("on Portal: " + str(body.overPortal))


func _on_Puzzle1Portal_body_exited(body):
	animation_player.play("Idle")
	$InstructionLabel.visible = false
	body.overPortal = false
	print("on Portal: " + str(body.overPortal))




