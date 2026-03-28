extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var recover_timer = $Attack_recover
@export var player_path : CharacterBody3D
@export var ROTATION_SPEED = 5.0
@export var LIFE = 100
var SPEED = 3
var player_reachable = false;

func _ready():
	add_to_group("enemies")

func _process(delta: float) -> void:
	if LIFE <= 0:
		get_node("Man - Eater Bug").die()
		await get_tree().create_timer(1.4).timeout
		Global.kill += 1
		$".".disable_mode = true
		self.queue_free()
	if player_reachable == true && recover_timer.is_stopped():
		recover_timer.start()
		get_node("Man - Eater Bug").attack()

func lose_life(damage :int) -> void:
	LIFE -= damage
	get_node("Man - Eater Bug").hit_flash()


func _physics_process(delta: float) -> void:
	var current_location  = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var direction = (next_location - current_location)
	direction.y = 0

	if LIFE <= 0 :
		next_location = Vector3(0,0,0);
		return
	if !get_node("Man - Eater Bug").is_moving:
		return
	if direction.length() > 0.01:
		var target_rotation = Transform3D().looking_at(direction.normalized(), Vector3.UP).basis.get_euler()
		target_rotation.y += deg_to_rad(180)
		rotation.y = lerp_angle(rotation.y, target_rotation.y, ROTATION_SPEED * delta)
	
	var new_velocity = direction.normalized() * SPEED
	velocity += get_gravity() * delta
	nav_agent.set_velocity(new_velocity)


func update_target_location(target_location):
	nav_agent.set_target_position(target_location)

func _on_navigation_agent_3d_target_reached() -> void:
	pass # Replace with function body.

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, .25)
	if LIFE > 0 :
		move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if "Player" in body:
		player_reachable = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if "Player" in body:
		player_reachable =false
