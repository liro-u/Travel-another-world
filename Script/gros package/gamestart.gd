extends Node2D

var multiplicateurVitesse
var x_acceleration_mult
var move_player
var coin_of_game
var acc_up
var distance
var pause=false
var lock_play_anim=false
var visu_pause_down=false
var revive_by_game
var revive_by_game_max
signal die_finish

func _ready():
	gamereset()
	$"../loader_layer/loader_screen".disapear_all()
	revive_by_game_max=$"Layers/player/Player".nbr_revive_tot
	connect("die_finish",$"../fix_GUI","death_menu_appear")
	
func gamereset():
	$"../fix_GUI/death_menu/CenterContainer/health/global coin".refresh_coin()
	revive_by_game=0
	coin_of_game=0
	distance=0
	move_player=true
	$"Layers/player/Player".revive()
	$"Layers/player/Player".death=true
	x_acceleration_mult=0
	multiplicateurVitesse=0
	acc_up=true
	$Background.reset_start()
	$Layers/pannel.reset_pannel()
	$"momentané/backstart".start()
	$"../fix_GUI/GUI".visible=true
	
func gamerestart():
	$"Layers/player/Player".death=true
	move_player=true
	$"Camera"._timer=0.0
	$Layers/pannel.reset_pannel()
	$TimerAcceleration.start()
	acc_up=true
	visu_pause_down=false
	$"../fix_GUI/GUI/HBoxContainer/pause".disabled=false
	
func gamestart():
	$"game_music".play_just_me()
	$TimerAcceleration.start()
	$"Layers/player/Player".event_valid=true
	$"momentané/backstart".stop()
	
func acceleration():
	if not pause:
		if acc_up:
			multiplicateurVitesse=(atan(0.05*x_acceleration_mult-5)*8+22)*2
			x_acceleration_mult+=0.2
		else:
			if multiplicateurVitesse>0:
				if $"Layers/player/Player".is_on_floor():
					multiplicateurVitesse-=log(x_acceleration_mult)
					x_acceleration_mult+=0.1
				if multiplicateurVitesse<0:
					multiplicateurVitesse=0
					emit_signal("die_finish")
			else:
				multiplicateurVitesse=0

func _process(_delta):
	if not pause:
		distance+=multiplicateurVitesse/100
		$"../fix_GUI/GUI/HBoxContainer/compteur/metre/Label".text=str(round(distance))
	if visu_pause_down and $"../fix_GUI/GUI/HBoxContainer/pause".modulate.a>=0 :
		$"../fix_GUI/GUI/HBoxContainer/pause".modulate.a-=0.01
	elif not visu_pause_down and $"../fix_GUI/GUI/HBoxContainer/pause".modulate.a<=1:
		$"../fix_GUI/GUI/HBoxContainer/pause".modulate.a+=0.01
		
func grab_coin(valeur):
	coin_of_game+=valeur
	$"../fix_GUI/GUI/HBoxContainer/compteur/coin/piece/Label".text=str(coin_of_game)


func unpause_finish():
	visu_pause_down=false
	pause=false
	move_player=true
	get_tree().call_group("animated","play")
	$"../fix_GUI/compteur".visible=false
	
func _on_pause_pressed():
	visu_pause_down=true
	pause=true
	move_player=false
	get_tree().call_group("animated","stop")
	$"../fix_GUI/pause menu global".visible=true


func _on_Player_kill():
	visu_pause_down=true
	$"../fix_GUI/GUI/HBoxContainer/pause".disabled=true

func _on_restart_pressed():
	gamereset()
	$"../fix_GUI/pause menu global".visible=false
	pause=false
	get_tree().call_group("animated","play")
	$"../fix_GUI/GUI/HBoxContainer/compteur/metre/Label".text="0"
	$"../fix_GUI/GUI/HBoxContainer/compteur/coin/piece/Label".text="0"
	$"Layers/player/Player".position.x=8.556
	$"Layers/player/Player".position.y=424.932
	$"Layers/player/Player".live=true
	$"Camera"._timer=0.0
	$"../fix_GUI/GUI/HBoxContainer/pause".modulate.a=1
	$"../fix_GUI/GUI/HBoxContainer/pause".disabled=false
	visu_pause_down=false
	$"../loader_layer/loader_screen".disapear_all()
	


func _on_pannel_alpha_down_finish():
	gamerestart()
	$"Layers/pannel".up_alpha()
