extends CheckBox

func is_radio():
	pass

func _ready():
	pass

func _process(delta):
	pass


func _on_RadioButton_toggled(button_pressed):
	if button_pressed:
		for child in get_parent().get_children():
			if child.has_method("is_radio"):
				child.pressed = false
				pressed = true
   else:
				pressed = true
