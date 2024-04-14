extends Area3D

signal car_spawned(car)
# Used to check if a new car can be spawned yet
@onready var spawn_timer : Timer = $SpawnTimer

# Array of all possible spawnable cars
var spawnable_cars : Array = [
	preload("res://Scenes/OtherCars/car_black.tscn"),
	preload("res://Scenes/OtherCars/car_blue.tscn"),
	preload("res://Scenes/OtherCars/car_red.tscn")
]


func spawn_car(car_packed_scene: PackedScene):
	var car_scene = car_packed_scene.instantiate()
	car_spawned.emit(car_scene)	

func _process(delta):
	# If the spawn cd is still active or there is a car in the spawn area, dont spawn another car
	if spawn_timer.is_stopped():
		if has_overlapping_bodies():
			print("Spawn zone occupied. Waiting...")
			return
		print("Spawning car.")
		var random_car = spawnable_cars.pick_random()
		spawn_car(random_car)
		spawn_timer.start()
	
		
		
		
