extends Node2D

func _ready() -> void:
	$AudioStreamPlayer.play()
	

	if $AudioStreamPlayer.finished:
		$AudioStreamPlayer.play()
