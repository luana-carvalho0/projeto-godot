extends CanvasLayer

const DIALOG_CONTAINER: PackedScene = preload("res://scenes/interface/general/dialog_container.tscn")
onready var inventory: Control = get_node("InventoryConteiner")

func _process(_delta: float) -> void:
	# Chama a função apenas se a tecla de inventário for pressionada
	if Input.is_action_just_pressed("inventory"):
		show_inventory()

func show_inventory() -> void:
	if inventory.visible:  # Se o inventário estiver visível
		inventory.animation.play("hide_container")
		yield(inventory.animation, "animation_finished")  # Aguarda a animação terminar
		inventory.hide()  # Oculta o inventário ao final da animação de esconder
	else:  # Se o inventário estiver oculto
		inventory.show()  # Mostra o inventário antes de iniciar a animação de exibição
		inventory.animation.play("show_container")

func spawn_dialog(interactable, dialog_list: Dictionary)-> void:
	var dialog = DIALOG_CONTAINER.instance()
	dialog.connect("finished", interactable, "on_dialog_finished")
	dialog.dialog_list = dialog_list
	add_child(dialog)
	
