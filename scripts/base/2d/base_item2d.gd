extends Node2D
class_name BaseItem2D

@export var data : BaseItemInfo
@export var sprite:Sprite2D

func _ready():
	sprite.texture = data.item_icon
	
