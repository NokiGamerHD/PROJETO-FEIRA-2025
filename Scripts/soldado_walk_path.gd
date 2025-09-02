extends PathFollow3D

@onready var sprite = $AnimatedSprite3D
var last_position : Vector3

func _ready():
	last_position = global_position

func _process(delta):
	
	progress += 1.50 * delta   

	
	var direction = (global_position - last_position).normalized()
	last_position = global_position

	
	if abs(direction.x) > abs(direction.z):
		if direction.x > 0:
			sprite.play("walk_right")
		else:
			sprite.play("walk_left")
	else:
		if direction.z > 0:
			sprite.play("walk_down")
		else:
			sprite.play("walk_up")
