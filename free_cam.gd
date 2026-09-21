extends Camera3D

@export var move_speed: float = 15.0
@export var boost_multiplier: float = 3.0
@export var mouse_sensitivity: float = 0.002

var _looking: bool = false
var _yaw: float = 0.0
var _pitch: float = 0.0


func _ready() -> void:
	make_current()
	_yaw = global_rotation.y
	_pitch = global_rotation.x


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			_set_looking(event.pressed)

	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			_set_looking(false)

	if event is InputEventMouseMotion and _looking:
		_yaw -= event.screen_relative.x * mouse_sensitivity
		_pitch -= event.screen_relative.y * mouse_sensitivity
		_pitch = clampf(_pitch, deg_to_rad(-89.0), deg_to_rad(89.0))

		global_rotation = Vector3(_pitch, _yaw, 0.0)


func _process(delta: float) -> void:
	if not _looking:
		return

	var direction := Vector3.ZERO

	# Camera-relative movement: W flies toward where you're looking.
	if Input.is_physical_key_pressed(KEY_W):
		direction -= global_basis.z
	if Input.is_physical_key_pressed(KEY_S):
		direction += global_basis.z
	if Input.is_physical_key_pressed(KEY_A):
		direction -= global_basis.x
	if Input.is_physical_key_pressed(KEY_D):
		direction += global_basis.x

	# World-relative vertical movement.
	if Input.is_physical_key_pressed(KEY_Q):
		direction += Vector3.DOWN
	if Input.is_physical_key_pressed(KEY_E):
		direction += Vector3.UP

	var speed := move_speed
	if Input.is_physical_key_pressed(KEY_SHIFT):
		speed *= boost_multiplier

	global_position += direction.normalized() * speed * delta


func _set_looking(enabled: bool) -> void:
	_looking = enabled
	Input.mouse_mode = (
		Input.MOUSE_MODE_CAPTURED if enabled
		else Input.MOUSE_MODE_VISIBLE
	)


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		_set_looking(false)


func _exit_tree() -> void:
	if _looking:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
