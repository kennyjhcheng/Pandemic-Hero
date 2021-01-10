extends Node2D



func _ready():
	$AnimationPlayer.play("phone")

func articleTwo():
	$phone_article2.visible = true
	
func articleThree():
	$phone_article3.visible = true

func articleFour():
	$phone_article4.visible = true
