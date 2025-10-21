extends Area2D

var exit = true

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		$Mine/Button.visible = false


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		$AnimatedSprite2D.modulate = $".".modulate
		$AnimatedSprite2D.play("default")
		if not $boom.playing :
				death_music.rpc()
		await $AnimatedSprite2D.animation_finished
		if exit == false :
			body.death(3)
		queue_free()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		exit = true
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		exit = false

@rpc("any_peer", "reliable","call_local")
func death_music():
	$boom.play()
