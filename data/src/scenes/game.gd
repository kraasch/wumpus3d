extends Node3D

const res_bomb = preload("res://data/src/scenes/bomb.tscn")
const res_hole = preload("res://data/src/scenes/hole.tscn")
const res_wump = preload("res://data/src/scenes/wumpus.tscn")
const res_bat  = preload("res://data/src/scenes/bat.tscn")
const res_play = preload("res://data/src/scenes/player.tscn")
const res_fog  = preload("res://data/src/scenes/fog.tscn")
const res_mark = preload("res://data/src/scenes/marker.tscn")

var mark   = res_mark.instantiate()
var player = res_play.instantiate()
var wump   = res_wump.instantiate()
var bat    = res_bat.instantiate()
var hole   = res_hole.instantiate()
var bomb   = res_bomb.instantiate()

var grid = []
var game_objects = []

func _ready():
	game_objects.append(mark)
	game_objects.append(player)
	game_objects.append(wump)
	game_objects.append(bat)
	game_objects.append(hole)
	game_objects.append(bomb)
	for obj in game_objects:
		self.get_node('Objs').add_child(obj)
		obj.visible = true
		obj.position.y = 0.25
	new_game()
	init_obj(mark, 5, 5)
	init_game()

func init_game():
	const N = 4
	var i = 0
	for obj in grid:
		@warning_ignore("integer_division")
		var x : int = int(i / N)
		var y : int = int(i % N)
		init_obj(obj, x, y)
		i += 1

func init_obj(obj, x, y, vis : bool = true):
	if obj != null:
		obj.position.z = -(y + 1)
		obj.position.x = x + 1
		obj.position.y = 0.25
		obj.visible = vis

func new_game():
	grid = [
			bomb, null, wump, hole,
			null, null, null, null,
			bat, null, player, null,
			null, null, null, null,
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

func set_mark(x, y):
	mark.position.x = player.position.x + x
	mark.position.z = player.position.z + y
