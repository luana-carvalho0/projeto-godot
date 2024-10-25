extends EnemyTemplate
class_name KasaObake

func _ready()-> void:
	randomize()
	drop_list = {
		"Heal Potion ":[
			"res://assets/item/consumable/health_potion.png",
			25,
			"Health",
			5,
			2
		],
		
		"Mana Potion": [
			"res://assets/item/consumable/mana_potion.png",
			30,
			"Mana",
			5,
			5
		]
	}
