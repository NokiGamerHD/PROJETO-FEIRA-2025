extends CharacterBody3D

@export var speed : float = 5.0

@onready var animation_tree : AnimationTree = $AnimationTree

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	
	# Mover em 4 direções
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector3.ZERO

	move_and_slide()

	# Trocar animações
	if velocity == Vector3.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true


	if direction != Vector3.ZERO:
		var blend_pos = Vector2(direction.x, direction.z)
		animation_tree["parameters/Idle/blend_position"] = blend_pos
		animation_tree["parameters/Walk/blend_position"] = blend_pos
