extends MultiplayerSynchronizer
var pos = Vector2(0,0)
@export var direction := Vector2()
@export var nickname = Autoload.nickname1
@export var rotation_speed = 4.0
var rotation_direction = 0
var death = false
var hp = 10

func _ready():
	if nickname == 'админ хуесос':
		nickname = 'сам хуесос'
		$"../player/ui/Control3/Button2".visible = true
	else : 
		$"../player/ui/Control3/Button2".visible = false
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
func _process(delta):
	if hp <= 0:
		death = true
		$"..".death.rpc()
	if death :
		if not $"../player/death".playing:
			death_music.rpc()
	else :

		$"../player/ui/Control4/Label".text = 'hp : ' + str(hp)
	
		if nickname == 'cat' or nickname == 'это я насрал в тапки' :
				nickname = 'это я насрал в тапки'
				$"../player/Cat".visible = true
		elif nickname == 'ельцин' or nickname == 'уважаемые россияне':
				nickname = 'уважаемые россияне'
				$"../player/Ельцин".visible = true
				$"../player/AnimatedSprite2D".visible = false
		elif nickname == 'brorAutisme' or nickname == 'Сахаровская Слойка' :
			$"../player/SugarSloika".visible = true
			nickname = 'Сахаровская Слойка'
		elif nickname == 'зум дар дар' or nickname == 'РВИ И КРОМСАЙ' :
			nickname = 'РВИ И КРОМСАЙ'
			$"../player/Dandar".visible = true
		elif nickname == 'не вводи это' or nickname == 'Never Gona Give You Up':
			nickname = 'Never Gona Give You Up'
			nevergiveyouup.rpc()
		elif nickname == 'группа груша' : 
			$"../player/Sovok".visible = true
		if nickname =='rgb' or nickname == 'эпилептикам привет' :
				nickname = 'эпилептикам привет'
				randomize()  # Инициализация генератора случайных чисел
				var red = randi() % 256  # Получение числа от 0 до 255
				var green = randi() % 256  # Получение числа от 0 до 255
				var blue = randi() % 256  # Получение числа от 0 до 255
				$"../player/AnimatedSprite2D/Sprite2D".self_modulate = Color(red / 255.0, green / 255.0, blue / 255.0)
				$"../mine".modulate = Color(red / 255.0, green / 255.0, blue / 255.0)
		else : 
			
			$"../mine".modulate = Autoload.color
			$"../player/AnimatedSprite2D/Sprite2D".self_modulate = Autoload.color
		$"../marker1/Label".text = nickname
		
	
		if $"../player".velocity != Vector2(0,0):
			if not $"../player/drive".playing :
				drive_music.rpc()
		else : 
			drive_music_stop.rpc()
		
		#управление 1
		if Autoload.control :
			var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			if input_direction != Vector2.ZERO:  # Проверка, движется ли игрок
				var target_rotation = input_direction.angle()  # Получаем угол для вращения
				$"../player".rotation = target_rotation  # Поворачиваем игрока в сторону движения
			$"../player".velocity = input_direction * $"..".SPEED
		#управление  2
		else :
			rotation_direction = Input.get_axis("ui_left", "ui_right")
			$"../player".velocity = $"../player".transform.x * Input.get_axis("ui_down", "ui_up") * $"..".SPEED
			$"../player".rotation += rotation_direction * rotation_speed * delta
		$"../marker1".position = $"../player".position
		$"../marker1".position.y = $"../player".position.y - 52
		$"../player".move_and_slide()
		if Input.is_action_just_pressed("rightbutton"):
			mine_spawn.rpc()
		if Input.is_action_just_pressed("leftbutton"):
			shoot.rpc()

@rpc("any_peer", "reliable","call_local")
func mine_spawn():
	var mine = preload("res://tscn/mine.tscn").instantiate()
	$"../mine".add_child(mine,true)
	mine.global_position = $"../player/mine_spawner".global_position
	

@rpc("any_peer", "reliable","call_local")
func shoot():
	$"../player/fire".play()
	var bullet = preload("res://tscn/bullet.tscn").instantiate()
	$"../bullet".add_child(bullet,true)
	bullet.transform = $"../player/Marker2D".global_transform
	
@rpc("any_peer", "reliable","call_local")
func drive_music():
	$"../player/drive".play()
	$"../player/AnimatedSprite2D".play("default")
	
@rpc("any_peer", "reliable","call_local")
func drive_music_stop():
	$"../player/drive".stop()
	$"../player/AnimatedSprite2D".stop()

@rpc("any_peer", "reliable","call_local")
func death_music():
	$"../player/death".play()
	
@rpc("any_peer", "reliable","call_local")
func nevergiveyouup():
	$"../player/AnimatedSprite2D/nevergiveyouup".visible = true
	$"../player/AnimatedSprite2D/nevergiveyouup".play("default")
	
	
