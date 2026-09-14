class_name Minion
extends CharacterBody2D

## Emitted when the minion's target has changed. [target] can be null.
signal target_updated(target: Defense)
## [Minion]'s speed.
@export var movement_speed: float = 4.0
## [Minion]'s base damage.
@export var damage: int = 3
## [Minion]'s current target.
var target: Defense:
	set(value):
		if not is_instance_valid(value):
			target = null
		else:
			target = value
		
		target_updated.emit(target)
