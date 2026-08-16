class_name InventoryCellUI
extends CellBase

@export var cell_data:InventoryCell

@export var quantity_label:Label

signal cell_selected(cell: BaseItemInfo)

func _update_ui():
	if cell_data == null or cell_data.is_empty():
		icon.texture = null
		quantity_label.text = ""
		return
	icon.texture = cell_data.data.item_icon
	quantity_label.text = str(cell_data.data.item_quantity)

func _selected():
	cell_sprite.frame = 1
	if cell_data != null:
		if !cell_data.is_empty():
			cell_selected.emit(cell_data.data)
			return
	_update_ui()
	get_parent().get_parent().info_panel._empty()
		
