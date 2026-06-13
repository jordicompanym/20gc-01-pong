extends CharacterBody2D

## señal para el movimiento de la paleta por primera vez, 
## se utilizara para el control del saque
signal paleta_movida_saque
var _ya_emitio = false

@export var tecla_arriba: String = "ui_up"
@export var tecla_abajo: String = "ui_down"
@export var velocidad: float = 900

var limit_top: float = 30
var limit_bottom: float = 0

func posicion_inicial(x: float,y: float):
	position = Vector2(x, y)

func _ready():
	add_to_group("palas")
	limit_bottom = get_viewport_rect().size.y - $ColorRect.size.y	
	

func centro_pala() -> Vector2:
	return global_position + $ColorRect.size / 2.0

func _physics_process(delta):
	var dir := Input.get_axis(tecla_arriba, tecla_abajo)
	if dir != 0 and not _ya_emitio:
		paleta_movida_saque.emit()
		_ya_emitio = true
	position.y = clamp(position.y + dir * velocidad * delta, limit_top, limit_bottom)
