# Plan de assets visuales — El Ultimo Sello

Este documento guia la produccion e integracion de assets graficos para la terminal de **El Ultimo Sello**.

Debe consultarse antes de crear, pedir, importar o integrar cualquier asset visual de UI, terminal, documentos, botones, iconos, overlays o pantallas de reporte.

## 1. Proposito

Crear una ruta de trabajo paso a paso para mejorar el apartado grafico sin romper:

- la legibilidad de la UI;
- el alcance del MVP;
- la identidad visual propia;
- la estructura tecnica de Godot 4;
- la separacion entre arte, datos y codigo.

Este documento no reemplaza a `CLAUDE.md`. Lo complementa para tareas visuales.

## 2. Documentos base obligatorios

Antes de trabajar en assets visuales, consultar:

1. `CLAUDE.md` — reglas principales para agentes.
2. `PROJECT.md` — vision y direccion visual oficial.
3. `GAME_DESIGN.md` — funcion jugable de la terminal y documentos.
4. `TECHNICAL_SPEC.md` — estructura tecnica Godot 4.
5. `IP_SAFETY.md` — limites visuales para evitar similitud con IP externa.

Si la tarea es solo produccion grafica, este archivo debe ser la guia operativa principal despues de `CLAUDE.md`.

## 3. Direccion visual

La direccion oficial es:

> Retrofuturismo burocratico analogico.

La UI debe sentirse como una terminal administrativa vieja, institucional, pesada y opresiva. No debe parecer una interfaz futurista limpia ni depender solo de texto verde plano.

Prioridades visuales:

1. Legibilidad.
2. Tension burocratica.
3. Identidad propia.
4. Claridad de decision.
5. Atmosfera opresiva.

Evitar:

- pixel art como obligacion;
- hologramas modernos y limpios;
- UI decorativa que dificulte comparar datos;
- simbolos o siluetas demasiado cercanas a franquicias existentes;
- interfaz monocromatica sin jerarquia.

## 4. Resolucion base y escalado

Resolucion base del juego:

```txt
1280 x 720
```

Aspecto objetivo:

```txt
16:9
```

Configuracion recomendada en Godot:

```txt
Viewport Width: 1280
Viewport Height: 720
Stretch Mode: canvas_items
Stretch Aspect: keep
```

Los assets deben disenarse para 1280x720 y dejar que Godot escale la UI. No crear versiones separadas por cada resolucion mientras el objetivo sea PC 16:9.

## 5. Carpeta recomendada

Crear esta estructura cuando empiece la integracion real:

```txt
game/assets/ui/terminal/
game/assets/ui/panels/
game/assets/ui/buttons/
game/assets/ui/icons/
game/assets/ui/overlays/
game/assets/fonts/
```

Si Godot ya tiene una estructura de assets distinta al momento de implementar, respetar la estructura existente y documentar la decision.

## 6. Kit visual minimo del terminal

El primer objetivo no es hacer todo el arte final. Es crear un kit minimo reutilizable:

```txt
terminal_background.png
scanline_overlay.png
panel_frame_9patch.png
button_normal_9patch.png
button_hover_9patch.png
button_pressed_9patch.png
button_danger_9patch.png
alert_icon.png
seal_icon.png
scanner_frame.png
```

Este kit debe permitir mejorar:

- pantalla principal del puesto;
- paneles de documentos;
- botones de decision;
- alertas;
- reporte final del dia;
- cierres terminales.

## 7. Medidas iniciales recomendadas

Usar estas medidas como punto de partida. La medida definitiva debe verificarse en Godot revisando el `Size` de cada `Control`.

| Asset | Medida base |
| --- | --- |
| Fondo completo de terminal | 1280x720 |
| Overlay de scanlines | 1280x720 |
| Panel principal | 1200x620 aprox. |
| Panel de reporte | 1200x500 aprox. |
| Boton grande | 260x52 aprox. |
| Boton con dos lineas | 260x60 o 280x64 |
| Icono pequeno | 24x24 o 32x32 |
| Icono de alerta | 48x48 o 64x64 |
| Textura NinePatch | 64x64, 96x96 o 128x128 |

Para paneles y botones escalables, preferir `NinePatchRect` o `StyleBoxTexture` en vez de imagenes planas rigidas.

## 8. Flujo por pasos

## Referencias visuales recibidas

Estas referencias vienen de capturas compartidas por el desarrollador y deben usarse como memoria visual del estado actual antes de crear assets.

### Foto 1 - Pantalla principal durante un caso

Estado observado:

- Resolucion visible: 1280x720.
- Layout dividido en 4 zonas: encabezado superior, panel izquierdo de solicitante/dialogo, panel central de documentos, panel derecho de herramientas, barra inferior de decisiones.
- Estilo actual: fondo verde oscuro, lineas finas verde fosforo, texto verde, botones planos de color.
- Documento principal muy centrado y con mucho espacio vacio.
- Botones de decision ya tienen jerarquia por color: aprobar verde, retener amarillo/marron, rechazar rojo.

Necesidades visuales:

- Fondo de terminal completo.
- Marcos/paneles con mas peso institucional.
- Estilos de botones con estados normal, hover, pressed y disabled.
- Jerarquia visual mas rica para documentos sin perder lectura.

### Foto 2 - Alerta/escaner activo

Estado observado:

- El resultado del escaner reemplaza el contenido del documento central.
- Panel derecho muestra estado de escaner usado.
- El resultado textual es claro, pero visualmente se parece demasiado al documento normal.

Necesidades visuales:

- Asset o marco propio para informe de escaner.
- Icono de escaner o sello tecnico.
- Diferenciar visualmente "sin anomalias" de "alerta real".
- Overlay sutil o cabecera tecnica para que el escaner se sienta como herramienta, no como otro texto plano.

### Foto 3 - Reporte del turno parte 1

Estado observado:

- Reporte usa cabecera superior, bloque de resumen, auditoria del turno y botones inferiores.
- El scroll vertical aparece en el lado derecho.
- La auditoria es legible, pero todos los bloques se sienten muy parecidos.

Necesidades visuales:

- Marco de reporte/auditoria institucional.
- Separadores visuales por expediente.
- Estilo diferente para resumen, auditoria e incidentes.
- Mejor jerarquia para "expediente validado/observado".

### Foto 4 - Reporte del turno parte 2

Estado observado:

- La lista larga de expedientes se mantiene legible.
- Mucho texto comparte el mismo tono verde.
- Los casos importantes pueden perderse dentro del scroll.

Necesidades visuales:

- Estados visuales por expediente: validado, observado, sancionado, incidente.
- Pequenos iconos o sellos para destacar entradas relevantes.
- Espaciado y separadores mas expresivos.

### Foto 5 - Reporte del turno parte 3

Estado observado:

- El bloque final de consecuencia narrativa aparece despues de la auditoria.
- La consecuencia e incidentes son importantes, pero visualmente no dominan tanto como deberian.
- Botones inferiores permanecen claros.

Necesidades visuales:

- Panel especial para dictamen de rendimiento.
- Panel de incidentes del turno.
- Variante visual de cierre terminal cuando exista.
- Posible sello institucional o alerta roja/ambar para consecuencias graves.

### Diagnostico visual inicial

La UI actual ya funciona y es legible. El problema no es de estructura, sino de identidad y jerarquia visual. La primera mejora no debe redibujar todo: debe vestir la terminal con assets modulares.

Prioridad recomendada:

1. `terminal_background.png` y `scanline_overlay.png`.
2. `panel_frame_9patch.png`.
3. `button_*_9patch.png`.
4. Marco especial para escaner.
5. Marco especial para reporte y consecuencia narrativa.

### Paso 1 — Inventario visual actual

Objetivo:
Registrar que pantallas y controles existen antes de crear assets.

Acciones:

- Revisar escenas principales en `game/scenes/main/`.
- Revisar scripts UI en `game/scripts/ui/`.
- Identificar botones, paneles, labels, reportes, alertas y documentos.
- Anotar medidas aproximadas de los controles principales.

Entregable:

- Lista de elementos UI a intervenir.
- Medidas base de cada elemento.
- Prioridad: alta, media o baja.

Criterio de aceptacion:

- Se sabe que asset necesita cada zona de la UI.

#### Inventario realizado - estado actual

Base tecnica observada:

- Escenas revisadas: `ControlDesk.tscn` y `DayReport.tscn`.
- Scripts UI revisados: `ControlDesk.gd` y `DayReport.gd`.
- La UI usa `ColorRect`, `PanelContainer`, `VBoxContainer`, `HBoxContainer`, `Button`, `Label` y `ScrollContainer`.
- Los estilos actuales se aplican por codigo con `StyleBoxFlat`.
- Esto permite integrar assets progresivamente con `TextureRect`, `NinePatchRect` o `StyleBoxTexture`, sin tocar reglas, decisiones ni JSON.

Resolucion y layout base:

```txt
Pantalla base: 1280x720
StatusBar: 44 px alto
DecisionBar/Footer: 72 px alto
Area principal aproximada: 1280x604
Panel solicitante: 270 px ancho
Panel herramientas: 190 px ancho
Panel documentos: ancho flexible, aprox. 820 px
Botones principales: 220x52 px
Botones de reporte: 280x50 px
```

| Zona | Nodo / escena | Medida aproximada | Asset recomendado | Prioridad |
| --- | --- | --- | --- | --- |
| Fondo general de terminal | `BG` en `ControlDesk` y `DayReport` | 1280x720 | `terminal_background.png` + `scanline_overlay.png` | Alta |
| Barra superior del puesto | `StatusBar` | 1280x44 | `panel_header_9patch.png` o estilo compartido | Media |
| Panel solicitante | `ApplicantPanel` | 270x604 aprox. | `panel_frame_9patch.png` | Alta |
| Panel documentos | `DocumentArea` | 820x604 aprox. | `panel_frame_9patch.png` | Alta |
| Vista interna de documento | `DocumentView` | 796x522 aprox. | `document_view_9patch.png` | Alta |
| Pestañas de documentos | `Tab1`, `Tab2`, `Tab3` | 260x28 aprox. cada una | `tab_active_9patch.png`, `tab_inactive_9patch.png`, `tab_disabled_9patch.png` | Media |
| Panel herramientas | `ToolsPanel` | 190x604 aprox. | `panel_frame_9patch.png` | Alta |
| Boton escaner | `ScannerButton` | 174x34 aprox. | `button_tool_9patch.png`, icono opcional | Alta |
| Pestañas alertas/regulaciones | `TabAlertas`, `TabRegs` | 85x25 aprox. | `tab_small_*_9patch.png` | Baja |
| Barra inferior decisiones | `DecisionBar` | 1280x72 | `panel_footer_9patch.png` | Media |
| Botones aprobar/retener/rechazar | `ApproveButton`, `HoldButton`, `RejectButton` | 220x52 | `button_approve_*_9patch.png`, `button_hold_*_9patch.png`, `button_reject_*_9patch.png` | Alta |
| Botones de preguntas | creados por `ControlDesk.gd` | 250x30 aprox. | `button_question_9patch.png` | Media |
| Reporte - cabecera | `Header` en `DayReport` | 1280x52 | `panel_header_9patch.png` | Media |
| Reporte - resumen | `SummaryPanel` | 1260x150 aprox. variable | `report_summary_9patch.png` | Media |
| Reporte - auditoria | `DecisionsPanel` | 1260xvariable | `report_audit_9patch.png` | Alta |
| Reporte - consecuencia | `ConsequencePanel` | 1260xvariable | `report_consequence_9patch.png` | Alta |
| Reporte - cierre terminal | `ConsequencePanel` con estilo rojo | 1260xvariable | `report_terminal_9patch.png` | Alta |
| Reporte - botones inferiores | `RestartBtn`, continue button dinamico | 280x50 | `button_report_*_9patch.png` | Media |
| Debug con Y | panel dinamico | 390-420 px ancho | Mantener estilo tecnico simple, no prioridad de arte | Baja |

#### Lectura de riesgo visual

- Riesgo principal: que el overlay o los marcos decorativos reduzcan la legibilidad.
- Riesgo secundario: que botones con texturas fijas no soporten dos lineas, especialmente `RETENER / Enviar a revision`.
- Riesgo tecnico: actualmente no hay carpeta `game/assets/`; se debe crear recien en Paso 3.
- Decision recomendada: comenzar con assets `NinePatch` para paneles y botones, mas un fondo/overlay en `TextureRect`.

### Paso 2 — Definir kit grafico minimo

Objetivo:
Decidir exactamente que imagenes se van a producir primero.

Acciones:

- Confirmar el kit minimo del punto 6.
- Definir si cada asset sera `PNG`, `WEBP`, `SVG` o NinePatch.
- Definir nombres finales de archivo.
- Definir que pantalla usara cada asset.

Entregable:

- Tabla de assets con nombre, formato, medida y uso.

Criterio de aceptacion:

- No hay assets ambiguos ni duplicados innecesarios.

#### Kit grafico minimo definido

El kit se divide en dos tandas. La primera tanda debe producirse antes de integrar arte en escenas. La segunda queda preparada para cuando el primer look funcione en juego.

##### Tanda 1 - Integracion visual base

| Archivo final | Carpeta destino | Formato | Medida base | Tipo Godot recomendado | Uso |
| --- | --- | --- | --- | --- | --- |
| `terminal_background.png` | `game/assets/ui/terminal/` | PNG | 1280x720 | `TextureRect` | Fondo general del puesto y reporte. Debe ser oscuro, sobrio y no competir con texto. |
| `scanline_overlay.png` | `game/assets/ui/overlays/` | PNG con alpha | 1280x720 | `TextureRect` | Scanlines, ruido o desgaste sutil. Opacidad baja. |
| `panel_frame_9patch.png` | `game/assets/ui/panels/` | PNG NinePatch | 96x96 o 128x128 | `StyleBoxTexture` / `NinePatchRect` | Panel general reutilizable para solicitante, documentos, herramientas y bloques de reporte. |
| `document_view_9patch.png` | `game/assets/ui/panels/` | PNG NinePatch | 96x96 o 128x128 | `StyleBoxTexture` / `NinePatchRect` | Interior del documento o area central de lectura. Debe ser mas oscuro que el panel general. |
| `button_approve_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x64 | `StyleBoxTexture` | Boton APROBAR. Verde institucional, legible. |
| `button_hold_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x64 | `StyleBoxTexture` | Boton RETENER. Debe soportar dos lineas de texto. |
| `button_reject_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x64 | `StyleBoxTexture` | Boton RECHAZAR. Rojo oscuro, grave, no chillón. |
| `button_tool_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x48 | `StyleBoxTexture` | Boton de ESCANER y herramientas. Azul/verde tecnico. |
| `scanner_frame_9patch.png` | `game/assets/ui/panels/` | PNG NinePatch | 96x96 o 128x128 | `StyleBoxTexture` / `NinePatchRect` | Variante visual para informe de escaner dentro del panel central. |

##### Tanda 2 - Reporte, estados e iconos

| Archivo final | Carpeta destino | Formato | Medida base | Tipo Godot recomendado | Uso |
| --- | --- | --- | --- | --- | --- |
| `report_summary_9patch.png` | `game/assets/ui/panels/` | PNG NinePatch | 96x96 o 128x128 | `StyleBoxTexture` | Bloque RESUMEN del reporte. |
| `report_audit_9patch.png` | `game/assets/ui/panels/` | PNG NinePatch | 96x96 o 128x128 | `StyleBoxTexture` | Bloque AUDITORIA DEL TURNO. |
| `report_consequence_9patch.png` | `game/assets/ui/panels/` | PNG NinePatch | 96x96 o 128x128 | `StyleBoxTexture` | Dictamen de rendimiento e incidentes. |
| `report_terminal_9patch.png` | `game/assets/ui/panels/` | PNG NinePatch | 96x96 o 128x128 | `StyleBoxTexture` | Cierre terminal. Variante roja/ambar de emergencia. |
| `tab_active_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x32 | `StyleBoxTexture` | Pestaña activa de documentos y herramientas. |
| `tab_inactive_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x32 | `StyleBoxTexture` | Pestaña inactiva. |
| `tab_disabled_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x32 | `StyleBoxTexture` | Pestaña bloqueada o documento ausente. |
| `button_question_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 96x40 | `StyleBoxTexture` | Botones de interrogatorio. |
| `button_report_9patch.png` | `game/assets/ui/buttons/` | PNG NinePatch | 128x64 | `StyleBoxTexture` | Reiniciar dia / continuar dia. |
| `alert_icon.png` | `game/assets/ui/icons/` | PNG con alpha | 32x32 o 48x48 | `TextureRect` | Alertas de regla, riesgo o consecuencia. |
| `seal_icon.png` | `game/assets/ui/icons/` | PNG con alpha | 32x32 o 48x48 | `TextureRect` | Sello institucional, validacion o auditoria. |
| `scanner_icon.png` | `game/assets/ui/icons/` | PNG con alpha | 32x32 | `TextureRect` | Boton o encabezado de escaner. |

#### Estados por asset

Para botones, evitar crear cuatro archivos por estado al inicio. Primero producir una textura base por tipo de boton y usar modulacion o estilos en Godot para:

- normal;
- hover;
- pressed;
- disabled.

Solo crear archivos separados por estado si la textura base no escala bien o si el resultado visual queda pobre.

#### Reglas para los NinePatch

- Mantener esquinas y bordes con detalle.
- Dejar el centro simple y oscuro.
- No poner texto dentro del asset.
- Reservar margenes internos amplios para labels.
- Diseñar pensando en escalado horizontal y vertical.

Medidas recomendadas:

```txt
Paneles: 128x128
Botones principales: 96x64
Botones pequenos/tabs: 96x32 o 96x40
Iconos: 32x32 o 48x48
Fondos/overlays: 1280x720
```

#### Criterio de cierre del Paso 2

El Paso 2 queda cerrado con esta lista. Para pasar al Paso 3 no hace falta crear todos los assets: basta con producir o importar la Tanda 1.

### Paso 3 — Crear o importar assets base

Objetivo:
Generar o incorporar los archivos graficos sin conectarlos todavia a la logica.

Acciones:

- Crear las carpetas de assets.
- Importar los archivos.
- Mantener nombres simples y consistentes.
- Evitar referencias visuales de IP externa.

Entregable:

- Assets dentro de `game/assets/`.

Criterio de aceptacion:

- Godot importa los assets sin errores.

#### Paso 3 ejecutado - Tanda 1 base

Se creo la estructura inicial de carpetas:

```txt
game/assets/ui/terminal/
game/assets/ui/panels/
game/assets/ui/buttons/
game/assets/ui/icons/
game/assets/ui/overlays/
game/assets/fonts/
```

Assets base generados:

| Archivo | Estado | Nota |
| --- | --- | --- |
| `game/assets/ui/terminal/terminal_background.png` | Creado | Fondo 1280x720 oscuro con grilla institucional sutil. |
| `game/assets/ui/overlays/scanline_overlay.png` | Creado | Overlay 1280x720 con scanlines transparentes. |
| `game/assets/ui/panels/panel_frame_9patch.png` | Creado | Marco general 128x128. |
| `game/assets/ui/panels/document_view_9patch.png` | Creado | Marco oscuro para area de documento. |
| `game/assets/ui/panels/scanner_frame_9patch.png` | Creado | Marco tecnico azulado para informe de escaner. |
| `game/assets/ui/buttons/button_approve_9patch.png` | Creado | Base verde para aprobar. |
| `game/assets/ui/buttons/button_hold_9patch.png` | Creado | Base ambar para retener. |
| `game/assets/ui/buttons/button_reject_9patch.png` | Creado | Base roja para rechazar. |
| `game/assets/ui/buttons/button_tool_9patch.png` | Creado | Base azul/tecnica para escaner y herramientas. |

Notas:

- Estos assets son una primera base funcional, no arte final.
- Deben poder reemplazarse por versiones mejores sin cambiar nombres ni rutas.
- Antes de integrarlos en escenas, Godot debe importarlos y generar sus `.import`.
- El siguiente paso debe probarlos en UI real y ajustar margen/escala si el NinePatch se deforma.

### Paso 4 — Integrar fondo, overlays y marcos

Objetivo:
Aplicar el look de terminal sin cambiar reglas, decisiones ni datos.

Acciones:

- Usar `TextureRect` para fondo completo.
- Usar overlay sutil para scanlines/glitch.
- Usar `NinePatchRect` o estilos equivalentes para paneles.
- Mantener texto legible.

Entregable:

- Terminal principal con identidad visual mejorada.

Criterio de aceptacion:

- La pantalla se ve mas propia sin perder claridad.

#### Paso 4 ejecutado - Integracion base

Archivos modificados:

- `game/scripts/ui/ControlDesk.gd`
- `game/scripts/ui/DayReport.gd`

Integrado:

- Fondo visual `terminal_background.png` como `TextureRect` de pantalla completa.
- Overlay `scanline_overlay.png` como capa superior con opacidad baja y `mouse_filter = ignore`.
- `panel_frame_9patch.png` como base para paneles principales.
- `document_view_9patch.png` para el area interna de documentos.
- `scanner_frame_9patch.png` para el informe de escaner.
- Botones principales usando texturas base:
  - `button_approve_9patch.png`
  - `button_hold_9patch.png`
  - `button_reject_9patch.png`
  - `button_tool_9patch.png`

Decisiones tecnicas:

- La integracion se hizo por codigo para evitar reestructurar escenas.
- Si un asset no carga, el sistema cae al estilo plano anterior.
- El escaner cambia temporalmente el marco del area central y vuelve al marco de documento al seleccionar/cargar documentos.
- Los estados `hover`, `pressed` y `disabled` se generan por modulacion de la textura base, no con archivos separados.

Pendiente de validacion:

- Abrir Godot para que genere `.import`.
- Revisar si los margenes NinePatch necesitan ajuste fino.
- Confirmar que el overlay no reduce legibilidad.
- Confirmar que `RETENER / Enviar a revision` sigue cabiendo bien.

### Paso 5 — Integrar botones e iconos

Objetivo:
Mejorar las acciones del jugador y la lectura de alertas.

Acciones:

- Aplicar estilos a aprobar, rechazar y retener.
- Mantener labels claros:
  - `APROBAR`
  - `RECHAZAR`
  - `RETENER`
- Para `RETENER`, mantener subtitulo:
  - `Enviar a revision`
- Agregar tooltip:
  - `Usar cuando el expediente requiera verificacion adicional, custodia temporal o revision superior.`
- Agregar iconos solo si ayudan a leer la accion.

Entregable:

- Botones de decision y alertas visualmente diferenciados.

Criterio de aceptacion:

- El jugador entiende cada accion sin explicar el sistema fuera de la UI.

### Paso 6 — Mejorar documentos y reportes

Objetivo:
Hacer que documentos y auditoria final sean mas memorables sin ocultar informacion.

Acciones:

- Diferenciar visualmente tipos de documentos.
- Aplicar marcos o cabeceras por documento.
- Mantener campos comparables.
- Mejorar jerarquia en reporte final: resumen, auditoria, incidentes, cierre terminal.

Entregable:

- Documentos y reporte con mayor identidad institucional.

Criterio de aceptacion:

- La comparacion de datos sigue siendo rapida.

### Paso 7 — QA visual

Objetivo:
Validar que el arte no rompa la usabilidad.

Acciones:

- Probar en 1280x720.
- Probar escalado 1920x1080 si es posible.
- Revisar que no haya texto cortado.
- Revisar contraste de texto.
- Revisar que overlays no tapen informacion.
- Revisar que botones sigan siendo clicables.

Entregable:

- Lista de ajustes visuales.

Criterio de aceptacion:

- La UI se ve mejor y se juega igual o mas claro que antes.

## 9. Reglas de integracion en Godot

- Fondos completos: `TextureRect` con layout full rect.
- Paneles escalables: `NinePatchRect` o `StyleBoxTexture`.
- Botones escalables: estilos por estado normal, hover, pressed y disabled.
- Iconos simples: preferir PNG pequeno o SVG propio.
- Overlays: usar transparencia baja para no dañar lectura.
- Fuentes: importar en `game/assets/fonts/` y probar acentos si hay textos en espanol.
- No meter textos importantes dentro de imagenes si cambian por idioma o balance.

## 10. Criterios de aceptacion generales

Un asset esta listo cuando:

- respeta la direccion visual;
- no copia IP externa;
- funciona en 1280x720;
- escala sin deformarse cuando corresponde;
- no reduce legibilidad;
- tiene nombre claro;
- esta ubicado en la carpeta correcta;
- puede ser reemplazado sin tocar logica jugable.

## 11. Pendientes futuros

Estos puntos quedan para cuando el kit minimo funcione:

- variante visual para Dia 4 en adelante;
- estados de dano o alerta de terminal;
- animaciones sutiles de pantalla;
- vista del solicitante fuera de la terminal;
- identidad visual por faccion o institucion;
- assets para pagina de Steam y screenshots.
