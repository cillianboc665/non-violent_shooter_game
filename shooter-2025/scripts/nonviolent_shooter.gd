extends Node2D

@onready var player = $player
@onready var main_cam = $MainCam
@onready var spawner = $EnemySpawner
@onready var ui = $score_ui


func _ready() -> void:
	player.camera_remote_transform.remote_path = main_cam.get_path()
	spawner.score_ui = ui
