class_name CameraFollower2D extends Node2D

@export var TargetNode : Node2D
func _process(_delta: float) -> void:
	if TargetNode != null:
		global_position = TargetNode.global_position

func retarget(new_target : Node2D):
	TargetNode = new_target
