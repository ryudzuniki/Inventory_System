class_name EquipPanel
extends GridContainer

@export var separation_x:int = 134
@export var separation_y:int = 70

@export var equip_tab:Label

@export var hp:Label
@export var sp:Label
@export var stn:Label
@export var lvl:Label
@export var exp:Label

signal item_equipped(item:EquipableItemInfo)
signal item_unequipped(item:EquipableItemInfo)

func _ready():
	set("theme_override_constants/h_separation", separation_x)
	set("theme_override_constants/v_separation", separation_y)
	equip_tab.sprite.frame = 1

func _info_update(character:Node2D):
	if character != null:
		hp.text = str(character.health_points)
		sp.text = str(character.stamina_points)
		stn.text = str(character.stun_points)
		lvl.text = str(character.level)
		exp.text = str(character.experience)

func _get_cell_to_equip(item:BaseItemInfo):
	for cell in get_children():
		if cell is CellBase:
			var result = cell.try_equip(item)
			if result:
				break
