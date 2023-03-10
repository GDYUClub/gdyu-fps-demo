extends Node3D

@onready var projSpawner = $ProjSpawner 

@onready var player = get_parent().get_parent()
@onready var projScene = preload("res://src/player/weapons/projectile.tscn")
var speed := -0.1
var looking_dir = Vector3.ZERO

var proj_velocity:Vector3 = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	pass

func make_proj(gun_dir:Vector3):
	print('proj')
	var proj := projScene.instantiate()
	proj.position =  projSpawner.position
	gun_dir = projSpawner.get_global_transform().basis.z
	proj.velocity = gun_dir * speed 
	get_parent().get_parent().get_parent().get_parent().add_child(proj)
