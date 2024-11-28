extends Node2D

const ITEM_SCENE: PackedScene = preload("res://scenes/env/physic_item.tscn")
const COLLECT_EFFECT: PackedScene = preload("res://scenes/effect/general_effect/colect_item.tscn")

var drop_list: Dictionary = {
	"Mana Potion": [
		"res://assets/item/consumable/lamen.png",
		5,
		"Mana",
		5,
		5
	]
}

func drop_item(item_name: String) -> void:
	# Verifica se o item está no dicionário de drop
	if not drop_list.has(item_name):
		print("Item não encontrado na lista de drops")
		return
	
	# Instancia o item
	var item_instance: PhysicItem = ITEM_SCENE.instance()
	get_parent().add_child(item_instance)
	item_instance.global_position = $Position2D.global_position
	
	# Define as informações do item
	var item_info = drop_list[item_name]
	item_instance.update_item_info(
		item_name,
		preload(item_info[0]),
		item_info
	)
