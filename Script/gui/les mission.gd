extends Control

export(String,MULTILINE) var text_no_mission
export(PackedScene) var task_node
export(String) var node_list_task_path

var node_list_task

func _ready():
	node_list_task=get_node(NodePath(node_list_task_path))
	print(node_list_task)
	
func refresh_task():
	get_tree().call_group_flags(2,"task_node","queue_free")
	var task_list=node_list_task.get_children()
	if task_list:
		for task in task_list:
			var new_node=task_node.instance()
			new_node.text=task.final_text
			$"MarginContainer/ScrollContainer/VBoxContainer".add_child_below_node($"MarginContainer/ScrollContainer/VBoxContainer/HSeparator2",new_node)
	else:
		var new_node=task_node.instance()
		new_node.text=text_no_mission
		$"MarginContainer/ScrollContainer/VBoxContainer".add_child_below_node($"MarginContainer/ScrollContainer/VBoxContainer/HSeparator2",new_node)
