extends TextureRect

@export var effect:EffectBase
@export var fading:int = 10
@export var time_label:Label

func _is_empty():
	if effect == null:
		return true
	return effect.effect_time<=0

func _update(delta):
	if effect != null:
		time_label.text = "%.2f" % effect.effect_time
	modulate.a-=delta/float(fading)
