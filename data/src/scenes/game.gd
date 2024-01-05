extends Node3D

const res_bomb = preload("res://data/src/scenes/bomb.tscn")
const res_hole = preload("res://data/src/scenes/hole.tscn")
const res_wump = preload("res://data/src/scenes/wumpus.tscn")
const res_bat  = preload("res://data/src/scenes/bat.tscn")
const res_play = preload("res://data/src/scenes/player.tscn")
const res_fog  = preload("res://data/src/scenes/fog.tscn")
const res_mark = preload("res://data/src/scenes/marker.tscn")

var grid = []
var view = []
var mark = res_mark.instantiate()

func place_object(resource, x, y, z : float = 0.25):
	var offset : bool = true
	var obj = resource.instantiate()
	self.get_node('Objs').add_child(obj)
	if offset:
		obj.position.y = z
	obj.position.z = -y
	obj.position.x = x

func _ready():
	self.get_node('Objs').add_child(mark)
	mark.visible = false
	mark.position.y = 0.25
	new_game()
	show_game()

func show_game():
	const N = 4
	var i = 0
	for obj in grid:
		@warning_ignore("integer_division")
		var x : int = int(i / N)
		var y : int = int(i % N)
		if view[i]:
			if obj != null:
				place_object(obj, x + 1, y + 1)
		else:
			place_object(res_fog, x + 1, y + 1)
		i += 1

func new_game():
	grid = [
			res_bomb, null, res_wump, res_hole,
			null, null, null, null,
			res_bat, null, res_play, null,
			null, null, null, null,
		]
	view = [
			false, false, false, false,
			false, false, false, false,
			false, false, true, false,
			false, false, false, false,
		]

func _input(event):
	if event.is_action_pressed("ui_left"):
		set_mark(1, 0)
	if event.is_action_pressed("ui_right"):
		set_mark(-1, 0)
	if event.is_action_pressed("ui_up"):
		set_mark(0, -1)
	if event.is_action_pressed("ui_down"):
		set_mark(0, 1)
	if event.is_action_pressed("ui_accept"):
		pass

var player_x = 3
var player_y = 3

func set_mark(x, y):
	mark.visible = true
	mark.position.x = player_x + x
	mark.position.z = -(player_y + y)
