extends Node2D

var loader
var wait_frame
export var time_max=100

func _ready():
	set_process(false)

func needLoader(path):
	loader=ResourceLoader.load_interactive(path)
	if loader ==null:
		return
	$"../loader_layer/loader_screen".set_load_bar(0,false)
	set_process(true)
	wait_frame=1

func _process(_delta):
	if loader==null:
		set_process(false)
		return
	if wait_frame>0:
		wait_frame-=1
		return
	var t= OS.get_ticks_msec()
	while OS.get_ticks_msec()<t+time_max:
		var err=loader.poll()
		if err==ERR_FILE_EOF:
			var ressource=loader.get_resource()
			print("etape ",loader.get_stage()+1,"/",loader.get_stage_count())
			print("ressources load: ",ressource)
			$"../loader_layer/loader_screen".set_load_bar(100)
			loader=null
			$"../loader_layer/loader_screen".load_end(ressource)
			break
		elif err==OK:
			$"../loader_layer/loader_screen".set_load_bar(round(float(loader.get_stage())/ float(loader.get_stage_count())*100))
			print("etape ",loader.get_stage(),"/",loader.get_stage_count())
		else:
			loader=null
			break
	
