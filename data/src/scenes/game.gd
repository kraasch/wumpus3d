extends Node3D

const res_bomb = preload("res://data/src/scenes/bomb.tscn")
const res_hole = preload("res://data/src/scenes/hole.tscn")
const res_wump = preload("res://data/src/scenes/wumpus.tscn")
const res_mush  = preload("res://data/src/scenes/bat.tscn")

func place_object(resource, x, y):
	var offset : bool = true
	var obj = resource.instantiate()
	self.get_node('Objs').add_child(obj)
	if offset:
		obj.position.y = 0.25
	obj.position.z = -y
	obj.position.x = x

func _ready():
	place_object(res_bomb, 3, 3)
	place_object(res_wump, 3, 4)
	place_object(res_hole, 4, 3)
	place_object(res_mush, 4, 4)
