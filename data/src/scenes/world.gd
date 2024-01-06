extends Node3D

const res_msg = preload("res://data/src/scenes/message.tscn")

func _ready():
	$'Misc/Hud'.world = self
	$'Misc/Game'.world = self
	
func msg(text, ttl):
	res_msg.instantiate().msg(text, ttl, $'Misc/Log')
