extends Node
class_name StateMachine

@export var InitialState: State
var _state: State


func _ready() -> void:
	await owner.ready
	_state = InitialState
	
	for child in get_children():
		if child is State:
			child.state_machine = self
	
	_state.Enter(StateMessage.new())

func _unhandled_input(event: InputEvent) -> void: _state.HandleInput(event)
func _process(delta: float) -> void: _state.Update(delta)
func _physics_process(delta: float) -> void: _state.PhysicsUpdate(delta)

func TransitionTo(targetStateName: String, msg: StateMessage = StateMessage.new()):
	print(_state.name + " to " + targetStateName)
	if (!has_node(targetStateName)): return
	_state.Exit()
	_state = get_node(targetStateName)
	_state.Enter(msg)
