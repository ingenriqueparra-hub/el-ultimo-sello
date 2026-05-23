# Plan visual — Cabina con giro de cuello

Este documento reemplaza el plan visual anterior. A partir de ahora, la direccion de trabajo para la UI principal de **El Ultimo Sello** es:

> Cabina de inspeccion con tres monitores fisicos y cambio de mirada entre monitor izquierdo, central y derecho.

El objetivo ya no es decorar una UI plana. El objetivo es convertir el puesto de control en una maquina fisica: vieja, pesada, sucia, institucional y legible.

La clave tecnica y visual es que el juego se organiza como **tres pantallas verticales**:

```txt
Pantalla 1: solicitante/interrogatorio
Pantalla 2: expediente/documentos
Pantalla 3: herramientas/alertas/regulaciones
```

En PC horizontal, esas tres pantallas verticales se ven juntas como una cabina de tres monitores.

En movil vertical, se muestra una pantalla vertical a la vez y se cambia entre ellas con `1/2/3` o tabs tactiles.

Por eso, PC y movil no son dos disenos separados: son dos formas de presentar la misma estructura base.

Decision tecnica:

- El texto jugable siempre debe ser recto y rectangular.
- No usar texto en diagonal ni UI deformada en perspectiva.
- La perspectiva debe venir del arte de fondo, marcos, vidrio, sombras y animacion.
- Esto protege legibilidad, scroll, botones, tooltips y soporte movil.

## 1. Documentos base

Antes de tocar arte, UI o escenas visuales, consultar:

1. `CLAUDE.md`
2. `PROJECT.md`
3. `GAME_DESIGN.md`
4. `TECHNICAL_SPEC.md`
5. `IP_SAFETY.md`

Este archivo funciona como guia operativa para el apartado visual. Si contradice `CLAUDE.md`, manda `CLAUDE.md`.

## 2. Nueva direccion visual

La pantalla principal debe representar una cabina de control con:

- monitor izquierdo;
- monitor central;
- monitor derecho;
- consola inferior fisica;
- vidrio grueso, suciedad, desgaste y scanlines;
- texto e interfaz encima de cada monitor.

No queremos una pantalla plana con marcos verdes. Queremos una estacion de inspeccion que parezca usada durante anos por una burocracia decadente.

La cabina debe tener tres pantallas funcionales:

```txt
Pantalla 1: monitor izquierdo / solicitante.
Pantalla 2: monitor central / expediente.
Pantalla 3: monitor derecho / herramientas.
```

En PC pueden verse juntas dentro de una cabina horizontal. En movil vertical se navegan una por una.

Intensidad del movimiento:

```txt
PC horizontal:
movimiento leve de foco/parallax.
Las 3 pantallas siguen visibles.

Movil vertical:
movimiento amplio entre pantallas.
Solo una pantalla principal visible a la vez.
```

## 3. Regla de IP

La referencia visual compartida sirve solo como composicion general:

- tres monitores;
- cabina oscura;
- pantallas verdes;
- maquina vieja y opresiva.

No copiar:

- simbolos reconocibles de franquicias existentes;
- aguilas imperiales reconocibles;
- composicion exacta;
- textos, emblemas o iconografia protegida;
- estilo demasiado cercano a Warhammer 40k.

La version propia debe usar identidad del mundo:

- Ministerio de Admision Planetaria;
- Puesto Umbral 7;
- sellos MAP-7;
- simbolos administrativos propios;
- marcas industriales originales.

## 4. Distribucion de los tres monitores

### Monitor izquierdo — Solicitante

Contenido:

- numero de solicitante;
- nombre;
- origen;
- destino;
- motivo;
- dialogo;
- preguntas de interrogatorio.

Funcion:

- representar la revision humana del caso;
- mantener informacion personal y dialogo separados del expediente documental.

### Monitor central — Expediente

Contenido:

- documentos;
- pestanas de documentos;
- contenido del documento activo;
- informe de escaner cuando se use;
- regulaciones importantes si hace falta.

Funcion:

- ser el foco principal de lectura y comparacion;
- ocupar el monitor mas grande.

### Monitor derecho — Herramientas

Contenido:

- escaner;
- alertas;
- regulaciones;
- sintomas narrativos o estado institucional futuro.

Funcion:

- concentrar herramientas auxiliares;
- no competir visualmente con el monitor central.

### Consola inferior — Decisiones

Contenido:

- APROBAR;
- RETENER;
- RECHAZAR;
- indicadores de credito o estado si conviene.

Funcion:

- sentirse como botones fisicos de una consola;
- mantener decisiones fuera de los monitores.

## 5. Resolucion base

La base conceptual es una pantalla vertical repetible. PC horizontal equivale a tres pantallas verticales juntas.

Base PC:

```txt
1280 x 720
16:9
```

Base movil vertical sugerida:

```txt
720 x 1280
9:16
```

Regla:

- Disenar cada pantalla funcional como si pudiera vivir sola en vertical.
- En PC, componer las tres pantallas en horizontal.
- En movil, mostrar una pantalla a la vez con controles tactiles.

## 6. Assets principales requeridos

Los primeros assets reales de esta nueva direccion deben contemplar PC horizontal y pantalla vertical individual:

```txt
game/assets/ui/cockpit/cockpit_three_screens_pc.png
game/assets/ui/cockpit/mobile_screen_frame.png
```

Medida:

```txt
cockpit_three_screens_pc.png: 1280 x 720
mobile_screen_frame.png: 720 x 1280
```

`cockpit_three_screens_pc.png` debe contener:

- fondo de cabina;
- tres monitores verticales;
- marcos fisicos industriales;
- consola inferior;
- desgaste, tornillos, metal, polvo;
- espacios claros donde se colocara texto encima.

`mobile_screen_frame.png` debe contener:

- un monitor vertical casi completo;
- marco fisico;
- vidrio/suciedad;
- espacio central amplio para texto;
- zona inferior para tabs/decisiones.

No debe contener:

- texto jugable;
- botones con texto;
- documentos escritos;
- iconografia protegida;
- detalles tan fuertes que impidan leer encima.

## 7. Rectangulos UI base

Los textos y controles actuales deben colocarse dentro de tres rectangulos funcionales. Estos rectangulos deben servir tanto para PC como para movil.

Propuesta PC horizontal:

```txt
Pantalla 1 / Solicitante:
x: 24
y: 88
w: 360
h: 500

Pantalla 2 / Expediente:
x: 410
y: 78
w: 460
h: 520

Pantalla 3 / Herramientas:
x: 896
y: 88
w: 360
h: 500

Consola inferior:
x: 180
y: 620
w: 920
h: 80
```

Propuesta movil vertical:

```txt
Pantalla activa:
x: 32
y: 96
w: 656
h: 850

Tabs 1/2/3:
x: 32
y: 970
w: 656
h: 70

Decisiones:
x: 32
y: 1060
w: 656
h: 180
```

Regla:

- Cada pantalla funcional debe poder operar sola.
- En PC se ven las tres pantallas al mismo tiempo.
- En movil se muestra una pantalla activa y se cambia con `1/2/3`.
- No meter los tres monitores completos en movil vertical.
- No rotar ni inclinar labels, botones o areas de texto.
- Si una pantalla lateral se ve en perspectiva, su UI jugable debe ir dentro de una zona util rectangular.

## 8. Capas visuales

Orden recomendado:

```txt
1. fondo de cabina PC o marco movil
2. UI/texto de Godot dentro de pantalla(s) funcional(es)
3. scanlines por monitor o globales
4. vidrio/suciedad encima
5. foco/parallax leve en PC o transicion amplia en movil
6. efectos animados sutiles
```

Importante:

- El vidrio debe ir encima del texto, pero con opacidad baja.
- La suciedad debe notarse en pantalla completa, no impedir leer.
- Las animaciones deben ser sutiles.

## 9. Estructura de carpetas

Crear o usar:

```txt
game/assets/ui/cockpit/
game/assets/ui/overlays/
game/assets/ui/buttons/
game/assets/ui/panels/
```

Assets nuevos previstos:

```txt
cockpit_three_screens_pc.png
mobile_screen_frame.png
monitor_glass_left.png
monitor_glass_center.png
monitor_glass_right.png
monitor_scanlines.png
console_button_frame_9patch.png
scan_sweep_overlay.png
glitch_band_overlay.png
```

## 10. Fases de implementacion

### Paso 1 — Mockups base PC + movil

Objetivo:

Crear o importar los dos fondos base que comparten la misma estructura de tres pantallas:

Archivos:

- `game/assets/ui/cockpit/cockpit_three_screens_pc.png`
- `game/assets/ui/cockpit/mobile_screen_frame.png`

Criterio de aceptacion:

- La cabina PC se entiende sin texto.
- Las tres pantallas PC tienen espacio suficiente para UI legible.
- El marco movil permite mostrar una pantalla vertical completa.
- Ambos formatos comparten la misma logica 1/2/3.
- No hay iconografia riesgosa.

Estado:

```txt
Ejecutado como mockup base reemplazable.
```

Assets creados:

```txt
game/assets/ui/cockpit/cockpit_three_screens_pc.png
game/assets/ui/cockpit/mobile_screen_frame.png
```

Notas:

- Son placeholders funcionales para medir y reorganizar UI.
- No son arte final.
- Mantienen texto fuera de la imagen.
- Permiten avanzar al Paso 2: medir rectangulos exactos.

### Paso 2 — Medir monitores

Objetivo:

Definir rectangulos exactos para PC y movil.

Entregable:

```txt
pc_screen_1_rect
pc_screen_2_rect
pc_screen_3_rect
pc_console_rect
mobile_active_screen_rect
mobile_tabs_rect
mobile_decisions_rect
```

Criterio de aceptacion:

- Cada panel actual tiene un destino claro.
- El texto cabe dentro de cada monitor.

### Paso 3 — Reorganizar ControlDesk

Objetivo:

Adaptar la escena principal a la cabina sin cambiar logica de juego.

Cambios:

- Fondo de cabina full screen segun vista activa.
- PC: tres pantallas visibles al mismo tiempo.
- Movil: una pantalla activa visible.
- Pantalla 1: panel solicitante/interrogatorio.
- Pantalla 2: documentos/escaner.
- Pantalla 3: herramientas/alertas/regulaciones.
- Botones de decision sobre consola inferior.

No tocar:

- reglas;
- JSON;
- DecisionSystem;
- RuleEngine;
- NarrativeState;
- flujo de dias.

Criterio de aceptacion:

- El juego funciona igual.
- La UI se percibe como una cabina de tres pantallas en PC.
- La UI se percibe como un monitor vertical navegable en movil.
- Se puede aprobar, rechazar, retener, escanear y preguntar igual que antes.
- El texto permanece recto y legible en todos los modos.

### Paso 4 — Navegacion 1/2/3 y giro de mirada

Objetivo:

Implementar la navegacion entre pantallas como parte del flujo principal de la UI.

Controles:

```txt
1 = pantalla solicitante/interrogatorio
2 = pantalla expediente/documentos
3 = pantalla herramientas/alertas/regulaciones
```

Comportamiento PC:

- Las tres pantallas siguen visibles.
- La pantalla activa recibe foco visual.
- Las pantallas no activas bajan intensidad o quedan como contexto.
- El cambio debe sentirse como enfocar otro monitor, no como cambiar de menu.
- El movimiento debe ser leve: pequeno parallax, pulso de brillo o desplazamiento sutil.

Comportamiento movil:

- Solo una pantalla principal queda visible.
- `1/2/3` o tabs tactiles cambian la pantalla activa.
- El cambio puede ser amplio: slide, paneo o transicion de mirada.
- La pantalla activa ocupa casi todo el espacio vertical disponible.

No hacer:

- No rotar texto.
- No deformar UI con perspectiva.
- No ocultar botones de decision durante el cambio.
- No perder estado del caso, documento activo, alertas ni escaner usado.

Criterio de aceptacion:

- `1/2/3` cambia pantalla activa sin romper otros atajos.
- En PC se entiende que el jugador enfoca otra pantalla.
- En movil se entiende que el jugador cambia a otra pantalla vertical.
- El texto sigue recto y legible.
- El estado del caso no se reinicia al cambiar de pantalla.

### Paso 5 — Adaptar DayReport

Objetivo:

Mostrar el reporte usando la misma cabina o una variante de pantalla de auditoria.

Opciones:

- usar vista central para reporte principal;
- en PC, usar laterales para resumen/incidentes;
- en movil, usar pantallas 1/2/3 para resumen, auditoria e incidentes;
- mantener reporte actual temporalmente si el cambio pone en riesgo el MVP.

Criterio de aceptacion:

- El reporte sigue siendo legible.
- No se pierde informacion de auditoria.

### Paso 6 — Vidrio y suciedad por monitor

Objetivo:

Aplicar capas de vidrio fisico encima de cada monitor.

Assets:

```txt
monitor_glass_left.png
monitor_glass_center.png
monitor_glass_right.png
```

Criterio de aceptacion:

- Se siente como vidrio grueso y viejo.
- No tapa texto.

### Paso 7 — Animaciones sutiles

Objetivo:

Agregar vida de terminal sin convertirlo en arcade.

Efectos:

- flicker muy leve;
- barrido horizontal;
- glitch corto al cambiar solicitante;
- barrido de escaner;
- pulso suave en alertas.

Implementacion recomendada:

```txt
game/scripts/ui/TerminalEffects.gd
```

Criterio de aceptacion:

- La cabina se siente viva.
- No distrae de leer documentos.

### Paso 8 — QA visual

Objetivo:

Validar que el cambio grande no rompa la jugabilidad.

Checklist:

- texto legible en 1280x720;
- texto legible en 720x1280;
- botones clicables;
- botones tactiles grandes en movil;
- scroll si hace falta;
- preguntas caben en pantalla 1;
- documentos caben en pantalla 2;
- alertas caben en pantalla 3;
- teclas `1/2/3` cambian de vista sin romper atajos actuales;
- debug con Y no queda inutilizable;
- reporte final sigue claro.

## 11. Reglas de diseno

- Primero cabina, despues efectos.
- Primero legibilidad, despues suciedad.
- Primero estructura comun PC/movil, despues perspectiva decorativa.
- Texto recto siempre; perspectiva solo en arte y efectos.
- No poner texto jugable dentro de imagenes.
- No hacer todo verde brillante.
- No usar simbolos de IP externa.
- No redisenar sistemas de juego durante este cambio.
- Mantener el cambio dividido en fases.

## 12. Estado actual

Estado:

```txt
Paso 1 ejecutado con mockups base reemplazables.
Pendiente Paso 2: medir rectangulos exactos para PC y movil.
```

Notas:

- Los assets anteriores de overlays y paneles pueden quedar como material temporal.
- La direccion anterior de UI plana queda descartada como objetivo final.
- El foco base ahora es comun: tres pantallas verticales.
- PC horizontal muestra las tres pantallas juntas.
- Movil vertical muestra una pantalla a la vez.
- El siguiente trabajo debe empezar por `cockpit_three_screens_pc.png` y `mobile_screen_frame.png`.
