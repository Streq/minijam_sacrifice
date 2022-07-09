extends Node

export (NodePath) onready var input_state = (get_node(input_state) if input_state else null) as InputState

func _physics_process(delta):
	input_state.dir = InputUtils.get_input_dir()
	input_state.global_aim = InputUtils.get_global_mouse_position(get_viewport())
	input_state.shoot = Input.is_action_pressed("shoot")
