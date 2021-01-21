extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.


func _input(event):
	if (event.is_action_pressed("ui_accept")) or (event is InputEventScreenTouch && event.is_pressed()):
		animationPlayer.playback_speed = 4
	else:
		animationPlayer.playback_speed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
