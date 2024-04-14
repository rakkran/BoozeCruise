extends Control

var world_scene = preload("res://Scenes/Levels/World.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_pressed("confirm"):
		get_tree().root.add_child(world_scene)
		GlobalEventBus.game_started.emit()
		queue_free()
		
