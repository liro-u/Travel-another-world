extends Node2D

#varriable
var type
var info_taille
var visibilityNotifier=true
	
func _ready():
	refresh_info_taille()
	$VisibilityNotifier2D.set_rect(Rect2(Vector2(-10,-10),Vector2(info_taille[1],600)))

	
func change_frames(frame):
	$SpriteBackgroundPannel.set_sprite_frames(frame)

func change_animation(animation):
	$SpriteBackgroundPannel.set_animation(animation)
func moove(decalage):
	position.x-=decalage

func set_animation_on(frame=0):
	$SpriteBackgroundPannel.playing=true
	$SpriteBackgroundPannel.frame=frame%($SpriteBackgroundPannel.frames.get_frame_count($SpriteBackgroundPannel.animation))

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	if visibilityNotifier:
		if self.is_in_group("backgroundback"):
			type="back"
			var bg_front=get_tree().get_nodes_in_group("backgroundback")
			bg_front[len(bg_front)-1].refresh_info_taille()
			get_tree().call_group("background","check_transition")
		elif self.is_in_group("backgroundmidle"):
			type="midle"
			var bg_front=get_tree().get_nodes_in_group("backgroundmidle")
			bg_front[len(bg_front)-1].refresh_info_taille()
		elif self.is_in_group("backgroundfront"):
			type="front"
			var bg_front=get_tree().get_nodes_in_group("backgroundfront")
			bg_front[len(bg_front)-1].refresh_info_taille()
		else:
			type="front_cache"
			var bg_front=get_tree().get_nodes_in_group("backgroundfrontcache")
			bg_front[len(bg_front)-1].refresh_info_taille()
		get_tree().call_group("background", "out_background", type, [self])

func delete ():
	self.queue_free()
	visibilityNotifier=false
	if self.is_in_group("backgroundback"):
		self.remove_from_group("backgroundback")
	elif self.is_in_group("backgroundmidle"):
		self.remove_from_group("backgroundmidle")
	elif self.is_in_group("backgroundfront"):
		self.remove_from_group("backgroundfront")
	else:
		self.remove_from_group("backgroundfrontcache")
	
	
	
func refresh_info_taille():
	info_taille=Vector2(position.x,$SpriteBackgroundPannel.get_sprite_frames().get_frame($SpriteBackgroundPannel.animation,$SpriteBackgroundPannel.frame).get_size().x)


func _on_SpriteBackgroundPannel_frame_changed():
	if self.is_in_group("backgroundback"):
		get_tree().call_group("background", "set_anim_back_play",$SpriteBackgroundPannel.frame)
	elif self.is_in_group("backgroundmidle"):
		get_tree().call_group("background", "set_anim_midle_play",$SpriteBackgroundPannel.frame)
	elif self.is_in_group("backgroundfront"):
		get_tree().call_group("background", "set_anim_front_play",$SpriteBackgroundPannel.frame)
	else:
		get_tree().call_group("background", "set_anim_front_cache_play",$SpriteBackgroundPannel.frame)
	
func play():
	$SpriteBackgroundPannel.play()

func stop():
	$SpriteBackgroundPannel.stop()
	
