extends Area2D

onready var aux_animation: AnimationPlayer = get_node("Dialogicon/AuxAnimation")

var can_interact: bool = true
var player_ref: KinematicBody2D = null

func on_shop_body_entered(body):
	player_ref = body
	if can_interact:
		aux_animation.play("fade_in")


func on_shop_body_exited(_body):
	player_ref = null
	aux_animation.play("fade_out")
	
