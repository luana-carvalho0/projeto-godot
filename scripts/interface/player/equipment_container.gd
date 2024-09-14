extends Control
class_name EquipmentContainer

onready var animation: AnimationPlayer = get_node("Animation")

onready var consumable_container: TextureRect = get_node("ConsumableBackground")
onready var armor_container: TextureRect = get_node("VContainer/ArmorBackground")
onready var weapon_container: TextureRect = get_node("VContainer/WeaponBackground")



