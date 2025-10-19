extends Node2D
var timer_baff = true
var scale_list = [0.5,1,2]

func _ready():
	Autoload.load_game()
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)
	
	for id in multiplayer.get_peers():
		add_player(id)

	if not OS.has_feature("dedicated_server"):
		add_player(1)
		
func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)

func add_player(id: int):
	var character = preload("res://tscn/player1.tscn").instantiate()
	character.player = id
	character.name = str(id)
	$player.add_child(character,true)
	
func del_player(id: int):
	if not $player.has_node(str(id)):
		return
	$player.get_node(str(id)).queue_free()
	

@rpc("any_peer", "reliable","call_local")
func add_baff_heart():
	var heart = preload("res://tscn/heart.tscn").instantiate()
	randomize()  # Инициализация генератора случайных чисел
	var x = randi() % 7500  # Получение числа от 0 до 255
	var y = randi() % 4350  # Получение числа от 0 до 255
	heart.position = Vector2(x,y)
	$baff.add_child(heart,true)
	
@rpc("any_peer", "reliable","call_local")
func add_baff_speed():
	var speed = preload("res://tscn/speed.tscn").instantiate()
	randomize()  # Инициализация генератора случайных чисел
	var x = randi() % 7500  # Получение числа от 0 до 255
	var y = randi() % 4350  # Получение числа от 0 до 255
	speed.position = Vector2(x,y)
	$baff.add_child(speed,true)
	
@rpc("any_peer", "reliable","call_local")
func add_baff_size():
	var size = preload("res://tscn/05size.tscn").instantiate()
	randomize()  # Инициализация генератора случайных чисел
	var x = randi() % 7500  # Получение числа от 0 до 255
	var y = randi() % 4350  # Получение числа от 0 до 255
	var scale_number = randi() % 3
	size.scale_tank = Vector2(scale_list[scale_number],scale_list[scale_number])
	size.position = Vector2(x,y)
	$baff.add_child(size,true)
	
@rpc("any_peer", "reliable","call_local")
func baff_random():
	randomize()  # Инициализация генератора случайных чисел\
	var baff_number = randi() % 3  # Получение числа от 0 до 2
	if baff_number == 0:
		add_baff_heart.rpc()
	elif baff_number ==1:
		add_baff_speed.rpc()
	else:
		add_baff_size.rpc()
		
func _on_timer_timeout() -> void:
	#if multiplayer.is_server():
		baff_random.rpc()
