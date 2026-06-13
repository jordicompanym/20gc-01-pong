extends CanvasLayer

var _resultado_jugador_1 : int = 0
var _resultado_jugador_2 : int = 0

func posicion_inicial(screensize : Vector2):
	var tamano_contadores = screensize.x / 2 
	$Control.size.x = screensize.x
	# marcador jugador izquierdo
	$Control/marcador_izquierdo.size.x = tamano_contadores
	$Control/marcador_izquierdo.position.x = 0
	# para el mensaje de partida ganada
	$Control/marcador_central.size.x = tamano_contadores
	$Control/marcador_central.position.x = tamano_contadores / 2
	$Control/marcador_central.position.y = screensize.y / 2
	#$Control/marcador_central.te
	# marcador jugador derecho
	$Control/marcador_derecho.size.x = tamano_contadores
	$Control/marcador_derecho.position.x = screensize.x - tamano_contadores
	# asignar el resultado inicial a los marcadores
	$Control/marcador_izquierdo.text = str(_resultado_jugador_1)
	$Control/marcador_derecho.text = str(_resultado_jugador_2)

func aumentar_resultado(jugador: int) -> int:
	var retorno : int
	if jugador == 1:
		_resultado_jugador_1 += 1
		retorno = _resultado_jugador_1
	if jugador == 2:
		_resultado_jugador_2 += 1
		retorno =_resultado_jugador_2
	$AudioStreamPlayer.play()
	refrescar_marcador()
	return retorno

func reset_marcador():
	_resultado_jugador_1 = 0
	_resultado_jugador_2 = 0
	refrescar_marcador()

func refrescar_marcador():
	$Control/marcador_izquierdo.text = str(_resultado_jugador_1)
	$Control/marcador_derecho.text = str(_resultado_jugador_2)

func mensaje_central(texto : String):
	$Control/marcador_central.text = str(texto)
