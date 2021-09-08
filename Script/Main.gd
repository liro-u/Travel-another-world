###__BUG__###
#
#	-trouver le bug de l'apparition du bg quand on 
#	meurt, il s'arrete de se generer
#
#	-exportation add things crash
#
###__BUG__###


###__CHOSE A FAIRE__###
#
#	-finir taches
#
#	-finir les textures
#
#	-ajouter les sons
#
###__CHOSE A FAIRE__###


###__TACHES__###
#
#	-trouver des nouvel taches
#
#	-ajouter un systeme pour obtenir de nouvel tache
#		-a un certain niveau on gagne 1 tache de plus
#		-ajouter un gain de niveau par tache
#		-equilibrer les tache dispo
#
###__TACHES__###


###__TEXTURE__###
#
#	-zone labo
#
#	-texture chargement
#
###__TEXTURE__###


###__SON__###
#
#	-son mort
#
#	-son revive
#
###__SON__###






###__CHOSE A FAIRE BONUS__###
#
#	-finir le menu
#
#	-gestion des différents perso
#
###__CHOSE A FAIRE BONUS__###


###__MENU DEATH BONUS__###
#
#	-revive add a finir
#
#	-animation player se releve avant de revive
#
#	-animation coin en moins quand achat revive
#
#	-animation mission complété nouvel mission
#
#	-animation piece recolté transferer au global
#
###__MENU DEATH BONUS__###


###__MENU BONUS__###
#
#	-parametre
#
#	-shop
#
#	-share
#
###__MENU BONUS__###








extends Node2D
export(String,FILE,"*.txt") var txt_data_game_path
var Logo=load("res://Scene/big package/logo.tscn")
var Menu
var Game
var GUI_game

var HGScore
var global_coin


func _ready():
	randomize()
	read_data_game()
	load_task()
	var logo=Logo.instance()
	add_child(logo)

func set_ressource(node,num_node):
	if num_node==0:
		Menu=node
	elif num_node==1:
		Game=node
	elif num_node==2:
		GUI_game=node
		ShowMenu(2)
		$"loader_layer/loader_screen".set_f2(funcref($menu,"start"))
		$"loader_layer/loader_screen".get_verif(1)
		
func ShowMenu(time=1):
	var menu=Menu.instance()
	add_child(menu)
	$menu.set_wait_time(time)
	
func ShowMenu_byGame(time=1):
	ShowMenu(time)
	$"menu".start()
	get_tree().call_group("pannel","set_visibilityNotifier_off")
	$"game".queue_free()
	$"fix_GUI".queue_free()
	$"loader_layer/loader_screen".disapear_all()
	
	

func NewGame():
	$menu.queue_free()
	var gui_game=GUI_game.instance()
	add_child(gui_game)
	var game=Game.instance()
	add_child(game)
	
func _notification(event):
	if event == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST or event==MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().call_group("pannel","set_visibilityNotifier_off")
		get_tree().quit() 

func save_data_game():
	var saveFile=File.new()
	saveFile.open(txt_data_game_path,File.WRITE)
	saveFile.store_line(str(HGScore))
	saveFile.store_line(str(global_coin))
	saveFile.close()
	save_task()
	
func read_data_game():
	var loadFile=File.new()
	loadFile.open(txt_data_game_path,File.READ)
	HGScore=int(loadFile.get_line())
	global_coin=int(loadFile.get_line())
	print("hgscore:",HGScore)
	print("gblcoin:",global_coin)
	loadFile.close()

func get_all_file_in_directory(path):
	var files=[]
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file =dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	return files
	
func save_task():
	var list_task_file=get_all_file_in_directory("res://data/task/")
	var dir_task=Directory.new()
	for file in list_task_file:
		dir_task.remove(file)
	list_task_file=get_all_file_in_directory("res://data/task_data/")
	for file in list_task_file:
		dir_task.remove(file)
		
	var list_task=get_tree().get_nodes_in_group("task_active")
	print(list_task)
	var num=0
	var packedscene=PackedScene.new()
	for task in list_task:
		packedscene.pack(task)
		var pathtaskfile="res://data/task/task_"+str(num)+".tscn"
		task.save_data(num)
		num+=1
		ResourceSaver.save(pathtaskfile,packedscene)
	print("save")
func load_task():
	var list_task_file=get_all_file_in_directory("res://data/task/")
	var num=0
	for file in list_task_file:
		var packedscene=load("res://data/task/"+file)
		var new_task=packedscene.instance()
		new_task.load_data(num)
		num+=1
		$"list_task".add_child(new_task)
		
