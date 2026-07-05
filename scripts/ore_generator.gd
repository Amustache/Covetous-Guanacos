extends Node2D

@onready var control: Control = $"../Camera2D/CanvasLayer/Control"
@onready var sprite_2d: Sprite2D = $"../Mountain/Sprite2D"

@export var variation: int = 1
@export var force: int = 1000

func shoot_ore(ore_name: String) -> void:
	var instance = GameManager.items[ore_name]["resource"].instantiate() as RigidBody2D
	add_child(instance)
	instance.global_transform = global_transform
	instance.apply_impulse(Vector2(-250 + randi_range(-25, 25), -500 + randi_range(-25, 25)))
	control.update_labels()
	sprite_2d.shake_mountain()
