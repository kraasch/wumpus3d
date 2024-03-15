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
const N = 4
const MIN = 1
const MAX = 4
var click_timer = null
var px : int = -1
var py : int = -1

var select_count = 0
var max_select = 4
var directions = [
	[1, 0],
	[-1, 0],
	[0, -1],
	[0, 1]
]

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
		if obj is PlayerClass:
			px = x
			py = y

func _input(event):
	if was_triggered(event):
		if click_timer != null:
			# click was on time.
			move_player()
			remove_timer()
		else: # timer was not activated
			create_timer()

func create_timer():
	click_timer = Timer.new()
	click_timer.one_shot = true
	click_timer.wait_time = 0.4
	click_timer.timeout.connect(on_timeout)
	add_child(click_timer)
	click_timer.start()

func on_timeout():
	move_marker()
	remove_timer()
#	mark.visible = false # TODO.

func remove_timer():
	click_timer.stop()
	click_timer = null

func was_triggered(event):
	return event.is_action_pressed("ui_select") or event.is_action_pressed("ui_accept")

func move_marker():
	select_count += 1
	select_count = select_count % max_select
	var dir = directions[select_count]
	set_mark(dir[0], dir[1])

func move_player():
	if mark.visible:
		var dir = directions[select_count]
		if is_free(px + dir[0], py + dir[1]):
			# TODO: make grid coordinates the source of truth (instead of moving towards other objects).
			player.position.x = mark.position.x
			player.position.z = mark.position.z
			mark.visible = false

func is_free(x, y):
	var obj = grid[x + y * N]
	print(str(obj) + ' ' + str(x) + ', ' + str(y))
	return obj == null

func set_mark(change_x, change_y):
	mark.visible = true
	var x = px + change_x
	var y = py + change_y
	print(str(x) + ', ' + str(y))
	if x < MIN or x > MAX or y < -MAX or y < -MIN:
		print('out of bounds')
		# mark is out of bounds, re-trigger set mark.
		move_marker()
		#mark.visible = false
	else:
		# new coordinates are within grid's bounds.
		# TODO: make grid coordinates the source of truth (instead of moving towards other objects).
		mark.position.x = x
		mark.position.z = y
