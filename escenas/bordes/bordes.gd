extends StaticBody2D

func posicion_inicial(alto_juego : float, alto_marcador : float):
	var screen := get_viewport_rect().size
	# limite superior
	$limite_superior.shape.size = Vector2(screen.x, 5)
	$limite_superior.position = Vector2(screen.x / 2, alto_marcador + 5)

	# limite inferior
	$limite_inferior.shape.size = Vector2(screen.x, 5)
	$limite_inferior.position = Vector2(screen.x / 2, screen.y)
	
	#area izquierda
	$area_izquierda/limite_izquierdo.shape.size = Vector2(15, alto_juego)
	$area_izquierda/limite_izquierdo.position = Vector2(0, alto_marcador + alto_juego / 2)
	
	#area derecha
	$area_derecha/limite_derecho.shape.size = Vector2(15, alto_juego)
	$area_derecha/limite_derecho.position = Vector2(screen.x, alto_marcador + alto_juego / 2)
