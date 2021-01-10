extends Node2D

var incorrect = false
var returnPosition = 0

func _physics_process(delta):
	pass
#	if incorrect:
#		var returnPosition = 0
#		for node in get_node('/root/Matching/Control/Nucleotides').get_children():
#			if node.get_child(0).name == self.name:
#				returnPosition = node.get_child(0).position
#		global_position = lerp(global_position, returnPosition, delta * 10)
#		self.queue_free()
#
