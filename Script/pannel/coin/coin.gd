extends Area2D

var valeur
export var gain_rubis=10
export var gain_piece=1
export var unSurXchanceRubis=10
export var rubis_forcing=false

func _ready():
	randomize()
	if rubis_forcing==true:
		valeur=gain_rubis
		$AnimatedSprite.set_animation("rubis")
	else:
		if (randi() % unSurXchanceRubis)==0 :
			valeur=gain_rubis
			$AnimatedSprite.set_animation("rubi")
		else:
			valeur=gain_piece
			$AnimatedSprite.set_animation("coin")
func _on_coin_body_entered(_body):
	$"../../../../".grab_coin(valeur)
	queue_free()

func play():
	$AnimatedSprite.play()

func stop():
	$AnimatedSprite.stop()
