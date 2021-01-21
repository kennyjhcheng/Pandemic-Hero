extends Node2D




func _on_Area2D_input_event(viewport, event, shape_idx):
	print("CLICK")
	if Input.is_action_just_pressed("left_click"):
		print("CLICK")
		$HTTPRequest.my_data["entry.1545835980"] =  $A1.text
		print($A1.text)
		$HTTPRequest.my_data["entry.1341626230"] =  $A2.text
		$HTTPRequest.my_data["entry.1003277605"] =  $A3.text
		



func _on_Area2D2_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		print("CLICK")


func _on_Submit_pressed():
	$HTTPRequest.my_data["entry.1545835980"] =  $A1.text
	$HTTPRequest.my_data["entry.1341626230"] =  $A2.text
	$HTTPRequest.my_data["entry.1003277605"] =  $A3.text
	$HTTPRequest.send_data()
	$ColorRect.visible= true
