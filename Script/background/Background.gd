extends Node2D

#chargement des themes
#transition
var front_cache_void=preload("res://assets/background/transition/void.tres")
var front_transition=preload("res://assets/background/transition/front/new_spriteframes.tres")
var front_cache_transition=preload("res://assets/background/transition/front_cache/new_spriteframes.tres")
#city_vegetation_1
var front_transition_city_vegetation=preload("res://assets/background/city_vegetation_1/transition/transitions.tres")
var front_city_vegetation=preload("res://assets/background/city_vegetation_1/front/vegetation_city.tres")
var front_cache_city_vegetation=preload("res://assets/background/city_vegetation_1/front_cache/city_vegetal.tres")
var midle_city_vegetation=preload("res://assets/background/city_vegetation_1/midle/garden.tres")
var back_city_vegetation=preload("res://assets/background/city_vegetation_1/back/sky.tres")
#labo
var front_transition_labo=preload("res://assets/background/labo/front/transition.tres")
var front_labo=preload("res://assets/background/labo/front/new_spriteframes.tres")
var front_cache_labo=preload("res://assets/background/labo/front_cache/new_spriteframes.tres")
var midle_labo=preload("res://assets/background/labo/midle/new_spriteframes.tres")
var back_labo=preload("res://assets/background/labo/back/new_spriteframes.tres")



#variables
export (PackedScene) var BackgroundPannel
var wait_valid_anim_front_cache
var wait_valid_anim_front
var wait_valid_anim_midle
var wait_valid_anim_back
var decalage
var chance_front_cache_fill=3

var compt_pan_theme
var max_pan_theme=25
var min_pan_theme=12
var theme="city_vegetation_1"
var theme_list=["city_vegetation_1","labo"]
var transition
var compt_valid_trans_back
#les frames doivent avoir les meme 1ere colonne de pixel en debut et fin
	
func reset_start():
	#initialiser les variables
	theme="city_vegetation_1"
	var list_delete = get_tree().get_nodes_in_group("backgroundPannel")
	for node_delete in list_delete:
		node_delete.delete()
	wait_valid_anim_front_cache=false
	wait_valid_anim_front=false
	wait_valid_anim_midle=false
	wait_valid_anim_back=false
	compt_pan_theme=0
	transition=0
	compt_valid_trans_back=0
	create_started_pannel()
	
func create_started_pannel():
	#créer les sprites de fond du debut du jeu
	#back
	add_back()
	add_back()
	add_back()
	#midle
	add_midle()
	add_midle()
	add_midle()
	#front
	add_front()
	add_front()
	add_front()
	#front cache
	add_front_cache([],true,[front_cache_void])
	add_front_cache([],true,[front_cache_void])
	add_front_cache()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  not $"../".pause :
		decalage=$"../".multiplicateurVitesse*delta
		get_tree().call_group("backgroundfront", "moove", decalage*20)
		get_tree().call_group("backgroundfrontcache", "moove", decalage*25)
		get_tree().call_group("backgroundmidle", "moove", decalage*7)
		get_tree().call_group("backgroundback", "moove", decalage*3)
	
	
#ajout de pannel type
#ajout front cache
func add_front_cache(node_delete=[],activ_anim=true,res=[]):
	#calcul de la l'emplacement du nouveau pannel
	var pos_x=0
	var bg_front=get_tree().get_nodes_in_group("backgroundfrontcache")
	var len_bg_front=len(bg_front)
	if node_delete!=[]:
		node_delete[0].queue_free()
		node_delete=[]
	if bg_front!=[]:
		var info_taille=bg_front[len_bg_front-1].info_taille
		pos_x=info_taille[0]+info_taille[1]-1
	#créer l'instance
	var backgroundPannel= BackgroundPannel.instance()
	backgroundPannel.position.x=pos_x
	#dire que le programme a une animation a synchro
	if activ_anim:
		backgroundPannel.set_animation_on()
	else:
		wait_valid_anim_front_cache=true
	#definir la ressources frames/animation
	var frames
	if res==[]:
		frames=set_ressource_front_cache()
	else:
		frames=res[0]
	backgroundPannel.change_frames(frames)
	backgroundPannel.change_animation(random_animation(frames))
	#ajouter a l'arbre et au groupe
	$"../Layers/front_cache".add_child(backgroundPannel)
	backgroundPannel.add_to_group("backgroundfrontcache")
#ajout front
func add_front(node_delete=[],activ_anim=true):
	#calcul de l'emplacement du nouveau pannel
	var pos_x=0
	var bg_front=get_tree().get_nodes_in_group("backgroundfront")
	var len_bg_front=len(bg_front)
	if node_delete!=[]:
		node_delete[0].queue_free()
		node_delete=[]
	if bg_front!=[]:
		var info_taille=bg_front[len_bg_front-1].info_taille
		pos_x=info_taille[0]+info_taille[1]-1
	#créer l'instance
	var backgroundPannel= BackgroundPannel.instance()
	backgroundPannel.position.x=pos_x
	#dire que le programme a une animation a synchro
	if transition!=2:
		if activ_anim:
			backgroundPannel.set_animation_on()
		else:
			wait_valid_anim_front=true
	#definir la ressources frames
	var frames=set_ressource_front()
	backgroundPannel.change_frames(frames)
	if transition!=3 and transition!=1:
		backgroundPannel.change_animation(random_animation(frames))
	elif transition==3:
		transition=2
		backgroundPannel.change_animation("end")
	else:
		transition=0
		backgroundPannel.change_animation("start")
	#ajouter a l'arbre et au groupe
	$"../Layers/front".add_child(backgroundPannel)
	backgroundPannel.add_to_group("backgroundfront")
#ajout midle
func add_midle(node_delete=[],activ_anim=true):
	#calcul de la l'emplacement du nouveau pannel
	var pos_x=0
	var bg_front=get_tree().get_nodes_in_group("backgroundmidle")
	var len_bg_front=len(bg_front)
	if node_delete!=[]:
		node_delete[0].queue_free()
		node_delete=[]
	if bg_front!=[]:
		var info_taille=bg_front[len_bg_front-1].info_taille
		pos_x=info_taille[0]+info_taille[1]-1
	#créer l'instance
	var backgroundPannel= BackgroundPannel.instance()
	backgroundPannel.position.x=pos_x
	#dire que le programme a une animation a synchro
	if activ_anim:
		backgroundPannel.set_animation_on()
	else:
		wait_valid_anim_midle=true
	#definir la ressources frames
	var frames=set_ressource_midle()
	backgroundPannel.change_frames(frames)
	backgroundPannel.change_animation(random_animation(frames))
	#ajouter a l'arbre et au groupe
	$"../Layers/midle".add_child(backgroundPannel)
	backgroundPannel.add_to_group("backgroundmidle")
#ajout back
func add_back(node_delete=[],activ_anim=true):
	#calcul de la l'emplacement du nouveau pannel
	var pos_x=0
	var bg_front=get_tree().get_nodes_in_group("backgroundback")
	var len_bg_front=len(bg_front)
	if node_delete!=[] :
		node_delete[0].queue_free()
	if bg_front!=[]:
		var info_taille=bg_front[len_bg_front-1].info_taille
		pos_x=info_taille[0]+info_taille[1]-1
	#créer l'instance
	var backgroundPannel= BackgroundPannel.instance()
	backgroundPannel.position.x=pos_x
	#dire que le programme a une animation a synchro
	if activ_anim:
		backgroundPannel.set_animation_on()
	else:
		wait_valid_anim_back=true
	#definir la ressources frames
	var frames=set_ressource_back()
	backgroundPannel.change_frames(frames)
	backgroundPannel.change_animation(random_animation(frames))
	#ajouter a l'arbre et au groupe
	$"../Layers/back".add_child(backgroundPannel)
	backgroundPannel.add_to_group("backgroundback")





#choisi la ressource d'un type
#ressource back
func set_ressource_back():
	if theme=="city_vegetation_1":
		return(back_city_vegetation)
	elif theme=="labo":
		return(back_labo)
#ressource midle
func set_ressource_midle():
	if theme=="city_vegetation_1":
		return(midle_city_vegetation)
	elif theme=="labo":
		return(midle_labo)
#ressource front cache
func set_ressource_front_cache():
	if (randi() % chance_front_cache_fill)==0:
		if transition!=0:
			return(front_cache_transition)
		else:
			if theme=="city_vegetation_1":
				return(front_cache_city_vegetation)
			elif theme=="labo":
				return(front_cache_labo)
	else:
		return(front_cache_void)
#ressource front
func set_ressource_front():
	var theme_save=theme
	#test si il y a un changement de theme
	if len(theme_list)!=1:
		if compt_pan_theme>max_pan_theme:
			compt_pan_theme=0
			transition=3
			while theme_save==theme:
				theme=theme_list[randi() % len(theme_list)-1]
		elif compt_pan_theme>min_pan_theme:
			if randi() %5==4:
				compt_pan_theme=0
				transition=3
				while theme_save==theme:
					theme=theme_list[randi() % len(theme_list)-1]
	#charger les ressources
	#ancien theme ---> zone transition et zone transition ---> nouveau theme
	if transition==3 or transition==1:
		if theme_save=="city_vegetation_1":
			return(front_transition_city_vegetation)
		elif theme_save=="labo":
			return(front_transition_labo)
	#zone transition
	elif transition==2:
		return(front_transition)
	#theme
	else:
		compt_pan_theme+=1
		if theme=="city_vegetation_1":
			return(front_city_vegetation)
		elif theme=="labo":
			return(front_labo)
			

func random_animation(frames):
	var anim=frames.get_animation_names()
	return(anim[randi()%len(anim)])
			

func check_transition():
	if transition!=0:
		compt_valid_trans_back+=1
		if compt_valid_trans_back>2:
			transition=1
			compt_valid_trans_back=0

	
	
	
	
	
#lancer les animation dun type
#lancer back
func set_anim_back_play(frame):
	if wait_valid_anim_back:
		wait_valid_anim_back=false
		var fonc_back=get_tree().get_nodes_in_group("backgroundback")
		fonc_back[len(fonc_back)-1].set_animation_on(frame)
#lancer midle
func set_anim_midle_play(frame):
	if wait_valid_anim_midle:
		wait_valid_anim_midle=false
		var fonc_midle=get_tree().get_nodes_in_group("backgroundmidle")
		fonc_midle[len(fonc_midle)-1].set_animation_on(frame)
#lancer front
func set_anim_front_play(frame):
	if wait_valid_anim_front:
		wait_valid_anim_front=false
		var fonc_front=get_tree().get_nodes_in_group("backgroundfront")
		fonc_front[len(fonc_front)-1].set_animation_on(frame)
#lancer front cache
func set_anim_front_cache_play(frame):
	if wait_valid_anim_front_cache:
		wait_valid_anim_front_cache=false
		var fonc_front_cache=get_tree().get_nodes_in_group("backgroundfrontcache")
		fonc_front_cache[len(fonc_front_cache)-1].set_animation_on(frame)
#gere la creation dun type de pannel
func out_background(type,node_delete):
	if type=="front_cache":
		add_front_cache(node_delete,false)
	elif type=="front":
		add_front(node_delete,false)
	elif type=="midle":
		add_midle(node_delete,false)
	else:
		add_back(node_delete,false)
	
	
