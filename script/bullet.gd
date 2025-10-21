extends Area2D
var SPEED = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position += SPEED * transform.x


func _on_body_entered(body):
	if body.name != "TileMapLayer":
		body.death(1)
	#elif body is TileMapLayer :
		#var tile_position = body.local_to_map(global_position)  # Преобразуем мировую позицию в координаты клетки
		#
		#body.set_cell(tile_position, -1)  # Удаляем тайл, устанавливая его значение на -1
	death()


func death():
	queue_free()
func _on_area_entered(area: Area2D) -> void:
	if area.name =="bullet" :
		area.death()
