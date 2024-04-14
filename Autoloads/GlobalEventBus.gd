extends Node

signal player_died
signal game_started
signal add_new_input

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _game_start():
	AudioManager.start_game()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
