extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Autoload.load_game()
	if Autoload.control : 
		$settings/control.button_pressed = true
	if Autoload.control2 :
		$settings/control2.button_pressed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Autoload.mute:
		$settings/MusicOff.visible = true
		$settings/MusicOn.visible = false
	print(Autoload.control , Autoload.control2)
	
func _on_music_button_pressed() -> void:
	$settings/MusicOn.visible = !$settings/MusicOn.visible
	$settings/MusicOff.visible = !$settings/MusicOff.visible
	Autoload.mute = !Autoload.mute
	
func _on_exit_button_pressed() -> void:
	Autoload.save_game()
	get_tree().change_scene_to_file("res://tscn/multiplay1er.tscn")


func _on_control_toggled(toggled_on: bool) -> void:
	Autoload.control = !Autoload.control
	if Autoload.control : 
		$settings/control2.button_pressed = false
		Autoload.control2 = false

func _on_control_2_toggled(toggled_on: bool) -> void:
	Autoload.control2 = !Autoload.control2
	if Autoload.control2 :
		$settings/control.button_pressed = false
		Autoload.control = false
