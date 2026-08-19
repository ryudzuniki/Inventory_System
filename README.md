# Inventory System for Godot 4

- [English](#english)
- [Русский](#russian)
- [日本語](#japanese)

---

<a name="english"></a>
## English

A full-featured inventory system with gamepad support, equipment, and item drops.

### Features
- **Gamepad Support** — Full navigation with controller
- **Equipment System** — Equip/Unequip items
- **Item Dropping** — Drop items into the world
- **Effect System** — Buffs/Debuffs support
- **Custom UI** — 24 sprites, pixel art style
- **Clean Architecture** — Resources + Nodes separation

### Controls

| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Move | Arrows | LeftStick |
| Equip | Z | B |
| Drop | Escape | X |
| Switch Tab | Space | A |

### Structure

#### Custom Classes

| Class Name | Parent | Description |
|------------|--------|-------------|
| BaseItemInfo | Resource | Base data for any item |
| EquipableItemInfo | BaseItemInfo | Data for equippable items |
| ConsumableItemInfo | BaseItemInfo | Data for consumable items (with effect) |
| InventoryCell | Resource | Cell data for inventory (holds BaseItemInfo) |
| EquipmentCell | Resource | Cell data for equipment slots (holds EquipableItemInfo) |
| Inventory | Resource | Main inventory data manager |
| InventoryUI | Control | Main UI controller (ties all panels) |
| CellBase | Control | Base class for UI cells |
| InventoryCellUI | CellBase | UI cell for inventory grid |
| EquipmentCellUI | CellBase | UI cell for equipment slots |
| InventoryTab | Control | Manages inventory grid and switching tabs |
| InfoPanel | Control | Displays item info and action hints |
| EquipPanel | GridContainer | Equipment grid + character stats |
| ActionPanel | Control | Shows key hints for actions |
| EffectBase | Resource | Base effect data |
| Types | Node | Enum of item types |

#### Detailed Script Reference

| Script Name | Type | Properties | Methods |
|-------------|------|------------|---------|
| `action_panel.gd` | Control (ActionPanel) | `_uselabel: Label`, `_throwlabel: Label` | `_empty()`<br>`_update(data: BaseItemInfo)` |
| `effect_cell.gd` | TextureRect | `effect: EffectBase`, `fading: int`, `time_label: Label` | `_is_empty() -> bool`<br>`_update(delta: float)` |
| `effect_container.gd` | GridContainer | `effect_cell_scene: PackedScene`, `character: Node2D`, `last_size_effects: int` | `_create_grid()`<br>`_update_cells(delta: float)`<br>`_update_grid()`<br>`_clear_grid()`<br>`_process(delta: float)` |
| `equip_panel.gd` | GridContainer (EquipPanel) | `separation_x: int`, `separation_y: int`, `equip_tab: Label`, `hp, sp, stn, lvl, exp: Label`<br>**signals:** `item_equipped(item: EquipableItemInfo)`, `item_unequipped(item: EquipableItemInfo)` | `_ready()`<br>`_info_update(character: Node2D)`<br>`_get_cell_to_equip(item: BaseItemInfo)` |
| `equipment_cell_ui.gd` | CellBase (EquipmentCellUI) | `cell_data: EquipmentCell`, `count_label: Label`, `type_sprite: Sprite2D`, `type_texture: Texture2D`<br>**signal:** `cell_selected(cell: BaseItemInfo)` | `_ready()`<br>`update_ui()`<br>`try_equip(item: BaseItemInfo) -> bool`<br>`_equip(item: BaseItemInfo)`<br>`_unequip(equiping_item: BaseItemInfo = null)`<br>`_selected()` |
| `infopanel.gd` | Control (InfoPanel) | `item_icon: TextureRect`, `item_name: Label`, `item_desc: Label`, `info_tab: Label`, `action_panel: Control` | `_ready()`<br>`_empty()`<br>`_show_info(data: BaseItemInfo)` |
| `inventory_cell_ui.gd` | CellBase (InventoryCellUI) | `cell_data: InventoryCell`, `quantity_label: Label`<br>**signal:** `cell_selected(cell: BaseItemInfo)` | `_update_ui()`<br>`_selected()` |
| `inventory_tab.gd` | Control (InventoryTab) | `cell_scene: PackedScene`, `cell_grid: GridContainer`, `separation: int`, `info_panel: InfoPanel`, `equip_panel: EquipPanel`, `currentTab: InventoryTabs`, `character: Node2D`, `current_cell: CellBase`, `inventory: Inventory`, `info_cells: Array`, `advanced_cells: Array`<br>**signal:** `item_consumed()` | `_setup_grid()`<br>`refresh()`<br>`_process(_delta: float)`<br>`_input(event: InputEvent)`<br>`_update()`<br>`_focused_cell(cursor_pos: Vector2 = Vector2.ZERO, setup = false)`<br>`_throw()` |
| `inventory_ui.gd` | Control (InventoryUI) | `character: Node2D`, `inventory: Inventory`, `inventory_tab: InventoryTab`, `equipment_tab: EquipPanel`, `effect_container: GridContainer`, `cursor_position: Vector2`, `grid_borders: Array` | `_ready()`<br>`_cursor_move(cursor_pos: Vector2, action: String) -> Vector2`<br>`_update_grid_borders() -> Array`<br>`_input(event: InputEvent)` |
| `tab.gd` | Label | `sprite: Sprite2D` | *(none)* |
| `cell_base.gd` | Control (CellBase) | `icon: TextureRect`, `cell_sprite: Sprite2D` | *(none)* |
| `equip_cell.gd` | Resource (EquipmentCell) | `slot_type: Types.types`, `equipped_item: BaseItemInfo` | `is_empty() -> bool` |
| `inventory.gd` | Resource (Inventory) | `cells: Array[InventoryCell]`, `max_size: int`<br>**signal:** `inventory_changed` | `_ready()`<br>`_find_exist(item_data: BaseItemInfo) -> InventoryCell`<br>`sort_inventory()`<br>`_add_item(item_data: BaseItemInfo)`<br>`_remove_item(item: BaseItemInfo)` |
| `inventory_cell.gd` | Resource (InventoryCell) | `data: BaseItemInfo`, `full: bool` | `is_empty() -> bool`<br>`stack(count: int = 1) -> int`<br>`_delete_items(count: int = 0, all: bool = false)` |
| `base_item_info.gd` | Resource (BaseItemInfo) | `item_id: String`, `item_name: String`, `item_icon: Texture2D`, `item_description: String`, `item_quantity: int`, `item_stack: int`, `item_scene: PackedScene` | `_init(_item_id: String = "", _item_name: String = "", _item_icon: Texture2D = null, _item_des: String = "", _i_quant: int = 0, _i_stack: int = 0, _item_scene: PackedScene = null)` |
| `consumable_item_info.gd` | Resource (ConsumableItemInfo) | `effect: EffectBase` | `_consume(character: Node2D)` |
| `equipable_item_info.gd` | Resource (EquipableItemInfo) | `equipped: bool`, `type: Types.types` | *(inherits BaseItemInfo)* |
| `key_hint_generator.gd` | Node(Singleton) | *(none)* | `get_action_text(action_name: String) -> String`<br>`_get_joypad_name(button: int) -> String` |
| `types.gd` | Node(Singleton) | `enum types { Melee_Weapon, Ranged_Weapon, Addictional_Equipment, Ammunition, Artefact, Propelling_Weapon, Decorative }` | *(none)* |
| `character.gd` | Node2D | `health_points: float`, `stamina_points: float`, `stun_points: float`, `level: float`, `experience: float`, `effects: Array[EffectBase]` | `_process(delta: float)` |
| `effect_base.gd` | Resource (EffectBase) | `effect_name: String`, `effect_time: float`, `effect_texture: Texture2D` | `_add(character: Node2D)`<br>`_update_effect(character: Node2D, delta_time: float, add_time: float = 0.0)`<br>`_delete_effect(character: Node2D)` |

#### Detailed Documentation

**BaseItemInfo** (Resource)  
Base data container for all items.  
- Properties: `item_id`, `item_name`, `item_icon`, `item_description`, `item_quantity`, `item_stack`, `item_scene`.  
- Constructor: `_init(...)` – all optional.

**EquipableItemInfo** (BaseItemInfo)  
Extends base with equipment‑specific data.  
- Additional properties: `equipped: bool`, `type: Types.types`.

**ConsumableItemInfo** (BaseItemInfo)  
Extends base with effect application.  
- Additional property: `effect: EffectBase`.  
- Method: `_consume(character: Node2D)` – applies effect to character and decreases quantity.

**InventoryCell** (Resource)  
Stores a single inventory slot.  
- Properties: `data: BaseItemInfo`, `full: bool`.  
- Methods: `is_empty() -> bool`, `stack(count: int = 1) -> int` (returns remainder), `_delete_items(count: int = 0, all: bool = false)`.

**EquipmentCell** (Resource)  
Stores a single equipment slot.  
- Properties: `slot_type: Types.types`, `equipped_item: BaseItemInfo`.  
- Method: `is_empty() -> bool`.

**Inventory** (Resource)  
Manages the inventory data (add, remove, sort).  
- Properties: `cells: Array[InventoryCell]`, `max_size: int`.  
- Signal: `inventory_changed`.  
- Methods: `_add_item(item_data: BaseItemInfo)`, `_remove_item(item: BaseItemInfo)`, `sort_inventory()`, `_find_exist(item_data: BaseItemInfo) -> InventoryCell`.

**InventoryUI** (Control)  
Top‑level UI controller.  
- Properties: `character`, `inventory`, `inventory_tab`, `equipment_tab`, `effect_container`, `cursor_position`, `grid_borders`.  
- Methods: `_ready()`, `_cursor_move(cursor_pos: Vector2, action: String) -> Vector2`, `_update_grid_borders() -> Array`, `_input(event: InputEvent)`.

**InventoryTab** (Control)  
Manages the inventory grid and tab switching.  
- Properties: `cell_scene`, `cell_grid`, `separation`, `info_panel`, `equip_panel`, `currentTab`, `character`, `current_cell`, `inventory`, `info_cells`, `advanced_cells`.  
- Signal: `item_consumed()`.  
- Methods: `_setup_grid()`, `refresh()`, `_process(_delta: float)`, `_input(event: InputEvent)`, `_update()`, `_focused_cell(cursor_pos: Vector2 = Vector2.ZERO, setup = false)`, `_throw()`.

**InfoPanel** (Control)  
Displays item details and action hints.  
- Properties: `item_icon`, `item_name`, `item_desc`, `info_tab`, `action_panel`.  
- Methods: `_empty()`, `_show_info(data: BaseItemInfo)`.

**EquipPanel** (GridContainer)  
Shows equipment slots and character stats.  
- Properties: `separation_x`, `separation_y`, `equip_tab`, `hp`, `sp`, `stn`, `lvl`, `exp`.  
- Signals: `item_equipped(item: EquipableItemInfo)`, `item_unequipped(item: EquipableItemInfo)`.  
- Methods: `_ready()`, `_info_update(character: Node2D)`, `_get_cell_to_equip(item: BaseItemInfo)`.

**ActionPanel** (Control)  
Displays contextual key hints.  
- Properties: `_uselabel: Label`, `_throwlabel: Label`.  
- Methods: `_empty()`, `_update(data: BaseItemInfo)`.

**EffectBase** (Resource)  
Base effect logic.  
- Properties: `effect_name`, `effect_time`, `effect_texture`.  
- Methods: `_add(character: Node2D)`, `_update_effect(character: Node2D, delta_time: float, add_time: float = 0.0)`, `_delete_effect(character: Node2D)`.

**CellBase** (Control)  
Base class for UI cells.  
- Properties: `icon: TextureRect`, `cell_sprite: Sprite2D`.

**InventoryCellUI** (CellBase)  
UI representation of an inventory cell.  
- Properties: `cell_data: InventoryCell`, `quantity_label: Label`.  
- Signal: `cell_selected(cell: BaseItemInfo)`.  
- Methods: `_update_ui()`, `_selected()`.

**EquipmentCellUI** (CellBase)  
UI representation of an equipment cell.  
- Properties: `cell_data: EquipmentCell`, `count_label: Label`, `type_sprite: Sprite2D`, `type_texture: Texture2D`.  
- Signal: `cell_selected(cell: BaseItemInfo)`.  
- Methods: `_ready()`, `update_ui()`, `try_equip(item: BaseItemInfo) -> bool`, `_equip(item: BaseItemInfo)`, `_unequip(equiping_item: BaseItemInfo = null)`, `_selected()`.

**effect_cell.gd** (TextureRect)  
Displays a single active effect.  
- Properties: `effect: EffectBase`, `fading: int`, `time_label: Label`.  
- Methods: `_is_empty() -> bool`, `_update(delta: float)`.

**effect_container.gd** (GridContainer)  
Manages the effect cells for a character.  
- Properties: `effect_cell_scene: PackedScene`, `character: Node2D`, `last_size_effects: int`.  
- Methods: `_create_grid()`, `_update_cells(delta: float)`, `_update_grid()`, `_clear_grid()`, `_process(delta: float)`.

**key_hint_generator.gd** (Node)  
Utility for getting readable action names.  
- Methods: `get_action_text(action_name: String) -> String`, `_get_joypad_name(button: int) -> String`.

**types.gd** (Node)  
Holds the `types` enum: `Melee_Weapon`, `Ranged_Weapon`, `Addictional_Equipment`, `Ammunition`, `Artefact`, `Propelling_Weapon`, `Decorative`.

**character.gd** (Node2D)  
Character stats and active effects.  
- Properties: `health_points`, `stamina_points`, `stun_points`, `level`, `experience`, `effects: Array[EffectBase]`.  
- Method: `_process(delta: float)` – updates all active effects.

**tab.gd** (Label)  
Simple label with a sprite reference.  
- Property: `sprite: Sprite2D`.

---

<a name="russian"></a>
## Русский

Полнофункциональная система инвентаря с поддержкой геймпада, экипировкой и выбрасыванием предметов.

### Возможности
- **Поддержка геймпада** — полная навигация с контроллера
- **Система экипировки** — надевание/снятие предметов
- **Выбрасывание предметов** — выброс в игровой мир
- **Система эффектов** — поддержка баффов/дебаффов
- **Пользовательский UI** — 24 спрайта в пиксельном стиле
- **Чистая архитектура** — разделение на ресурсы и узлы

### Управление

| Действие | Клавиатура | Геймпад |
|----------|------------|---------|
| Движение | Стрелки | Левый стик |
| Экипировать | Z | B |
| Выбросить | Escape | X |
| Переключить вкладку | Space | A |

### Структура

#### Пользовательские классы

| Имя класса | Родитель | Описание |
|------------|----------|----------|
| BaseItemInfo | Resource | Базовые данные предмета |
| EquipableItemInfo | BaseItemInfo | Данные для экипируемых предметов |
| ConsumableItemInfo | BaseItemInfo | Данные для расходуемых предметов (с эффектом) |
| InventoryCell | Resource | Ячейка инвентаря (хранит BaseItemInfo) |
| EquipmentCell | Resource | Ячейка слота экипировки (хранит EquipableItemInfo) |
| Inventory | Resource | Основной менеджер данных инвентаря |
| InventoryUI | Control | Главный контроллер UI (связывает все панели) |
| CellBase | Control | Базовый класс для UI-ячеек |
| InventoryCellUI | CellBase | UI-ячейка для сетки инвентаря |
| EquipmentCellUI | CellBase | UI-ячейка для слотов экипировки |
| InventoryTab | Control | Управляет сеткой инвентаря и переключением вкладок |
| InfoPanel | Control | Отображает информацию о предмете и подсказки действий |
| EquipPanel | GridContainer | Сетка экипировки + статы персонажа |
| ActionPanel | Control | Показывает подсказки клавиш для действий |
| EffectBase | Resource | Базовые данные эффекта |
| Types | Node | Перечисление типов предметов |

#### Подробная справка по скриптам

| Имя скрипта | Тип | Свойства | Методы |
|-------------|-----|----------|--------|
| `action_panel.gd` | Control (ActionPanel) | `_uselabel: Label`, `_throwlabel: Label` | `_empty()`<br>`_update(data: BaseItemInfo)` |
| `effect_cell.gd` | TextureRect | `effect: EffectBase`, `fading: int`, `time_label: Label` | `_is_empty() -> bool`<br>`_update(delta: float)` |
| `effect_container.gd` | GridContainer | `effect_cell_scene: PackedScene`, `character: Node2D`, `last_size_effects: int` | `_create_grid()`<br>`_update_cells(delta: float)`<br>`_update_grid()`<br>`_clear_grid()`<br>`_process(delta: float)` |
| `equip_panel.gd` | GridContainer (EquipPanel) | `separation_x: int`, `separation_y: int`, `equip_tab: Label`, `hp, sp, stn, lvl, exp: Label`<br>**сигналы:** `item_equipped(item: EquipableItemInfo)`, `item_unequipped(item: EquipableItemInfo)` | `_ready()`<br>`_info_update(character: Node2D)`<br>`_get_cell_to_equip(item: BaseItemInfo)` |
| `equipment_cell_ui.gd` | CellBase (EquipmentCellUI) | `cell_data: EquipmentCell`, `count_label: Label`, `type_sprite: Sprite2D`, `type_texture: Texture2D`<br>**сигнал:** `cell_selected(cell: BaseItemInfo)` | `_ready()`<br>`update_ui()`<br>`try_equip(item: BaseItemInfo) -> bool`<br>`_equip(item: BaseItemInfo)`<br>`_unequip(equiping_item: BaseItemInfo = null)`<br>`_selected()` |
| `infopanel.gd` | Control (InfoPanel) | `item_icon: TextureRect`, `item_name: Label`, `item_desc: Label`, `info_tab: Label`, `action_panel: Control` | `_ready()`<br>`_empty()`<br>`_show_info(data: BaseItemInfo)` |
| `inventory_cell_ui.gd` | CellBase (InventoryCellUI) | `cell_data: InventoryCell`, `quantity_label: Label`<br>**сигнал:** `cell_selected(cell: BaseItemInfo)` | `_update_ui()`<br>`_selected()` |
| `inventory_tab.gd` | Control (InventoryTab) | `cell_scene: PackedScene`, `cell_grid: GridContainer`, `separation: int`, `info_panel: InfoPanel`, `equip_panel: EquipPanel`, `currentTab: InventoryTabs`, `character: Node2D`, `current_cell: CellBase`, `inventory: Inventory`, `info_cells: Array`, `advanced_cells: Array`<br>**сигнал:** `item_consumed()` | `_setup_grid()`<br>`refresh()`<br>`_process(_delta: float)`<br>`_input(event: InputEvent)`<br>`_update()`<br>`_focused_cell(cursor_pos: Vector2 = Vector2.ZERO, setup = false)`<br>`_throw()` |
| `inventory_ui.gd` | Control (InventoryUI) | `character: Node2D`, `inventory: Inventory`, `inventory_tab: InventoryTab`, `equipment_tab: EquipPanel`, `effect_container: GridContainer`, `cursor_position: Vector2`, `grid_borders: Array` | `_ready()`<br>`_cursor_move(cursor_pos: Vector2, action: String) -> Vector2`<br>`_update_grid_borders() -> Array`<br>`_input(event: InputEvent)` |
| `tab.gd` | Label | `sprite: Sprite2D` | *(нет)* |
| `cell_base.gd` | Control (CellBase) | `icon: TextureRect`, `cell_sprite: Sprite2D` | *(нет)* |
| `equip_cell.gd` | Resource (EquipmentCell) | `slot_type: Types.types`, `equipped_item: BaseItemInfo` | `is_empty() -> bool` |
| `inventory.gd` | Resource (Inventory) | `cells: Array[InventoryCell]`, `max_size: int`<br>**сигнал:** `inventory_changed` | `_ready()`<br>`_find_exist(item_data: BaseItemInfo) -> InventoryCell`<br>`sort_inventory()`<br>`_add_item(item_data: BaseItemInfo)`<br>`_remove_item(item: BaseItemInfo)` |
| `inventory_cell.gd` | Resource (InventoryCell) | `data: BaseItemInfo`, `full: bool` | `is_empty() -> bool`<br>`stack(count: int = 1) -> int`<br>`_delete_items(count: int = 0, all: bool = false)` |
| `base_item_info.gd` | Resource (BaseItemInfo) | `item_id: String`, `item_name: String`, `item_icon: Texture2D`, `item_description: String`, `item_quantity: int`, `item_stack: int`, `item_scene: PackedScene` | `_init(_item_id: String = "", _item_name: String = "", _item_icon: Texture2D = null, _item_des: String = "", _i_quant: int = 0, _i_stack: int = 0, _item_scene: PackedScene = null)` |
| `consumable_item_info.gd` | Resource (ConsumableItemInfo) | `effect: EffectBase` | `_consume(character: Node2D)` |
| `equipable_item_info.gd` | Resource (EquipableItemInfo) | `equipped: bool`, `type: Types.types` | *(наследует BaseItemInfo)* |
| `key_hint_generator.gd` | Node(Синглтон) | *(нет)* | `get_action_text(action_name: String) -> String`<br>`_get_joypad_name(button: int) -> String` |
| `types.gd` | Node(Синглтон) | `enum types { Melee_Weapon, Ranged_Weapon, Addictional_Equipment, Ammunition, Artefact, Propelling_Weapon, Decorative }` | *(нет)* |
| `character.gd` | Node2D | `health_points: float`, `stamina_points: float`, `stun_points: float`, `level: float`, `experience: float`, `effects: Array[EffectBase]` | `_process(delta: float)` |
| `effect_base.gd` | Resource (EffectBase) | `effect_name: String`, `effect_time: float`, `effect_texture: Texture2D` | `_add(character: Node2D)`<br>`_update_effect(character: Node2D, delta_time: float, add_time: float = 0.0)`<br>`_delete_effect(character: Node2D)` |

#### Подробная документация

**BaseItemInfo** (Resource)  
Базовый контейнер данных для всех предметов.  
- Свойства: `item_id`, `item_name`, `item_icon`, `item_description`, `item_quantity`, `item_stack`, `item_scene`.  
- Конструктор: `_init(...)` – все параметры необязательны.

**EquipableItemInfo** (BaseItemInfo)  
Расширяет базовый класс данными для экипировки.  
- Дополнительные свойства: `equipped: bool`, `type: Types.types`.

**ConsumableItemInfo** (BaseItemInfo)  
Расширяет базовый класс применением эффекта.  
- Дополнительное свойство: `effect: EffectBase`.  
- Метод: `_consume(character: Node2D)` – применяет эффект к персонажу и уменьшает количество.

**InventoryCell** (Resource)  
Хранит одну ячейку инвентаря.  
- Свойства: `data: BaseItemInfo`, `full: bool`.  
- Методы: `is_empty() -> bool`, `stack(count: int = 1) -> int` (возвращает остаток), `_delete_items(count: int = 0, all: bool = false)`.

**EquipmentCell** (Resource)  
Хранит одну ячейку слота экипировки.  
- Свойства: `slot_type: Types.types`, `equipped_item: BaseItemInfo`.  
- Метод: `is_empty() -> bool`.

**Inventory** (Resource)  
Управляет данными инвентаря (добавление, удаление, сортировка).  
- Свойства: `cells: Array[InventoryCell]`, `max_size: int`.  
- Сигнал: `inventory_changed`.  
- Методы: `_add_item(item_data: BaseItemInfo)`, `_remove_item(item: BaseItemInfo)`, `sort_inventory()`, `_find_exist(item_data: BaseItemInfo) -> InventoryCell`.

**InventoryUI** (Control)  
Главный контроллер UI.  
- Свойства: `character`, `inventory`, `inventory_tab`, `equipment_tab`, `effect_container`, `cursor_position`, `grid_borders`.  
- Методы: `_ready()`, `_cursor_move(cursor_pos: Vector2, action: String) -> Vector2`, `_update_grid_borders() -> Array`, `_input(event: InputEvent)`.

**InventoryTab** (Control)  
Управляет сеткой инвентаря и переключением вкладок.  
- Свойства: `cell_scene`, `cell_grid`, `separation`, `info_panel`, `equip_panel`, `currentTab`, `character`, `current_cell`, `inventory`, `info_cells`, `advanced_cells`.  
- Сигнал: `item_consumed()`.  
- Методы: `_setup_grid()`, `refresh()`, `_process(_delta: float)`, `_input(event: InputEvent)`, `_update()`, `_focused_cell(cursor_pos: Vector2 = Vector2.ZERO, setup = false)`, `_throw()`.

**InfoPanel** (Control)  
Отображает детали предмета и подсказки действий.  
- Свойства: `item_icon`, `item_name`, `item_desc`, `info_tab`, `action_panel`.  
- Методы: `_empty()`, `_show_info(data: BaseItemInfo)`.

**EquipPanel** (GridContainer)  
Показывает слоты экипировки и статы персонажа.  
- Свойства: `separation_x`, `separation_y`, `equip_tab`, `hp`, `sp`, `stn`, `lvl`, `exp`.  
- Сигналы: `item_equipped(item: EquipableItemInfo)`, `item_unequipped(item: EquipableItemInfo)`.  
- Методы: `_ready()`, `_info_update(character: Node2D)`, `_get_cell_to_equip(item: BaseItemInfo)`.

**ActionPanel** (Control)  
Отображает контекстные подсказки клавиш.  
- Свойства: `_uselabel: Label`, `_throwlabel: Label`.  
- Методы: `_empty()`, `_update(data: BaseItemInfo)`.

**EffectBase** (Resource)  
Базовая логика эффектов.  
- Свойства: `effect_name`, `effect_time`, `effect_texture`.  
- Методы: `_add(character: Node2D)`, `_update_effect(character: Node2D, delta_time: float, add_time: float = 0.0)`, `_delete_effect(character: Node2D)`.

**CellBase** (Control)  
Базовый класс для UI-ячеек.  
- Свойства: `icon: TextureRect`, `cell_sprite: Sprite2D`.

**InventoryCellUI** (CellBase)  
UI-представление ячейки инвентаря.  
- Свойства: `cell_data: InventoryCell`, `quantity_label: Label`.  
- Сигнал: `cell_selected(cell: BaseItemInfo)`.  
- Методы: `_update_ui()`, `_selected()`.

**EquipmentCellUI** (CellBase)  
UI-представление ячейки экипировки.  
- Свойства: `cell_data: EquipmentCell`, `count_label: Label`, `type_sprite: Sprite2D`, `type_texture: Texture2D`.  
- Сигнал: `cell_selected(cell: BaseItemInfo)`.  
- Методы: `_ready()`, `update_ui()`, `try_equip(item: BaseItemInfo) -> bool`, `_equip(item: BaseItemInfo)`, `_unequip(equiping_item: BaseItemInfo = null)`, `_selected()`.

**effect_cell.gd** (TextureRect)  
Отображает один активный эффект.  
- Свойства: `effect: EffectBase`, `fading: int`, `time_label: Label`.  
- Методы: `_is_empty() -> bool`, `_update(delta: float)`.

**effect_container.gd** (GridContainer)  
Управляет ячейками эффектов для персонажа.  
- Свойства: `effect_cell_scene: PackedScene`, `character: Node2D`, `last_size_effects: int`.  
- Методы: `_create_grid()`, `_update_cells(delta: float)`, `_update_grid()`, `_clear_grid()`, `_process(delta: float)`.

**key_hint_generator.gd** (Node)  
Утилита для получения читаемых названий действий.  
- Методы: `get_action_text(action_name: String) -> String`, `_get_joypad_name(button: int) -> String`.

**types.gd** (Node)  
Содержит перечисление `types`: `Melee_Weapon`, `Ranged_Weapon`, `Addictional_Equipment`, `Ammunition`, `Artefact`, `Propelling_Weapon`, `Decorative`.

**character.gd** (Node2D)  
Статы персонажа и активные эффекты.  
- Свойства: `health_points`, `stamina_points`, `stun_points`, `level`, `experience`, `effects: Array[EffectBase]`.  
- Метод: `_process(delta: float)` – обновляет все активные эффекты.

**tab.gd** (Label)  
Простая метка со ссылкой на спрайт.  
- Свойство: `sprite: Sprite2D`.

---

<a name="japanese"></a>
## 日本語

ゲームパッド対応、装備、アイテムドロップ機能を備えた完全なインベントリシステム。

### 特徴
- **ゲームパッド対応** — コントローラーによる完全ナビゲーション
- **装備システム** — アイテムの装備/解除
- **アイテムドロップ** — ワールドへのアイテム投げ捨て
- **エフェクトシステム** — バフ/デバフのサポート
- **カスタムUI** — 24個のピクセルアートスプライト
- **クリーンなアーキテクチャ** — リソースとノードの分離

### 操作

| アクション | キーボード | ゲームパッド |
|------------|-----------|-------------|
| 移動 | 矢印キー | 左スティック |
| 装備 | Z | B |
| ドロップ | Escape | X |
| タブ切り替え | Space | A |

### 構造

#### カスタムクラス

| クラス名 | 親 | 説明 |
|----------|----|------|
| BaseItemInfo | Resource | アイテムの基本データ |
| EquipableItemInfo | BaseItemInfo | 装備可能アイテムのデータ |
| ConsumableItemInfo | BaseItemInfo | 消費アイテムのデータ（エフェクト付き） |
| InventoryCell | Resource | インベントリセル（BaseItemInfoを保持） |
| EquipmentCell | Resource | 装備スロットセル（EquipableItemInfoを保持） |
| Inventory | Resource | インベントリデータのメインマネージャー |
| InventoryUI | Control | メインUIコントローラー（全パネルを統合） |
| CellBase | Control | UIセルの基底クラス |
| InventoryCellUI | CellBase | インベントリグリッドのUIセル |
| EquipmentCellUI | CellBase | 装備スロットのUIセル |
| InventoryTab | Control | インベントリグリッドとタブ切り替えを管理 |
| InfoPanel | Control | アイテム情報とアクションヒントを表示 |
| EquipPanel | GridContainer | 装備グリッド + キャラクターステータス |
| ActionPanel | Control | アクションのキーヒントを表示 |
| EffectBase | Resource | エフェクトの基本データ |
| Types | Node| アイテムタイプの列挙 |

#### スクリプト詳細リファレンス

| スクリプト名 | タイプ | プロパティ | メソッド |
|--------------|--------|------------|----------|
| `action_panel.gd` | Control (ActionPanel) | `_uselabel: Label`, `_throwlabel: Label` | `_empty()`<br>`_update(data: BaseItemInfo)` |
| `effect_cell.gd` | TextureRect | `effect: EffectBase`, `fading: int`, `time_label: Label` | `_is_empty() -> bool`<br>`_update(delta: float)` |
| `effect_container.gd` | GridContainer | `effect_cell_scene: PackedScene`, `character: Node2D`, `last_size_effects: int` | `_create_grid()`<br>`_update_cells(delta: float)`<br>`_update_grid()`<br>`_clear_grid()`<br>`_process(delta: float)` |
| `equip_panel.gd` | GridContainer (EquipPanel) | `separation_x: int`, `separation_y: int`, `equip_tab: Label`, `hp, sp, stn, lvl, exp: Label`<br>**シグナル:** `item_equipped(item: EquipableItemInfo)`, `item_unequipped(item: EquipableItemInfo)` | `_ready()`<br>`_info_update(character: Node2D)`<br>`_get_cell_to_equip(item: BaseItemInfo)` |
| `equipment_cell_ui.gd` | CellBase (EquipmentCellUI) | `cell_data: EquipmentCell`, `count_label: Label`, `type_sprite: Sprite2D`, `type_texture: Texture2D`<br>**シグナル:** `cell_selected(cell: BaseItemInfo)` | `_ready()`<br>`update_ui()`<br>`try_equip(item: BaseItemInfo) -> bool`<br>`_equip(item: BaseItemInfo)`<br>`_unequip(equiping_item: BaseItemInfo = null)`<br>`_selected()` |
| `infopanel.gd` | Control (InfoPanel) | `item_icon: TextureRect`, `item_name: Label`, `item_desc: Label`, `info_tab: Label`, `action_panel: Control` | `_ready()`<br>`_empty()`<br>`_show_info(data: BaseItemInfo)` |
| `inventory_cell_ui.gd` | CellBase (InventoryCellUI) | `cell_data: InventoryCell`, `quantity_label: Label`<br>**シグナル:** `cell_selected(cell: BaseItemInfo)` | `_update_ui()`<br>`_selected()` |
| `inventory_tab.gd` | Control (InventoryTab) | `cell_scene: PackedScene`, `cell_grid: GridContainer`, `separation: int`, `info_panel: InfoPanel`, `equip_panel: EquipPanel`, `currentTab: InventoryTabs`, `character: Node2D`, `current_cell: CellBase`, `inventory: Inventory`, `info_cells: Array`, `advanced_cells: Array`<br>**シグナル:** `item_consumed()` | `_setup_grid()`<br>`refresh()`<br>`_process(_delta: float)`<br>`_input(event: InputEvent)`<br>`_update()`<br>`_focused_cell(cursor_pos: Vector2 = Vector2.ZERO, setup = false)`<br>`_throw()` |
| `inventory_ui.gd` | Control (InventoryUI) | `character: Node2D`, `inventory: Inventory`, `inventory_tab: InventoryTab`, `equipment_tab: EquipPanel`, `effect_container: GridContainer`, `cursor_position: Vector2`, `grid_borders: Array` | `_ready()`<br>`_cursor_move(cursor_pos: Vector2, action: String) -> Vector2`<br>`_update_grid_borders() -> Array`<br>`_input(event: InputEvent)` |
| `tab.gd` | Label | `sprite: Sprite2D` | *(なし)* |
| `cell_base.gd` | Control (CellBase) | `icon: TextureRect`, `cell_sprite: Sprite2D` | *(なし)* |
| `equip_cell.gd` | Resource (EquipmentCell) | `slot_type: Types.types`, `equipped_item: BaseItemInfo` | `is_empty() -> bool` |
| `inventory.gd` | Resource (Inventory) | `cells: Array[InventoryCell]`, `max_size: int`<br>**シグナル:** `inventory_changed` | `_ready()`<br>`_find_exist(item_data: BaseItemInfo) -> InventoryCell`<br>`sort_inventory()`<br>`_add_item(item_data: BaseItemInfo)`<br>`_remove_item(item: BaseItemInfo)` |
| `inventory_cell.gd` | Resource (InventoryCell) | `data: BaseItemInfo`, `full: bool` | `is_empty() -> bool`<br>`stack(count: int = 1) -> int`<br>`_delete_items(count: int = 0, all: bool = false)` |
| `base_item_info.gd` | Resource (BaseItemInfo) | `item_id: String`, `item_name: String`, `item_icon: Texture2D`, `item_description: String`, `item_quantity: int`, `item_stack: int`, `item_scene: PackedScene` | `_init(_item_id: String = "", _item_name: String = "", _item_icon: Texture2D = null, _item_des: String = "", _i_quant: int = 0, _i_stack: int = 0, _item_scene: PackedScene = null)` |
| `consumable_item_info.gd` | Resource (ConsumableItemInfo) | `effect: EffectBase` | `_consume(character: Node2D)` |
| `equipable_item_info.gd` | Resource (EquipableItemInfo) | `equipped: bool`, `type: Types.types` | *(BaseItemInfoを継承)* |
| `key_hint_generator.gd` | Node(Singleton) | *(なし)* | `get_action_text(action_name: String) -> String`<br>`_get_joypad_name(button: int) -> String` |
| `types.gd` | Node(Singleton) | `enum types { Melee_Weapon, Ranged_Weapon, Addictional_Equipment, Ammunition, Artefact, Propelling_Weapon, Decorative }` | *(なし)* |
| `character.gd` | Node2D | `health_points: float`, `stamina_points: float`, `stun_points: float`, `level: float`, `experience: float`, `effects: Array[EffectBase]` | `_process(delta: float)` |
| `effect_base.gd` | Resource (EffectBase) | `effect_name: String`, `effect_time: float`, `effect_texture: Texture2D` | `_add(character: Node2D)`<br>`_update_effect(character: Node2D, delta_time: float, add_time: float = 0.0)`<br>`_delete_effect(character: Node2D)` |

#### 詳細ドキュメント

**BaseItemInfo** (Resource)  
全アイテムの基本データコンテナ。  
- プロパティ: `item_id`, `item_name`, `item_icon`, `item_description`, `item_quantity`, `item_stack`, `item_scene`.  
- コンストラクタ: `_init(...)` – すべてオプション。

**EquipableItemInfo** (BaseItemInfo)  
装備固有データでベースを拡張。  
- 追加プロパティ: `equipped: bool`, `type: Types.types`.

**ConsumableItemInfo** (BaseItemInfo)  
エフェクト適用でベースを拡張。  
- 追加プロパティ: `effect: EffectBase`.  
- メソッド: `_consume(character: Node2D)` – キャラクターにエフェクトを適用し、数量を減らす。

**InventoryCell** (Resource)  
単一のインベントリスロットを格納。  
- プロパティ: `data: BaseItemInfo`, `full: bool`.  
- メソッド: `is_empty() -> bool`, `stack(count: int = 1) -> int`（余りを返す）, `_delete_items(count: int = 0, all: bool = false)`.

**EquipmentCell** (Resource)  
単一の装備スロットを格納。  
- プロパティ: `slot_type: Types.types`, `equipped_item: BaseItemInfo`.  
- メソッド: `is_empty() -> bool`.

**Inventory** (Resource)  
インベントリデータを管理（追加、削除、ソート）。  
- プロパティ: `cells: Array[InventoryCell]`, `max_size: int`.  
- シグナル: `inventory_changed`.  
- メソッド: `_add_item(item_data: BaseItemInfo)`, `_remove_item(item: BaseItemInfo)`, `sort_inventory()`, `_find_exist(item_data: BaseItemInfo) -> InventoryCell`.

**InventoryUI** (Control)  
トップレベルのUIコントローラー。  
- プロパティ: `character`, `inventory`, `inventory_tab`, `equipment_tab`, `effect_container`, `cursor_position`, `grid_borders`.  
- メソッド: `_ready()`, `_cursor_move(cursor_pos: Vector2, action: String) -> Vector2`, `_update_grid_borders() -> Array`, `_input(event: InputEvent)`.

**InventoryTab** (Control)  
インベントリグリッドとタブ切り替えを管理。  
- プロパティ: `cell_scene`, `cell_grid`, `separation`, `info_panel`, `equip_panel`, `currentTab`, `character`, `current_cell`, `inventory`, `info_cells`, `advanced_cells`.  
- シグナル: `item_consumed()`.  
- メソッド: `_setup_grid()`, `refresh()`, `_process(_delta: float)`, `_input(event: InputEvent)`, `_update()`, `_focused_cell(cursor_pos: Vector2 = Vector2.ZERO, setup = false)`, `_throw()`.

**InfoPanel** (Control)  
アイテム詳細とアクションヒントを表示。  
- プロパティ: `item_icon`, `item_name`, `item_desc`, `info_tab`, `action_panel`.  
- メソッド: `_empty()`, `_show_info(data: BaseItemInfo)`.

**EquipPanel** (GridContainer)  
装備スロットとキャラクターステータスを表示。  
- プロパティ: `separation_x`, `separation_y`, `equip_tab`, `hp`, `sp`, `stn`, `lvl`, `exp`.  
- シグナル: `item_equipped(item: EquipableItemInfo)`, `item_unequipped(item: EquipableItemInfo)`.  
- メソッド: `_ready()`, `_info_update(character: Node2D)`, `_get_cell_to_equip(item: BaseItemInfo)`.

**ActionPanel** (Control)  
コンテキストキーヒントを表示。  
- プロパティ: `_uselabel: Label`, `_throwlabel: Label`.  
- メソッド: `_empty()`, `_update(data: BaseItemInfo)`.

**EffectBase** (Resource)  
エフェクトの基本ロジック。  
- プロパティ: `effect_name`, `effect_time`, `effect_texture`.  
- メソッド: `_add(character: Node2D)`, `_update_effect(character: Node2D, delta_time: float, add_time: float = 0.0)`, `_delete_effect(character: Node2D)`.

**CellBase** (Control)  
UIセルの基底クラス。  
- プロパティ: `icon: TextureRect`, `cell_sprite: Sprite2D`.

**InventoryCellUI** (CellBase)  
インベントリセルのUI表現。  
- プロパティ: `cell_data: InventoryCell`, `quantity_label: Label`.  
- シグナル: `cell_selected(cell: BaseItemInfo)`.  
- メソッド: `_update_ui()`, `_selected()`.

**EquipmentCellUI** (CellBase)  
装備セルのUI表現。  
- プロパティ: `cell_data: EquipmentCell`, `count_label: Label`, `type_sprite: Sprite2D`, `type_texture: Texture2D`.  
- シグナル: `cell_selected(cell: BaseItemInfo)`.  
- メソッド: `_ready()`, `update_ui()`, `try_equip(item: BaseItemInfo) -> bool`, `_equip(item: BaseItemInfo)`, `_unequip(equiping_item: BaseItemInfo = null)`, `_selected()`.

**effect_cell.gd** (TextureRect)  
単一のアクティブエフェクトを表示。  
- プロパティ: `effect: EffectBase`, `fading: int`, `time_label: Label`.  
- メソッド: `_is_empty() -> bool`, `_update(delta: float)`.

**effect_container.gd** (GridContainer)  
キャラクターのエフェクトセルを管理。  
- プロパティ: `effect_cell_scene: PackedScene`, `character: Node2D`, `last_size_effects: int`.  
- メソッド: `_create_grid()`, `_update_cells(delta: float)`, `_update_grid()`, `_clear_grid()`, `_process(delta: float)`.

**key_hint_generator.gd** (Node)  
アクション名を可読な文字列に変換するユーティリティ。  
- メソッド: `get_action_text(action_name: String) -> String`, `_get_joypad_name(button: int) -> String`.

**types.gd** (Node)  
`types` 列挙型を含む: `Melee_Weapon`, `Ranged_Weapon`, `Addictional_Equipment`, `Ammunition`, `Artefact`, `Propelling_Weapon`, `Decorative`.

**character.gd** (Node2D)  
キャラクターのステータスとアクティブエフェクト。  
- プロパティ: `health_points`, `stamina_points`, `stun_points`, `level`, `experience`, `effects: Array[EffectBase]`.  
- メソッド: `_process(delta: float)` – 全アクティブエフェクトを更新。

**tab.gd** (Label)  
スプライト参照を持つシンプルなラベル。  
- プロパティ: `sprite: Sprite2D`.