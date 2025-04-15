extends CharacterBody3D


const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

@export var base_speed: float = 5.0
var current_speed: float = base_speed

@onready var jump_sfx = $jump_sfx
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var footsteps = $footstep_sfx

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 6.5
		jump_sfx.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()

func _play_footstep_audio():
	footsteps.pitch_scale = randf_range(.8, 1.2)
	footsteps.play()
	
func apply_speed_boost(boost_factor: float, duration: float) -> void:
	current_speed = base_speed * boost_factor
	
	var timer = Timer.new()
	timer.wait_time = duration
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_speed_boost_timeout)
	timer.start()

func _on_speed_boost_timeout() -> void:
	current_speed = base_speed
