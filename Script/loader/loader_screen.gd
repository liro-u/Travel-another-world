extends Node2D

export(Array, Texture) var texture_loader_list
export(Array,Array,String,MULTILINE) var text_loader_list
var path_list
var num_path
var function
var function2
var verif
export var speed_alpha_bar=4
export var speed_alpha_label=1
var alpha_bar_up=true

var disappear=false
var state="appear"
var alpha_up=false
var alpha_down=false
var speed_alpha

func _ready():
	set_physics_process(false)
	set_process_input(false)

func set_texture_random():
	var num=randi()%len(texture_loader_list)
	set_texture(texture_loader_list[num])
	
func set_label_random():
	var num=randi()%len(text_loader_list)
	set_label(text_loader_list[num])
	
func set_label(text_list):
	$"texture/astuce/VBoxContainer/titre".text=text_list[0]
	$"texture/astuce/VBoxContainer/detail".text=text_list[1]
	
func set_texture(t,r=1,g=1,b=1,a=1):
	$texture.texture=t
	$texture.self_modulate.r=r
	$texture.self_modulate.g=g
	$texture.self_modulate.b=b
	$texture.self_modulate.a=a

func set_alpha(b1,b2,s=1):
	if b1:
		modulate.a=0
	alpha_up=b1
	alpha_down=b2
	speed_alpha=s
	
func set_random():
	set_texture_random()
	set_label_random()
	
func need_loading_screen(f1=null,list=[]):
	path_list=list
	function=f1
	function2=null
	verif=1
	if path_list==[]:
		$"texture/MarginContainer".visible=false
		$"texture/astuce".hide()
	else:
		$"texture/MarginContainer".visible=true
		$"texture/astuce".show()
	$"texture/MarginContainer/TextureProgress/CenterContainer/MarginContainer/Label2".modulate.a=0
	$"texture/MarginContainer/press key".modulate.a=0
	$"texture/MarginContainer/TextureProgress".modulate.a=1

func start_loading():
	num_path=0
	$"../../loader".needLoader(path_list[num_path])
	$"texture/MarginContainer/TextureProgress/CenterContainer/MarginContainer/Label2".text="(dossier "+str(num_path)+"/"+str(len(path_list))+")"
	$"texture/MarginContainer/TextureProgress/CenterContainer/MarginContainer/Label2".modulate.a=1
	
func set_load_bar(percent,tween=true):
	if tween:
		$Tween.interpolate_property($"texture/MarginContainer/TextureProgress", "value", $"texture/MarginContainer/TextureProgress".value,percent, 0.2)
		if not $Tween.is_active():
			$Tween.start()
	else:
		print("remove")
		$Tween.remove_all()
		$"texture/MarginContainer/TextureProgress".value=0
		$"texture/MarginContainer/TextureProgress/CenterContainer/MarginContainer/Label".text="0%"
		
func load_end(node):
	if num_path<len(path_list)-1:
		function.call_func(node,num_path)
		num_path+=1
		$"../../loader".needLoader(path_list[num_path])
	else:
		function.call_func(node,num_path)
	$"texture/MarginContainer/TextureProgress/CenterContainer/MarginContainer/Label2".text="(dossier "+str(num_path+1)+"/"+str(len(path_list))+")"

func start():
	visible=true
	set_physics_process(true)

func _input(event):
	if event is InputEventKey:
		disapear_all()
		
func disapear_all():
	disappear=true
	if function2!=null:
		function2.call_func()
	set_process_input(false)
		
func _physics_process(delta):
	if state=="appear":
		if alpha_up:
			if modulate.a<1:
				modulate.a+=speed_alpha*delta
			else:
				modulate.a=1
				alpha_up=false
		if not alpha_up:
			if path_list!=[]:
				state="trans"
				set_physics_process(false)
				start_loading()
			else:
				state="wait"
				if function!=null:
					function.call_func()
	elif state=="trans":
		if $"texture/MarginContainer/TextureProgress".modulate.a>0:
			$"texture/MarginContainer/TextureProgress".modulate.a-=speed_alpha_bar*delta
		else:
			$"texture/MarginContainer/TextureProgress".modulate.a=0
			set_process_input(true)
			state="wait_key_press"
	elif state=="wait_key_press":
		if alpha_bar_up:
			if $"texture/MarginContainer/press key".modulate.a<1 :
				$"texture/MarginContainer/press key".modulate.a+=speed_alpha_label*delta
			else :
				alpha_bar_up=false
		else:
			if $"texture/MarginContainer/press key".modulate.a>0 :
				$"texture/MarginContainer/press key".modulate.a-=speed_alpha_label*delta
			else:
				alpha_bar_up=true
	if disappear:
		if alpha_down:
			if modulate.a>0:
				modulate.a-=speed_alpha*delta
			else:
				modulate.a=0
				alpha_down=false
		else:
			state="appear"
			disappear=false
			set_physics_process(false)
			visible=false

func _on_Tween_tween_step(_object, _key, _elapsed, _value):
	$"texture/MarginContainer/TextureProgress/CenterContainer/MarginContainer/Label".text=str($"texture/MarginContainer/TextureProgress".value)+"%"

func _on_Tween_tween_all_completed():
	get_verif(1)

func get_verif(n=0):
	verif-=n
	if verif<=0:
		set_physics_process(true)

func add_verif(n=1):
	verif+=n
	
func set_f2(f):
	function2=f
