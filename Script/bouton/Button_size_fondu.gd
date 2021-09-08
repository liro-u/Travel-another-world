extends TextureButton

export var time=1
var taille_max=Vector2()
export (Curve) var courbe
var point=0.0
export var groupe=""
export var function=""
export var text=""
export var police_size=30
export var center=false
export var adjust_bottom=false
signal show_finish

func _ready():
	taille_max=rect_min_size
	rect_min_size=Vector2(0,0)
	courbe.bake()
	modulate.a=0
	$Label.modulate.a=0
	$Label.text=text
	$Timer.wait_time=float(time)/courbe.bake_resolution
	var font=$Label.get_font("font").duplicate()
	font.size=police_size
	$Label.add_font_override("font",font)
	if center:
		$Label.anchor_left=0.5
		$Label.anchor_right=0.5
		$Label.anchor_top=0.5
		$Label.anchor_bottom=0.5
		var size_lab=$Label.rect_size
		$Label.margin_left=-size_lab.x/2
		$Label.margin_right=-size_lab.x/2
		$Label.margin_top=-size_lab.y/2
		$Label.margin_bottom=-size_lab.y/2
	if adjust_bottom:
		$Label.anchor_left=0
		$Label.anchor_right=1
		$Label.anchor_top=1
		$Label.anchor_bottom=1
		var size_lab=$Label.rect_size
		$Label.margin_top=-size_lab.y/2
		$Label.margin_bottom=-size_lab.y/2

	
	
func start_show():
	$Timer.start()

func _on_Timer_timeout():
	rect_min_size.x=courbe.interpolate(point)*taille_max.x
	rect_min_size.y=courbe.interpolate(point)*taille_max.y
	point+=1.0/courbe.bake_resolution
	modulate.a+=1.0/courbe.bake_resolution
	if modulate.a>0.8:
		$Label.modulate.a+=5.0/courbe.bake_resolution
	if point>=1:
		$Timer.stop()
		modulate.a=1
		emit_signal("show_finish")
		$Label.modulate.a=1
		get_tree().call_group(groupe,function)
	
