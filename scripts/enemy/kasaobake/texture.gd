extends EnemyTexture
class_name KasaObakeTexture

func animate(velocity: Vector2)-> void:
	if enemy.can_attack or enemy.can_hit or enemy.can_die:
		action_behavior()
	else:
		move_behavior(velocity)
		
func action_behavior()-> void:
	if enemy.can_die:
		animation.play("dead")
		enemy.can_hit = false
		enemy.can_attack = false
		attack_area_collision.set_deferred("disabled", true)
		
	elif enemy.can_hit:
		animation.play("hit")
		enemy.can_attack = false
		attack_area_collision.set_deferred("disabled", true)
		
	elif enemy.can_attack:
		animation.play("attack" + enemy.attack_animation_suffix)
		
		

func move_behavior(velocity: Vector2)-> void:
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
		
func on_animation_finished(anim_name: String)-> void:
	match anim_name:
		"attack":
			enemy.can_attack = false
			enemy.set_physics_process(true)
			
		"hit":
			enemy.can_hit =false
			enemy.can_attack = false
			enemy.set_physics_process(true)
			
		"dead":
			enemy.kill_enemy()
			enemy.can_attack = false
			
		"kill":
			enemy.queue_free()
	
