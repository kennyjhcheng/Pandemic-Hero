extends Node2D

var summary = ["You learned that mRNA is composed of 4 nucleotide components:\n   A - Adenine \n   G - Guanine \n   C - Cytosine \n   U - Uracil.",
				"Fun Fact: \nThe COVID-19 vaccine is safer than vaccines for other illnesses because it uses mRNA which does not affect DNA.\n\nMade in less than one year, it is one of the fastest vaccines ever developed while passing the necessafey guidelines."
				]

var pageNumber = 0

onready var item_scene: = load("res://Scenes/Puzzle 1/UIItem.tscn")
onready var worktable_item_scene: = load("res://Scenes/Puzzle 1/WorkTableItem.tscn")
onready var dialog: = $InstructionLabel
onready var dialogCount: = $InstructionLabel/InstructionCountLabel
onready var whichStructureLabel: = $Structure/WhichStructureLabel
onready var animation_player: = $AnimationPlayer
var dialogIndex: = 0
var dialogs: = [
	"\nWe need mRNA to create a vaccine. mRNA is a recipe that creates proteins which are part of viruses like COVID-19. It is made of building blocks called nucleotides",
	"\nRefer to the components under 'Elements' and the nucleotide template under 'Structure'. Combine 'Elements' to create 4 different nucleotides. Create adenine and the next will appear.",
	"\nDrag and drop sections of each nucleotide into the 'Experiment' section and combine them by dragging them on top of each other. They will automatically combine if they match.",
	"\nThe first nucleotide you must create is Adenine. When you successfully create it, it will appear under \"Discovered Nucleotides\".",
]
var shape = null
var itemCounter: = 0
var iconHash: = {
		'A1G3' : ELEMENTS.Acomponent1Gcomponent3,
		'A2C3' : ELEMENTS.Acomponent2Ccomponent3,
		'A3' : ELEMENTS.ACOMPONENT3,
		'U1' : ELEMENTS.UCOMPONENT1,
		'U2' : ELEMENTS.UCOMPONENT2,
		'Ura' : ELEMENTS.URACIL,
		'Ade' : ELEMENTS.ADENINE,
		'C1' : ELEMENTS.CCOMPONENT1,
		'C2' : ELEMENTS.CCOMPONENT2,
		'G1' : ELEMENTS.GCOMPONENT1,
		'G2' : ELEMENTS.GCOMPONENT2,
		'Cyt': ELEMENTS.CYTOSINE,
		'Gua': ELEMENTS.GUANINE
	}
#var ChooseA1G3Save = null
#var ChooseA2G3C3Save = null
var ChooseUraSave = null
var ChooseAdeSave = null
var ChooseC1Save = null
var ChooseC2Save = null
var ChooseG1Save = null
var ChooseG2Save = null
var ChooseCytSave = null
var ChooseGuaSave = null
var continueButtonSave = null
var completeButtonSave = null
var summaryButtonSave = null

var createdAde = false
var createdUra = false
var createdCyt = false
var createdGua = false




func _ready():
	animation_player.play("ResetAnimations")
	yield(animation_player, "animation_finished")
	$BackgroundBubblingAudio.play()
	_store_and_save_components()
	$GarbageCan.connect('area_shape_entered', self, '_onGarbageCan')
	animation_player.play("PlayCurrInstruction")
	$Structure.frame = 0
	whichStructureLabel.text = "Adenine"
	
	
func _store_and_save_components():
	ChooseUraSave = get_node("Inventory/ChooseUra").duplicate()
	ChooseAdeSave = get_node("Inventory/ChooseAde").duplicate()
	ChooseC1Save = get_node("Inventory/ChooseC1").duplicate()
	ChooseC2Save = get_node("Inventory/ChooseC2").duplicate()
	ChooseG1Save = get_node("Inventory/ChooseG1").duplicate()
	ChooseG2Save = get_node("Inventory/ChooseG2").duplicate()
	ChooseCytSave = get_node("Inventory/ChooseCyt").duplicate()
	ChooseGuaSave = get_node("Inventory/ChooseGua").duplicate()
	continueButtonSave = get_node("ContinueButton").duplicate() 
	completeButtonSave = get_node("CompleteButton").duplicate()
	summaryButtonSave = $SummaryButton.duplicate()
	get_node("Inventory/ChooseUra").queue_free()
	get_node("Inventory/ChooseAde").queue_free()
	get_node("Inventory/ChooseC1").queue_free()
	get_node("Inventory/ChooseC2").queue_free()
	get_node("Inventory/ChooseG1").queue_free()
	get_node("Inventory/ChooseG2").queue_free()
	get_node("Inventory/ChooseCyt").queue_free()
	get_node("Inventory/ChooseGua").queue_free()
	get_node("ContinueButton").queue_free()
	get_node("CompleteButton").queue_free()
	$SummaryButton.queue_free()
	

	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			shape = find_colliding_shape(event.position)
			if shape == null:
				var inventory_item = find_colliding_invetory_item(event.position)
				if inventory_item:
					var new_shape = inventory_item.name.right(6)
					var scene = load("res://Scenes/Puzzle 1/WorkTableItem.tscn")
					shape = scene.instance()
					shape.get_node('Icon').frame = iconHash[new_shape]
					shape.set_position(event.position)
					shape.name = new_shape + str(itemCounter)
					shape.z_index = 5
					print("created shape's name:" + shape.name) 
					makeConnection(shape)
					$WorkTable.add_child(shape)
					itemCounter += 1
				else:
					return 
		elif shape!=null:
			shape = null
	elif event is InputEventMouseMotion and shape!=null:
		if shape.translate_by == null:
			shape.translate_by = Vector2.ZERO
		shape.translate_by = shape.translate(event.get_relative())

func find_colliding_shape(pos):
	return find_colliding_with("WorkTable",pos)

func find_colliding_invetory_item(pos):
	return find_colliding_with("Inventory",pos)
	
	
	
func find_colliding_with(folder,event_position):
	var pointer = get_node("Pointer")
	pointer.set_position(event_position)
	var pointer_shape = pointer.shape_owner_get_shape(0,0)
	var pointer_transform = pointer.get_transform()
	for node in get_node(folder).get_children():
		var new_shape = node.shape_owner_get_shape(0,0)
		var res = new_shape.collide(node.get_transform(),pointer_shape,pointer_transform)
		if res:
			return node
#	print('returned null')
	return null
	
func makeConnection(shape):
	var shapeName = shape.name
	if "A1G3" in shapeName:
		shape.connect("area_shape_entered", self, "_onA1G3")
	elif "A2C3" in shapeName:
		shape.connect("area_shape_entered", self, "_onA2C3")
	elif "A3" in shapeName:
		shape.connect("area_shape_entered", self, "_onA3")
	elif "A+13" in shapeName:
		shape.connect("area_shape_entered", self, "_onA13")
	elif "A+23" in shapeName:
		shape.connect("area_shape_entered", self, "_onA23")
	elif "U1" in shapeName:
		shape.connect("area_shape_entered", self, "_onU1")
	elif "U2" in shapeName:
		shape.connect("area_shape_entered", self, "_onU2")
	elif "Ade" in shapeName:
		shape.connect("area_shape_entered", self, "_onAde")
	elif "Ura" in shapeName:
		shape.connect("area_shape_entered", self, "_onUra")
	elif "C1" in shapeName:
		shape.connect("area_shape_entered", self, "_onC1")
	elif "C2" in shapeName:
		shape.connect("area_shape_entered", self, "_onC2")
	elif "C+12" in shapeName:
		shape.connect("area_shape_entered", self, "_onC12")
	elif "C+23" in shapeName:
		shape.connect("area_shape_entered", self, "_onC23")
	elif "G1" in shapeName:
		shape.connect("area_shape_entered", self, "_onG1")
	elif "G2" in shapeName:
		shape.connect("area_shape_entered", self, "_onG2")
	elif "G+12" in shapeName:
		shape.connect("area_shape_entered", self, "_onG12")
	elif "G13" in shapeName:
		shape.connect("area_shape_entered", self, "_onG13")
	elif "Cyt" in shapeName:
		shape.connect("area_shape_entered", self, "_onCyt")
	elif "Gua" in shapeName:
		shape.connect("area_shape_entered", self, "_onGua")

func _onA1G3(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	createAndDeleteParent("A3", "ChooseA3", "A+13", "_onA13", ELEMENTS.ACOMPONENT13, area, area_shape)
	createAndDeleteParent("A+23", "ChooseA+23", "Ade", "_onAde", ELEMENTS.ADENINE, area, area_shape)
	if createdCyt:
		deleteParent("G1", "ChooseG1", area, area_shape)
		deleteParent("G+12", "ChooseG+12", area, area_shape)
	

func _onA2C3(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	createAndDeleteParent("A3", "ChooseA3", "A+23", "_onA23", ELEMENTS.ACOMPONENT23, area, area_shape)
	createAndDeleteParent("A+13", "ChooseA+13", "Ade", "_onAde", ELEMENTS.ADENINE, area, area_shape)
	deleteParent("C2", "ChooseC2", area, area_shape)
	deleteParent("C+12", "ChooseC+12", area, area_shape)
	

func _onA3(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	deleteParent("A1G3", "ChooseA1G3", area, area_shape)
	deleteParent("A2C3", "ChooseA2C3", area, area_shape)
	
	
func _onA13(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	deleteParent("A2C3", "ChooseA2C3", area, area_shape)

	
func _onA23(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	deleteParent("A1G3", "ChooseA1G3", area, area_shape)
	
	
func _onU1(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	if createdAde:
		createAndDeleteParent("U2", "ChooseU2", "Ura", "_onUra", ELEMENTS.URACIL, area, area_shape)
	
	
func _onU2(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	if createdAde:
		deleteParent("U1", "ChooseU1", area, area_shape)
	
	
func _onAde(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	pass
	
func _onUra(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	pass

func _onC1(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	deleteParent("C2", "ChooseC2", area, area_shape)
	deleteParent("C+23", "ChooseC+23", area, area_shape)
	
func _onC2(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	createAndDeleteParent("C1", "ChooseC1", "C+12", "_onC12", ELEMENTS.CCOMPONENT12, area, area_shape)
	createAndDeleteParent("A2C3", "ChooseA2C3", "C+23", "_onC23", ELEMENTS.CCOMPONENT23, area, area_shape)
	
func _onC12(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	createAndDeleteParent("A2C3", "ChooseA2C3", "Cyt", "_onCyt", ELEMENTS.CYTOSINE, area, area_shape)
	
func _onC23(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	createAndDeleteParent("C1", "ChooseC1", "Cyt", "_onCyt", ELEMENTS.CYTOSINE, area, area_shape)

func _onG1(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	if createdCyt:
		deleteParent("G2", "ChooseG2", area, area_shape)
		createAndDeleteParent("A1G3", "ChooseA1G3", "G+13", "_onG13", ELEMENTS.GCOMPONENT13, area, area_shape)

func _onG2(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	if createdCyt:
		createAndDeleteParent("G1", "ChooseG1", "G+12", "_onG12", ELEMENTS.GCOMPONENT12, area, area_shape)
		createAndDeleteParent("G+13", "ChooseG+13", "Gua", "_onGua", ELEMENTS.GUANINE, area, area_shape)
	
func _onG12(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	createAndDeleteParent("A1G3", "ChooseA1G3", "Gua", "_onGua", ELEMENTS.GUANINE, area, area_shape)
	
func _onG13(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	deleteParent("G2", "ChooseG2", area, area_shape)
	
func _onCyt(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	pass
func _onGua(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	pass

func _onGarbageCan(area_id: int, area: Area2D, area_shape: int, self_shape: int):
	var deletingArea= area.shape_owner_get_owner(area.shape_find_owner(area_shape))
	var parent = deletingArea.get_parent()
	if parent.name != "Pointer":
		parent.queue_free()
		itemCounter -= 1
		$TrashAudio.play()
	
func deleteParent(worktableItemName: String, inventoryItemName: String, area: Area2D, area_shape: int):
	if worktableItemName in area.name and area.name != inventoryItemName:
		var deletingArea= area.shape_owner_get_owner(area.shape_find_owner(area_shape))
		var parent = deletingArea.get_parent()
		parent.queue_free()
		itemCounter -= 1

func createAndDeleteParent(
						worktableItemName: String, 
						inventoryItemName: String, 
						resultName: String, 
						connectionName: String, 
						resultFrame: int,
						area: Area2D, 
						area_shape: int
					):
	if worktableItemName in area.name and area.name != inventoryItemName:
		var deletingArea = area.shape_owner_get_owner(area.shape_find_owner(area_shape))
		var parent = deletingArea.get_parent()
		var s = worktable_item_scene.instance()
		s.set_position(parent.position)
		s.name = resultName + str(itemCounter)
		s.connect("area_shape_entered",self,connectionName)
		s.get_node('Icon').frame = resultFrame
		s.z_index = 5
		get_node("WorkTable").add_child(s)
		parent.queue_free()
		$CorrectAudio.play()
		if resultFrame == ELEMENTS.ADENINE && createdAde == false:
			createdAde = true
#			print(str(createdAde))
			get_node("Inventory").add_child(ChooseAdeSave)
			dialogs.append("\nGreat job discovering adenine! Now, create uracil.")
			dialogIndex = len(dialogs) - 1
			animation_player.stop()
			animation_player.play("AdeFadeIn")
			yield(animation_player, "animation_finished")
			animation_player.play("PlayCurrInstruction")
			$Structure.frame = 1
			whichStructureLabel.text = "Uracil"
		elif resultFrame == ELEMENTS.URACIL && createdUra == false:
			createdUra = true
			get_node("Inventory").add_child(ChooseUraSave)
			dialogs.append("\nFantastic, you made uracil! Click the continue button to create the next two nucleotides.")
			dialogIndex = len(dialogs) - 1
			self.add_child(continueButtonSave)
			animation_player.stop()
			animation_player.play("UraFadeIn")
			yield(animation_player, "animation_finished")
			animation_player.play("ContinueButtonFadeIn")
			yield(animation_player, "animation_finished")
			animation_player.play("PlayCurrInstruction")
		elif resultFrame == ELEMENTS.CYTOSINE && createdCyt == false:
			createdCyt = true
			get_node("Inventory").add_child(ChooseCytSave)
			animation_player.stop()
			animation_player.play("CytFadeIn")
			dialogs.append("\nAmazing, you made cytosine! You have only one nucleotide left before you can create mRNA!")
			dialogIndex = len(dialogs) - 1
			yield(animation_player,"animation_finished")
			animation_player.play("PlayCurrInstruction")
			$Structure.frame = 3
			whichStructureLabel.text = "Guanine"
		elif resultFrame == ELEMENTS.GUANINE && createdGua == false:
			createdGua = true
			get_node("Inventory").add_child(ChooseGuaSave)
			animation_player.stop()
			animation_player.play("GuaFadeIn")
			dialogs.append("\nImpressive, you made all four nucleotides! Click 'Summary' to learn something you might not have known. Then hit 'Complete' to continue making the vaccine.")
			dialogIndex = len(dialogs) - 1
			yield(animation_player, "animation_finished")
			animation_player.play("PlayCurrInstruction")
			self.add_child(completeButtonSave)
			self.add_child(summaryButtonSave)
			yield(animation_player, "animation_finished")
			animation_player.play("CompleteSummaryButtonFadeIn")

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
#	print("left button pressed")
	$ClickAudio.play()
	if dialogIndex > 0:
#		print("dialog Index: " + str(dialogIndex))
		dialogIndex -= 1
		animation_player.stop()
		animation_player.play("PlayCurrInstruction")


func _on_RightInstructionButton_button_down():
	$ClickAudio.play()
#	print("right button pressed")
	if dialogIndex < len(dialogs) - 1:
#		print("dialog Index: " + str(dialogIndex))
		dialogIndex += 1
		animation_player.stop()
		animation_player.play("PlayCurrInstruction")


func _on_ContinueButton_button_down():
	$ClickAudio.play()
#	print('button pressed')
	$ContinueButton.disconnect("button_down",self,"_on_ContinueButton_button_down")
	animation_player.play("TransitionFreeOld")
	yield(animation_player, "animation_finished")
	freeAU()
	addCG()
	animation_player.play("TransitionAddNew")
	$Structure.frame = 2
	whichStructureLabel.text = "Cytosine"
	dialogs.append("\nCreate the last two nucleotides that form mRNA! Your next task is to create Cytosine.")
	dialogIndex = len(dialogs) - 1
	yield(animation_player, "animation_finished")
	animation_player.play("PlayCurrInstruction")
	$ContinueButton.queue_free()
	

func freeAU():
	get_node("Inventory/ChooseA3").queue_free()
	get_node("Inventory/ChooseU1").queue_free()
	get_node("Inventory/ChooseU2").queue_free()
	get_node("Inventory/ChooseAde").queue_free()
	get_node("Inventory/ChooseUra").queue_free()

func addCG():
	get_node("Inventory").add_child(ChooseC1Save)
	get_node("Inventory").add_child(ChooseC2Save)
	get_node("Inventory").add_child(ChooseG1Save)
	get_node("Inventory").add_child(ChooseG2Save)


func _on_CompleteButton_button_down():
	$ClickAudio.play()
	$CompleteButton.disconnect("button_down",self,"_on_CompleteButton_button_down")
	var fadeOut = load("res://Scenes/FadeOutAnimation.tscn")
	var fadeOutInstance = fadeOut.instance()
	fadeOutInstance.name = 'fade'
	self.add_child(fadeOutInstance)
	get_node('fade/CanvasLayer/Label').text = "\"Nothing in life is to be feared; it is only to be understood. Now is the time to understand more, so that we may fear less.\" \n- Marie Curie" # We're one step towards creating a vaccine.
																						  # We're one step towards combating COVID-19.
	get_node('fade').get_node('AnimationPlayer').play('FadeToMessageDisappear')
	yield(get_node('fade').get_node('AnimationPlayer'), 'animation_finished')
	get_tree().change_scene("res://Scenes/InsideLab/InsideTheLabAfterAlchemy.tscn")
	
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
	



func _on_Close_button_down():
	$ClickAudio.play()
	$FadeBackground.visible = false
	$SummaryPopUp.hide()


func _on_Right_button_down():
	$ClickAudio.play()
	pageNumber+=1
	if pageNumber<len(summary):	
		$SummaryPopUp/Summary.text = summary[pageNumber]
		$SummaryPopUp/PageCount.text = str(pageNumber + 1) + "/" + str(len(summary))
	if pageNumber>=len(summary):
		pageNumber = len(summary) -1
	



func _on_Left_button_down():
	$ClickAudio.play()
	pageNumber = pageNumber -1
	if pageNumber>0:
		$SummaryPopUp/Summary.text = summary[pageNumber]
	if pageNumber<=0:
		pageNumber = 0
		$SummaryPopUp/Summary.text = summary[0]
	$SummaryPopUp/PageCount.text = str(pageNumber + 1) + "/" + str(len(summary))
