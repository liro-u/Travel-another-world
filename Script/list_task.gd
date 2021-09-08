extends Node2D
export(Array,PackedScene) var list_mission_C
export(Array,PackedScene) var list_mission_B
export(Array,PackedScene) var list_mission_A
export(Array,PackedScene) var list_mission_S

export var chance_S=5
export var chance_A=15
export var chance_B=30

func new_rand():
	var rand_num=randi()%100
	if rand_num<chance_S:
		new_task(list_mission_S)
	elif rand_num<chance_A:
		new_task(list_mission_A)
	elif rand_num<chance_B:
		new_task(list_mission_B)
	else:
		new_task(list_mission_C)
		
func new_task(list_task):
	var new_task=list_task[randi()%len(list_task)].instance()
	add_child(new_task)
	print("new")
