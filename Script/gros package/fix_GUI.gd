extends CanvasLayer

export(NodePath) var node_on_top_task_path
export(PackedScene) var task_node

var state="health"
var click=false
var cost_health

var revive_is_not_activate=true
var node_on_top_task

func _ready():
	node_on_top_task=get_node(node_on_top_task_path)
	cost_health=int($"death_menu/CenterContainer/health/health/health_by_coin/button warning/HBoxContainer/cost".text)
	$"pause menu global/CenterContainer/pause_menu/grille bouton mission/les mission".refresh_task()
	
func _on_pause_pressed():
	$"../game"._on_pause_pressed()
	$"GUI/HBoxContainer/pause".disabled=true
	get_tree().call_group_flags(2,"task_distance","add_progress",$"../game".distance)
	$"pause menu global/CenterContainer/pause_menu/grille bouton mission/les mission".refresh_task()

func _on_restart_pressed():
	$"../loader_layer/loader_screen".set_texture(load("res://assets/background/labo/back/labo.png"),0,0,0)
	$"../loader_layer/loader_screen".set_alpha(true,true,4)
	$"../loader_layer/loader_screen".need_loading_screen(funcref($"../game","_on_restart_pressed"))
	$"../loader_layer/loader_screen".start()

func _on_menu_pressed():
	$"../loader_layer/loader_screen".set_texture(load("res://assets/background/labo/back/labo.png"),0,0,0)
	$"../loader_layer/loader_screen".set_alpha(true,true,4)
	$"../loader_layer/loader_screen".need_loading_screen(funcref($"../","ShowMenu_byGame"))
	$"../loader_layer/loader_screen".start()
	
func death_menu_appear():
	$"death_menu".visible=true
	if $"../game".revive_by_game<$"../game".revive_by_game_max:
		show_health_button()
	else:
		next_death_menu()
		
func show_health_button():
	$"death_menu/CenterContainer/health".visible=true
	$"death_menu/CenterContainer/health/health/health_by_add".appear()
	$"death_menu/CenterContainer/health/health/health_by_coin".appear()
	$"death_menu/CenterContainer/health/global coin".run()

func hide_hearth_choice():
	$"death_menu/CenterContainer/health/global coin".run()
	$"death_menu/CenterContainer/health/health/health_by_add".disappear()
	$"death_menu/CenterContainer/health/health/health_by_coin".disappear()

func show_button_death():
	$"death_menu/CenterContainer/button/retry".appear()
	$"death_menu/CenterContainer/button/menu".appear()

func show_score_or_button():
	if state=="button":
		$"death_menu/CenterContainer/Timer".start()
	elif state=="score":
		$"death_menu/CenterContainer/score".visible=true
		$"death_menu/CenterContainer/score".set_score()
		$"death_menu/CenterContainer/score"._appear_start()
			
func hearth_is_hide():
	if revive_is_not_activate:
		$"death_menu/CenterContainer/health".visible=false
		show_score_or_button()
	else:
		revive_is_not_activate=true
		$"death_menu/CenterContainer/health".hide()
		$"death_menu".hide()
		$"../game/Layers/pannel".run()
		
func _on_health_by_coin_pressed():
	if $"../".global_coin>=cost_health:
		if click:
			$"../game".revive_by_game+=1
			revive_is_not_activate=false
			$"../".global_coin-=cost_health
			$"death_menu/CenterContainer/health/global coin".refresh_coin()
			click=false
			set_process_input(false)
			hide_hearth_choice()

func _on_health_by_add_pressed():
	if click:
		pass
	
func _on_health_by_add_show_finish():
	click=true
	set_process_input(true)
		
func show_death_button():
	get_tree().call_group_flags(2,"task_distance","add_progress",$"../game".distance)
	get_tree().call_group_flags(2,"task_distance","give_reward")
	if $"../".HGScore<round($"../game".distance):
		$"../".HGScore=round($"../game".distance)
	$"../".global_coin+=$"../game".coin_of_game
	$"../".save_data_game()
	$"death_menu/CenterContainer/button".show()
	show_button_death()
			
func _on_Control_gui_input(event):
	if click:
		if event is InputEventMouseButton and event.button_index==BUTTON_LEFT:
			next_death_menu()
				
func next_death_menu():
	click=false
	set_process_input(false)
	if state=="health":
		if $"../".HGScore<round($"../game".distance):
			state="score"
			show_score_or_button()
		else:
			state="button"
		if $"../game".revive_by_game<$"../game".revive_by_game_max:
			hide_hearth_choice()
		else:
			state="score"
			show_score_or_button()
	elif state=="score":
		state="button"
		$"death_menu/CenterContainer/Timer".start()
		
func hide_death_button():
	$"death_menu/CenterContainer/button/menu".disappear()
	$"death_menu/CenterContainer/button/retry".disappear()
	state="health"
	$"death_menu".hide()
	
func _on_retry_pressed():
	hide_death_button()
	_on_restart_pressed()

func _on_menu_death_pressed():
	hide_death_button()
	_on_menu_pressed()



func _on_musique_toggled(button_pressed):
	AudioServer.set_bus_mute(1,button_pressed)


func _on_son_toggled(button_pressed):
	AudioServer.set_bus_mute(2,button_pressed)
