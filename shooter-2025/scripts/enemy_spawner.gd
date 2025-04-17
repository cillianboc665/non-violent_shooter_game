extends Node2D

@onready var main = get_node("/root/Node2D")

var enemy_scene := preload("res://scenes/enemy.tscn")
var spawn_points := []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var opps = enemy_scene.instantiate()
	opps.position = spawn.position
	main.add_child(opps)
