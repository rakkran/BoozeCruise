extends Camera3D

@export var lerp_speed = 3.0
@export var offset : Vector3 = Vector3.ZERO # Offset of the camera from the car
@export var target : Node # The car to be targetted

func _physics_process(delta):
	if target:
		# Sets the target position to be the target adjusted by the offset
		var target_pos = target.global_transform.translated_local(offset)
		global_transform = global_transform.interpolate_with(target_pos, lerp_speed * delta)
		look_at(target.global_position, Vector3.UP)
