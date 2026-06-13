# Pong

*[English version](README.en.md)*

Mi versión del clásico Pong, hecha en Godot 4.6 como **juego 1** del [20 Games Challenge](https://20_games_challenge.gitlab.io/).

![Captura del juego](captura_pong.png)

## Pong original

Pong es uno de los videojuegos más antiguos e importantes de la historia. Su antecesor directo es *Tennis for Two* (1958), creado por William Higinbotham, que se jugaba sobre un osciloscopio como pantalla y un ordenador analógico para calcular la trayectoria de la "pelota". Catorce años después, en 1972, Atari sacó *Pong* a las recreativas y se convirtió en el pelotazo (con perdón) que dio el pistoletazo de salida a la industria del videojuego tal y como la conocemos hoy.

La premisa es minimalista: dos palas, una pelota y un marcador. Pero detrás de esa simpleza están ya todos los elementos básicos de cualquier juego: entrada del jugador, físicas, colisiones, puntuación y condición de victoria. Por eso es el ejercicio perfecto para empezar un reto como este.

## Por qué he hecho este juego

Este proyecto es la primera entrega del [20 Games Challenge](https://20_games_challenge.gitlab.io/), un reto que consiste en recrear 20 juegos clásicos para aprender (o repasar) desarrollo de videojuegos de forma progresiva, empezando por lo más sencillo e ir subiendo el nivel poco a poco.

Pong encabeza la lista por un buen motivo: es lo bastante simple como para terminarlo sin agobiarse, pero toca casi todos los sistemas básicos de un motor de juegos (input, física 2D, señales, interfaz, audio...). Además era mi primera toma de contacto en serio con Godot, así que era el punto de partida perfecto para familiarizarme con el editor y su flujo de trabajo antes de meterme en proyectos más ambiciosos.

## Qué he aprendido con este juego

A nivel de conceptos:

- Cómo organizar un proyecto de Godot por escenas, manteniendo cada una autocontenida (script, recursos y nodos propios juntos).
- El funcionamiento de los nodos principales del motor y para qué sirve cada uno.
- El sistema de señales de Godot para comunicar nodos sin acoplarlos entre sí.
- Cómo vincular efectos de sonido a acciones y eventos del juego.
- Físicas 2D: diferencias entre cuerpos estáticos, de personaje y rígidos, y cómo controlar rebotes y colisiones a mano.

Nodos utilizados:

- `Node2D`
- `ColorRect`
- `CollisionObject2D`
- `CanvasLayer`
- `CharacterBody2D`
- `RigidBody2D`
- `AudioStreamPlayer`
- `Control`
- `Button`
- `Label`
- `CollisionShape2D`
- `StaticBody2D`
- `Area2D`

## Controles

| Jugador | Subir | Bajar |
| --- | --- | --- |
| Izquierdo | `W` | `S` |
| Derecho | `↑` (flecha arriba) | `↓` (flecha abajo) |

## Créditos

Los efectos de sonido usados en este proyecto no son propios. Gracias a sus autores:

**Efecto de rebote** (pala y paredes)
- Archivo: `Bleep_04.wav`
- Pack: *Interface Bleeps Wav*
- Autor: [bleeoop](https://bleeoop.itch.io/interface-bleeps)

**Efecto de punto ganado**
- Archivo: `Complete_02.wav`
- Pack: *Interface Bleeps Wav*
- Autor: [bleeoop](https://bleeoop.itch.io/interface-bleeps)

**Efecto de partida ganada**
- Archivo: `703543__yoshicakes77__win.ogg`
- Autor: [Yoshicakes77](https://freesound.org/people/Yoshicakes77/sounds/703543/)

## Posibles evoluciones

El juego ya está terminado y es jugable, pero da para mucho más. Algunas ideas para retomarlo en ratos libres:

- **IA como oponente**, para poder jugar en solitario.
- **Selector de dificultad**, con variantes como:
  - Palas más pequeñas o más rápidas.
  - Obstáculos aleatorios en el centro del campo que desvíen la trayectoria de la pelota.
- **Pantalla de opciones** real (volumen, controles, etc.).
- Soporte para mando, o incluso un modo a 4 jugadores.
- **Estela visual de la pelota**: un rastro que se desvanece detrás de la bola, más largo cuanto más rápido vaya. Es una mejora puramente estética, sin efecto en la jugabilidad, pero ayuda a transmitir la sensación de velocidad.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE.md](LICENSE.md) para más detalles.
