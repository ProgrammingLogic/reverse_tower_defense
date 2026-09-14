extends Control

const MINION: PackedScene = preload("uid://ckethcuhcs77b")

@onready var summon_button: Button = %SummonButton
@onready var spawn_point: Node2D = %SpawnPoint
@onready var castle: Sprite2D = %Castle
@onready var wall: Sprite2D = %Wall
@onready var archer_tower: Sprite2D = %ArcherTower

func summon_minion() -> void:
	var minion: Minion = MINION.instantiate()
	add_child(minion)
	minion.global_position = spawn_point.global_position
	minion.target = archer_tower

func _ready() -> void:
	%SummonButton.button_up.connect(summon_minion)
