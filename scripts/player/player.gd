extends KinematicBody2D
class_name Player

onready var player_sprite: Sprite = get_node("Texture")
onready var wall_ray:  RayCast2D = get_node("WallRay")
onready var stats:  Node = get_node("Stats")

var velocity: Vector2

var direction: int = 1
var jump_count: int = 0

var dead: bool = false
var on_hit: bool = false
var landing: bool = false
var on_wall: bool = false
var attacking: bool = false
var defending: bool = false
var crouching: bool = false

var not_on_wall: bool = true
var can_track_input: bool = true

export(int) var speed
export(int) var jump_speed
export(int) var wall_jump_speed

export(int) var wall_gravity
export(int) var player_gravity
export(int) var wall_impulse_speed

func _physics_process(delta: float) -> void:
		horizontal_movement_env()
		vertical_movement_env()
		actions_env()
		verify_height()
		
		gravity(delta)
		velocity = move_and_slide(velocity, Vector2.UP)
		player_sprite.animate(velocity)
	
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if not can_track_input or attacking:
		velocity.x = 0
		return
		
	velocity.x = input_direction * speed
	
func vertical_movement_env() -> void:
	if is_on_floor() or is_on_wall():
		jump_count = 0
	
	var jump_condition: bool = can_track_input
	if Input.is_action_just_pressed("ui_select") and jump_count < 2 and jump_condition:
		jump_count += 1
		if next_to_wall() and not is_on_floor():
			velocity.y = wall_jump_speed
			velocity.x += wall_impulse_speed * direction
		else:
			velocity.y = jump_speed
		
func actions_env() -> void:
	attack()
	crouch()
	defense()
	
func attack() -> void:
	#var attack_condition: bool = not attacking and not crouching and not defending
	var attack_condition: bool = not attacking and not defending
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		attacking = true
		player_sprite.normal_attack =  true
	
func crouch() -> void:
	if Input.is_action_pressed("crouch") and is_on_floor() and not defending:
		crouching = true
		can_track_input = false
	elif not defending:
		crouching = false
		can_track_input = true
		player_sprite.crouching_off = true
	
func defense() -> void:
	#if Input.is_action_pressed("defense") and is_on_floor() and not crouching:
	if Input.is_action_pressed("defense") and is_on_floor():
		defending = true
		stats.shielding = true
		can_track_input = false
	elif not crouching:
		defending = false
		can_track_input = true
		stats.shielding = false
		player_sprite.shield_off = true
	
func gravity(delta: float) -> void:
	if next_to_wall():
		velocity.y += wall_gravity * delta
		if velocity.y >= wall_gravity:
			velocity = wall_gravity
	else:
		velocity.y += delta * player_gravity 
		if velocity.y >= player_gravity:
			velocity.y = player_gravity
		
func next_to_wall() -> bool:
	if wall_ray.is_colliding() and not is_on_floor():
		if not_on_wall:
			velocity.y = 0
			not_on_wall = true
		
		return true
	
	else:
		not_on_wall = true
		return false
		
func spawn_effect(effect_path: String , offset: Vector2, is_flipped: bool)-> void:
	var effect_isntance: EffectTemplate = load(effect_path).instance()
	get_tree().root.call_deferred("add_child", effect_isntance)
	if is_flipped:
		effect_isntance.flip_h = true
		
	effect_isntance.global_position = global_position + offset
	effect_isntance.play_effect()
	
func reset(state: bool)-> void:
	set_physics_process(not state)
	$Animation.play("idle")
	
func verify_height() -> void:
	if position.y > 450:
		#var timer = Timer.new()
		#timer.wait_time = 2.0  
		#timer.one_shot = true  
		#add_child(timer)  
		#timer.start()  
		
		#yield(timer, "timeout")
		#get_tree().change_scene()
		get_tree().change_scene("res://scenes/management/level.tscn")
		
	print(position.y)
	
