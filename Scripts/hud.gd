extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("esc"):
			$".".visible = !visible
			$Sectors/Red_Button.grab_focus()
			get_node("")
