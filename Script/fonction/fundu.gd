extends Node

export var time=1
export var node=""

func _ready():
	$"../".modulate.a=0
	set_physics_process(false)
	$Timer.wait_time=time
	
	
func _physics_process(delta):
	$"../".modulate.a+=0.4*delta
	if $"../".modulate.a>=1:
		get_tree().call_group(node,"end_fondu")
		set_physics_process(false)



func _on_Timer_timeout():
	set_physics_process(true)
