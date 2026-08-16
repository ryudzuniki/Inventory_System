class_name InventoryTab
extends Control

@export var cell_scene:PackedScene
@export var cell_grid:GridContainer
@export var separation:int = 64

@export var info_panel:InfoPanel
@export var equip_panel:EquipPanel

enum InventoryTabs{InfoTab, EquipTab}
@export var currentTab:InventoryTabs = InventoryTabs.InfoTab

signal item_consumed()

var character:Node2D

var current_cell
var inventory:Inventory
var info_cells = []
var advanced_cells = []

func _setup_grid() -> void:
	cell_grid.custom_minimum_size = Vector2(64.0,64.0)
	cell_grid.set("theme_override_constants/h_separation", separation)
	cell_grid.set("theme_override_constants/v_separation", separation)
	inventory.inventory_changed.connect(refresh)
	refresh()
	_focused_cell(Vector2.ZERO, true)

func refresh():
	var perf_inf = int(inventory.max_size/10.0)*10
	if perf_inf != inventory.max_size:
		inventory.max_size = (floor(inventory.max_size/10.0)+cell_grid.columns/10.0)*10.0
	if cell_grid.get_child_count()==0:
		for i in range(inventory.max_size):
			var cell = cell_scene.instantiate()
			cell.cell_data = InventoryCell.new()
			if inventory.cells.size()-1<i:
				inventory.cells.append(InventoryCell.new())
			cell.cell_data.data = inventory.cells[i].data
			cell_grid.add_child(cell)
			cell.cell_selected.connect(info_panel._show_info)
	else:
		for i in range(inventory.max_size):
			if inventory.cells.size()-1>i:
				cell_grid.get_child(i).cell_data = inventory.cells[i]
			else:
				cell_grid.get_child(i).cell_data = null
			cell_grid.get_child(i)._update_ui()

func _process(_delta:float)->void:
	match currentTab:
		InventoryTabs.EquipTab:
			info_panel.visible = false
			equip_panel.visible = true
			_update()
		InventoryTabs.InfoTab:
			equip_panel.visible = false
			info_panel.visible = true

func _input(event:InputEvent):
	if Input.is_action_just_pressed("ui_accept"):
		currentTab = InventoryTabs.EquipTab if currentTab == InventoryTabs.InfoTab else InventoryTabs.InfoTab
	if current_cell!=null:
		if event.get_action_strength("eq")>0.7:
			if current_cell is InventoryCellUI:
				if !current_cell.cell_data.is_empty():
					if current_cell.cell_data.data is EquipableItemInfo:
						currentTab = InventoryTabs.EquipTab
						equip_panel._get_cell_to_equip(current_cell.cell_data.data)
					else:
						current_cell.cell_data.data._consume(character)
						inventory.sort_inventory()
			else:
				if !current_cell.cell_data.is_empty():
					current_cell._unequip()
		if event.get_action_strength("ui_cancel")>0.7 and current_cell.cell_data.data.item_scene != null:
				_throw()
func _update():
	for cell in cell_grid.get_children():
		cell._update_ui()

func _focused_cell(cursor_pos : Vector2 = Vector2.ZERO, setup = false):
	if currentTab == InventoryTabs.InfoTab:
		if info_cells.is_empty():
			var raw = []
			for child in cell_grid.get_children():
				raw.append(child)
				if raw.size()==cell_grid.columns:
					info_cells.append(raw)
					raw = []
		if advanced_cells.is_empty():
			advanced_cells.append_array(info_cells)
			var raw = []
			for child in equip_panel.get_children():
				if child is CellBase:
					raw.append(child)
				if raw.size()>equip_panel.columns-1:
					advanced_cells.append(raw)
					raw = []
		if !setup:
			if current_cell:
				current_cell.cell_sprite.frame = 0
			current_cell = info_cells[int(cursor_pos.y)][int(cursor_pos.x)]
			current_cell._selected()
	else:
		if current_cell:
			current_cell.cell_sprite.frame = 0
		current_cell = advanced_cells[int(cursor_pos.y)][int(cursor_pos.x)]
		current_cell._selected()

func _throw():
	var item = current_cell.cell_data.data.item_scene.instantiate()
	item.data = current_cell.cell_data.data
	get_tree().current_scene.add_child(item)
	inventory._remove_item(current_cell.cell_data.data)
	return
