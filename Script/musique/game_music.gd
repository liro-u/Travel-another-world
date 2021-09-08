extends AudioStreamPlayer

func play_just_me():
	get_tree().call_group_flags(2,"musique","stop")
	play()
