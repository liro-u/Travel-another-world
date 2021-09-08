extends TextureRect

export var speed_alpha=2
var state="show"

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if state=="show":
		appear(delta)
	else:
		disappear(delta)
		
func start_show():
	set_physics_process(true)
	show()
	
func start_hide():
	set_physics_process(true)
	
func appear(delta):
	modulate.a+=delta*speed_alpha
	if modulate.a>=1:
		modulate.a=1
		set_physics_process(false)
		state="hide"
	
func disappear(delta):
	modulate.a-=delta*speed_alpha
	if modulate.a<=0:
		modulate.a=0
		set_physics_process(false)
		hide()
		state="show"
		
