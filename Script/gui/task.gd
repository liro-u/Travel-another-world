extends Node2D

export(String, MULTILINE) var text
var final_text
export(int) var distance_objectif
export(bool) var one_shot

export(int,"coin") var type_reward
export(int) var reward

var distance=0
var distance_game=0

func _ready():
	refresh_text()
	
func refresh_text():
	final_text=text+"("+str(round(distance_game+distance))+"/"+str(distance_objectif)+")"

func add_progress(new_distance=0):
	distance_game=new_distance
	refresh_text()
	
func give_reward():
	distance+=distance_game
	if distance>=distance_objectif:
		match type_reward:
			0:
				$"../../".global_coin+=reward
		$"../".new_rand()
		remove_from_group("task_active")
		print("remove")
		queue_free()
	else:
		if one_shot==true:
			distance=0

func save_data(num):
	var saveFile=File.new()
	var txt_data_game_path="res://data/task_data/task_data_"+str(num)+".txt"
	saveFile.open(txt_data_game_path,File.WRITE)
	saveFile.store_line(str(distance))
	saveFile.close()
	
func load_data(num):
	var loadFile=File.new()
	var txt_data_game_path="res://data/task_data/task_data_"+str(num)+".txt"
	loadFile.open(txt_data_game_path,File.READ)
	distance=int(loadFile.get_line())
	loadFile.close()
