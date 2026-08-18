#  Inventory System for Godot 4

A full-featured inventory system with gamepad support, equipment, and item drops.

## Features

- **Gamepad Support** — Full navigation with controller
- **Equipment System** — Equip/Unequip items
- **Item Dropping** — Drop items into the world
- **Effect System** — Buffs/Debuffs support
- **Custom UI** — 24 sprites, pixel art style
- **Clean Architecture** — Resources + Nodes separation

## Screenshots

| Inventory | Equipment | Drop |
|-----------|-----------|------|
| [screenshot] | [screenshot] | [screenshot] |

## Controls

| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Move | Arrows | LeftStick |
| Equip | Z | B |
| Drop | Escape |X|
| Switch Tab | Space | A |

## Structure
- Custom Classes:

    |Class Name|Parent|Function|
    |------------|--------|--------|
    |BaseItemInfo|Resource|Data about item|
    |EquipableItemInfo|BaseItemInfo|Data about equipable item|
    |ConsumabeItemInfo|BaseItemInfo|Data about consumable item|
    |InventoryCell|Resource|DataCell for BaseItemInfo|
    |EquipmentCell|Resource|DataCell for EquipableItemInfo|
    |Inventory|Resource|Main methods for working with data in the system|
    |InventoryUI|Control|Work with Inventory, InventoryTab,EquipPanel, effect_container(GridContainer) classes|
    |CellBase|Control|Parent for UI cells|
    |InventoryCellUI|CellBase|Contain InventoryCell and methods of its processing|
    |EquipmentCellUI|CellBase|Accepts data of EquipableItemInfo in form of EquipmentCell|
    |InventoryTab|Control|Work with InfoPanel and EquipPanel, create InventoryCellUI for any item in Inventory|
    |InfoPanel|Control| Accept data of BaseItemInfo(this class of data and accepts data as a class and its derivatives)|
    |EquipPanel|GridContainer|Responsible for equipping and displaying character stats|
    |ActionPanel|Control|Responsible for showing keyhints|
- Detailed Script Reference:
    |script_name.gd|type|methods|
    |-----------|----|-------|
    |base_item_info|Data Class| &bull; _init():<br>&emsp;&#9643;`Args: item_id(String), item_name(String), item_icon(Texture2D), item_description(String), item_quantity(int), item_stack(int), item_scene(PackedScene)`|
    |consumable_item_info|Data Class|Vars: effect(EffectBase)<br>&bull; _consume():<br>&emsp;&#9643;`Args: character(Node2D)`|
    |equipable_item_info|Data Class|Vars: equipped(bool), type(Types.types)|
    |inventory_cell|Custom Class|Vars: data(BaseItemInfo), full(bool)<br>&bull; is_empty()<br>&bull; stack():<br>&emsp;&#9643;`Args: count(int)`<br>&bull; _delete_items()<br>&emsp;&#9643;`Args: count(int), all(bool)`|
    |equip_cell|Custom Class|Vars : slot_type(Types.types), equipped_item(BaseItemInfo)<br>&bull; is_empty()|
    |inventory|Custom Class| Vars: cells(Array[InventoryCell]), max_size(int), inventory_changed(signal)<br>&bull; _add_item():<br>&emsp;&#9643;`Args: item_data(BaseItemInfo)`<br>&bull; _find_exist():<br>&emsp;&#9643;`Args: item_data(BaseItemInfo)`<br>&bull; _remove_item():<br>&emsp;&#9643;`Args: item(BaseItemInfo)`<br>&bull; sort_inventory()|
    |inventory_ui|Custom Class| Vars: character(Node2D), inventory(Inventory), inventory_tab(InventoryTab), equipment_tab(EquipPanel), effect_container(GridContainer), cursor_position(Vector2), grid_borders(Array[int])<br>&bull; _cursor_move():<br>&emsp;&#9643;`Args: cursor_pos(Vector2), action(String)`<br>&bull; _update_grid_borders()|
    |cell_base|Custom Class|Vars: icon(TextureRect), cell_sprite(Sprite2D)|
    |inventory_cell_ui|Custom Class|Vars: cell_data(InventoryCell), quantity_label(Label), cell_selected(signal)<br>&bull; _update_ui()<br>&bull; _selected()|
    |equipment_cell_ui|Custom Class|Vars: cell_data(EquipmentCell), count_label(Label), type_texture(Texture2D), cell_selected(signal)<br>&bull; _equip():<br>&emsp;&#9643;`Args: item(BaseItemInfo)<br>&bull; _selected()<br>&bull; _unequip():<br>&emsp;&#9643;`Args: equipping_item(BaseItemInfo)`<br>&bull; try_equip()<br>&emsp;&#9643;`Args: item(BaseItemInfo)`<br>&bull; update_ui()|
    ||||
    ||||
    ||||
    ||||
    ||||
    ||||
    ||||
    ||||
    ||||
