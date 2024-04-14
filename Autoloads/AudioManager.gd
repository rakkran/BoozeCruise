extends Node

# Voice lines are split into 5 stages, A through E
# A - Calm, nothings wrong
# B - confident
# C - Somethings off
# D - Oh god something is off
# E - I'm going insane
# Z - Wait I'm almost home though
signal playing_voiceline(subtitle_text)
signal voiceline_finished

@export_group("Voice Lines")
@export var VOICE_LINES_A: Array[AudioStream]
@export var VOICE_LINES_B: Array[AudioStream]
@export var VOICE_LINES_C: Array[AudioStream]
@export var VOICE_LINES_D: Array[AudioStream]
@export var VOICE_LINES_E: Array[AudioStream]
@export var VOICE_LINES_Z: Array[AudioStream]

@export_group("Subtitles")
@export var SUBTITLES_A: Array[String]
@export var SUBTITLES_B: Array[String]
@export var SUBTITLES_C: Array[String]
@export var SUBTITLES_D: Array[String]
@export var SUBTITLES_E: Array[String]
@export var SUBTITLES_Z: Array[String]

@onready var voiceline_player = $VoiceLinePlayer
@onready var voiceline_timer = $VoiceLineTimer
@export var CURRENT_VOICE_LINES : Array[AudioStream]
@export var CURRENT_SUBTITLES : Array[String]

func _ready():
	pass

func start_game():
	voiceline_timer.start()

func play_voiceline(voiceline: AudioStream, subtitle: String):
	voiceline_player.stream = voiceline
	voiceline_player.play()
	playing_voiceline.emit(subtitle)

func _on_voice_line_finished():
	voiceline_finished.emit()

# Play a random voiceline from the current selection
func _on_voice_line_timer_timeout():
	if CURRENT_VOICE_LINES.is_empty():
		return
	
	var line_num =  randi() % CURRENT_VOICE_LINES.size()
	var voice_line = CURRENT_VOICE_LINES.pop_at(line_num)
	var subtitle = CURRENT_SUBTITLES.pop_at(line_num)
	play_voiceline(voice_line, subtitle)
	# Choose a random time before the next voiceline 
	voiceline_timer.time_left = randi() % 6 + 10

# Sets current voice line set
func set_voice_lines(key : String):
	match key:
		"A":
			CURRENT_VOICE_LINES = VOICE_LINES_A
			CURRENT_SUBTITLES = SUBTITLES_A
		"B":
			CURRENT_VOICE_LINES = VOICE_LINES_B
			CURRENT_SUBTITLES = SUBTITLES_B
		"C":
			CURRENT_VOICE_LINES = VOICE_LINES_C
			CURRENT_SUBTITLES = SUBTITLES_C
		"D":
			CURRENT_VOICE_LINES = VOICE_LINES_D
			CURRENT_SUBTITLES = SUBTITLES_D
		"E":
			CURRENT_VOICE_LINES = VOICE_LINES_E
			CURRENT_SUBTITLES = SUBTITLES_E
		"Z":
			CURRENT_VOICE_LINES = VOICE_LINES_Z
			CURRENT_SUBTITLES = SUBTITLES_Z
