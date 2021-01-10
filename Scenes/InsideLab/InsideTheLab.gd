extends Node2D


var dialogs = [
	"My lab..the only place that makes me feel like home"
]
var dialogIndex = 0
onready var animationPlayer = $AnimationPlayer
onready var player = $Player


func _ready():
	player.animationPlayer.play("IdleRight")
	animationPlayer.play("EnteringLab")

func _process(delta):
	if Input.is_action_pressed("ui_accept") && $Player.overPortal:
		animationPlayer.play("fade_to_alchemy")
		yield(animationPlayer, "animation_finished")
		get_tree().change_scene("res://Scenes/Puzzle 1/Alchemy.tscn")
		


func sayDialog():
	if dialogIndex< len(dialogs):
		$Label.text = dialogs[dialogIndex]
		$Label.show()

func closeDialog():
	$Label.hide()
	
func clearDialog():
	$Label.text = ""

func playTypeSound():
	$Keyboard.play()
	
func stopTypeSound():
	$Keyboard.stop()
	
func sayDialog2():
	dialogs.append("I've got this! Let's head to the first station and make the basic components of the vaccine.")
	dialogIndex += 1
	$Label.text = dialogs[dialogIndex]
	
	


