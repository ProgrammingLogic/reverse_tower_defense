class_name Healthbar
extends ProgressBar

## [Health] [ProgressBar] derives it data from.
var health: Health:
	set(new_health):
		if is_instance_valid(health):
			health.hurt.disconnect(_on_update)
			health.healed.disconnect(_on_update)
		
		if not is_instance_valid(new_health):
			health = null
			return
		
		health = new_health
		health.hurt.connect(_on_update)
		health.healed.connect(_on_update)
@export var show_numbers := true:
	set(new_show_numbers):
		show_numbers = new_show_numbers
		%HealthLabel.visible = show_numbers
## [RichTextLabel] containing the linked [Health]'s [member Health.value] and 
## 	[member Health.max_value]. Can be disabled with [member Health.show_numbers].
@onready var health_label: RichTextLabel = %HealthLabel

func _on_update(_amount: int):
	value = health.value
	max_value = health.max_value
	health_label.text = "%d / %d" % [health.value, health.max_value]
