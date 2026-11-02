extends Timer


var Plataformas:Array[Platform] 

func _ready() -> void:
	for platform in get_tree().get_nodes_in_group("Platform"):
		Plataformas.append(platform)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stop = Input.is_action_pressed("Stop_moving_debug")
	if stop:
		for plataforma in Plataformas.size():
			Plataformas[plataforma].detener = false
			Plataformas[plataforma].stop_moving_debug()
		
		
func _on_timeout() -> void:
	for plataforma in Plataformas.size():
		Plataformas[plataforma].detener = true
		Plataformas[plataforma].stop_moving_debug()
		
