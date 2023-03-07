extends Node3D

@onready var projSpawner = $ProjSpawner 
@onready var projScene = preload("res://src/player/weapons/projectile.tscn")
var speed := 5.0
var looking_dir = Vector3.ZERO

var proj_velocity:Vector3 = Vector3.ZERO

@onready var player:Player = get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		make_proj()

func make_proj():
	looking_dir = global_position - player.global_position 
	var proj := projScene.instantiate()
	proj.velocity = looking_dir * speed 
	get_tree().get_root().add_child(proj)
