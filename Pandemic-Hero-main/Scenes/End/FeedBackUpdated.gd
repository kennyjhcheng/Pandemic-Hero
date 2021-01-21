extends Node2D

var answers = {"entry.1898599222" : "I was absorbed in this experience", 
"entry.1151237277": "This experience was demanding or confusing",
"entry.295245154":"I liked the graphics and images of this game",
"entry.219712003":"My experience was rewarding",
"entry.261559753":"I would reccomend to my friend",
"entry.1894768050":"Guanine,Cytosine,Adenine,Uracil",
"entry.772407846":"Dna squence",
"entry.1494425191":"Solutio,liplid,phosporous",
"entry.415721056":"Game strengthened my chmistry knowledge",
"entry.135923913":"Game introduced me to the vaccine dev",
"entry.988206795":"this game increased my interest",
"entry.1131381742":"How long to take vaccine",
"entry.1579349442":"how did you feel about storyline?",
"entry.1601705065":"At end of the game what message did you take away?"
}
var firstMCQ = false
var secondMCQ = false
var thirdMCQ = false
var pageNumber = 1
var group = ButtonGroup.new()
var groupTwo = ButtonGroup.new()
var groupThree = ButtonGroup.new()
var groupFour = ButtonGroup.new()
var recommend = false
var stopRequests = false
var recommendationsComplete = false
onready var os = OS.get_name()
func _ready():
	$QuestionSet2/q2/a.set_button_group(group)
	$QuestionSet2/q2/a2.set_button_group(group)
	$QuestionSet2/q2/a3.set_button_group(group)
	$QuestionSet2/q2/a4.set_button_group(group)
	$QuestionSet2/q4/a.set_button_group(groupTwo)
	$QuestionSet2/q4/a2.set_button_group(groupTwo)
	$QuestionSet2/q4/a3.set_button_group(groupTwo)
	$QuestionSet2/q4/a4.set_button_group(groupTwo)
	$QuestionSet2/q5/a.set_button_group(groupThree)
	$QuestionSet2/q5/a2.set_button_group(groupThree)
	$QuestionSet2/q5/a3.set_button_group(groupThree)
	$QuestionSet2/q5/a4.set_button_group(groupThree)
	
	

	



func _on_q1aSlider_value_changed(value):
	answers["entry.1898599222"] = value


func _on_q1cSlider_value_changed(value):
	answers["entry.295245154"] = value

func _on_q1eSlider_value_changed(value):
	answers["entry.261559753"] = value


func _on_q1dSlider_value_changed(value):
	answers["entry.219712003"] = value
	


func _on_q1bSlider_value_changed(value):
	answers["entry.1151237277"] = value




func _on_Next_pressed():
	pageNumber+=1
	if stopRequests==true:
		var fadeOut = load("res://Scenes/FadeOutAnimation.tscn")
		var fadeOutInstance = fadeOut.instance()
		fadeOutInstance.name = 'fade'
		fadeOutInstance.visible = false
		self.add_child(fadeOutInstance)
		get_node('fade').visible = true
		get_node('fade/CanvasLayer/Label').text = "Almost a year later..."
		get_node('fade').get_node('AnimationPlayer').play('FadeToMessageDisappear')
		yield(get_node('fade').get_node('AnimationPlayer'), 'animation_finished')
		get_tree().change_scene("res://Scenes/Epilogue/EpilogueLab.tscn")
		
	if recommend==true:
		$Recommend.connect("request_completed", self, "_on_request_completed")
		$Recommend.reccomend({"q1":firstMCQ,"q2":secondMCQ,"q3":thirdMCQ})
#		$Wait.visible = true
		recommend==false
		stopRequests=true
		print("Recommend")
		$Thankyou.text = "These are articles suggested by our machine learning model to supplement your knowledge!"
		recommendationsComplete = true
	if pageNumber==1:
		$QuestionSet1.visible = true
		
	if pageNumber==2:
		$PageNumber.text = "2 of 4"
		$QuestionSet1.visible = false
		$QuestionSet2.visible = true
		
	if pageNumber==3:
		$PageNumber.text = "3 of 4"
		if group.get_pressed_button() == null:
			answers["entry.1894768050"] = -1
		else:	
			answers["entry.1894768050"] = structureOfAdenine(group.get_pressed_button().get_index())
		if groupTwo.get_pressed_button() == null:
			answers["entry.1494425191"] = -1
		else:
			answers["entry.1494425191"] = mRna(groupTwo.get_pressed_button().get_index())
		if groupThree.get_pressed_button() == null:
			
			answers["entry.1131381742"] = -1
		else:
			print("DUDE",numberOfMonths(groupThree.get_pressed_button().get_index()))
			answers["entry.1131381742"] = numberOfMonths(groupThree.get_pressed_button().get_index())
		answers["entry.772407846"] = $QuestionSet2/q3/a.text
		
		$QuestionSet2.visible = false
		$QuestionSet3.visible = true
		
	if pageNumber==4:
		
		$PageNumber.text = "4 of 4"
		$QuestionSet3.visible = false
		$QuestionSet4.visible = true
	if pageNumber > 4 :
		answers["entry.1579349442"] = $QuestionSet4/q1/a1.text
		answers["entry.1601705065"] = $QuestionSet4/q2/a2.text
		$HTTPRequest.send_data(answers)
		$QuestionSet4.visible = false
		$PageNumber.visible = false	
		$Thankyou.visible = true
		
		recommend = true
	
#QuestionSet3 q1
func _on_a1_value_changed(value):
	answers["entry.415721056"] = value

#QuestionSet3 q2
func _on_a2_value_changed(value):
	answers["entry.135923913"] = value

#QuestionSet3 q3
func _on_a3_value_changed(value):
	answers["entry.988206795"] = value


func structureOfAdenine(index):
	
	if index+1==1:
		firstMCQ = true
		return "ACGU"
	if index+1==2:
		return "ADGU"
	if index+1==3:
		return "ACGT"
	if index+1==4:
		return "AUCT"
	

func mRna(index):
	if index+1==1:
		return "Solution"
	if index+1==2:
		secondMCQ = true
		return "Phospholipid bilayer"
	if index+1==3:
		return "Phosphorus layer"
	if index+1==4:
		return "Phosphate layer"


func numberOfMonths(index):
	print(index,"G")
	if index+1==1:
		return "3months"
	if index+1==2: 
		return "8months"
	if index+1==3:
		return "6months"
	if index+1==4:
		thirdMCQ = true
		return "1year"
	else :
		return "3months"
		



	


func _on_request_completed(result, response_code, headers, body):
	
	$Wait.visible = false
	if recommend==false:
		return
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if json.result!=null:
		$TextEdit.visible = true
		$TextEdit.text = arr_join(json.result)
	else:
		$TextEdit.text = "Sever was taken down for maintainace, Sorry."


func arr_join(arr, separator = ""):
	var output = "";
	for s in arr:
		output += str(s) + separator + "\n"
	output = output.left( output.length() - separator.length() )
	output = output.replace("{","-")
	output = output.replace("}","")
	output = output.replace(".:","\n Link: ")
	return output



