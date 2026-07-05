extends Node2D

@onready var COPPER_SCENE: Resource = preload("res://scenes/ores/copper.tscn")
@onready var GOLD_SCENE: Resource = preload("res://scenes/ores/gold.tscn")
@onready var IRON_SCENE: Resource = preload("res://scenes/ores/iron.tscn")
@onready var ROCK_SCENE: Resource = preload("res://scenes/ores/rock.tscn")
@onready var SILVER_SCENE: Resource = preload("res://scenes/ores/silver.tscn")


@onready var ores_parent: Node2D = $Ores
@onready var ores_generator: Node2D = $generator

@onready var BASE_ITEM = {
	rock = {prob = 0.75, resource = ROCK_SCENE},
	iron = {prob = 0.21, resource = IRON_SCENE},
	copper = {prob = 0.19, resource = COPPER_SCENE},
	silver = {prob = 0.08, resource = SILVER_SCENE},
	gold = {prob = 0.05, resource = GOLD_SCENE},
}
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		for item in BASE_ITEM:
			if randf() < BASE_ITEM[item]["prob"]:
				var instance = BASE_ITEM[item]["resource"].instantiate() as RigidBody2D
				ores_parent.add_child(instance)
				instance.global_position = ores_generator.global_position
				var applied_force = Vector2(randi_range(2, 3), -randi_range(2, 3)) * 1000
				instance.apply_force(applied_force)
