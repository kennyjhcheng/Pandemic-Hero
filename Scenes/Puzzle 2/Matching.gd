extends Node2D

var summary = ["mRNA has uracil (U) instead thymine (T) in DNA.\n\nNucleotides are matched in pairs: \n   DNA-mRNA\n     A-T\n     T-U\n     C-G\n     G-C",
				"Fun Fact: \nThe Pfizer-BioNTech COVID-19 vaccine has side effects such as... \n   - injection site pain\n   - chills\n   - fatigue\n   - feeling feverish\nHowever, don't be afraid, these are common temporary vaccine side effects with no health risks."
				]

var pageNumber = 0

const SlotClass = preload("res://Scenes/Puzzle 2/Slot.gd")
onready var all_slots = $Control
var holding_item = null

onready var dialog: = $InstructionLabel
onready var dialogCount: = $InstructionLabel/InstructionCountLabel
onready var animation_player: = $AnimationPlayer
var dialogIndex: = 0
var dialogs: = [
	"For your next task, you must create the mRNA strand by pairing nucleotides with its DNA template.",
	"Nucleotides are paired together through special bonds between them called hydrogen bonds. Pair the nucleotides, which you discovered in the last puzzle, with the DNA template.",
	"Tip: Although DNA and mRNA have similar components, in mRNA, the nucleotide thymine (T) is replaced by uracil (U).",
	"Tip: Each DNA nucleotide has a corresponding pair with an mRNA nucleotide, can you guess what the pairs are?",
]

var nucleotideHash: = {
	'A' : 0,
	'C' : 1,
	'G' : 2,
	'T' : 3,
}
var checkSuccess = false
var continueButtonSave = null
var summaryButtonSave = null

func _ready():
	animation_player.play("resetAnimations")
	yield(animation_player, "animation_finished")
	setDNATemplate('CACGTAGA')
	for slot in all_slots.get_node("Nucleotides").get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])
	for slot in all_slots.get_node("mRNA").get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])
	for slot in all_slots.get_node("GarbageGrid").get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])
	# ------- Dialog -----------------
	continueButtonSave = $ContinueButton.duplicate()
	summaryButtonSave = $SummaryButton.duplicate()
	$ContinueButton.queue_free()
	$SummaryButton.queue_free()
	animation_player.play("PlayCurrInstruction")
	
func _process(delta):
	if !checkSuccess:
		checkSequence()
		
func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.nucleotide: # Place holding item to slot
					slot.putIntoSlot(holding_item)
					holding_item = null
				else: # Swap holding item with item in slot
					if slot.moveable:
						var temp_item = slot.nucleotide
						slot.pickFromSlot()
						temp_item.global_position = event.global_position
						slot.putIntoSlot(holding_item)
						holding_item = temp_item
					else:
						var temp_item = holding_item
						holding_item = null
						temp_item.queue_free()
						$TrashAudio.play()
			elif slot.nucleotide:
				holding_item = slot.nucleotide
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()
		
				
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
		
		



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


func _on_LeftInstructionButton_button_down():
	$ClickAudio.play()
	print("left button pressed")
	if dialogIndex > 0:
		print("dialog Index: " + str(dialogIndex))
		dialogIndex -= 1
		animation_player.stop()
		animation_player.play("PlayCurrInstruction")


func _on_RightInstructionButton_button_down():
	$ClickAudio.play()
	print("right button pressed")
	if dialogIndex < len(dialogs) - 1:
		print("dialog Index: " + str(dialogIndex))
		dialogIndex += 1
		animation_player.stop()
		animation_player.play("PlayCurrInstruction")
		
func setDNATemplate(sequence : String):
	var Index = 0
	var Cursor = 0
	var key = null
	for node in get_node("Background/DNATemplate").get_children():
#		for letter in sequence:
#			if Index == Cursor:
#				key = letter
#			Cursor += 1
#		Cursor = 0
		node.get_child(0).get_node('Icon').frame = nucleotideHash[sequence[Index]]
		Index += 1
		print(str(nucleotideHash[sequence[0]]))
		
func checkSequence():
	var numSuccess = 0
	for node in get_node("Control/mRNA").get_children():
		if node.get_child_count() == 1:
			if node.get_child(0).get_node('Icon').frame % 2 == 0:
				numSuccess += 1
	if numSuccess == 8:
		checkSuccess = true
		dialogs.append('Congratulations! You have successfully matched and created a portion of mRNA. \nClick the \'Summary\' Button to learn something about the COVID-19 Vaccine! \nThen click the \'Continue\' button to continue with testing the vaccine.')
		dialogIndex = len(dialogs) - 1
		animation_player.play("PlayCurrInstruction")
		yield(animation_player, "animation_finished")
		self.add_child(continueButtonSave)
		self.add_child(summaryButtonSave)
		animation_player.play("ContinueSummaryButtonFadeIn")
		




func _on_TextureButton_button_down():
	$ClickAudio.play()
	$ContinueButton.disconnect("button_down", self, "_on_TextureButton_button_down")
	$SummaryButton.disabled = true
	var fadeOut = load("res://Scenes/FadeOutAnimation.tscn")
	var fadeOutInstance = fadeOut.instance()
	fadeOutInstance.name = 'fade'
	self.add_child(fadeOutInstance)
	get_node('fade/CanvasLayer/Label').text = "\"Sometimes you find yourself in the middle of chaos, and sometimes in the middle of chaos, you find yourself.\"\n- Boonaa Mohammed"
	get_node('fade').get_node('AnimationPlayer').play('FadeToMessage')
	yield(get_node('fade').get_node('AnimationPlayer'), 'animation_finished')
	get_tree().change_scene("res://Scenes/InsideLab/InsideTheLabAfterMatching.tscn")
	
func startKeyboardTyping():
	$KeyboardSound.play()
	
func stopKeyboardTyping():
	$KeyboardSound.stop()


func _on_SummaryButton_button_down():
	$ClickAudio.play()
	pageNumber=0
	$FadeBackground.visible = true
	$SummaryPopUp.popup_centered(Vector2.ZERO)
	$SummaryPopUp/Summary.text = summary[0]


func _on_Left_button_down():
	$ClickAudio.play()
	pageNumber = pageNumber -1
	if pageNumber>0:
		$SummaryPopUp/Summary.text = summary[pageNumber]
	if pageNumber<=0:
		pageNumber = 0
		$SummaryPopUp/Summary.text = summary[0]
	$SummaryPopUp/PageCount.text = str(pageNumber + 1) + "/" + str(len(summary))


func _on_Right_button_down():
	$ClickAudio.play()
	pageNumber+=1
	if pageNumber<len(summary):	
		$SummaryPopUp/Summary.text = summary[pageNumber]
		$SummaryPopUp/PageCount.text = str(pageNumber + 1) + "/" + str(len(summary))
	if pageNumber>=len(summary):
		pageNumber = len(summary) -1


func _on_X_button_down():
	$ClickAudio.play()
	$FadeBackground.visible = false
	$SummaryPopUp.hide()
