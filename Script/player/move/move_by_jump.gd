extends Node2D

var screen_size

export var speed_jump=-600
export var gravity=30

export var anim_fall=200

func _ready():
	screen_size=get_viewport_rect().size


func _input(event):
	if $"../".event_valid and not $"../../../../".pause:
		if event.is_action_pressed("jump"):
			$"../".velocity.y=speed_jump

func _physics_process(_delta):
	if $"../../../../".move_player :
		if $"../".is_on_ceiling():
			$"../".velocity.y=0
		$"../".velocity.y+=gravity
		
func _process(_delta):
	if $"../".velocity.y<=anim_fall:
		$"../".air_up=true
	else:
		$"../".air_up=false
