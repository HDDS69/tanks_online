extends Area2D


@onready var big = $big
@onready var small = $big/small
@onready var max_distance = $CollisionShape2D.shape.radius
var distance = 0
var touched = false
func _input(event):
	#var distance = event.position.distance_to(big.global_position)
	if event is InputEventScreenTouch :
		if event.index == 0 or event.index == 1: # first finger drag
		##	if timer_shoot == true :
		##		$"../Timer".start()
		##		timer_shoot = false
		##		shoot.rpc()
				#
		##f event.index == 1: # second finger
			distance = event.position.distance_to(big.global_position)
			#if not touched:
			#	if distance < max_distance:
			#		touched = true
			#else : 
			#	touched = false
			#	small.position = Vector2(0,0)
	elif distance < max_distance:
			touched = true
	else :
			touched = false
			small.position = Vector2(0,0)
func _process(_delta):
	if touched:
		small.global_position = get_global_mouse_position()
		small.position = big.position + (small.position - big.position).limit_length(max_distance)
func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = small.position.x / max_distance
	joy_velo.y = small.position.y / max_distance
	return joy_velo
	
