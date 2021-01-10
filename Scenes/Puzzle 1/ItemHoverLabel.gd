extends Label

func _ready():
	set_physics_process(false)
	
func _process(delta):
	self.rect_global_position = get_global_mouse_position()
	
func hide_label():
	set_physics_process(false)
	self.hide()
	
func show_label():
	set_physics_process(false)
	self.show()
