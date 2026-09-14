class_name AttackState
extends State

## Linked [Minion] class.
@export var minion: Minion
## [Minion]'s StateMachine.
@onready var state_machine: StateMachine = %StateMachine
## [Minion]'s advance state.
@onready var advance_state: AdvanceState = %AdvanceState
## Attack time for the [Minion]. Cooldown is defined in [member Minion.attack_cooldown].
@onready var attack_timer: Timer = %AttackTimer

func _ready() -> void:
	attack_timer.timeout.connect(on_attack)
	minion.target_updated.connect(on_target_updated)

## Called when [Class] is entered.
func enter() -> void:
	## If the target is an invalid instance, it won't emit signal destroyed. This
	## 	check prevents the minion from getting stuck if the tower is destoryed before it
	##  hits the tower.
	if not is_instance_valid(minion.target):
		state_machine.set_state(advance_state)
		return
	
	var attack_delay := randf_range(
		minion.attack_delay_range.x, 
		minion.attack_delay_range.y
	)
	attack_timer.start(minion.attack_cooldown + attack_delay)
	assert(minion.target.has_signal("destroyed"))
	# For some reason, when the last defenses are destroyed, the attack state is 
	#	entered, and we attempt to connect to target.destroyed twice. This prevents
	#	that error. No idea why it was happening to begin with.
	if not minion.target.destroyed.is_connected(on_target_death):
		minion.target.destroyed.connect(on_target_death)

## Called when [Class] is exited.
func exit() -> void:
	attack_timer.stop()

func on_attack() -> void:
	var target := minion.target
	
	if not is_instance_valid(target):
		return
	
	assert(target.has_method("damage"))
	target.damage(minion.damage)

func on_target_death(_defense: Defense) -> void:
	state_machine.set_state(advance_state)

func on_target_updated(_target: Defense) -> void:
	# Ensure that we move to the advance state whenever the target is updated,
	#	so the minion is *as close* as they can be to the target.
	state_machine.set_state(advance_state)
