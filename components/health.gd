class_name Health
extends Node
## Health of entity in the game.
##
## Responible for tracking the entity's health and notifying listeners when
##	the entity's health is modified or depleted.

## Emitted when the entity's health falls below 1.
signal killed
## Emitted when the entity is healed.
signal healed(amount: int)
## Emitted when the entity takes damage.
signal hurt(amount: int)

## Entity's max health.
var max_value: int = 1:
	set(new_max_value):
		max_value = new_max_value
		
		if value > max_value:
			var delta := max_value - value
			damage(delta)

## Entity's current health.
var value: int

## Inflict [param amount] damage on the entity.
##
## [param amount] is clamped to be above zero. If the actual damage taken is
##	more than 0, emits [signal Health.damaged] with the damage taken as
##	[param amount]. If [member Health.value] falls below 1, emits [signal Health.killed].
func damage(amount: int) -> void:
	var clamped_amount: int = clamp(amount, 0, INF)
	var new_value: int = value - clamped_amount
	var delta: int = new_value - value
	var damage_taken: int = abs(delta)

	value = new_value

	if damage_taken > 0:
		hurt.emit(damage_taken)

	if new_value < 1:
		killed.emit()

## Heal the entity for [param amount].
##
## The new [member Health.value] is clamped to be above zero and less than
##	[member Health.max_value]. If the actual healing received is more than 0,
##	emits [signal Health.healed].
func heal(amount: int) -> void:
	var clamped_amount: int = clamp(amount, 0, INF)
	var new_value: int = value - clamped_amount
	var clamped_new_value: int = clamp(new_value, 1, max_value)
	var delta: int = clamped_new_value - value
	var healing_received: int = abs(delta)

	value = clamped_new_value

	if healing_received > 0:
		healed.emit(healing_received)
