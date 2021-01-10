extends Node2D



var puzzleCompletion :int = 0
var summary = ["Learning Goals: \n\nRecognize that for the mRNA vaccine to enter ones body, it requires a protective bilayer made of fat. \nThis layer is identical to the layer covering cells which allows them to combine and accept the mRNA.",
				"Fun Fact: Bell's Palsy is a weakened feeling in facial muscles. 7 out of 60,000 vaccine trial participants experienced it and recovered from it within a few weeks. \n\nBell's Palsy is not a serious side effect because it is temporary and only affected 0.01% of the sample."
				]
# Called when the node enters the scene tree for the first time.
var pageNumber = 0
var instructionNumber = 0
onready var dialog = $Instructions
onready var dialogCount = $Instructions/DialogCount
var dialogIndex: = 0
var dialogs: = [
	"For our vaccine to take effect in our bodies, we need to place the mRNA in a protective shell. This shell is called a phospholipid bilayer and it is present in all our cells to protect contents inside.",
	"Create a phospholipid bilayer by completing the puzzle. \nDrag and drop the puzzle pieces in the the correct slot in the puzzle.",
]
func _ready():
	$FadeOutLayer/ColorRect.visible = false
	$AnimationPlayer.play("Initialize")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("PlayCurrInstruction")
	

func sayDialog():
	dialog.visible = true
	dialog.text = dialogs[dialogIndex]
	dialogCount.text = str(dialogIndex + 1) + "/" + str(len(dialogs))
	if dialogIndex< len(dialogs):
		dialog.show()

func closeDialog():
	dialog.hide()

func clearDialog():
	dialog.text=""	

func continue():
	$Fireworks.visible = true
	$PuzzleComplete.play()
	$Label.visible = true
	$SummaryButton.visible= true
	$ContinueButton.visible= true
	dialogs.append("You created a phospholipid bilayer! \nNow that the mRNA has been protected with the phospholipid bilayer, you can proceed with testing.\n\nClick 'Summary' first to learn something about the COVID-19 vaccine, then click 'Continue' to proceed with testing.")
	dialogIndex = len(dialogs) - 1
	$AnimationPlayer.play("PlayCurrInstruction")
	var timer = Timer.new()
	timer.connect("timeout",self,"stop_fireworks") 
	add_child(timer)
	timer.set_wait_time(1.26)
	timer.start()
	


func stop_fireworks():
	$Fireworks.visible = false
	



func _on_Back_pressed():
	$ClickAudio.play()
	print("HIDE")
	$FadeOut.visible = false
	$SummaryPopUp.hide()




	


func _on_Left_pressed():
	$ClickAudio.play()
	if dialogIndex > 0:
#		print("dialog Index: " + str(dialogIndex))
		dialogIndex -= 1
		$AnimationPlayer.stop()
		$AnimationPlayer.play("PlayCurrInstruction")


func _on_Right_pressed():
	$ClickAudio.play()
	if dialogIndex < len(dialogs) - 1:
#		print("dialog Index: " + str(dialogIndex))
		dialogIndex += 1
		$AnimationPlayer.stop()
		$AnimationPlayer.play("PlayCurrInstruction")




func _on_RightSummary_pressed():
	$ClickAudio.play()
	print("hey right")
	pageNumber+=1
	if pageNumber<len(summary):
		$SummaryPopUp/Summary.text = summary[pageNumber]
		$SummaryPopUp/PageCount.text = str(pageNumber + 1) + "/" + str(len(summary))
	if pageNumber>=len(summary):
		pageNumber = len(summary) -1




func _on_LeftSummary_pressed():
	$ClickAudio.play()
	pageNumber = pageNumber -1
	if pageNumber>0:
		print("PREV:  ",pageNumber)
		$SummaryPopUp/Summary.text = summary[pageNumber]
	if pageNumber<=0:
		print("PREV2:  ",pageNumber)
		pageNumber = 0
		$SummaryPopUp/Summary.text = summary[0]
	$SummaryPopUp/PageCount.text = str(pageNumber + 1) + "/" + str(len(summary))


func _on_Cross_pressed():
	$ClickAudio.play()
	print("HIDE")
	$FadeOut.visible = false
	$SummaryPopUp.hide()


func _on_SummaryButton_pressed():
	$ClickAudio.play()
	pageNumber=0
	$FadeOut.visible = true
	$SummaryPopUp.popup_centered(Vector2.ZERO)
	$SummaryPopUp/Summary.text = summary[0]


func _on_ContinueButton_button_down():
	$ClickAudio.play()
	$ContinueButton.disconnect("button_down", self, "_on_ContinueButton_button_down")
	var fadeOut = load("res://Scenes/FadeOutAnimation.tscn")
	var fadeOutInstance = fadeOut.instance()
	fadeOutInstance.name = 'fade'
	self.add_child(fadeOutInstance)
	get_node('fade/CanvasLayer/Label').text = "\"Optimism is the faith that leads to achievement. Nothing can be done without hope and confidence\"\n- Helen Keller"
	get_node('fade').get_node('AnimationPlayer').play('FadeToMessage')
	yield(get_node('fade').get_node('AnimationPlayer'), 'animation_finished')
	get_tree().change_scene("res://Scenes/InsideLab/InsideTheLabAfterPuzzle3.tscn")

func startKeyboardTyping():
	$KeyboardSound.play()
	
func stopKeyboardTyping():
	$KeyboardSound.stop()
