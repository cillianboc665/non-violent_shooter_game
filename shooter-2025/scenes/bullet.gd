extends RigidBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		pass
	elif body is enemy:
		body._take_damage(1)
		queue_free()
	elif body is StaticBody2D:
		queue_free()
