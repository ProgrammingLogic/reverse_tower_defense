class_name Defense
extends Node2D

## Emitted when [Defense] is destroyed.
signal destroyed(defense: Defense)
## The defense's health.
var health: Health = Health.new()
## The max health of the defense.
@export var max_health: int:
	get:
		return health.max_value
	set(value):
		health.max_value = value
## [Node2D] representing where a [Minion] should stop when navigating to the tower.
@export var navigation_point: Node2D
## [Healthbar] providing a visual representation of [member Defense.health].
@onready var healthbar: Healthbar = %Healthbar

func _ready() -> void:
	health.max_value = max_health
	health.value = max_health
	healthbar.health = health
	health.killed.connect(_on_killed)
	assert(is_instance_valid(navigation_point))

## Executed when [member Defense.health]'s [signal Health.killed] is emitted.
func _on_killed() -> void:
	destroyed.emit(self)
	queue_free()

## Hurt [Defense] for [param amount] damage.
func damage(amount: int) -> void:
	health.damage(amount)
