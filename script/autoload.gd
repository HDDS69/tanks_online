extends Node
var save = "user://savetanks.save"
var nickname1 = "player"
var color
var mute = false
var control = true
var control2 = false
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save_game():
	var  file = FileAccess.open(save , FileAccess.WRITE)
	file.store_var(mute)
	file.store_var(control)
	file.store_var(control2)
	
	
	
func load_game():
	var file = FileAccess.open(save, FileAccess.READ)
	if file:  # Check if the file opened successfully
		mute = file.get_var(mute)  # Correctly retrieve the data
		control = file.get_var(control)
		control2 = file.get_var(control2)
		print("profit")
		file.close()  # Always close the file after use
	else:
		print("Failed to open the save file.")
