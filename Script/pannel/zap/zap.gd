extends Node2D

export var amount=4
var colision=preload("res://Scene/pannel/zap/Area2D.tscn")

func play():
	$"BeamParticles2D".speed_scale=1
	$"CastingParticles2D2".speed_scale=1
	$"CastingParticles2D".speed_scale=1

func stop():
	$"BeamParticles2D".speed_scale=0
	$"CastingParticles2D2".speed_scale=0
	$"CastingParticles2D".speed_scale=0
	



func _ready():
	var taille=self.cast_to.x
	$Line2D.points[1]=Vector2.ZERO
	$Line2D.points[1].x=taille
	$BeamParticles2D.position.x =taille *0.5
	$CastingParticles2D2.position.x =taille
	$BeamParticles2D.process_material=$BeamParticles2D.process_material.duplicate()
	$BeamParticles2D.process_material.emission_box_extents.x=taille*0.5
	$BeamParticles2D.amount=round(amount*(taille/300))
	
	var colisionshape=colision.instance()
	colisionshape.get_node("CollisionShape2D").shape=colisionshape.get_node("CollisionShape2D").shape.duplicate()
	colisionshape.get_node("CollisionShape2D").shape.set_height(taille)
	colisionshape.position.x=taille*0.5
	self.add_child(colisionshape)
