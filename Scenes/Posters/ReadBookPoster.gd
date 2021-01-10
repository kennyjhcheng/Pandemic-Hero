extends Area2D


func _ready():
	$InstructionLabel.visible = false
	



func _on_ReadBookPoster_body_entered(body):
	$AnimationPlayer.play("Body_Over")
	$InstructionLabel.visible = true
	body.overReadBookPoster = true


func _on_ReadBookPoster_body_exited(body):
	$AnimationPlayer.play("Idle")
	$InstructionLabel.visible = false
	body.overReadBookPoster = false
