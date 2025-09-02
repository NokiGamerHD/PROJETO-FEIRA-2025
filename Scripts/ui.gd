extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func resume():
	
	get_tree().paused = false


func pause():
	
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	testEsc()
	
	if Input.is_action_just_pressed("esc") or Input.is_action_just_pressed("c"):
		
			$".".visible = !visible
			$Fundo_Sector/Sectors/Red_Button.grab_focus()
			get_node("")
			
	
func testEsc():
	
	if Input.is_action_just_pressed("esc") and !get_tree().paused or Input.is_action_just_pressed("c") and !get_tree().paused:
		pause()
		
	elif Input.is_action_just_pressed("esc") and get_tree().paused or Input.is_action_just_pressed("c") and get_tree().paused:
		resume()
		

func _on_red_button_focus_entered() -> void:
	
	print("VERMELHO FOCADO!!!")
	var red_items = $Fundo_Red
	red_items.visible = true
	
	
func _on_blue_button_focus_entered() -> void:
	print("AZUL FOCADO!!!")
	var blue_items = $Fundo_Blue
	blue_items.visible = true


func _on_yellow_button_focus_entered() -> void:
	
	print("AMARELO FOCADO!!!")
	var yellow_items = $Fundo_Yellow
	yellow_items.visible = true
	

func _on_green_button_focus_entered() -> void:
	
	print("VERDE FOCADO!!!")
	var green_items = $Fundo_Green
	green_items.visible = true


func _on_red_button_focus_exited() -> void:
	
	print("VERMELHO DESFOCADO!!!")
	var red_items = $Fundo_Red
	red_items.visible = false


func _on_blue_button_focus_exited() -> void:
	
	print("AZUL DESFOCADO!!!")
	var blue_items = $Fundo_Blue
	blue_items.visible = false


func _on_yellow_button_focus_exited() -> void:
	
	print("AMARELO DESFOCADO!!!")
	var yellow_items = $Fundo_Yellow
	yellow_items.visible = false
	

func _on_green_button_focus_exited() -> void:
	
	print("VERDE DESFOCADO!!!")
	var green_items = $Fundo_Green
	green_items.visible = false


func _on_config_pressed() -> void:
	
	print("CONFIGURAÇÃO!!!")
	var config_tab = $Fundo_Config
	config_tab.visible = true


func _on_texture_button_pressed() -> void:
	
	print("ADEUS CONFIGURAÇÃO!!!")
	var config_tab = $Fundo_Config
	config_tab.visible = false
	$Fundo_Sector/Sectors/Red_Button.grab_focus()


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
		4:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_exit_game_pressed() -> void:
	get_tree().quit()
