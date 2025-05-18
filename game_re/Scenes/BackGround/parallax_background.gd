extends ParallaxBackground
#бесконечная прокрутка фона в меню со скоростью speed
var speed = 100

func _process(delta: float) -> void:
	scroll_offset.x -= speed*delta
