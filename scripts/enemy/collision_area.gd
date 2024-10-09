extends Area2D
class_name CollisionArea

onready var time: Timer = get_node("Timer")

export(int) var health
export(float) var invulnerability_timer
export(NodePath) var enemy_path  # Caminho do nó do inimigo, para ser configurado no editor
onready var enemy: KinematicBody2D = null  # Inicialize como nulo

func _ready():
	if enemy_path != null:
		enemy = get_node(enemy_path) as KinematicBody2D  # Obtenha o nó do inimigo quando a cena estiver pronta

func on_collision_area_entered(area):
	if area.get_parent() is Player:
		var player_stats: Node = area.get_parent().get_node("Stats")
		var player_attack: int = player_stats.base_attack + player_stats.bonus_attack
		update_health(player_attack)
	

func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		enemy.can_die = true
		return
		
	enemy.can_hit = true
