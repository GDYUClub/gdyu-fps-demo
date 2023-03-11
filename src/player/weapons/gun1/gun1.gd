extends Node3D

@onready var projSpawner = $ProjSpawner 

@onready var player = get_parent().get_parent()
@onready var projScene = preload("res://src/player/weapons/projectile.tscn")
var speed := -0.9
var looking_dir = Vector3.ZERO

var proj_velocity:Vector3 = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func make_proj(gun_dir:Vector3,player_velocity:Vector3):
	var proj := projScene.instantiate()
	proj.position =  projSpawner.global_position
	proj.velocity = gun_dir * speed 
	get_parent().get_parent().get_parent().add_child(proj)
