extends Node3D
class_name TerrainController

var TerrainBlocks: Array = []
## The set of terrian blocks which are currently rendered to viewport
var terrain_belt: Array[MeshInstance3D] = []
var terrian_count: int =0
var terrian_remove_limit: int =2
var terrian_counter_time: bool= true
var terrian_remove_time: bool= false
var terrian_add_time: bool= true

@export var terrain_velocity: float = 10
## The number of blocks to keep rendered to the viewport
@export var num_terrain_blocks = 10
## Path to directory holding the terrain block scenes
@export_dir var terrian_blocks_path = "res://scene/terrian_scence"


func _ready() -> void:
	_load_terrain_scenes(terrian_blocks_path)
	_init_blocks(num_terrain_blocks)


func _physics_process(delta: float) -> void:
	_progress_terrain(delta)


func _init_blocks(number_of_blocks: int) -> void:
	for block_index in number_of_blocks:
		var block = TerrainBlocks.pick_random().instantiate()
		if block_index == 0:
			block.position.z = block.mesh.size.y/2
		else:
			_append_to_far_edge(terrain_belt[block_index-1], block)
		add_child(block)
		terrain_belt.append(block)


func _progress_terrain(delta: float) -> void:
	for block in terrain_belt:
		block.position.z += terrain_velocity * delta

	if terrain_belt[0].position.z >= terrain_belt[0].mesh.size.y/2:
		if terrian_add_time:
			terrian_add_time=false
			$TerrianAdderTime.start(1.6)
		
		if terrian_count==terrian_remove_limit and terrian_remove_time:
			$TerrianBlockRemoverTimer.start(0.9)
		elif terrian_counter_time:
			terrian_counter_time=false
			$TerrianCount.start(0.5)

func _append_to_far_edge(target_block: MeshInstance3D, appending_block: MeshInstance3D) -> void:
	appending_block.position.z = target_block.position.z - target_block.mesh.size.y/2 - appending_block.mesh.size.y/2


func _load_terrain_scenes(target_path: String) -> void:
	var dir = DirAccess.open(target_path)
	for scene_path in dir.get_files():
		print("Loading terrian block scene: " + target_path + "/" + scene_path)
		TerrainBlocks.append(load(target_path + "/" + scene_path))



func _on_terrian_block_remover_timer_timeout():
	var terrain = terrain_belt.pop_front()
	terrain.queue_free()
	terrian_count=0
	terrian_remove_time=false

func _on_terrian_count_timeout():
	terrian_count+=1
	if terrian_count==2:
		terrian_remove_time=true
	terrian_counter_time=true


func _on_terrian_adder_time_timeout():
	var last_terrain = terrain_belt[-1]
	var block = TerrainBlocks.pick_random().instantiate()
	_append_to_far_edge(last_terrain, block)
	add_child(block)
	terrain_belt.append(block)
	terrian_add_time=true
	
