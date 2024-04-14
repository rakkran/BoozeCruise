extends Control
class_name PlayerHud

@onready var input_container = $Inputs
@onready var subtitles_panel = $SubtitleContainer/PanelContainer
@onready var subtitles = $SubtitleContainer/PanelContainer/MarginContainer/Subtitles
@onready var subtitle_timer = $SubtitleTimer
@onready var speedometer = $Speedometer

var input_prompt = preload("res://Scenes/UI/InputIcon.tscn")
var test = false

func _ready():
	AudioManager.playing_voiceline.connect(_on_voice_line_played)
	AudioManager.voiceline_finished.connect(_on_voice_line_finished)
	GlobalEventBus.add_new_input.connect(_on_new_action)

# When a new input is being added. Next ones to be added should be stored in GameGlobals
func _on_new_action():
	pass

func _on_voice_line_played(subtitle_text: String):
	subtitles.text = subtitle_text
	subtitles_panel.visible = true

func _on_voice_line_finished():
	subtitle_timer.start()

func _on_subtitle_timer_timeout():
	subtitles_panel.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	speedometer.text = "Current speed: (%s, %s)" % [GameGlobals.player_speed.x, GameGlobals.player_speed.z]

