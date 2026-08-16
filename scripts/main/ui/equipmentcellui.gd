class_name EquipmentCellUI
extends CellBase

@export var cell_data: EquipmentCell
@export var slot_type_label:Label
@export var type_sprite:Sprite2D
@export var type_texture:Texture2D
signal cell_selected(cell: BaseItemInfo)

func _ready():
	update_ui()
	if type_texture == null:
		match cell_data.slot_type:
			Types.types.Melee_Weapon:
				type_texture = preload("res://addons/inventory_system/assets/icons/melee_cell_icon.png") as Texture2D
			Types.types.Artefact:
				type_texture = preload("res://addons/inventory_system/assets/icons/artefact_cell_icon.png") as Texture2D
			Types.types.Ammunition:
				type_texture = preload("res://addons/inventory_system/assets/icons/ammunition_cell_icon.png") as Texture2D
			Types.types.Ranged_Weapon:
				type_texture = preload("res://addons/inventory_system/assets/icons/ranged_cell_icon.png") as Texture2D
			Types.types.Addictional_Equipment:
				type_texture = preload("res://addons/inventory_system/assets/icons/addictional_cell_icon.png") as Texture2D
			Types.types.Decorative:
				type_texture = preload("res://addons/inventory_system/assets/icons/fastheal_cell_icon.png") as Texture2D
			Types.types.Propelling_Weapon:
				type_texture = preload("res://addons/inventory_system/assets/icons/propelling_cell_icon.png") as Texture2D
	
	type_sprite.texture = type_texture
func update_ui():
	if cell_data == null or cell_data.is_empty():
		icon.texture = null
		type_sprite.visible = true
		slot_type_label.text = ''
		return
	if cell_data.slot_type in [Types.types.Ammunition]:
		slot_type_label.text = str(cell_data.equipped_item.item_quantity)
	icon.texture = cell_data.equipped_item.item_icon
	type_sprite.visible = false

func try_equip(item: BaseItemInfo):
	if item == null:
		return false
	if item.type == cell_data.slot_type:
		if cell_data.is_empty():
			_equip(item)
		else:
			_unequip(item)
		return true
	return false
func _equip(item:BaseItemInfo):
	cell_data.equipped_item = item
	update_ui()
	get_parent().item_equipped.emit(item)

func _unequip(equiping_item:BaseItemInfo = null):
	if equiping_item == null:
		var data = cell_data.equipped_item
		get_parent().item_unequipped.emit(data)
		cell_data.equipped_item = null
	else:
		_equip(equiping_item)
	update_ui()

func _selected():
	cell_sprite.frame = 1
	if cell_data != null:
		if !cell_data.is_empty():
			cell_selected.emit(cell_data.equipped_item)
			return
	get_parent().get_parent().info_panel._empty()
