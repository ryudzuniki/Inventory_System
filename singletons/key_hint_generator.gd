extends Node

func get_action_text(action_name: String) -> String:
	var custom = {
	"eq": ["Z","B"]
	}
	if custom.has(action_name):
			return custom[action_name][0] if Input.get_connected_joypads().size() == 0 else custom[action_name][1]
	var events = InputMap.action_get_events(action_name)
	for event in events:
		if event is InputEventKey and Input.get_connected_joypads().size()==0:
			return OS.get_keycode_string(event.keycode)
		elif event is InputEventJoypadButton:
			return _get_joypad_name(event.button_index)
	return "?"

func _get_joypad_name(button: int) -> String:
	return {
		JOY_BUTTON_A: "A",
		JOY_BUTTON_B: "B",
		JOY_BUTTON_X: "X",
		JOY_BUTTON_Y: "Y",
		JOY_BUTTON_LEFT_SHOULDER: "LB",
		JOY_BUTTON_RIGHT_SHOULDER: "RB",
		JOY_BUTTON_DPAD_UP: "↑",
		JOY_BUTTON_DPAD_DOWN: "↓",
		JOY_BUTTON_DPAD_LEFT: "←",
		JOY_BUTTON_DPAD_RIGHT: "→",
	}.get(button, "?")
