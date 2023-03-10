extends CharacterBody3D

var health := 20.0

func _ready() -> void:
    pass

func _process(delta: float) -> void:
    pass


func take_damage(damage):
    health = max(0, health - damage)
    if health == 0:
        queue_free()
