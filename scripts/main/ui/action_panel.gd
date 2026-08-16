class_name ActionPanel
extends Control

@export var _uselabel:Label
@export var _throwlabel:Label
func _empty():
	visible = false

func _update(data:BaseItemInfo):
	var hints = [KHG.get_action_text("ui_cancel"), KHG.get_action_text("eq")]
	print("Equip: " + KHG.get_action_text("eq"), "Throw:" + KHG.get_action_text("ui_cancel"))
	visible = true
	_throwlabel.text = "Throw" + "["+hints[0]+"]"
	if data is ConsumableItemInfo:
		_uselabel.text = "Consume" + "["+hints[1]+"]"
		return
	else:
		_uselabel.text = "Equip" + "["+hints[1]+"]" if !data.equipped else "Unequip" + "["+KHG.get_action_text("eq")+"]"
		return
	
