extends RigidBody2D

@export var speed := 500.0

var _screen : Vector2
var _ultimo_sacador : CharacterBody2D
var _reiniciar_pelota := false
var _nuevo_lanzamiento := false
var destino_lanzamiento : Vector2
var _detener_pelota := false
const ANGULO_MAX := deg_to_rad(55.0)   # ángulo máximo de salida respecto a la horizontal
const PESO_PALA := 0.5                # cuánto influye la velocidad de la pala (0 = nada, 1 = mucho)

func _ready():
	_screen = get_viewport_rect().size
	can_sleep = false
	contact_monitor = true       # habilita el reporte de contactos
	max_contacts_reported = 4    # cuántos contactos como máximo se reportan (0 por defecto, por eso "no hay nada")
	body_entered.connect(_on_body_entered)

func posicion_inicial(screen_size: Vector2):
	position.x = (screen_size.x / 2) - ($ColorRect.size.x / 2)
	position.y = screen_size.y / 2
	freeze = true # para frenar la pelota

func saque_inicial(jugador: CharacterBody2D):
	if freeze:
		freeze = false
		var direccion = (jugador.centro_pala() - global_position).normalized()
		linear_velocity = direccion * speed
		_ultimo_sacador = jugador

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if _detener_pelota:
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		freeze = true
	
	for i in state.get_contact_count():
		var cuerpo = state.get_contact_collider_object(i)
		
		if cuerpo.is_in_group("palas"):
			_rebote_con_pala(state, cuerpo, i)

	if state.linear_velocity.length() > 0:
		state.linear_velocity = state.linear_velocity.normalized() * speed
		
	if _reiniciar_pelota:
		
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		state.transform.origin.x = (_screen.x / 2) - ($ColorRect.size.x / 2)
		state.transform.origin.y = _screen.y / 2
		_reiniciar_pelota = false
	
	if _nuevo_lanzamiento:
		# reanudar el movimiento hacia el jugador que saca
		var direccion = (destino_lanzamiento - state.transform.origin).normalized()
		state.linear_velocity = direccion * speed
		_nuevo_lanzamiento = false


func saque_continuacion(jugador_izquierdo : CharacterBody2D, jugador_derecho : CharacterBody2D):
	_reiniciar_pelota = true
	speed = 500.0
	var destino : Vector2
	
	if _ultimo_sacador == jugador_izquierdo:
		destino = jugador_derecho.global_position + jugador_derecho.centro_pala()
		_ultimo_sacador = jugador_derecho
	elif _ultimo_sacador == jugador_derecho:
		destino = jugador_izquierdo.global_position + jugador_izquierdo.centro_pala()
		_ultimo_sacador = jugador_izquierdo
		
	pedir_lanzamiento_en_1_segundo(destino)

func pedir_lanzamiento_en_1_segundo(destino : Vector2):
	# Esperamos 1 segundo para volver a poner la pelota en juego con la direccion adecuada
	await get_tree().create_timer(1.0).timeout
	destino_lanzamiento = destino
	_nuevo_lanzamiento = true

# Funcion de control del rebote con las palas
func _rebote_con_pala(state: PhysicsDirectBodyState2D, pala: CharacterBody2D, contacto: int) -> void:
	var centro_bola: Vector2 = state.transform.origin + $CollisionShape2D.position
	var centro_pala: Vector2 = pala.global_position + pala.centro_pala()
	var mitad_alto: float = pala.get_node("ColorRect").size.y / 2.0
	
	# acelerar la velocidad de la bola y las palas con cada golpe
	speed = minf(speed + 20.0, 900.0) 
	
	# a) punto de impacto: -1 arriba, 0 centro, +1 abajo
	var offset: float = clampf((centro_bola.y - centro_pala.y) / mitad_alto, -1.0, 1.0)

	# b) efecto por movimiento de la pala, normalizado a [-1, 1]
	var vel_pala: Vector2 = state.get_contact_collider_velocity_at_position(contacto)
	var influencia: float = clampf(vel_pala.y / pala.velocidad, -1.0, 1.0) * PESO_PALA

	# ángulo final: suma de ambos, acotada para que nunca salga vertical
	var angulo: float = clampf(offset + influencia, -1.0, 1.0) * ANGULO_MAX

	# sentido horizontal: siempre alejándose de la pala que golpea
	var sentido_x: float = 1.0 if centro_pala.x < centro_bola.x else -1.0

	state.linear_velocity = Vector2(cos(angulo) * sentido_x, sin(angulo)) * speed

func detener():
	_detener_pelota = true

func _on_body_entered(_body: Node) -> void:
	#efecto rebote tanto con palas como con border superior e inferior
	$AudioStreamPlayer.play()
