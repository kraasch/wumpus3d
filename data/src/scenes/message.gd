extends Control

func msg(text, ttl, parent):
	parent.add_child(self)
	$Label.text = text
	add_timer(ttl)

func add_timer(ttl : float = 3.0):
	# make new timer:
	var timer = Timer.new()
	timer.one_shot = true
	timer.autostart = true
	timer.connect('timeout', on_timer_timeout)
	timer.wait_time = ttl
	# start timer:
	add_child(timer)
	timer.start()

func on_timer_timeout():
	self.visible = false
	queue_free()
