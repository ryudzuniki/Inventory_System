class_name ConsumableItemInfo
extends BaseItemInfo

@export var effect:EffectBase

func _consume(character:Node2D):
	if item_quantity > 0:
		item_quantity-=1
		effect._add(character)
