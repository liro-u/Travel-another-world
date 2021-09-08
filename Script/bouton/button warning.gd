extends CenterContainer

var state="appear"
var size_switch="down"

export var speedAlpha=2
export var speedSize=Vector2(85,85)

export var minSize=Vector2(180,180)
export var maxSize=Vector2(200,200)

export(Texture) var texture=null

signal pressed
signal hiden
signal show_finish

func _ready():
	if texture:
		$"button warning".texture_normal=texture
	set_physics_process(false)
	
func _physics_process(delta):
	if size_switch=="up":
		up_size(delta)
	elif size_switch=="down":
		down_size(delta)
	if state=="appear":
		up_alpha(delta)
	elif state=="disappear":
		down_alpha(delta)
	
func up_size(delta):
	$"button warning".rect_min_size.x+=speedSize.x*delta
	$"button warning".rect_min_size.y+=speedSize.y*delta
	if $"button warning".rect_min_size.x>=maxSize.x or $"button warning".rect_min_size.y>=maxSize.y:
		$"button warning".rect_min_size.x=maxSize.x
		$"button warning".rect_min_size.y=maxSize.y
		size_switch="down"
		emit_signal("show_finish")
func down_size(delta):
	$"button warning".rect_min_size.x-=speedSize.x*delta
	$"button warning".rect_min_size.y-=speedSize.y*delta
	$"button warning".rect_size.x-=speedSize.x*delta
	$"button warning".rect_size.y-=speedSize.y*delta
	if $"button warning".rect_min_size.x<=minSize.x or $"button warning".rect_min_size.y<=minSize.y:
		$"button warning".rect_min_size.x=minSize.x
		$"button warning".rect_min_size.y=minSize.y
		$"button warning".rect_size.x=minSize.x
		$"button warning".rect_size.y=minSize.y
		size_switch="up"
	
func up_alpha(delta):
	modulate.a+=delta*speedAlpha
	if modulate.a>=1:
		modulate.a=1
		state="wait"
func down_alpha(delta):
	modulate.a-=delta*speedAlpha
	if modulate.a<=0:
		modulate.a=0
		state="appear"
		set_physics_process(false)
		visible=false
		emit_signal("hiden")
	
func appear():
	set_physics_process(true)
	visible=true
func disappear():
	state="disappear"
	
func action_call():
	emit_signal("pressed")

