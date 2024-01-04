extends Control

var world = null

func _on_button_pressed():
	if world != null:
		deactivate()
		
func deactivate():
	self.visible = false
	world.visible = true
