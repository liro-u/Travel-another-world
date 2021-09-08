extends Node2D
var visibilityNotifier=true

func _process(delta):
	if not $"../../../".pause:
		position.x-=$"../../../".multiplicateurVitesse*delta*20
	
func get_size():
	return($VisibilityNotifier2D.get_rect().size.x * $VisibilityNotifier2D.scale.x)

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	if visibilityNotifier:
		$"../".add_pannel()
		delete()

func set_visibilityNotifier_off():
	visibilityNotifier=false
	
func delete():
	queue_free()
	visibilityNotifier=false
