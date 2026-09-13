extends Control

const SKELETON: PackedScene = preload("uid://ckethcuhcs77b")

@onready var summon_button: Button = %SummonButton
@onready var spawn_point: Node2D = %SpawnPoint
@onready var castle: Sprite2D = %Castle
@onready var wall: Sprite2D = %Wall
@onready var archer_tower: Sprite2D = %ArcherTower

func summon_skeleton() -> void:
	var skeleton: Skeleton = SKELETON.instantiate()
	add_child(skeleton)
	skeleton.global_position = spawn_point.global_position
	skeleton.add_target(archer_tower)
	skeleton.add_target(wall)
	skeleton.add_target(castle)

func _ready() -> void:
	%SummonButton.button_up.connect(summon_skeleton)
