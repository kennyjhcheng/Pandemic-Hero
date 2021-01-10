extends Node

var items: = {
	'carbon_atom'     : { 'name' : 'Carbon Atom',     'icon': 0},
	'oxygen_atom'     : { 'name' : 'Oxygen Atom',     'icon': 1},
	'hydrogen_atom'   : { 'name' : 'Hydrogen Atom',   'icon': 2},
	'phosphorus_atom' : { 'name' : 'Phosphorus Atom', 'icon': 3},
}

var inventory: = {
	'carbon_atom'     : true,
	'oxygen_atom'     : true,
	'hydrogen_atom'   : true,
	'phosphorus_atom' : true,
}

func add_item(item):
	if inventory[item]:
		return
	else:
		inventory[item] = true
