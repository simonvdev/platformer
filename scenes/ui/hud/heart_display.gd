class_name HeartDisplay extends Control

@onready var empty_heart: TextureRect = $EmptyHeart
@onready var half_heart: TextureRect = $HalfHeart
@onready var full_heart: TextureRect = $FullHeart

enum HeartState {
	full,
	half,
	empty
}

@onready var state : int = 0

func _ready() -> void:
	set_state(state)

func set_state(new_state : int):
	state = new_state
	match state:
		0:
			empty_heart.visible = true
			half_heart.visible = false
			full_heart.visible = false
		1:
			empty_heart.visible = false
			half_heart.visible = true
			full_heart.visible = false
		2:
			empty_heart.visible = false
			half_heart.visible = false
			full_heart.visible = true
