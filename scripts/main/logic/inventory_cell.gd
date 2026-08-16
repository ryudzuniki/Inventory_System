class_name InventoryCell
extends Resource

@export var data: BaseItemInfo

var full = false

func is_empty():
	return data == null or data.item_quantity <= 0

func stack(count=1):
	if data.item_stack>count+data.item_quantity:
		data.item_quantity+=count
		full = false
	else:
		data.item_quantity = data.item_stack
		full = true
		return count-data.item_stack
	return 0

func _delete_items(count = 0, all = false):
	if all or data.item_quantity<count:
		data = null
		full = false
		return
	data.item_quantity-= count
	
