class_name Inventory
extends Resource

@export var cells:Array[InventoryCell]
@export var max_size:int

signal inventory_changed

func _ready() -> void:
	for i in range(max_size):
		cells.append(InventoryCell.new())

func _find_exist(item_data:BaseItemInfo):
	for cell in cells:
		if !cell.is_empty():
			if item_data.item_id == cell.data.item_id and !cell.full:
				return cell
	return

func sort_inventory() -> void:
	# Сортируем: сначала непустые, потом пустые
	cells.sort_custom(func(a: InventoryCell, b: InventoryCell) -> bool:
		if a.is_empty() and not b.is_empty():
			return false
		if not a.is_empty() and b.is_empty():
			return true
		return false
	)
	inventory_changed.emit()
func _add_item(item_data:BaseItemInfo):
	var cl = _find_exist(item_data)
	if cl!=null:
		var mod = cl.stack(item_data)
		if mod == 0:
			return
		else:
			item_data.item_quantity =  mod
			_add_item(item_data)
			emit_signal("inventory_changed")
	
	for cell in cells:
		if cell.is_empty():
			cell.data = item_data
			return
	print("Inventory is full")

func _remove_item(item:BaseItemInfo):
	for cell in cells:
		if cell.data == item:
			cell.data = null
			sort_inventory()
			break
