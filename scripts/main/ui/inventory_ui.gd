class_name InventoryUI
extends Control

@export var character:Node2D

@export var inventory:Inventory

@export var inventory_tab:InventoryTab
@export var equipment_tab:EquipPanel
@export var effect_container:GridContainer

var cursor_position:Vector2= Vector2.ZERO
var grid_borders=[]

func _ready() -> void:
	inventory_tab.inventory = inventory
	effect_container.character = character
	equipment_tab.item_equipped.connect(inventory._remove_item)
	equipment_tab.item_unequipped.connect(inventory._add_item)
	inventory_tab._setup_grid()
	inventory_tab.character = character
	inventory_tab._update()

func _cursor_move(cursor_pos, action):
	equipment_tab._info_update(character)
	match action:
				"ui_down":
					if cursor_pos.y<grid_borders.size()-1 and (cursor_pos.x<3 or cursor_pos.y != inventory_tab.info_cells.size()-1):
						cursor_pos.y+=1
					else:
						cursor_pos.y=0
				"ui_up":
					if cursor_pos.y>0 and cursor_pos.x<3:
						cursor_pos.y-=1
					else:
						cursor_pos.y = grid_borders.size()-1
						cursor_pos.x = 0
				"ui_left":
					if cursor_pos.x > 0:
						cursor_pos.x-=1
					else:
						if cursor_pos.y>0:
							cursor_pos.y-=1
							cursor_pos.x = grid_borders[cursor_pos.y] 
						else:
							cursor_pos.y = grid_borders.size()-1
							cursor_pos.x = grid_borders[cursor_pos.y] 
				"ui_right":
					if cursor_pos.x < grid_borders[cursor_pos.y]:
						cursor_pos.x+=1
					else:
						if cursor_pos.y<grid_borders.size()-1:
							cursor_pos.y+=1
							cursor_pos.x=0
						else:
							cursor_pos = Vector2.ZERO
	return cursor_pos

func _update_grid_borders():
	var borders = []
	for raw in range(inventory_tab.info_cells.size()):
		borders.append(inventory_tab.info_cells[raw].size()-1)
	if inventory_tab.currentTab == inventory_tab.InventoryTabs.EquipTab:
		for raw in range(inventory_tab.advanced_cells.size()):
			if raw>inventory_tab.info_cells.size()-1:
				borders.append(inventory_tab.advanced_cells[raw].size()-1)
	return borders

func _input(event: InputEvent) -> void:
	grid_borders = _update_grid_borders()
	for action in ["ui_down", "ui_up", "ui_left", "ui_right"]:
		if event.is_action(action) and event.get_action_strength(action)>0.7:
			cursor_position = _cursor_move(cursor_position, action)
		inventory_tab._focused_cell(cursor_position)
