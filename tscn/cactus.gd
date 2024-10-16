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
	$CollisionShape2D2.set_deferred("disabled", true);
	$CollisionShape2D.set_deferred("disabled", true);
	$CollisionShape2D3.set_deferred("disabled", true);
	$CollisionShape2D4.set_deferred("disabled", true);
	$Cactus.visible = false
	$Cactus_shadow.visible = false
	$AnimatedSprite2D.play('default')
	await $AnimatedSprite2D.animation_finished
	queue_free()
