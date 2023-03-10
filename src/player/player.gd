extends CharacterBody3D
class_name Player

# steps
# have a camera head
# make the camera rotate up and down
# rotate the character left and right
# move
# jump
@onready var cameraArm = $CameraArm
@onready var aimcast := $CameraArm/Gun/GunModel/AimCast
@onready var gunModel := $CameraArm/Gun/GunModel
@onready var currentGun := $CameraArm/Gun

#var velocity = Vector3.ZERO
var speed:= 15.0
var camera_sensitivity := Vector2(13,10)
var max_y_rotation := 70.0
var input_dir:= Vector2.ZERO
var gravity := 10.0
var damage := 10.0
var camera_dir := Vector3.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		update_camera(event.relative)

func update_camera(mouse_delta:Vector2) -> void:
	mouse_delta.x = clamp(mouse_delta.x,-camera_sensitivity.x,camera_sensitivity.x)
	mouse_delta.y = clamp(mouse_delta.y,-camera_sensitivity.y,camera_sensitivity.y)

	var new_camera_rot = clamp(cameraArm.rotation_degrees.x - mouse_delta.y,-max_y_rotation,max_y_rotation)
	cameraArm.rotation_degrees.x = new_camera_rot 
	rotation_degrees.y -= mouse_delta.x
	

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
	
	if Input.is_action_just_pressed("shoot"):
		camera_dir = cameraArm.get_global_transform().basis.z
		currentGun.make_proj(camera_dir)

		#if aimcast.is_colliding():
			#var target = aimcast.get_collider()
			#if target.is_in_group("enemy"):
				#print('hit enemy')
				#target.take_damage(damage)


	move_and_slide()
	
