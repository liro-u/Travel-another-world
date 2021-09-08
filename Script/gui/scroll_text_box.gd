extends Control

export(String, MULTILINE) var text=""

func _ready():
	var label=load("res://Scene/gui/scrolltxt/Label.tscn").instance()
	label.text=text
	$"panneau mission/MarginContainer/VBoxContainer/ScrollContainer".add_child(label)

	var m=rect_size.y/255
	if round(m*$"panneau mission/MarginContainer/VBoxContainer/ScrollContainer".rect_size.y)>$"panneau mission/MarginContainer/VBoxContainer/ScrollContainer/Label".rect_size.y:
		$"panneau mission/MarginContainer/VBoxContainer/bas/TextureRect".visible=false
		$"panneau mission/MarginContainer/VBoxContainer/ScrollContainer".scroll_vertical_enabled=false
	$"panneau mission/MarginContainer".set("custom_constants/margin_bottom",$"panneau mission/MarginContainer".rect_size.y*m/7+5)
	$"panneau mission/MarginContainer".set("custom_constants/margin_top",$"panneau mission/MarginContainer".rect_size.y*m/10+5)
