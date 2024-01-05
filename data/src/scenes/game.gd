extends Node3D

const res_bomb = preload("res://data/src/scenes/bomb.tscn")
const res_hole = preload("res://data/src/scenes/hole.tscn")
const res_wump = preload("res://data/src/scenes/wumpus.tscn")
const res_mush = preload("res://data/src/scenes/bat.tscn")
const res_play = preload("res://data/src/scenes/player.tscn")
const res_fog  = preload("res://data/src/scenes/fog.tscn")

var grid = []
var view = []

func place_object(resource, x, y, z : float = 0.25):
	var offset : bool = true
	var obj = resource.instantiate()
	self.get_node('Objs').add_child(obj)
	if offset:
		obj.position.y = z
	obj.position.z = -y
	obj.position.x = x

func _ready():
	new_game()
	show_game()

func show_game():
	const N = 4
	var i = 0
	for obj in grid:
		var x : int = int(i / N)
		var y : int = int(i % N)
		if view[i] or true:
			if obj != null:
				place_object(obj, x + 1, y + 1)
		else:
			place_object(res_fog, x + 1, y + 1)
		i += 1

func new_game():
	grid = [
			res_bomb, null, res_wump, res_hole,
			null, null, null, null,
			res_mush, null, res_play, null,
			null, null, null, null,
		]
	view = [
			false, false, false, false,
			false, false, false, false,
			false, false, true, false,
			false, false, false, false,
		]
	
