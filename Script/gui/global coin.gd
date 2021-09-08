extends HBoxContainer

var state="up"

export var max_pos=0
export var min_pos=100

export var speed=100

func _ready():
	set_physics_process(false)
	
func refresh_coin():
	$"nbr".text=str($"../../../../..".global_coin)
	
func _physics_process(delta):
	if state=="up":
		if rect_position.y>=max_pos:
			rect_position.y=max_pos
			state="down"
			set_physics_process(false)
		else:
			rect_position.y+=speed*delta
	elif state=="down":
		if rect_position.y<=min_pos:
			rect_position.y=min_pos
			state="up"
			set_physics_process(false)
		else:
			rect_position.y-=speed*delta
		
func run():
	set_physics_process(true)
