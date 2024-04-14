extends Area3D

# Destroys the car when it passes through 
func _on_body_entered(body):
	body.queue_free()
