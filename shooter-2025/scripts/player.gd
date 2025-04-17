extends CharacterBody2D

class_name Player

var speed = 300

signal died

@onready var camera_remote_transform =$CameraRemoteTransform
@onready var shoot_raycast = $ShootRaycast

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("shoot"):
		if shoot_raycast.is_colliding():
			var collider = shoot_raycast.get_collider()
			if collider is StaticBody2D:
				pass
			elif collider is enemy:
				collider._take_damage(1)

func _physics_process(delta: float) -> void:
	var move_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	if move_direction != Vector2.ZERO:
		velocity = speed * move_direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is enemy:
		died.emit()
		queue_free()
