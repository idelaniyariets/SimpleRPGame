extends Node2D
#!!!USLESS USLESS USELESS!!!
func _ready() -> void:
	$AudioStreamPlayer.play()
	

	if $AudioStreamPlayer.finished:
		$AudioStreamPlayer.play()
