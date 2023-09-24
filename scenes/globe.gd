extends Node3D

var mouse_position

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_position=event.relative

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
