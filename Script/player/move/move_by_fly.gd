extends Node2D

var screen_size
var fly
export var gravity=25

#-(atan(x*divx-a)*b+c)
var x
export var divx=0.15
export var a=2.2
export var b=280
export var c=350

export var anim_fall=200

func _ready():
	screen_size=get_viewport_rect().size


func _input(event):
	if $"../".event_valid  and not $"../../../../".pause:
		if event.is_action_pressed("jump"):
			fly=true
			x=0
		if event.is_action_released("jump") and fly:
			fly=false

		


func _physics_process(_delta):
	if $"../../../../".move_player :
		if fly :
			if not $"../".is_on_ceiling():
				if $"../".is_on_floor():
					x=0
					$"../".velocity.y=0
				x+=1
				$"../".velocity.y=-(atan(x*divx-a)*b+c)
			else:
				x=0
				$"../".velocity.y=0
			
		else:
			if not $"../".is_on_floor():
				if $"../".is_on_ceiling():
					$"../".velocity.y=0
				$"../".velocity.y+=gravity
				
func _process(_delta):
	if not $"../".event_valid:
		fly=false
	if fly:
		$"../".air_up=true
	elif $"../".velocity.y>=anim_fall:
		$"../".air_up=false
		
