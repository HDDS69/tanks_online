extends CharacterBody2D

func death(hp):
	$"../player_input".hp -= hp
func hp():
	$"../player_input".hp +=1
func speed():
	$"..".SPEED += 20.0
