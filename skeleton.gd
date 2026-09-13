class_name Skeleton
extends CharacterBody2D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent2D = %NavigationAgent2D
@export var navigation_targets: Array[Sprite2D] = []

func _ready() -> void:
	pass

func update_movement_target() -> void:
	if navigation_targets.size() == 0:
		return
	
	var target: Sprite2D = navigation_targets.pop_front()
	var target_position: Vector2 = target.global_position
	navigation_agent.target_position = target_position

func add_target(target: Sprite2D) -> void:
	assert(is_instance_valid(target))
	navigation_targets.append(target)

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		if navigation_targets.size() > 0:
			update_movement_target()
		if navigation_targets.size() == 0:
			velocity = Vector2.ZERO
			move_and_slide()
			return

	var next_position := navigation_agent.get_next_path_position()
	velocity = global_position.direction_to(next_position) * movement_speed
	move_and_slide()
