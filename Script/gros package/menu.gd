extends Node2D

export var multiplicateurVitesse=20
var pause=false
var game="res://Scene/big package/game.tscn"
var gui_game="res://Scene/big package/fix_GUI.tscn"

func _ready():
	$Background.reset_start()
	$"menu_music".play_just_me()
	
func end_fondu():
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/play".start_show()

func button_show_finish():
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/task/task".start_show()
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/shop/shop".start_show()

func button2_show_finish():
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer2/param/param".start_show()
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer2/share/share".start_show()
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer2/credit/credit".start_show()


func set_wait_time(time):
	$"VBoxContainer/CenterContainer/titre/Fondu/Timer".wait_time=time

func start():
	$"VBoxContainer/CenterContainer/titre/Fondu/Timer".start()
	
func _on_play_pressed():
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/play".disabled=true
	$"../loader_layer/loader_screen".set_texture(load("res://assets/background/labo/back/labo.png"),0,0,0)
	$"../loader_layer/loader_screen".set_alpha(true,true,4)
	$"../loader_layer/loader_screen".need_loading_screen(funcref($"../","NewGame"))
	$"../loader_layer/loader_screen".start()


func _on_play_show_finish():
	$"VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/play".disabled=false
	
func _on_task_pressed():
	get_tree().call_group_flags(2,"task_distance","add_progress")
	$"CenterContainer/les mission".refresh_task()
	$"CenterContainer".show()
	$"VBoxContainer".hide()
	
func _on_return_pressed():
	$"CenterContainer".hide()
	$"VBoxContainer".show()
