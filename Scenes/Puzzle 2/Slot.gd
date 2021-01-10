extends Panel

onready var Nucleotide_Scene: = load("res://Scenes/Nucleotide.tscn")

onready var blank_tex = preload("res://Assets/Puzzle 2/blank.png")
onready var highlight_tex = preload("res://Assets/Puzzle 2/blank slot highlight.png")
#onready var incorrect_tex = preload("res://assets/item_slot_incorrect.png")
var blank_style: StyleBoxTexture = null
var highlight_style: StyleBoxTexture = null
#var incorrect_style: StyleBoxTexture = null

var nucleotide = null
var moveable: = true
var frameDict: = {
	"Adenine" : 1,
	"Cytosine" : 3,
	"Guanine" : 5,
	"Uracil" : 7
}
var correctNucleotide: = {
	"N1": "Guanine",
	"N2": "Uracil",
	"N3": "Guanine",
	"N4": "Cytosine",
	"N5": "Adenine",
	"N6": "Uracil",
	"N7": "Cytosine",
	"N8": "Uracil",
#	"N9": "Guanine",
#	"N10": "Adenine",
#	"N11": "Cytosine",
#	"N12": "Uracil",
}


func _process(delta):
	var positionDiff = get_global_mouse_position() - self.rect_global_position
		
	if positionDiff.x < 75 and positionDiff.x >= 0 and positionDiff.y < 80 and positionDiff.y >= 0:
		set_highlight_style()
	else:
		set_blank_style()
	
	
	

func _ready():
	blank_style = StyleBoxTexture.new()
	highlight_style = StyleBoxTexture.new()
#	incorrect_style = StyleBoxTexture.new()
	blank_style.texture = blank_tex
	highlight_style.texture = highlight_tex
#	incorrect_style.texture = incorrect_tex
	
	if get_child_count() == 1:
		nucleotide = get_child(0)
	if "UnMoveable" in self.name or "Garbage" in self.name:
		moveable = false
	if !moveable && self.name != "Garbage":
		get_child(0).get_node("Icon").frame = frameDict[get_child(0).name]
	play_audio()

func pickFromSlot():
	if moveable:
		remove_child(nucleotide)
		if nucleotide.get_node('Icon').frame % 2 == 0:
			nucleotide.get_node('Icon').frame += 1
		var parentNode = find_parent('Matching')
		parentNode.add_child(nucleotide)
		nucleotide = null
	else:
		var duplicate = nucleotide.duplicate()
		print(str(duplicate.name))
		remove_child(nucleotide)
		var parentNode = find_parent('Matching')
		parentNode.add_child(nucleotide)
		nucleotide = duplicate
		add_child(duplicate)
	play_audio()
		
	

func putIntoSlot(new_nucleotide):
	if moveable and self.name != "Garbage":
		nucleotide = new_nucleotide
		nucleotide.position = Vector2(0,0)
		var parentNode = find_parent('Matching')
		parentNode.remove_child(nucleotide)
		add_child(nucleotide)
	play_audio()

func play_audio():
	if moveable && self.get_child(0) != null:
		if correctNucleotide[self.name] == self.get_child(0).name:
			find_parent('Matching').get_node('SuccessAudio').play()
			self.get_child(0).get_node('Icon').frame -= 1
		else:
			find_parent('Matching').get_node("FailureAudio").play()
		
		
func set_highlight_style():
	if moveable && self.get_child(0) == null:
		set('custom_styles/panel', highlight_style)
		
func set_blank_style():
	if moveable && self.get_child(0) == null:
		set('custom_styles/panel', blank_style)
		
#	if moveable && self.get_child(0) != null:
#		if correctNucleotide[self.name] == get_child(0).name:
#			find_parent('Matching').get_node("SuccessAudio").play()
#			pass
#		else:
#			find_parent('Matching').get_node("FailureAudio").play()
#			remove_child(nucleotide)
#			nucleotide.incorrect = true
#			var parentNode = find_parent('Matching')
#			parentNode.add_child(nucleotide)
#			nucleotide = null
#
			
#	if moveable:
#		if nucleotide == null:
#			set('custom_styles/panel', default_style)
##			self.add_stylebox_override('panel', load("res://assets/item_slot_default_background.png"))
#		elif correctNucleotide[self.name] == get_child(0).name:
#			set('custom_styles/panel', correct_style)
##			self.add_stylebox_override('panel', load("res://assets/item_slot_correct.png"))
#		else:
#			set('custom_styles/panel', incorrect_style)
##			self.add_stylebox_override('panel', load("res://assets/item_slot_incorrect.png"))
		
	
