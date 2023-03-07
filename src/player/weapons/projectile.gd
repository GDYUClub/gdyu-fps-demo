extends Area3D

# get angle of camera
# use that as velocity * speed
# reduce with gravity 
# Called when the node enters the scene tree for the first time.
var velocity:Vector3 = Vector3.ZERO

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position += velocity