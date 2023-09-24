extends VehicleBody3D

const MAX_STEER = 0.6
const ENGINE_POWER = 300

@onready var cameraPivot = $pivot
@onready var camera3d = $pivot/Camera3D

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("turn_right", "turn_left") * MAX_STEER, delta*1.5)
	engine_force = Input.get_axis("reverse", "accelerate") * ENGINE_POWER
	cameraPivot.global_position = cameraPivot.global_position.lerp(global_position, delta * 20.0)
#const STEER_SPEED = 1.5
#const STEER_LIMIT = 0.4
#
#@export var engine_force_value = 100
#
#var steer_target = 0
#
#
#func _physics_process(delta):
#	var current_velocity : Vector3 = linear_velocity * transform.basis
#
#	var fwd_mps = current_velocity.x
#
#	steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
#	steer_target *= STEER_LIMIT
#
#	if Input.is_action_pressed("accelerate"):
#		# Increase engine force at low speeds to make the initial acceleration faster.
#		var speed = linear_velocity.length()
#		if speed < 5 and speed != 0:
#			engine_force = clamp(engine_force_value * 5 / speed, 0, 100)
#		else:
#			engine_force = engine_force_value
#	else:
#		engine_force = 0
#
#	if Input.is_action_pressed("reverse"):
#		# Increase engine force at low speeds to make the initial acceleration faster.
#		if fwd_mps >= -1:
#			var speed = linear_velocity.length()
#			if speed < 5 and speed != 0:
#				engine_force = -clamp(engine_force_value * 5 / speed, 0, 100)-100
#			else:
#				engine_force = -engine_force_value+10
#		else:
#			brake = 1
#	else:
#		brake = 0.0
#
#	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
