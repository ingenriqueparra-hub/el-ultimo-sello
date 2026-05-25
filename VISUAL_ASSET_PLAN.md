# Plan visual - Layout vertical 320x740

Este documento define la direccion operativa actual para la UI principal de **El Ultimo Sello**.

La fuente de verdad visual inmediata es:

```txt
game/data/ui/mobile_layout_320x740.json
```

El objetivo ya no es integrar mockups generales ni assets temporales. El objetivo es construir una interfaz funcional, legible y fisica a partir de zonas medidas, assets puntuales y UI real de Godot.

## 1. Documentos base

Antes de tocar arte, UI o escenas visuales, consultar:

1. `CLAUDE.md`
2. `PROJECT.md`
3. `GAME_DESIGN.md`
4. `TECHNICAL_SPEC.md`
5. `IP_SAFETY.md`
6. `game/data/ui/mobile_layout_320x740.json`

Si hay conflicto, manda `CLAUDE.md`. Si el conflicto afecta nombres, simbolos o referencias visuales, manda `IP_SAFETY.md`.

## 2. Direccion visual activa

La pantalla principal debe sentirse como una terminal fisica de admision: vieja, pesada, institucional y opresiva.

La composicion activa es una pantalla vertical base:

```txt
320 x 740 px
```

Esta composicion incluye:

- barra superior de estado;
- panel de expediente;
- vista del solicitante;
- consola fisica inferior;
- area de escaner/documento;
- botones de decision;
- barra inferior de herramientas.

La version PC puede adaptar esta estructura a una composicion horizontal mas amplia, pero no debe imponer de nuevo un plan de tres monitores como requisito inmediato.

## 3. Contrato de layout

`mobile_layout_320x740.json` define:

- `canvas`: resolucion base;
- `zones`: zonas funcionales;
- `rect`: area visible total;
- `safe_rect`: area segura para texto, botones e input;
- `layers`: orden visual recomendado;
- `assets_to_create`: assets puntuales recomendados;
- `dynamic_ui`: elementos que Godot debe renderizar como UI real;
- `ip_risks`: elementos de referencia que no deben copiarse.

Reglas:

- `rect` y `safe_rect` son coordenadas absolutas dentro del canvas `320 x 740`.
- Todo texto jugable, numero, dato, tab, medidor, contador y boton debe ser UI real.
- Los assets no deben contener texto jugable, valores dinamicos ni datos de expediente.
- Los assets se piden por zona y medida exacta.
- No generar una imagen completa final con toda la UI pintada.

## 4. Zonas principales

Zonas base del layout vertical:

```txt
top_status_bar:        x 0   y 0    w 320 h 47
dossier_panel:         x 5   y 52   w 310 h 225
applicant_viewport:    x 5   y 282  w 310 h 232
desk_console_area:     x 0   y 514  w 320 h 106
decision_buttons:      x 5   y 620  w 310 h 72
tools_bar:             x 0   y 693  w 320 h 47
```

Subzonas importantes:

- `dossier_tabs`
- `portrait_area`
- `dossier_fields`
- `scan_status`
- `system_notes_area`
- `dialogue_box`
- `document_scanner_area`
- `scanner_device_area`
- `physical_stamp_area`
- `approve_button`
- `inspect_button`
- `deny_button`

## 5. Mapeo al MVP actual

El JSON puede contener nombres visuales de la referencia. Para el MVP se interpretan asi:

| Zona / elemento | Interpretacion MVP |
|---|---|
| `inspect_button` | Mapea a `RETENER`, no a un sistema nuevo de inspeccion. |
| `tools_bar` | Puede mostrar slots visuales, pero solo el escaner es funcional por ahora. |
| `suspicion_meter` | Indicador visual futuro; no introducir logica nueva sin diseno. |
| `tool_uv`, `tool_verifier`, `tool_alert`, `tool_registry` | Futuro / bloqueado / decorativo hasta que entren al backlog. |
| `applicant_character_area` | Asset visual dinamico futuro; no debe bloquear el loop actual. |
| `overlay_area` | Reservado para reglamento, alertas o confirmaciones. |

No tocar durante la migracion visual:

- reglas;
- datos de solicitantes;
- datos de documentos;
- `DecisionSystem`;
- `RuleEngine`;
- `NarrativeStateSystem`;
- flujo de dias.

## 6. Capas visuales

Orden recomendado segun el JSON:

```txt
0. background_base
1. physical_scene_assets
2. character_layer
3. frame_layer
4. hud_static_controls
5. hud_dynamic_text
6. hud_dynamic_icons
7. effects_layer
8. modal_overlay_layer
```

Reglas:

- Primero layout, despues arte.
- Primero legibilidad, despues efectos.
- Vidrio, suciedad, scanlines, glitch y brillos son capas posteriores.
- No reintroducir desgaste global hasta validar que el texto se lee bien.

## 7. Assets a crear

Los assets se crean por zona, usando `assets_to_create` del JSON.

Prioridad recomendada:

```txt
1. frame_dossier_panel.png
2. bg_applicant_checkpoint_view.png
3. bg_desk_console.png
4. frame_document_scanner.png
5. frame_button_green.png
6. frame_button_yellow.png
7. frame_button_red.png
8. frame_top_status_bar.png
```

Luego:

```txt
9. prop_scanner_device.png
10. prop_physical_stamp.png
11. prop_rulebook_closed.png
12. frame_portrait_scan.png
13. applicant_worker_sprite.png
14. frame_tool_slot.png
```

Reglas para pedir assets:

- pedir una sola zona por prompt cuando sea posible;
- usar la medida exacta de `target_size`;
- pedir fondo transparente cuando el JSON lo indique;
- exigir que no tenga texto jugable;
- exigir que no tenga iconografia protegida;
- usar identidad propia: MAP-7, sello geometrico, torre, archivo, ojo tecnico, llave, circuito.

## 8. Estructura de carpetas

Usar o crear:

```txt
game/data/ui/
game/assets/ui/cockpit/
game/assets/ui/overlays/
game/assets/ui/buttons/
game/assets/ui/panels/
game/assets/ui/props/
game/assets/ui/portraits/
```

Nota:

Los assets temporales anteriores bajo `game/assets/ui/` fueron retirados del repositorio. No reintroducirlos salvo que se generen de nuevo desde el contrato JSON y cumplan estas reglas.

## 9. Fases de implementacion

### Paso 1 - Registrar contrato de layout

Objetivo:

Mantener `game/data/ui/mobile_layout_320x740.json` como referencia de medicion.

Criterio de aceptacion:

- el JSON existe;
- incluye `zones`, `layers`, `assets_to_create`, `dynamic_ui`, `ip_risks`;
- no contiene assets ni texto jugable fijo;
- esta documentado en `TECHNICAL_SPEC.md`, `MVP_BACKLOG.md` y este archivo.

Estado:

```txt
Ejecutado.
```

### Paso 2 - Prototipo visual sin assets finales

Objetivo:

Reorganizar `ControlDesk` segun las zonas del layout usando nodos `Control`, `PanelContainer`, `Button`, `Label` y estilos por codigo.

Criterio de aceptacion:

- el juego funciona igual;
- aprobar, retener, rechazar, escanear y preguntar siguen operativos;
- el layout se aproxima al mapa `320 x 740`;
- no se agregan sistemas nuevos;
- no se introducen assets temporales innecesarios.

### Paso 3 - Integrar assets prioritarios

Objetivo:

Reemplazar rectangulos base por assets puntuales generados segun `assets_to_create`.

Criterio de aceptacion:

- cada asset corresponde a una zona concreta;
- no contiene texto jugable;
- no reduce legibilidad;
- no usa simbolos de IP externa;
- puede reemplazarse sin tocar la logica.

### Paso 4 - Adaptar DayReport

Objetivo:

Adaptar el reporte final a la misma direccion visual sin perder auditoria institucional.

Criterio de aceptacion:

- reporte legible;
- auditoria completa de dias 1-7 se conserva;
- no muestra acumuladores internos al jugador normal;
- debug con `Y` sigue utilizable.

### Paso 5 - Efectos sutiles

Objetivo:

Agregar vida visual despues de validar layout y legibilidad.

Efectos permitidos:

- flicker leve;
- barrido de escaner;
- pulso en alertas;
- feedback visual por decision;
- glitch corto y no invasivo.

Criterio de aceptacion:

- no distrae de leer documentos;
- no tapa texto;
- se puede desactivar o reducir facilmente.

### Paso 6 - QA visual

Checklist:

- texto legible en base vertical;
- botones clicables;
- areas tactiles suficientemente grandes;
- documentos caben en `dossier_panel`;
- dialogo cabe en `dialogue_box`;
- herramientas no compiten con decisiones;
- debug con `Y` sigue accesible;
- no hay rutas a assets eliminados;
- no hay iconografia riesgosa.

## 10. Reglas de diseno

- UI como nucleo, no decoracion.
- Texto recto siempre.
- Perspectiva solo en arte, marcos o fondos.
- No poner texto jugable dentro de imagenes.
- No usar simbolos de IP externa.
- No hacer todo verde brillante.
- No redisenar sistemas de juego durante cambios visuales.
- No agregar herramientas funcionales fuera del MVP sin tarea separada.
- Mantener el cambio dividido en fases.

## 11. Estado actual

Estado:

```txt
Contrato movil 320x740 definido.
Assets temporales retirados.
Pendiente: prototipo visual sin assets finales en ControlDesk.
```

Siguiente trabajo recomendado:

```txt
Implementar Paso 2 - Prototipo visual sin assets finales.
Base: game/data/ui/mobile_layout_320x740.json
No crear assets nuevos todavia.
No tocar RuleEngine, DecisionSystem ni datos de dias.
```
