extends Node2D


var dialogs = [
	"My lab..the only place that makes me feel like home",
	"I've got this! Let's head to the first station and make the basic components of the vaccine."
]
var dialogIndex = 0
onready var animationPlayer = $AnimationPlayer
onready var player = $Player
var skipToSeconds = [3.5,6,10,11.5]
var currentSkipToSeconds = -1
var pauseBeforeNextSkip = 0

func _ready():
	player.animationPlayer.play("IdleRight")
	animationPlayer.play("EnteringLab")


func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		emitDialogSkip()
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and $Player.overPortal:
		fadeToAlchemy()


func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") && $Player.overPortal) or (Input.is_action_just_pressed("left_click") && $Player.overPortal) :
		fadeToAlchemy()
	if Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("ui_accept"):
		emitDialogSkip()



func fadeToAlchemy():
	animationPlayer.play("fade_to_alchemy")
	yield(animationPlayer, "animation_finished")
	get_tree().change_scene("res://Scenes/Puzzle 1/Alchemy.tscn")


func emitDialogSkip():
	if animationPlayer.current_animation_position > 1:
			dialogSkipped()
			
func sayDialog():
	if dialogIndex< len(dialogs):
		$Label.text = dialogs[dialogIndex]
		dialogIndex+=1
		$Label.show()
		

func closeDialog():
	$Label.hide()
	
func clearDialog():
	$Label.text = ""

func playTypeSound():
	$Keyboard.play()
	
func stopTypeSound():
	$Keyboard.stop()
	

	

func dialogSkipped():
	if currentSkipToSeconds<len(skipToSeconds)-1:
		var skipToPosition = skipToSeconds[currentSkipToSeconds+1]
		currentSkipToSeconds+=1
		animationPlayer.seek(skipToPosition, true)
	
	


