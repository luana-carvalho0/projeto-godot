extends TextureRect
class_name ArmorContainer

onready var armor_item: TextureRect = get_node("Item")
var armor_dictionary: Dictionary = {}
var amor_name: String = ""
var amor_type: String = ""
var amor_texture_path: String = ""

var amor_price: int

func update_armor_slot(item_texture: StreamTexture, item_info: Array) -> void:
	if armor_name != "":
		get_tree().call_group(
			"inventory",
			"update_slot",
			armor_name,
			armor_item.texture,
			[
				armor_texture_path,
				armor_type,
				armor_dictionary,
				armor_price,
				1
			]
		)
		
		reset()
		
	armor_item.texture=item_texture
	armor_texture_path = item_info[0]
	armor_name = item_info[1]
	armor_type=item_info[2]
	armor_dictionary = item_info[3]
	armor_price=item_info[4]
	
	armor_item.show()
	
func reset()->void:
	armor_name=""
	armor_type=""
	armor_texture_path=""
	
	armor_price = 0
	armor_item.texture= null
	
	armor_dictionary={}
