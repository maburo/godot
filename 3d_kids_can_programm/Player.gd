extends KinematicBody

var gravity = Vector3.DOWN * 12  # strength of gravity Vector3.DOWN * 12
var speed = 4  # movement speed
var jump_speed = 6  # jump strength
var spin = 0.1  # rotation speed

var velocity:Vector3 = Vector3()
var jump = false

func _physics_process(delta):	
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y += jump_speed
	
func get_input():
	var vy = velocity.y
	velocity = Vector3()
	if Input.is_action_pressed("ui_up"):
	    velocity += -transform.basis.z * speed;
	if Input.is_action_pressed("ui_down"):
	    velocity += transform.basis.z * speed;
	if Input.is_action_pressed("ui_right"):
	    velocity += transform.basis.x * speed;
	if Input.is_action_pressed("ui_left"):
	    velocity += -transform.basis.x * speed;
	velocity.y = vy
	jump = false
	if (Input.is_action_pressed("jump")):
		jump = true
	
		
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0, spin, event.relative.x / 10))