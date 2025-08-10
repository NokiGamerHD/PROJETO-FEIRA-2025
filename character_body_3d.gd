extends CharacterBody3D

# --- Configuráveis ---
@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 4.5
@export var FRAMES_PER_DIR: int = 4     # 4 frames por direção
@export var ANIM_SPEED: float = 8.0     # frames por segundo da animação

# Ajuste aqui a ordem/linha do seu sprite sheet (linha 0 = topo)
@export var ROW_DOWN: int = 0
@export var ROW_UP: int = 1
@export var ROW_LEFT: int = 2
@export var ROW_RIGHT: int = 3

# --- Constantes internas ---
const DOWN = 0
const UP = 1
const LEFT = 2
const RIGHT = 3

# --- Estado ---
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var facing: int = DOWN
var anim_timer: float = 0.0
var animation_frame: int = 0

func _physics_process(delta: float) -> void:
	# gravidade
	if not is_on_floor():
		velocity.y -= gravity * delta

	# pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# entrada e direção (input vector usa x: left/right, y: up/down)
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var world_dir: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# atualiza facing com PRIORIDADE HORIZONTAL em diagonais
	update_facing(input_dir)

	# movimento
	if world_dir.length() > 0.0:
		velocity.x = world_dir.x * SPEED
		velocity.z = world_dir.z * SPEED

		# animação automática
		anim_timer += delta * ANIM_SPEED
		animation_frame = int(anim_timer) % FRAMES_PER_DIR
	else:
		# desacelera suavemente
		velocity.x = move_toward(velocity.x, 0.0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0.0, SPEED * delta)
		anim_timer = 0.0
		animation_frame = 0

	# aplica frame no Sprite3D (assume hframes = FRAMES_PER_DIR e vframes >= 4)
	var row := _get_row_for_facing(facing)
	$Sprite3D.frame = animation_frame + (row * FRAMES_PER_DIR)
	$Sprite3D.flip_h = false  # como você tem sprites para direita/esquerda, mantenha false

	move_and_slide()

func update_facing(input_vec: Vector2) -> void:
	if input_vec.length() == 0:
		return
	# se houver x (horizontal) damos preferência à direção horizontal
	if input_vec.x < 0:
		facing = LEFT
	elif input_vec.x > 0:
		facing = RIGHT
	elif input_vec.y > 0:
		facing = DOWN
	elif input_vec.y < 0:
		facing = UP

func _get_row_for_facing(f: int) -> int:
	match f:
		DOWN: return ROW_DOWN
		UP: return ROW_UP
		LEFT: return ROW_LEFT
		RIGHT: return ROW_RIGHT
	return ROW_DOWN
