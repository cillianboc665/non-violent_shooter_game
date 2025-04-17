extends CharacterBody2D

class_name Player


var bullet = preload("res://scenes/bullet.tscn")

var speed = 400
var bullet_speed = 20000
var fire_rate = 0.7
var can_fire = true

signal died


@onready var camera_remote_transform =$CameraRemoteTransform


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = $BulletSpawn.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_force(Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		await(get_tree().create_timer(fire_rate).timeout)
		can_fire = true



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
