class_name Minion
extends CharacterBody2D

## Emitted when the minion's target has changed. [target] can be null.
signal target_updated(target: Defense)
## [Minion]'s speed.
@export var movement_speed: float
## Range [member Minion.speed] can vary by. Used to make Minions have "different"
##	speeds and not look clumped together when moving.
@export var speed_offset_range: Vector2
## Range [Minion] will offset [member Minion.target]'s [member Defense.global_position]
##	X cords by. Allows multiple minions to be visible at once.
@export var destination_offset_range_x: Vector2
## Range [Minion] will offset [member Minion.target]'s [member Defense.global_position]
##	Y cords by. Allows multiple minions to be visible at once.
@export var destination_offset_range_y: Vector2
## [Minion]'s attack cooldown in seconds.
@export var attack_cooldown: float
## Range of how much [member Minion.attack_cooldown]'s can vary. This allows for the player
##	to feel *the quantity of attacks* on the defenses.
@export var attack_delay_range: Vector2
## [Minion]'s base damage.
@export var damage: int

## [Minion]'s current target.
var target: Defense:
	set(value):
		if not is_instance_valid(value):
			target = null
		else:
			target = value
			target.destroyed.connect(on_target_death)
		
		target_updated.emit(target)

func on_target_death(target: Defense):
	target = null
