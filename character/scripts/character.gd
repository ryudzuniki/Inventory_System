extends Node2D

@export var health_points:float
@export var stamina_points:float
@export var stun_points:float
@export var level:float
@export var experience:float
@export var effects:Array[EffectBase]

func _process(delta:float):
	if effects.size()>0:
		for effect in effects:
			effect._update_effect(self, delta)
