extends Node3D

@onready var player = $Player2
@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D

var enemy = load("res://Scenes/Enemy.tscn")
var  instance

func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
	
func _get_randon_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func _on_zombie_spawn_timer_timeout() -> void:
	var spawn_point = _get_randon_child(spawns).global_position
	instance = enemy.instantiate()
	instance.position = spawn_point
	navigation_region.add_child(instance)
