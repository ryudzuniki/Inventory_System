class_name EquipmentCell
extends Resource

@export var slot_type : Types.types
@export var equipped_item: BaseItemInfo = null

func is_empty() -> bool:
	return equipped_item == null
