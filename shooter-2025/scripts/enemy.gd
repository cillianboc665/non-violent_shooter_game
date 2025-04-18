extends CharacterBody2D

class_name enemy

signal score

@onready var animation_player = $AnimationPlayer

var player: Player = null

var speed: float = 200.0
var direction := Vector2.ZERO

var hp: int = 1

var sounds := []

func _ready() -> void:
	for s in get_children():
		if s is AudioStreamPlayer:
			sounds.append(s)

func _process(delta: float) -> void:
	if player != null:
		look_at(player.global_position)


func _physics_process(delta: float) -> void:
	if player != null:
		var enemy_to_player = (player.global_position - global_position)
		direction = enemy_to_player.normalized()
		
		if direction != Vector2.ZERO:
			velocity = speed * direction
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
		
		move_and_slide()

func _on_sight_range_body_entered(body: Node2D) -> void:
	if body is Player:
		if player == null:
			player = body
	pass # Replace with function body.

func _take_damage(amount: int):
	if hp > 0:
		hp -= amount
		# sound effect here
		if hp <= 0:
			var rand_sound = sounds[randi() % sounds.size()]
			rand_sound.play()
			score.emit()
			velocity = Vector2.ZERO
			player = null
			animation_player.play("complimented")
			await rand_sound.finished
			queue_free()
			
