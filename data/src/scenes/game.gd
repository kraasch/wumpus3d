extends Node3D

var world = null

const res_bomb = preload("res://data/src/scenes/bomb.tscn")
const res_hole = preload("res://data/src/scenes/hole.tscn")
const res_wump = preload("res://data/src/scenes/wumpus.tscn")
const res_bat  = preload("res://data/src/scenes/bat.tscn")
const res_play = preload("res://data/src/scenes/player.tscn")
const res_fog  = preload("res://data/src/scenes/fog.tscn")
const res_mark = preload("res://data/src/scenes/marker.tscn")

var player = res_play.instantiate()
var mark   = res_mark.instantiate()
var wump   = res_wump.instantiate()
var hole   = res_hole.instantiate()
var bomb   = res_bomb.instantiate()
var bat    = res_bat.instantiate()
var fog    = res_fog.instantiate()

var grid = []
var game_objects = []
var fog_objects = []

func _ready():
	game_objects.append(mark)
	game_objects.append(player)
	game_objects.append(wump)
	game_objects.append(bat)
	game_objects.append(hole)
	game_objects.append(bomb)
	game_objects.append(fog)
	grid = [
			bomb, null, wump,   hole,
			null, null, null,   null,
			bat,  null, player, null,
			null, null, null,   null,
		]
	init_obj(mark, 5, 5, false)
	init_obj(bomb, 5, 5, false)
	init_obj(wump, 5, 5, false)
	init_obj(hole, 5, 5, false)
	init_obj(bat, 5, 5, false)
	init_obj(player, 5, 5, false)
	init_obj(fog, 5, 5, false)
	init_game()
	visualize()

func visualize():
	for obj in game_objects:
		self.get_node('Objs').add_child(obj)
#		obj.visible = true
		obj.position.y = 0.25

func init_game():
	const N = 4
	for x in range(0, N):
		for y in range(0, N):
			var new_fog = res_fog.instantiate()
			game_objects.append(new_fog)
			fog_objects.append(new_fog)
			init_obj(new_fog, x, y, false)
			var obj = grid[x + y * N] 
			if obj != null:
				init_obj(obj, x, y)

func init_obj(obj, x, y, vis : bool = true):
	if obj != null:
		obj.position.z = -(y + 1)
		obj.position.x = x + 1
		obj.position.y = 0.25
		obj.visible = vis

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
		move_player()

func move_player():
	if mark.visible:
		# TODO: move in GRID, then update COORDINATES.
		player.position.x = mark.position.x
		player.position.z = mark.position.z
		mark.visible = false

func set_mark(x, y):
	mark.visible = true
	const MIN = 1
	const MAX = 4
	var temp_x = player.position.x + x
	var temp_y = player.position.z + y
	if MIN > temp_x or MAX < temp_x or -MAX > temp_y or -MIN < temp_y:
		mark.visible = false
	# TODO: move in GRID, then update COORDINATES.
	mark.position.x = temp_x
	mark.position.z = temp_y
