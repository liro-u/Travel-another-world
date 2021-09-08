extends Label

func _ready():
	$"./".get_font("font").size=30
	
func _process(delta):
	$"./".get_font("font").size+=150*delta
	modulate.a-=1*delta
	if modulate.a<=0:
		queue_free()
