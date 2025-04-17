extends Node2D

@onready var player = $player
@onready var main_cam = $MainCam


func _ready() -> void:
	player.died.connect(_on_player_died)
	player.camera_remote_transform.remote_path = main_cam.get_path()


func _on_player_died():
	get_tree().create_timer(3).timeout.connect(get_tree().reload_current_scene)
	pass
