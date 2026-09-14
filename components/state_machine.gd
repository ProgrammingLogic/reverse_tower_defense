class_name StateMachine
extends Node
## Node responsible for managing the active [State].
##
## Calls [method State.enter] and [method State.exit] when a state is entered
##	exited. Calls [method State.update] and [method State.physics_update]
##	on the [member StateMachine.ActiveState] during Process and PhysicsProcess
## 	updates.

## [StateMachine]'s active [State].
##
## During each Process and Physics update, [member StateMachine.ActiveState]
##	[State]' [method State.update] and [method State.physics_update] are called.
var active_state: State

## [StateMachine]'s default [State].
@export
var default_state: State

func _ready() -> void:
	if not is_instance_valid(default_state):
		return

	set_state(default_state)

func _input(event: InputEvent) -> void:
	if is_instance_valid(active_state):
		active_state.input(event)

func _process(delta: float) -> void:
	if is_instance_valid(active_state):
		active_state.update(delta)

func _physics_process(delta: float) -> void:
	if is_instance_valid(active_state):
		active_state.physics_update(delta)

## Change [member StateMachine.active_state] to [State] [param state].
func set_state(state: State) -> void:
	if is_instance_valid(active_state):
		active_state.exit()

	## This allows us to set no active state
	if not is_instance_valid(state):
		active_state = null
		return

	active_state = state
	active_state.enter()
