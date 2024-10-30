extends Area2D

# Sinal para indicar que um corpo entrou na área
signal player_fell

# Chamada quando o corpo entra na área
func _on_body_entered(body):
	if body.is_in_group("players"):  # Verifique se o corpo é um jogador
		emit_signal("player_fell")    # Emite o sinal que indica que o jogador caiu

# Chamada quando o nó entra na árvore de cena pela primeira vez
func _ready():
	# Conecta o sinal body_entered ao método _on_body_entered
	connect("body_entered", self, "_on_body_entered")
