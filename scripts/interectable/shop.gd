extends Area2D

onready var aux_animation: AnimationPlayer = get_node("Dialogicon/AuxAnimation")

var can_interact: bool = true
var player_ref: KinematicBody2D = null

var dialog_list: Dictionary = {
	"dialog": [
		"Kitsune: Ah, ola! Estava esperando alguem curioso o suficiente para entrar. Esta indo para o jantar no templo, nao e?",
		"Protagonista: Como voce sabe disso?",
		"Kitsune: E, eu tenho meus meios. Nao e todo dia que humanos sao convidados para um evento como esse. Mas eu diria que voce deve se preparar para algo um pouco... fora do comum.",
		"Protagonista: Eu so ouvi que seria uma festa, nada de muito estranho. Acho que esta tudo bem.",
		"Kitsune: Ah, claro, claro. Nao se preocupe. Os yokais so tem um jeito proprio de se divertir. Eles nao sao tao diferentes de nos, apenas... mais criativos, talvez.",
		"Protagonista: Entao, o que voce acha? Devo ir?",
		"Kitsune: A escolha e sua, mas se voce quiser saber como essa noite vai acabar, pode confiar, sera uma experiencia inesquecivel. So lembre-se de se manter firme.",
		"Protagonista: Acho que vou descobrir por mim mesma. Obrigada pela dica.",
		"Kitsune: Cuidado no caminho. Tsukogamis habitam essa estrada."
	],
	"portrait": null, #"res://assets/interface/dialog/rm.png",  
	"name": null
}


func on_shop_body_entered(body):
	player_ref = body
	if can_interact:
		aux_animation.play("fade_in")

func on_shop_body_exited(_body):
	player_ref = null
	aux_animation.play("fade_out")
	
func _process(_delta: float)-> void:
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
