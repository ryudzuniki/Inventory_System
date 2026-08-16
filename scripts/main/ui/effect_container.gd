extends GridContainer

@export var effect_cell_scene:PackedScene

var character:Node2D
var last_size_effects:int = 0

func _create_grid():
	last_size_effects = character.effects.size()
	for effect in character.effects:
		var effect_cell = effect_cell_scene.instantiate()
		effect_cell.effect = effect
		effect_cell.name = effect.effect_name
		effect_cell.texture = effect.effect_texture
		add_child(effect_cell)

func _update_cells(delta):
	for i in range(character.effects.size()):
		get_child(i).effect =  character.effects[i]
		get_child(i)._update(delta)

func _update_grid():
	last_size_effects = character.effects.size()
	for child in get_children():
		child._update()
		if child._is_empty():
			child.queue_free()

func _clear_grid():
	last_size_effects = character.effects.size()
	for child in get_children():
		child.queue_free()

func _process(delta:float):
	if character.effects.size()>0:
		if get_child_count()>0:
			_update_cells(delta)
		if last_size_effects != 0:
			if last_size_effects != character.effects.size():
				_update_grid()
		else:
			_create_grid()
	else:
		_clear_grid()
	
	
