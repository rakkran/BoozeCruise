extends HBoxContainer

@onready var Icon = $MarginContainer/Icon
@onready var InputText = $InputPrompt

func set_text(text: String):
	InputText.text = text

# Gets the appropriate for an input
func set_icon(key_name: String):
	match key_name:
		"down":
			Icon.frame = 0
		"left":
			Icon.frame = 1
		"right":
			Icon.frame = 2
		"up":
			Icon.frame = 3
		"ctrl":
			Icon.frame = 4
		"d":
			Icon.frame = 5
		"e":
			Icon.frame = 6
		
