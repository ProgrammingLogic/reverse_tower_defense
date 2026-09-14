extends Control

const MINION: PackedScene = preload("uid://ckethcuhcs77b")

@onready var summon_button: Button = %SummonButton
@onready var spawn_point: Node2D = %SpawnPoint
@onready var defense: Defense = %Defense

func summon_minion() -> void:
	var minion: Minion = MINION.instantiate()
	add_child(minion)
	minion.global_position = spawn_point.global_position
	minion.target = defense

func _ready() -> void:
	%SummonButton.button_up.connect(summon_minion)
