extends Node3D


@onready var gun_anim =$Head/Camera3D/SteampunkRifle/AnimationPlayer
#@onready var camera = $Head/Camera3D
#@onready var head = $Head

@export var global:Node3D

const SENSITIVITY = 1000
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("Shoot"):
		_shooting_rifle()
	var mouse_position=$"../../../..".mouse_position
	rotation.y-=mouse_position.x/SENSITIVITY
	rotation.x+=mouse_position.y/SENSITIVITY


func _shooting_rifle():
	if !gun_anim.is_playing():
		gun_anim.play("Shoot")
