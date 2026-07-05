extends Node2D

@onready var control: Control = $Camera2D/CanvasLayer/Control

func _ready() -> void:
	control.update_labels()
