extends Node2D

export var nbr_p_coin_min=1
export var nbr_p_coin_max=3
export var nbr_p_obst_min=1
export var nbr_p_obst_max=6
export var etat_p_obst_base=true
var etat_p_obst
var compteur_etat_p=0
var first

var list_panel_coin=[
preload("res://Scene/pannel/list_pannel_coin/Pannel_coin0.tscn"),
preload("res://Scene/pannel/list_pannel_coin/Pannel_coin1.tscn"),
preload("res://Scene/pannel/list_pannel_coin/Pannel_coin2.tscn"),
preload("res://Scene/pannel/list_pannel_coin/Pannel_coin3.tscn"),
preload("res://Scene/pannel/list_pannel_coin/Pannel_coin4.tscn")
]

var list_panel_obstacle=[
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap0.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap1.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap2.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap3.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap4.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap5.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap6.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap7.tscn"),
preload("res://Scene/pannel/list_pannel_zap/Pannel_zap8.tscn")
]

export var speedAlpha=2
var Pannel_void=preload("res://Scene/pannel/Pannel_void.tscn")

signal alpha_down_finish

func alpha_down(delta):
	modulate.a-=delta*speedAlpha
	if modulate.a<=0:
		modulate.a=0
		set_physics_process(false)
		emit_signal("alpha_down_finish")
		
func _physics_process(delta):
	alpha_down(delta)
	
func run():
	set_physics_process(true)
	$"../player/Player".revive()

func up_alpha():
	modulate.a=1
	
func reset_pannel():
	etat_p_obst=etat_p_obst_base
	get_tree().call_group("pannel","delete")
	first=true
	add_pannel([Pannel_void])
	add_pannel([Pannel_void])
	add_pannel()

func _ready():
	randomize()
	
func add_pannel(newPannel=[]):
	if newPannel==[]:
		var srcPannel
		if etat_p_obst:
			if compteur_etat_p>=nbr_p_obst_max:
				etat_p_obst=false
				compteur_etat_p=0
			elif compteur_etat_p>=nbr_p_obst_min:
				if randi() %5==4:
					etat_p_obst=false
					compteur_etat_p=0
		else:
			if compteur_etat_p>=nbr_p_coin_max:
				etat_p_obst=true
				compteur_etat_p=0
			elif compteur_etat_p>=nbr_p_coin_min:
				if randi() %5==4:
					etat_p_obst=true
					compteur_etat_p=0
		if etat_p_obst:
			srcPannel=list_panel_obstacle[randi()%len(list_panel_obstacle)]
		else:
			srcPannel=list_panel_coin[randi()%len(list_panel_coin)]
		newPannel=srcPannel.instance()
		compteur_etat_p+=1
	else:
		newPannel=newPannel[0].instance()
	var list_pannel=get_tree().get_nodes_in_group("pannel")
	var len_pannel=len(list_pannel)
	if first:
		first=false
	elif len_pannel!=0:
		newPannel.position.x=list_pannel[len_pannel-1].get_size()+list_pannel[len_pannel-1].position.x
	add_child(newPannel)

