extends Control

const MINION: PackedScene = preload("uid://ckethcuhcs77b")

@onready var summon_button: Button = %SummonButton
@onready var spawn_point: Node2D = %SpawnPoint
@onready var defenses: Array[Defense] = [
	%Defense, %Defense2, %Defense3, %Defense4, %Defense5, %Defense6
]
var current_defense: Defense

func summon_minion() -> void:
	var minion: Minion = MINION.instantiate()
	add_child(minion)
	minion.global_position = spawn_point.global_position
	# Prevent setting the minion's target to a *null* defense
	if is_instance_valid(current_defense):
		minion.target = current_defense

func _ready() -> void:
	%SummonButton.button_up.connect(summon_minion)
	
	for defense: Defense in defenses:
		current_defense = defense
		update_targets()
		await current_defense.destroyed
		

func update_targets():
	assert(is_instance_valid(current_defense))
	var minions: Array[Node] = get_tree().get_nodes_in_group("minion")
	
	if minions.size() == 0:
		return
	
	for minion: Minion in minions:
		minion.target = current_defense
