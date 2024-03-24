extends Camera2D

@export var move_speed = 0.5  # camera position lerp speed
@export var zoom_speed = 0.25  # camera zoom lerp speed
@export var margin = Vector2(400, 200)  # include some buffer area around targets

var shake_ammount : float = 0
var default_offset : Vector2 = offset
var pos_x : int
var pos_y : int

var is_shaking : bool = false

@onready var timer : Timer = $Timer
@onready var tween : Tween = create_tween()


var targets = []  # Array of targets to be tracked.

@onready var screen_size = get_viewport_rect().size

func _process(_delta):
	if !targets:
		return
	# Keep the camera centered between the targets
	var p = Vector2.ZERO
	for target in targets:
		p += target.position
	p /= targets.size()
	position = lerp(position, p, move_speed)
	# Find the zoom that will contain all targets
	var r = Rect2(position, Vector2.ONE)
	for target in targets:
		r = r.expand(target.position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	if is_shaking: offset = Vector2(randf_range(-1, 1) * shake_ammount, randf_range(-1, 1) * shake_ammount)

func add_target(t):
	if t is Player_Class:
		targets.append(t)

func remove_target(t):
	if t is Player_Class:
		targets.erase(t)

func screen_shake(time, amount):
	timer.wait_time = time
	shake_ammount = amount
	is_shaking = true
	timer.start()

func _on_timer_timeout():
	is_shaking = false
	Tween.interpolate_value(self, "offset", 1, 1, tween.TRANS_LINEAR, tween.EASE_IN)
