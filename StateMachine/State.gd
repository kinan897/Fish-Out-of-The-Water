extends Node
class_name State

var state_machine: StateMachine

func HandleInput(input_event: InputEvent) -> void: pass
func Update(delta: float) -> void: pass
func PhysicsUpdate(delta: float) -> void: pass

func Enter(msg: StateMessage) -> void: pass
func Exit() -> void: pass
