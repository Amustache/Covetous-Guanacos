extends Node2D

@onready var area_2d: Area2D = $Area2D

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("yeys")


func _on_area_2d_mouse_entered() -> void:
	print("yeys3")


func _on_area_2d_mouse_exited() -> void:
	print("yeys33")
