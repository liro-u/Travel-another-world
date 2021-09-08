extends Control

var src_zoom_nbr=load("res://Scene/gui/zoom_nbr.tscn")
var nbr

func _on_unpause_pressed():
	visible=true
	nbr=3
	$"../pause menu global".visible=false
	$"Timer".start()
	new_nbr()
	nbr-=1
	
func new_nbr():
	var n_nbr=src_zoom_nbr.instance()
	n_nbr.text=str(nbr)
	add_child(n_nbr)
	
func _on_Timer_timeout():
	if nbr==2:
		new_nbr()
		nbr-=1
	elif nbr==1:
		new_nbr()
		nbr-=1
	else:
		visible=false
		$"../../game".unpause_finish()
		$"Timer".stop()
		$"../GUI/HBoxContainer/pause".disabled=false
		
