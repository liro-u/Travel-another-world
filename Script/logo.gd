extends Sprite

var etat=2
export var speed=0.4
export var time=2

func _ready():
	modulate.a=0
	
func _physics_process(delta):
	if etat==1:
		up_alpha(delta)
	elif etat==0:
		down_alpha(delta)
	
func up_alpha(delta):
	if modulate.a<1:
		modulate.a+=speed*delta
	else:
		modulate.a=1
		if time>0:
			$Timer.wait_time=time
			$Timer.start()
			set_physics_process(false)
		else:
			etat-=1
			
func down_alpha(delta):
	modulate.a-=speed*delta
	if modulate.a<=0:
		$Timer2.start()
		etat-=1
		
func delete():
	$"../loader_layer/loader_screen".set_random()
	$"../loader_layer/loader_screen".set_alpha(true,true,1)
	$"../loader_layer/loader_screen".need_loading_screen(funcref($"../","set_ressource"),["res://Scene/big package/menu.tscn","res://Scene/big package/game.tscn","res://Scene/big package/fix_GUI.tscn"])
	$"../loader_layer/loader_screen".add_verif()
	$"../loader_layer/loader_screen".start()
	queue_free()



func _on_Timer_timeout():
	etat-=1
	set_physics_process(true)


func _on_Timer2_timeout():
	delete()
