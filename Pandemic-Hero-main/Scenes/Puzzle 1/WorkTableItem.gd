extends Area2D

onready var Alchemy = get_node('/root/Alchemy')
var dragging : bool = false
var translate_by  = null
var id = null







func setId(idNum):
	id = idNum
	
func getId() -> int:
	return id
	
func _on_WorkTableItem_area_entered(area):
	print('collision detected')
	if area.get_parent().name == 'WorkTable':
		var icon1 = area.get_node("icon").get_frame()
		var icon2 = self.get_node("Icon").get_frame()
		Alchemy.combine(icon1, icon2, area, self)
		
