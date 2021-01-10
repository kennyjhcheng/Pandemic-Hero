extends Position2D



export var dropZoneID = 4
var selected = false
	
	
func select():
	selected = true
	
	
func deselect():
	pass
		
func get_drop_zone_id():
	return dropZoneID
