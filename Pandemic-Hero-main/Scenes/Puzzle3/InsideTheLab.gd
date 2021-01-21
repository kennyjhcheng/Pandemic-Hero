extends Node2D


var dialogs = [
	"My lab..let's create the vaccine."
]
var dialogIndex = 0
onready var animationPlayer = $AnimationPlayer
onready var player = $Player
onready var keyboardSoundPosition = 0.5

func _ready():
	
	$Player/AnimationPlayer.play("IdleRight")
	$AudioStreamPlayer.play()
	
	animationPlayer.play("EnteringLab")
	


func sayDialog():
	if dialogIndex< len(dialogs):
		$Label.text = dialogs[dialogIndex]
		$Label.show()

func closeDialog():
	$Label.hide()


func playTypeSound():
	$Keyboard.play(keyboardSoundPosition)
	
func stopTypeSound():
	keyboardSoundPosition = $Keyboard.get_playback_position()
	$Keyboard.stop()
