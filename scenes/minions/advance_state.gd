class_name AdvanceState
extends State

## Linked [Minion] class.
@export var minion: Minion
## [Minion]'s navigation agent.
@onready var navigation_agent: NavigationAgent2D = %NavigationAgent2D
## [Minion]'s StateMachine.
@onready var state_machine: StateMachine = %StateMachine
## [Minion]'s attack state.
@onready var attack_state: State = %AttackState

## Executed when [signal Minion.target_updated] is emitted. Updates [member Minion.navigation_agent]'s 
##	[member NavigationAgent2D.target_position] to match the new target.
func on_target_update(target: Defense) -> void:
	## Fallback to the minion's current position to prevent movement to unexpected places.
	if not is_instance_valid(target):
		navigation_agent.target_position = minion.global_position
		return
	
	var target_position := minion.target.navigation_point.global_position
	
	var offset_x := randf_range(
		minion.destination_offset_range_x.x,
		minion.destination_offset_range_x.y
	)
	target_position.x += offset_x
	
	var offset_y := randf_range(
		minion.destination_offset_range_y.x,
		minion.destination_offset_range_y.y
	)
	target_position.y += offset_y
	
	navigation_agent.target_position = target_position

## Called when [AdvanceState] is entered.
func enter() -> void:
	minion.target_updated.connect(on_target_update)
	
	## There are circumstances where the advance state is entered and minion doesn't have
	##	a target. This guard prevents unexpected behavior when this occurs.
	if is_instance_valid(minion.target):
		on_target_update(minion.target)

## Called when [AdvanceState] is exited.
func exit() -> void:
	minion.target_updated.disconnect(on_target_update)
	# Fallback to the minion's position so we don't move to unexpected places
	navigation_agent.target_position = minion.global_position

## Called during _PhysicsProcess when [Class] is active.
func physics_update(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
			minion.velocity = Vector2.ZERO
			minion.move_and_slide()
			state_machine.set_state(attack_state)

	var speed := minion.movement_speed
	var speed_offset := randf_range(
		speed - minion.speed_offset_range.x, 
		speed + minion.speed_offset_range.y
	)
	speed += speed_offset
	
	var next_position := navigation_agent.get_next_path_position()
	var direction := minion.global_position.direction_to(next_position)
	minion.velocity = direction * speed
	minion.move_and_slide()
