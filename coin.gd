extends Area3D
@onready var pick_up = $pick_up

const ROT_SPEED = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))




func _on_body_entered(body):
	
	get_parent().playCoin()
	queue_free()
	
