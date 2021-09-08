extends Area2D


var screen_size

func _input(event):
	if $"../".event_valid and not $"../../../../".pause:
		if event is InputEventScreenTouch and event.pressed and event.position.x>screen_size.x/2 and event.position.y>60:
			$"../".attack_play=true
	

func _ready():
	screen_size=get_viewport_rect().size

