extends Node2D

@export var puntos_vencedor := 5
var resultado_actual : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	## Llamada retardada (call_deferred) al reposicionamiento. 
	## Esto se hace para asegurar que los nodos esten listos cuando se llama a la funcion _posicionamiento_inicial	
	_posicionamiento_inicial.call_deferred()
	
	# control de la entrada de la pelota en las areas.
	$bordes/area_izquierda.body_entered.connect(_on_gol.bind(2, "Jugador derecho gana el partido!!"))
	$bordes/area_derecha.body_entered.connect(_on_gol.bind(1, "Jugador izquierdo gana el partido!!"))

	
	# suscripcion para el saque inicial
	$jugador_izquierdo.paleta_movida_saque.connect($pelota.saque_inicial.bind($jugador_izquierdo))
	$jugador_derecho.paleta_movida_saque.connect($pelota.saque_inicial.bind($jugador_derecho))

func _posicionamiento_inicial() -> void:
	var screen_size := get_viewport_rect().size
	var alto_paleta = $jugador_izquierdo/ColorRect.size.y
	var screen_mitad_y = (screen_size.y / 2) - (alto_paleta / 2)
	var alto_marcador = $marcador/Control.size.y  # o el valor fijo que tenga
	var alto_juego = screen_size.y - alto_marcador
	# extender el fondo al 100% de la pantalla
	$ColorRect.size = screen_size
	
	# posicion marcador
	$marcador.posicion_inicial(screen_size)
	
	# posicion inicial de las paletas
	$jugador_izquierdo.posicion_inicial(10, screen_mitad_y)
	$jugador_derecho.posicion_inicial(screen_size.x - 30, screen_mitad_y)

	#posicion de la bola
	$pelota.posicion_inicial(screen_size)
	
	# posicion bordes
	$bordes.posicion_inicial(alto_juego, alto_marcador)
	
func _on_gol(body: Node, jugador: int, mensaje_victoria: String):
	if body != $pelota:
		return
	if $marcador.aumentar_resultado(jugador) >= puntos_vencedor:
		terminar_partida(mensaje_victoria)
	else:
		$pelota.saque_continuacion.call_deferred($jugador_izquierdo, $jugador_derecho)
		
func terminar_partida(mensaje : String):
	$pelota.detener()
	$AudioStreamPlayer.play()
	$marcador.mensaje_central(mensaje)
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://escenas/pantalla_principal/pantalla_principal.tscn")
