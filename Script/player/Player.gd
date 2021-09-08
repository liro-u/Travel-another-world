extends KinematicBody2D

var velocity = Vector2()
var air_up
var event_valid=false
var live=true
var die_t_check=false
export var death=true
export var nbr_revive_tot=1
signal kill

func _physics_process(_delta):
	if $"../../../".move_player and not $"../../../".pause:
		move_and_slide(velocity,Vector2(0,-1))
		
func _process(_delta):
	if live:
		if is_on_floor():
			$AnimatedSprite.animation="run"
		else:
			if air_up:
				$AnimatedSprite.animation="fly"
			else:
				$AnimatedSprite.animation="fall"

	else:
		if is_on_floor():
			$"../../../".acc_up=false
		if die_t_check:
			if is_on_floor():
				if $"../../../".multiplicateurVitesse<1:
					$AnimatedSprite.animation="die_e"
				else:
					$AnimatedSprite.animation="die"
		else:
			$AnimatedSprite.animation="die_t"
			if $AnimatedSprite.get_sprite_frames().get_frame_count($AnimatedSprite.animation)-1==$AnimatedSprite.frame:
				die_t_check=true

func revive():
	$"CollisionShape2D".rotation_degrees=0
	$"CollisionShape2D".position.y=90
	event_valid=true
	live=true
	die_t_check=false
	
func kill():
	if death:
		death=false
		$"CollisionShape2D".rotation_degrees=90
		$"CollisionShape2D".position.y=140
		emit_signal("kill")
		event_valid=false
		live=false
		$"../../../Camera".shake(0.8,60,30)

func play():
	$AnimatedSprite.play()

func stop():
	$AnimatedSprite.stop()
