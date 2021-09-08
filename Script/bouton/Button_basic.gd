extends CenterContainer

export var speedAlpha=2

export(Texture) var texture=null

signal pressed

func _ready():
	if texture:
		$"TextureButton".texture_normal=texture
	set_physics_process(false)
	
func _physics_process(delta):
	up_alpha(delta)
	
	
func up_alpha(delta):
	modulate.a+=delta*speedAlpha
	if modulate.a>=1:
		modulate.a=1
		set_physics_process(false)

func appear():
	set_physics_process(true)
	visible=true
	
func disappear():
	modulate.a=0
	hide()
	
func action_call():
	emit_signal("pressed")

