extends Area2D

onready var aux_animation: AnimationPlayer = get_node("Dialogicon/AuxAnimation")

var can_interact: bool = true
var player_ref: KinematicBody2D = null

var dialog_list: Dictionary = {
	"dialog": [
		"Bem vinda, espero que voce tenha trazido algo!"
	],
	"portrait": null, 
	"name": null
}


func on_shop_body_entered(body):
	player_ref = body
	if can_interact:
		aux_animation.play("fade_in")

func on_shop_body_exited(_body):
	player_ref = null
	aux_animation.play("fade_out")
	
func _process(_delta: float) -> void:
	if (
		player_ref != null and 
		Input.is_action_just_pressed("interact") and 
		player_ref.is_on_floor() and
		can_interact
	):
		interactable_action()
		can_interact = false

func interactable_action() -> void:
	get_tree().call_group("hud", "spawn_dialog", self, dialog_list)
	aux_animation.play("fade_out")
	player_ref.reset(true)
	
func on_dialog_finished() -> void:
	can_interact = true
	player_ref.reset(false)
	aux_animation.play("fade_in")
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://scenes/interface/game_over.tscn")
