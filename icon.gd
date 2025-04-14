extends Sprite3D

var coins = 5
var player_name = "robot"
var hearts = 3.5
const speed = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hello world")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(5))
	
	pass
