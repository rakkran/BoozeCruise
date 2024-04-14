extends RigidBody3D

@onready var car_mesh = $CarMesh
@onready var body_mesh = $CarMesh/CarParts
@onready var ground_ray = $CarMesh/RayCast3D
@onready var right_wheel = $CarMesh/CarParts/FrontRightWheel
@onready var left_wheel = $CarMesh/CarParts/FrontLeftWheel
@onready var crash_check = $CarMesh/CrashCheck
@onready var headlight_1 = $CarMesh/CarParts/Headlight1
@onready var headlight_2 = $CarMesh/CarParts/Headlight2
const original_energy = 16

var sphere_offset : Vector3 = Vector3.DOWN
@export_group("Car Settings")
@export var acceleration : float = 35.0
@export var steering : float = 18.0 # Turn amount in degrees
@export var turn_speed : float = 4.0
@export var turn_stop_limit : float = 0.75 # Below this speed, the car doesnt turn
@export var body_tilt : int = 35

var speed_input = 0
var turn_input = 0

# The speed of the car just before impact
var previous_velocity : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	previous_velocity = linear_velocity
	GameGlobals.player_speed = previous_velocity
	car_mesh.position = position + sphere_offset
	if ground_ray.is_colliding():
		apply_central_force(-car_mesh.global_transform.basis.z * speed_input)

func _process(delta):
	if Input.is_action_pressed("toggle_headlights"):
		if headlight_1.light_energy >= 0:
			headlight_1.light_energy = 0
			headlight_2.light_energy = 0
		else:
			headlight_1.light_energy = 16
			headlight_2.light_energy = 16
	
	if not ground_ray.is_colliding():
		return
	speed_input = Input.get_axis("accelerate", "brake") * acceleration
	turn_input = Input.get_axis("steer_right", "steer_left") * deg_to_rad(steering)
	# Rotate the wheels
	right_wheel.rotation.y = turn_input
	left_wheel.rotation.y = turn_input
	
	# Rotate car mesh around y axis by turn_input
	if linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, turn_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
	
	# Tilt body when turning
	var tilt = -turn_input * linear_velocity.length() / body_tilt
	body_mesh.rotation.z = lerp(body_mesh.rotation.z, tilt, 10 * delta)
	
	# For slopes
	if ground_ray.is_colliding():
		var n = ground_ray.get_collision_normal()
		var xform = align_with_y(car_mesh.global_transform, n)
		car_mesh.global_transform = car_mesh.global_transform.interpolate_with(xform, 10.0 * delta)
	
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform.orthonormalized()

# Checks to see if the player has crashed into anything
func check_crash():
	if crash_check.is_colliding():
		var crash_velocity = previous_velocity.length()
		if crash_velocity >= 25.0:
			GameGlobals.drunk_score += 30
