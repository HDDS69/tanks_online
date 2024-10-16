extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'player' :
		death(1)

func death(x):
	$CollisionShape2D.set_deferred("disabled", true);
	$Borel.visible = false
	$Borel2.visible = false
	$AnimatedSprite2D.play("boom")
	await $AnimatedSprite2D.animation_finished
	queue_free()
