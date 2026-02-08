extends Node3D

@export var flash_material: ShaderMaterial
@onready var anim_tree : AnimationTree = $AnimationTree
@export var hit_material: Material
var original_materials := {}
@export var is_moving : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	_cache_original_materials($"Armature/Skeleton3D/Man-Eater Bug")

func _cache_original_materials(node):
	if !node:
		return
	if node is MeshInstance3D:
		var mats := []
		for i in range(node.mesh.get_surface_count()):
			mats.append(node.get_surface_override_material(i))
		original_materials[node] = mats

	for child in node.get_children():
		_cache_original_materials(child)

func _apply_material(node, material):
	if !node:
		return
	if node is MeshInstance3D:
		for i in range(node.mesh.get_surface_count()):
			node.set_surface_override_material(i, material)

	for child in node.get_children():
		_apply_material(child, material)

func _restore_materials():
	for mesh in original_materials.keys():
		var mats = original_materials[mesh]
		for i in range(mats.size()):
			mesh.set_surface_override_material(i, mats[i])

func hit_flash():
	_apply_material($"Armature/Skeleton3D/Man-Eater Bug", hit_material)
	await get_tree().create_timer(0.08).timeout
	_restore_materials()

func die():
	anim_tree["parameters/conditions/die"] = true
	is_moving = false

func attack():
	anim_tree.set("parameters/conditions/attacking", true)
	print("ATTACK")
	is_moving = false
	anim_tree.set("parameters/conditions/Is Moving", false)

	await get_tree().create_timer(1.25).timeout
	anim_tree.set("parameters/conditions/attacking", false)
	is_moving = true
	anim_tree.set("parameters/conditions/Is Moving", true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
