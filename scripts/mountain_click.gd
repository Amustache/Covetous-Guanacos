extends Area2D

@onready var sprite_mountain: Sprite2D = $"../Sprite2D"
@onready var sprite_llama: AnimatedSprite2D = $"../../EvilLlama/AnimatedSprite2D"

@onready var IMPACT_PUNCH_HEAVY_000 = preload("res://assets/sound/impacts/impactPunch_heavy_000.ogg")
@onready var IMPACT_PUNCH_HEAVY_001 = preload("uid://d02uxg8u26usw")
@onready var IMPACT_PUNCH_HEAVY_002 = preload("uid://dnj32af8dfxuo")
@onready var IMPACT_PUNCH_HEAVY_003 = preload("uid://smp4nxbwuvu0")
@onready var IMPACT_PUNCH_HEAVY_004 = preload("uid://c7tjrkejjke8g")
@onready var IMPACT_PUNCH_MEDIUM_000 = preload("uid://7osbtxx13527")
@onready var IMPACT_PUNCH_MEDIUM_001 = preload("uid://blhy1ntw3h1eo")
@onready var IMPACT_PUNCH_MEDIUM_002 = preload("uid://chy1xcwyn3ldq")
@onready var IMPACT_PUNCH_MEDIUM_003 = preload("uid://w7pks5e55cm0")
@onready var IMPACT_PUNCH_MEDIUM_004 = preload("uid://bi1gpnocvqvxl")

@onready var IMPACT_SFX = [
	IMPACT_PUNCH_HEAVY_000,
	IMPACT_PUNCH_HEAVY_001,
	IMPACT_PUNCH_HEAVY_002,
	IMPACT_PUNCH_HEAVY_003,
	IMPACT_PUNCH_HEAVY_004,
	IMPACT_PUNCH_MEDIUM_000,
	IMPACT_PUNCH_MEDIUM_001,
	IMPACT_PUNCH_MEDIUM_002,
	IMPACT_PUNCH_MEDIUM_003,
	IMPACT_PUNCH_MEDIUM_004,
]

@onready var audio_stream_player: AudioStreamPlayer = $"../../AudioStreamPlayer"
@onready var ore_generator_mountain: Node2D = $"../../OreGenerator"
@onready var llama: RigidBody2D = $"../../Llama"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../Llama/AnimatedSprite2D"

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		animated_sprite_2d.play("attack_right")
				#ore_generator_stack.shoot_ore(item)
		#update_labels()


func _on_animated_sprite_2d_frame_changed() -> void:
	match animated_sprite_2d.frame:
		1:
			audio_stream_player.stream = IMPACT_SFX[randi_range(0, len(IMPACT_SFX) - 1)]
			audio_stream_player.play()
	
			for item in GameManager.items:
				if randf() < GameManager.items[item]["prob"]:
					GameManager.items[item]["qt"] += 1
					GameManager.cur_mountain.elevation -= randf()
					ore_generator_mountain.shoot_ore(item)
					
			sprite_mountain.shake_mountain()
			sprite_llama.shake_llama()
