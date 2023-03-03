extends CharacterBody3D

# steps
# have a camera head
# make the camera rotate up and down
# rotate the character left and right
# move
# jump
@onready var cameraArm = $CameraArm


#var velocity = Vector3.ZERO
var speed:= 25.0
var camera_sensitivity := Vector2(13,10)
var max_y_rotation := 70.0
var input_dir:= Vector2.ZERO
var gravity := 10.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		update_camera(event.relative)

func update_camera(mouse_delta:Vector2) -> void:
	mouse_delta.x = clamp(mouse_delta.x,-camera_sensitivity.x,camera_sensitivity.x)
	mouse_delta.y = clamp(mouse_delta.y,-camera_sensitivity.y,camera_sensitivity.y)

	var new_camera_rot = clamp(cameraArm.rotation_degrees.x - mouse_delta.y,-max_y_rotation,max_y_rotation)
	cameraArm.rotation_degrees.x = new_camera_rot 
	rotation_degrees.y -= mouse_delta.x
	print(cameraArm.rotation_degrees)
	

func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("left","right","up","down")
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	var direction := (transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()	


	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x,0,speed)
		velocity.z = move_toward(velocity.z,0,speed)
	

	move_and_slide()
	
