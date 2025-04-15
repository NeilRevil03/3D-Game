extends Area3D
@export var boost_factor: float = 10.0      # How much the player's speed increases.
@export var boost_duration: float = 5.0    # Duration of the boost in seconds.
const ROT_SPEED = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		
		if body.has_method("apply_speed_boost"):
			body.apply_speed_boost(boost_factor, boost_duration)
		else:
			push_warning("The object that entered does not implement apply_speed_boost()")
	queue_free()
