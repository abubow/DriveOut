extends Node3D


@onready var gun_anim =$"./Camera3D/SteampunkRifle/AnimationPlayer"
@onready var camera = $Head/Camera3D
@onready var head = $Head

@export var global:Node3D

const SENSITIVITY = 500
func _ready():
	pass
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("Shoot"):
		_shooting_rifle()
	var mouse_position=$"../../../..".mouse_position
	rotation.y-=mouse_position.x/SENSITIVITY
	rotation.y=clamp(rotation.y,deg_to_rad(-90),deg_to_rad(90))
	rotation.x-=mouse_position.y/SENSITIVITY
	rotation.x=clamp(rotation.x,deg_to_rad(-30),deg_to_rad(30))
	

func _shooting_rifle():
	if !gun_anim.is_playing():
		gun_anim.play("Shoot")

