extends Node
const PORT = 4433
var player_nickname: String
func _ready():
	# Start paused
	Autoload.load_game()
	get_tree().paused = true
	# You can save bandwith by disabling server relay and peer notifications.
	multiplayer.server_relay = false

	# Automatically start the server in headless mode.
	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server")
		_on_host_pressed.call_deferred()


func _on_host_pressed():
	# Start as server
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server")
		return
	multiplayer.multiplayer_peer = peer
	set_nickname($UI/Remote2.text)
	start_game()

func _on_connect_pressed():
	# Start as client
	var txt : String = $UI/Remote.text
	if txt == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(txt, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client")
		return
	multiplayer.multiplayer_peer = peer
	set_nickname($UI/Remote2.text)
	start_game()

func start_game():
	# Hide the UI and unpause to start the game.
	$UI.hide()
	get_tree().paused = false
	# Only change level on the server.
	# Clients will instantiate the level via the spawner.
	if multiplayer.is_server():
		change_level.call_deferred(load("res://tscn/level.tscn"))


# Call this function deferred and only on the main authority (server).
func change_level(scene: PackedScene):
	# Remove old level if any.
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	# Add new level.
	level.add_child(scene.instantiate())

# The server can restart the level by pressing HOME.
func _input(event):
	if not multiplayer.is_server():
		return
	if event.is_action("ui_home") and Input.is_action_just_pressed("ui_home"): 
		change_level.call_deferred(load("res://tscn/level.tscn"))
	#if event.is_action('exit')  and Input.is_action_just_pressed('exit') :
	#	change_level.call_deferred(load("res://tscn/multiplay1er.tscn"))
@rpc  # Делает функцию доступной для удаленных вызовов
func set_nickname(nickname: String):
	Autoload.nickname1 = nickname
	Autoload.color = $UI/ColorPickerButton.color


func _on_button_pressed() -> void:
	randomize()  # Инициализация генератора случайных чисел
	var red = randi() % 256  # Получение числа от 0 до 255
	var green = randi() % 256  # Получение числа от 0 до 255
	var blue = randi() % 256  # Получение числа от 0 до 255
	$UI/ColorPickerButton.color = Color(red / 255.0, green / 255.0, blue / 255.0)


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://tscn/settings.tscn")
