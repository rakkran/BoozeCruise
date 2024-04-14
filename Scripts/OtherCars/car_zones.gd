extends Node3D

@export var CAR_SPEED : float = 20.0
@export var MAX_CARS : int = 10

func _on_car_spawned(car_scene: Node):
	# First checks to see if this would add too many cars: if so, removes one
	if %CarPath.get_child_count() >= MAX_CARS:
		%CarPath.get_child(0).queue_free()
		return
	
	var path_follow = PathFollow3D.new()
	path_follow.add_child(car_scene)
	%CarPath.add_child(path_follow)

# Moves active cars. Also checks to see if any of the path follows have lost their car.
func _physics_process(delta):
	for car_pathing in %CarPath.get_children():
		if car_pathing.get_child_count() == 0:
			car_pathing.queue_free()
		else:
			car_pathing.progress += CAR_SPEED * delta
