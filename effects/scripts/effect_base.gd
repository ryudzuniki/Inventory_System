class_name EffectBase
extends Resource

@export var effect_name:String
@export var effect_time:float
@export var effect_texture:Texture2D

func _add(character:Node2D):
	for active_effect in character.effects:
		if active_effect.effect_name == effect_name:
			active_effect.effect_time += effect_time
			return
	character.effects.append(self.duplicate())

func _update_effect(character:Node2D, delta_time:float, add_time:float = 0.0):
	if add_time > 0.0:
		effect_time+=add_time
		add_time = 0.0
	effect_time -= delta_time
	if effect_time<=0:
		_delete_effect(character)
		return

func _delete_effect(character:Node2D):
	character.effects.erase(self)
