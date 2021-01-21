extends Node2D


onready var animationPlayer = $AnimationPlayer
func _ready():
	animationPlayer.play("phone")

func articleTwo():
	$phone_article2.visible = true
	
func articleThree():
	$phone_article3.visible = true

func articleFour():
	$phone_article4.visible = true

func _input(event):
	if (event is InputEventScreenTouch and event.is_pressed()):
		animationPlayer.playback_speed = 4
		print("hold")
	elif (event is InputEventScreenTouch and not event.is_pressed()):
		print("reelase")
		animationPlayer.playback_speed = 1

func _on_Close_button_up():
	get_tree().quit()
