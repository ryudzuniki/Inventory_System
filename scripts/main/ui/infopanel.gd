class_name InfoPanel
extends Control

@export var item_icon:TextureRect
@export var item_name:Label
@export var item_desc:Label
@export var info_tab:Label

@export var action_panel:Control

func _ready():
	info_tab.sprite.frame = 1
func _empty():
	action_panel._empty()
	item_icon.texture = null
	item_name.text = ''
	item_desc.text = ''

func _show_info(data:BaseItemInfo):
	action_panel._update(data)
	item_icon.texture = data.item_icon
	item_name.text  = data.item_name
	item_desc.text = data.item_description
