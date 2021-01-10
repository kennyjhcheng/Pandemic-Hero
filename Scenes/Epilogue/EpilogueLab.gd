 extends Node2D


var dialogs = [
	"How long has it been since I've been back here after cooperating with a bigger company to produce the vaccine...",
	"It feels like ages...",
	"OH! I seem to have left my old iPhone 15s here. I wonder if it still has power left?"
]
var dialogIndex = 0
var posterOpen = false
var posterClose = false
onready var animationPlayer = $AnimationPlayer
onready var player = $Player


func _ready():
	player.animationPlayer.play("IdleRight")
	animationPlayer.play("EnteringLab")

func _input(event):
	if event.is_action_released("ui_accept") && $Player.overPortal:
		animationPlayer.play("fade_to_alchemy")
		yield(animationPlayer, "animation_finished")
		get_tree().change_scene("res://Scenes/Epilogue/Epilogue.tscn")
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
	$PosterPopUp/Sprite.texture = load(path)
	
func hidePoster():
	$PopUpBackground.visible = false
	$PosterPopUp.hide()
	posterOpen = false
	
func sayNext():
	dialogIndex += 1
	$Label.text = dialogs[dialogIndex]
	$Label.visible = true	

