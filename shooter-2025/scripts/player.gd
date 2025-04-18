extends CharacterBody2D

class_name Player


var bullet = preload("res://scenes/bullet.tscn")

var speed = 400
var bullet_speed = 20000
var fire_rate = 1
var can_fire = true

var alive = true


@onready var camera_remote_transform =$CameraRemoteTransform
@onready var anim_plyr = $AnimationPlayer
@onready var ouch = $AudioStreamPlayer


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if alive == true:
		if Input.is_action_just_pressed("shoot") and can_fire:
			var bullet_instance = bullet.instantiate()
			bullet_instance.position = $BulletSpawn.get_global_position()
			bullet_instance.rotation_degrees = rotation_degrees
			bullet_instance.apply_force(Vector2(bullet_speed, 0).rotated(rotation))
			get_tree().get_root().add_child(bullet_instance)
			can_fire = false
			await(get_tree().create_timer(fire_rate).timeout)
			can_fire = true
	else:
		pass



func _physics_process(delta: float) -> void:
	if alive == true:
		var move_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
		
		if move_direction != Vector2.ZERO:
			velocity = speed * move_direction
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
			
		move_and_slide()
	else:
		pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is enemy:
		$hitbox.set_deferred("monitoring", false)
		alive = false
		anim_plyr.play("crode")
		ouch.play()
		await ouch.finished
		get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
