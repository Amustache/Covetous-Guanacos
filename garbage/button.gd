extends Button

@onready var animation_player: AnimationPlayer = $"../../../../../../../../AnimationPlayer"
@onready var label: Label = $"../Label"

var iron = 0

func _button_on_pressed() -> void:
	animation_player.play("thing")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	iron += 1
	label.text = "iron: " + str(iron)
