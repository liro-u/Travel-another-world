extends HBoxContainer

export var speed_alpha=4
var state="appear"
export var time=2
export var speed=10

func set_score():
	$"Switch".text=str(round($"../../../../game".distance))
	$"Switch/list_score/GameScore".text=str(round($"../../../../game".distance))
	$"Switch/list_score/HGScore".text=str($"../../../../".HGScore)
	
func _ready():
	set_physics_process(false)
	
func appear(delta):
	modulate.a+=speed_alpha*delta
	if modulate.a>=1:
		modulate.a=1
		set_physics_process(false)
		state="switch"
		start_timer(0.25)
		
func start_timer(t):
	$"Timer".wait_time=t
	$"Timer".start()
	
func disappear(delta):
	modulate.a-=speed_alpha*delta
	if modulate.a<=0:
		modulate.a=0
		state="appear"
		set_physics_process(false)
		visible=false
		$"../../..".next_death_menu()
		$"Switch/list_score".rect_position.y=-72

func switch_score(delta):
	$"Switch/list_score".rect_position.y+=speed*delta
	if $"Switch/list_score".rect_position.y>=0:
		$"Switch/list_score".rect_position.x=0
		state="disappear"
		set_physics_process(false)
		start_timer(0.5)
	
func _physics_process(delta):
	if state=="appear":
		appear(delta)
	elif state=="switch":
		switch_score(delta)
	elif state=="disappear":
		disappear(delta)

func _on_Timer_timeout():
	set_physics_process(true)

func _appear_start():
	set_physics_process(true)
	visible=true
