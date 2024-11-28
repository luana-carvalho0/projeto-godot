extends Node

var save_path: String = "user://save.dat"
var initial_position: Vector2 = Vector2(-370,30)

var data_dictionary = {
	"level": 1,
	"current_exp": 0,
	"stats_points": 0,
	
	"current_mana": 15,
	"current_health": 15,
	
	"inventory": [],
	"aux_inventory": [],
	
	"base_stats": [],
	"armor_container": [],
	"weapon_container": [],
	"consumable_container": [],
	
	"sign_checkpoint": false,
	"checkpoint": false,
	"player_texture": "",
	"player_position": initial_position,
	"current_level_path": ""
}

func save_data() -> void:
	var file: File = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data_dictionary)
		file.close()
		
		
func load_data() -> void:
	var file: File = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			data_dictionary = file.get_var()
			file.close()
