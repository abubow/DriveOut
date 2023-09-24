extends SubViewport


@onready var crossHair= $Control/TextureRect

func _ready():
	crossHair.position.x=get_viewport().size.x/2-32
	crossHair.position.y=get_viewport().size.y/2-32
