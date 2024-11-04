extends Area2D

onready var aux_animation: AnimationPlayer = get_node("Dialogicon/AuxAnimation")
onready var interaction_timer: Timer = Timer.new()

var can_interact: bool = true
var dialog_active: bool = false  # Indica se o diálogo está ativo
var player_ref: KinematicBody2D = null

var dialog_list: Dictionary = {
	"name": "Comandos",
	"portrait": "",
	"dialog": [
		"Pressione a tecla E para coletar objetos\ninteragir com npc's\npular dialogos",
		"Utilize as setas do teclado para movimentar",
		"Q para atacar\nW para defender\n",
		"Espaco para salto\n2 vezes para um salto duplo"
	]
}

func _ready() -> void:
	add_child(interaction_timer)
	interaction_timer.one_shot = true
	interaction_timer.wait_time = 2.0  # Define o tempo de espera após o fechamento do diálogo
	interaction_timer.connect("timeout", self, "_on_interaction_timer_timeout")

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
		player_ref.is_on_floor() and
		can_interact
	):
		interactable_action()
		can_interact = false

func interactable_action() -> void:
	get_tree().call_group("hud", "spawn_dialog", self, dialog_list)
	aux_animation.play("fade_out")
	player_ref.reset(true)
	dialog_active = true

func on_dialog_finished() -> void:
	# Quando o diálogo é fechado, inicia o timer para aguardar antes de reativar `can_interact`
	dialog_active = false
	interaction_timer.start()  # Inicia o temporizador de espera
	player_ref.reset(false)
	aux_animation.play("fade_in")

func _on_interaction_timer_timeout() -> void:
	# Esta função é chamada quando o timer termina
	can_interact = true
