extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var nickname = Autoload.nickname1
@export var player := 1 :
	set(id):
		player = id
		$player_input.set_multiplayer_authority(id)
		
@onready var input = $player_input
func _ready():
	if player == multiplayer.get_unique_id():
		$Camera2D.make_current() #= true
	randomize()  # Инициализация генератора случайных чисел
	var red = randi() % 256  # Получение числа от 0 до 255
	var green = randi() % 256  # Получение числа от 0 до 255
	var blue = randi() % 256  # Получение числа от 0 до 255
	$"Untitled08-14-202411-08-44/Sprite2D".self_modulate = Color(red / 255.0, green / 255.0, blue / 255.0)
func _physics_process(delta):
	randomize()  # Инициализация генератора случайных чисел
	var red = randi() % 256  # Получение числа от 0 до 255
	var green = randi() % 256  # Получение числа от 0 до 255
	var blue = randi() % 256  # Получение числа от 0 до 255
	$"Untitled08-14-202411-08-44/Sprite2D".self_modulate = Color(red / 255.0, green / 255.0, blue / 255.0)
	if player == multiplayer.get_unique_id():
		velocity = $ui/joystick.get_velo() * SPEED
		up_direction = Vector2.UP
		var pos = $ui/joystick.get_velo() * 10000
		look_at(pos)
		move_and_slide()
	#if Input.is_action_just_pressed("leftbutton"):
	#	if player == multiplayer.get_unique_id():
	#		shoot.rpc()
		
#@rpc("any_peer", "reliable","call_local")
#func shoot():
	#var bullet = preload("res://bullet.tscn").instantiate()
#	get_tree().root.add_child(bullet)
#	bullet.transform = $Marker2D.global_transform

@rpc("any_peer", "reliable","call_local")
func death():
	$".".queue_free()



func _on_button_pressed():
	#multiplayer.disconnect_peer(player)
	#death()
	#get_tree().change_scene_to_file("res://multiplayer.tscn")
	pass


func _on_touch_screen_button_pressed():
	if player == multiplayer.get_unique_id():
			shoot.rpc()
