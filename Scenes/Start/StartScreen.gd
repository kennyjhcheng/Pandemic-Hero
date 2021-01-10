extends Node2D


func _ready():
	OS.set_window_title('Pandemic Hero')
	$Background/DefaultWindowButton.disabled = true
	$AnimationPlayer.play("Reset")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("MouseSpook")


func _on_DefaultWindowButton_button_down():
	$Background/DefaultWindowButton.disabled = true
	$Background/FullScreenButton.disabled = false
	OS.window_fullscreen = false


func _on_FullScreenButton_button_down():
	$Background/DefaultWindowButton.disabled = false
	$Background/FullScreenButton.disabled = true
	OS.window_fullscreen = true


func _on_PlayButton_button_up():
	$ClickAudio.play()
	var fadeOut = load("res://Scenes/FadeOutAnimation.tscn")
	var fadeOutInstance = fadeOut.instance()
	fadeOutInstance.name = 'fade'
	self.add_child(fadeOutInstance)
	get_node('fade').get_node('AnimationPlayer').play('FadeOut')
	yield(get_node('fade').get_node('AnimationPlayer'), 'animation_finished')
	get_tree().change_scene("res://Scenes/FirstCutScene/FirstCutScene.tscn")
