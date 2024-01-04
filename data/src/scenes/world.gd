extends Node3D

func _ready():
	self.get_node('Misc/Hud').world = self
