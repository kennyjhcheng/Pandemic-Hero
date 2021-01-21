extends Node2D


var dialogs = [
	"I'm going to put up a poster to remind myself of the importance of hygiene during the pandemic.",
	"Let me take a quick look at this poster",
	"Okay, the next task is to combine the parts of the mRNA together to create the core part of the vaccine."
]
var dialogIndex = 0
var posterOpen = false
var posterClose = false
onready var animationPlayer = $AnimationPlayer
onready var player = $Player
var simulatedKeyPress = null


func _ready():
	simulatedKeyPress = InputEventKey.new()
	$WashHandsPoster.visible = false
	player.animationPlayer.play("IdleRight")
	animationPlayer.play("EnteringLab")


func _input(event):
	if (event.is_action_released("ui_accept") && $Player.overPortal) or (event is InputEventScreenTouch && event.is_pressed() && $Player.overPortal):
		animationPlayer.play("fade_to_alchemy")
		yield(animationPlayer, "animation_finished")
		get_tree().change_scene("res://Scenes/Puzzle 2/Matching.tscn")
	if (event.is_action_released("ui_accept") && $Player.overHandWashPoster && posterOpen == false) or (event is InputEventScreenTouch && event.is_pressed() && $Player.overHandWashPoster && posterOpen == false ):
		posterOpen = true
	if (event.is_action_released("ui_accept") && $Player.overReadBookPoster && posterOpen == false) or (event is InputEventScreenTouch && event.is_pressed() && $Player.overReadBookPoster && posterOpen == false):
		posterOpen = true
	if (event.is_action_released("ui_accept") && $PopUpBackground.visible == true) or (event is InputEventScreenTouch && $PopUpBackground.visible == true):
		posterClose = true
	if (event.is_action_released("ui_accept")) or (event is InputEventScreenTouch && event.is_pressed()):
		animationPlayer.playback_speed = 4
	else:
		animationPlayer.playback_speed = 1
		
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
	$WashHandsPoster.visible = true
	
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
	


