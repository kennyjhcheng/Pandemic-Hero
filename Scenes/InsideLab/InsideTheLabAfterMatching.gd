extends Node2D


var dialogs = [
	"I really miss my Grandpa. I'm going to put up a poster of us as a reminder of my motivation to create this vaccine and save as many people as possible.",
	"I'm tearing up seeing his kind smile.",
	"I've almost done it Grandpa. Let's do a quick test to see if the vaccine works.",
	"        <VACCINE FAILED>\n The mRNA needs a protective layer to reach the cells safely."
]
var posterOpen = false
var posterClose = false
var dialogIndex = 0
onready var animationPlayer = $AnimationPlayer
onready var player = $Player
var simulatedKeyPress = null


func _ready():
	simulatedKeyPress = InputEventKey.new()
	$ReadBookPoster.visible = false
	player.animationPlayer.play("IdleRight")
	animationPlayer.play("EnteringLab")

func _input(event):
	if event.is_action_released("ui_accept") && $Player.overPortal:
		animationPlayer.play("fade_to_alchemy")
		yield(animationPlayer, "animation_finished")
		get_tree().change_scene("res://Scenes/Puzzle3/PutTogetherPuzzleArea.tscn")
	if event.is_action_released("ui_accept") && $Player.overHandWashPoster && posterOpen == false:
		posterOpen = true
	if event.is_action_released("ui_accept") && $Player.overReadBookPoster && posterOpen == false:
		posterOpen = true
	if event.is_action_released("ui_accept") && $PopUpBackground.visible == true:
		posterClose = true
		
func _process(delta):
	if posterOpen && $Player.overHandWashPoster:
		openPoster("res://Assets/Background/Wash_Hands.png")
		posterOpen = false
	elif posterOpen && $Player.overReadBookPoster:
		openPoster("res://Assets/Background/poster 2.png")
		posterOpen = false
	if posterClose:
		hidePoster()
		posterClose = false
		


func sayDialog():
	if dialogIndex< len(dialogs):
		$Label.text = dialogs[dialogIndex]
		$Label.show()

func closeDialog():
	$Label.hide()

func playTypeSound():
	$Keyboard.play()
	
func stopTypeSound():
	$Keyboard.stop()
	
func openPoster(path: String):
	posterOpen = true
	$PopUpBackground.visible = true
	$PosterPopUp.popup_centered(Vector2.ZERO)
	$PosterPopUp/poster.texture = load(path)
	
func hidePoster():
	$PopUpBackground.visible = false
	$PosterPopUp.hide()
	posterOpen = false	
	
func posterVisible():
	$ReadBookPoster.visible = true
	
func sayNext():
	dialogIndex += 1
	$Label.text = dialogs[dialogIndex]
	$Label.visible = true

func pressEnter():
	simulatedKeyPress.pressed = true
	simulatedKeyPress.scancode = KEY_ENTER
	Input.parse_input_event(simulatedKeyPress)
	simulatedKeyPress.pressed = false
	Input.parse_input_event(simulatedKeyPress)

