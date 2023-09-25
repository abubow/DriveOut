extends Node3D

var mouse_position=Vector3.ZERO
@onready var enemy_scence=load("res://scene/zombie/mutant.tscn")
@onready var spawn_point= $EnemySpawner
@onready var region=$NavigationRegion3D

@export var spawn_limit=4
var count=0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_position=event.relative


func _ready():
	$EnemySpawnTimer.start(0.2)


func _on_enemy_spawn_timer_timeout():
	if count<spawn_limit:
		var enemy=enemy_scence.instantiate()
		enemy.position=spawn_point.global_position
		region.add_child(enemy)
		count+=1
