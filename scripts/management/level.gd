extends Node2D
class_name Level

onready var player: KinematicBody2D = get_node("Player")


func _ready():
	var _game_over: bool = player.get_node("Texture").connect("game_over", self, "on_game_over")
	data_management.load_data()
	
	player.global_position = data_management.data_dictionary.player_position

func on_game_over() -> void:
	data_management.data_dictionary.player_position = data_management.initial_position
	data_management.save_data()
	
	var _reload: bool = get_tree().reload_current_scene()

