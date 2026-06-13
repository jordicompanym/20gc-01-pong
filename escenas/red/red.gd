extends Node2D

func _draw():
	var screen = get_viewport_rect().size
	var segment_height = 20
	var gap = 15
	var x = screen.x / 2 - 2
	var y = 30
	
	while y < screen.y:
		draw_rect(Rect2(x, y, 1, segment_height), Color.WHITE)
		y += segment_height + gap
