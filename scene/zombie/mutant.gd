extends CharacterBody3D

const SPEED = 10
const ATTACK_RANGE = 2.0

var state_machine

@onready var nav_agent=$NavigationAgent3D
@onready var anim_tree = $AnimationTree

func _ready():
	state_machine = anim_tree.get("parameters/playback")


func _process(delta):
	var player = $"../../GridContainer/frontView/carFront/Car"
	match state_machine.get_current_node():
		"Run":
			# Navigation
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10.0)
		"Attack":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	# Conditions
	anim_tree.set("parameters/conditions/attack", _target_in_range())
	anim_tree.set("parameters/conditions/run", !_target_in_range())
	
	
	move_and_slide()


func _target_in_range():
	return false
	
#	if !animation.is_playing():
#			animation.play("Run")
#		if velocity==Vector3.ZERO:
#			animation.play("Idle")
#		else:
#			$RunTimer.start(0.2)	

