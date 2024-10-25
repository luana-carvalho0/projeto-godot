extends Control
class_name BarContainer

onready var tween: Tween = get_node("Tween")

onready var health_bar: TextureProgress = get_node("HealthBarBackground/HealthBar")
onready var mana_bar: TextureProgress = get_node("ManaBarBackground/TextureProgress")
onready var exp_bar: TextureProgress = get_node("ExpBarBackground/TextureProgress")

var current_exp: int
var current_mana: int
var current_health: int

func init_bar(health: int, mana: int, max_exp_value: int) -> void:
	
