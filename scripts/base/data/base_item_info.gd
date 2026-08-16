class_name BaseItemInfo
extends Resource

@export var item_id:String
@export var item_name:String
@export var item_icon:Texture2D
@export var item_description:String
@export var item_quantity:int
@export var item_stack:int
@export var item_scene:PackedScene

func _init(
	_item_id: String = "",
	_item_name: String = "",
	_item_icon: Texture2D = null,
	_item_des: String = "",
	_i_quant: int = 0,
	_i_stack: int = 0,
	_item_scene: PackedScene = null,
):
	item_id = _item_id
	item_name = _item_name
	item_icon = _item_icon
	item_description = _item_des
	item_quantity = _i_quant
	item_stack = _i_stack
	item_scene = _item_scene
