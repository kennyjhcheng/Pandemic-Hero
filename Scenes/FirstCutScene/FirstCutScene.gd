extends Node2D



var dialogs = [
	"My grandfather passed away from COVID-19 two days ago...",
	"*Sigh* He meant so much to me...",
	"But I need to go back to my lab to figure out a vaccine for the world.",
	 "for the world."
]
var dialogIndex = 0
onready var animationPlayer = $AnimationPlayer
onready var dialog = $Label
onready var player = $Player
onready var directionLabel = $DirectionLabel
onready var keyboardSoundPosition = $Keyboard.get_playback_position()

func _ready():
	$AudioStreamPlayer.play()
	animationPlayer.play("ThePast")


func sayDialog():
	dialog.visible = true
	dialog.text = dialogs[dialogIndex]
	dialogIndex+=1
	if dialogIndex< len(dialogs):
		print("hey")
		dialog.show()



func closeDialog():
	dialog.hide()
	



func firstWalk():
	player.walkDistance(10)


func _on_Area2D_body_entered(_body):
	animationPlayer.play("TransitionToLab")



func changeSceneToLab():
	animationPlayer.play("fade_to_lab")
	yield(animationPlayer, "animation_finished")
	get_tree().change_scene("res://Scenes/InsideLab/InsideTheLab.tscn")
	


func showDirection():
	directionLabel.show()



func hideDirection():
	directionLabel.hide()



func clearDialog():
	dialog.text=""
	
func playMusic():
	$AudioStreamPlayer.play()

func stopMusic():
	$AudioStreamPlayer.stop()


func playTypeSound():
	$Keyboard.play(keyboardSoundPosition)
	
func stopTypeSound():
	keyboardSoundPosition = $Keyboard.get_playback_position()
	$Keyboard.stop()


func playBreeze():
	$Breeze.play()
