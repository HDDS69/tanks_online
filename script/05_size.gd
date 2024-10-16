extends Area2D

@export var scale_tank = Vector2(0.5,0.5)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if scale_tank == Vector2(0.5,0.5):
		$"05Size".visible = true
		$"05Size2".visible =  true
	elif scale_tank == Vector2(1,1):
		$NormalSize.visible = true
		$NormalSize2.visible = true
	elif scale_tank == Vector2(2,2):
		$"2Size".visible = true
		$"2Size2".visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name != 'TileMapLayer':
		body.scale = scale_tank
	queue_free()
