extends Area2D


func _ready():
	$InstructionLabel.visible = false


func _on_WashHandsPoster_body_entered(body):
	$AnimationPlayer.play("Body_Over")
	$InstructionLabel.visible = true
	body.overHandWashPoster = true


func _on_WashHandsPoster_body_exited(body):
	$AnimationPlayer.play("Idle")
	$InstructionLabel.visible = false
	body.overHandWashPoster = false
