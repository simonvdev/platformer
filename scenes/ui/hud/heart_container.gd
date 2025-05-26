extends HBoxContainer

@export var heart_display_scene : PackedScene

func _init() -> void:
	Director.PlayerHealthChanged.connect(_on_health_changed)

func _ready() -> void:
	if heart_display_scene == null:
		print("Cannot spawn any hearts in UI as its not assigned")
		return
			
	var max_health : int = 6
	
	@warning_ignore("integer_division")
	for n in (max_health / 2):
		var heartDisplay : HeartDisplay = heart_display_scene.instantiate()
		add_child(heartDisplay)
	
	
func _on_health_changed(old : int, new : int, delta : int):
	
	var touchedhearts = 0
	
	for heart in get_children():
		if heart is  HeartDisplay:
			var diff_to_new = new - touchedhearts
			if diff_to_new >= 2:
				heart.set_state(2)
				touchedhearts += 2
			elif diff_to_new == 1:
				heart.set_state(1)
				touchedhearts += 1
			else:
				heart.set_state(0)
