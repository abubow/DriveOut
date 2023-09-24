extends Node3D

var mouse_position=Vector3.ZERO

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_position=event.relative

