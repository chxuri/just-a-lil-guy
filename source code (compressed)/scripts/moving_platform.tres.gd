extends Path2D
class_name MovingPlatform

@export var path_time = 1.0
@warning_ignore("shadowed_global_identifier")
@export var ease : Tween.EaseType
@export var transition : Tween.TransitionType
@export var path_follow_2D : PathFollow2D
var tween: Tween

func _ready():
	move_tween()
	
func move_tween():
	tween = create_tween().set_loops()
	
	tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time).set_ease(ease).set_trans(transition)
	tween.tween_property(path_follow_2D, "progress_ratio", 0.0, path_time).set_ease(ease).set_trans(transition)
	
func stop_tween():
	if tween and tween.is_running():
		tween.kill()
