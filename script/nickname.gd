extends Node2D
@export var nick = Autoload.nickname1
func _ready():
	#Autoload.load_game()
	$RichTextLabel.text = nick
