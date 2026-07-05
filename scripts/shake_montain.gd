extends Sprite2D

func shake_mountain():
	var tween = create_tween()
	scale = Vector2(0.9, 0.9)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	
	tween.tween_property(self, "scale", Vector2(1,1), 0.25)
	tween.parallel().tween_property(self, "position:y", 0.1, 0.25).as_relative()
