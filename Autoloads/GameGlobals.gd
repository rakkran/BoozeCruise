extends Node

# Inputs to be added: Ignoring the initial movement ones.
var next_input_keys = ["e", "ctrl"]
var next_input_prompts = ["Turn off headlights", "Insert prompt here."]

# Drunk_score is an important number which decides many in-game interactions
var drunk_score : int = 0
const MAX_DRUNK_SCORE : int = 500

# Player speed
var player_speed : Vector3 = Vector3.ZERO

var cause_of_death : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

# Gain more drunk score over time 
func _process(delta):
	if drunk_score <= 0:
		return
	
	if drunk_score <= 500:
		drunk_score += 2 * delta
	
	if drunk_score <= 75:
		AudioManager.set_voice_lines("A")
	elif drunk_score <= 200:
		AudioManager.set_voice_lines("B")
	elif drunk_score <= 275:
		AudioManager.set_voice_lines("C")
	elif drunk_score <= 375:
		AudioManager.set_voice_lines("D")
	elif drunk_score <= 450:
		AudioManager.set_voice_lines("E")
	else:
		AudioManager.set_voice_lines("Z")
