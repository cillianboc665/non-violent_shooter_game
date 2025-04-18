extends CanvasLayer

var compliments = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$score.text = "Compliments Given: " + str(compliments)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _score():
	print("plus one")
	compliments = compliments + 1
	$score.text = "Compliments Given: " + str(compliments)
