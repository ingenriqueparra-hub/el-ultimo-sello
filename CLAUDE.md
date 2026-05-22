# Guía principal para agentes IA que trabajen en **El Último Sello**

Este archivo define cómo deben colaborar Claude Code, Codex y otros agentes IA en el desarrollo del proyecto.
Su objetivo es mantener coherencia narrativa, técnica, legal y de producto.

Este archivo funciona como **punto de entrada principal** del proyecto.
`AGENTS.md` existe como archivo secundario de compatibilidad para Codex y debe remitir a esta guía.
Si hay conflicto entre `CLAUDE.md` y `AGENTS.md`, priorizar `CLAUDE.md`.

Antes de diseñar, programar o modificar cualquier parte del juego, el agente debe usar este documento como router para saber qué archivos consultar, qué módulo tocar y qué límites respetar.

---

## 1. Rol general del agente

Actúa como un equipo compacto de desarrollo indie compuesto por:

- Game Designer.
- Narrative Designer.
- UX/UI Designer.
- Technical Designer.
- Producer.
- QA Analyst.
- Steam Marketing Strategist.
- Legal/IP Risk Reviewer.

El agente debe priorizar decisiones accionables, prototipables y orientadas a publicar en Steam.

---

## 2. Mapa de documentación del proyecto

Antes de diseñar, programar o modificar cualquier parte del proyecto, el agente debe leer y usar estos archivos como contexto base:

### 2.1. `PROJECT.md`

Fuente principal de:

- visión general;
- alcance;
- fantasía del jugador;
- principios de diseño;
- MVP;
- riesgos;
- criterio de éxito del prototipo;
- estado actual del proyecto.

Usar cuando la tarea tenga que ver con:

- dirección general del juego;
- alcance del producto;
- prioridades;
- decisiones de diseño de alto nivel;
- evaluación de riesgos;
- estado del proyecto.

---

### 2.2. `GAME_DESIGN.md`

Fuente principal de:

- loop jugable;
- decisiones base;
- tipos de solicitantes;
- tipos de documentos;
- inconsistencias;
- presión de tiempo;
- economía;
- progresión por días;
- condiciones de victoria.

Usar cuando la tarea tenga que ver con:

- mecánicas;
- reglas;
- documentos;
- decisiones del jugador;
- validación de casos;
- diseño de solicitantes;
- dificultad.

---

### 2.3. `TECHNICAL_SPEC.md`

Fuente principal de:

- motor recomendado;
- estructura de carpetas;
- modelos de datos;
- sistemas principales;
- estados del juego;
- arquitectura Godot 4;
- orden de implementación.

Usar cuando la tarea tenga que ver con:

- código;
- arquitectura;
- escenas;
- scripts;
- JSON;
- sistemas;
- estados;
- implementación del MVP.

---

### 2.4. `MVP_BACKLOG.md`

Fuente principal de:

- alcance cerrado del MVP;
- tareas priorizadas;
- criterios de aceptación;
- primeros 10 solicitantes;
- milestones;
- métricas de playtest.

Usar cuando la tarea tenga que ver con:

- qué construir primero;
- qué dejar fuera;
- tareas P0, P1 o P2;
- validación del MVP;
- orden de trabajo;
- control de alcance.

---

### 2.5. `NARRATIVE_BIBLE.md`

Fuente principal de:

- mundo;
- instituciones;
- tono;
- personajes recurrentes;
- conflicto central;
- lenguaje del mundo;
- tema central.

Usar cuando la tarea tenga que ver con:

- narrativa;
- nombres;
- facciones;
- diálogos;
- personajes;
- tono;
- ambientación;
- eventos narrativos.

---

### 2.6. `IP_SAFETY.md`

Fuente obligatoria para:

- evitar similitudes peligrosas con Warhammer 40k;
- evitar nombres protegidos;
- evitar iconografía reconocible;
- crear reemplazos originales;
- revisar riesgos de propiedad intelectual.

Usar siempre que la tarea tenga que ver con:

- nombres;
- facciones;
- símbolos;
- estética;
- lore;
- marketing público;
- enemigos;
- instituciones;
- referencias externas.

---

### 2.7. `STEAM_MARKETING.md`

Fuente principal de:

- posicionamiento;
- elevator pitch;
- descripción corta;
- descripción larga;
- features;
- tags;
- frases de venta;
- screenshots clave;
- trailer;
- público objetivo;
- diferenciador comercial.

Usar cuando la tarea tenga que ver con:

- Steam;
- marketing;
- página de tienda;
- pitch;
- trailer;
- screenshots;
- comunicación pública;
- diferenciación comercial.

---

### 2.8. `SKILLS.md`

Fuente principal de:

- capacidades necesarias;
- entregables esperados;
- disciplinas del proyecto;
- criterios de producción;
- reducción de alcance.

Usar cuando la tarea tenga que ver con:

- organización del equipo;
- definición de roles;
- revisión de entregables;
- producción;
- planificación;
- control de alcance.

---

## 3. Reglas de consulta obligatoria

Si la tarea requiere código, consultar primero:

1. `TECHNICAL_SPEC.md`
2. `MVP_BACKLOG.md`
3. `GAME_DESIGN.md`

Si la tarea requiere narrativa, nombres, facciones, diálogos o tono, consultar primero:

1. `NARRATIVE_BIBLE.md`
2. `IP_SAFETY.md`
3. `PROJECT.md`

Si la tarea cambia mecánicas, reglas, decisiones, documentos o progresión, consultar primero:

1. `GAME_DESIGN.md`
2. `MVP_BACKLOG.md`
3. `PROJECT.md`

Si la tarea afecta alcance, prioridades o MVP, consultar primero:

1. `PROJECT.md`
2. `MVP_BACKLOG.md`
3. `SKILLS.md`

Si la tarea afecta estética, símbolos, marketing público o referencias de franquicias externas, consultar primero:

1. `IP_SAFETY.md`
2. `STEAM_MARKETING.md`
3. `PROJECT.md`

---

## 4. Orden de prioridad entre documentos

Si hay conflicto entre documentos, priorizar en este orden:

1. `IP_SAFETY.md`
2. `PROJECT.md`
3. `MVP_BACKLOG.md`
4. `TECHNICAL_SPEC.md`
5. `GAME_DESIGN.md`
6. `NARRATIVE_BIBLE.md`
7. `STEAM_MARKETING.md`
8. `SKILLS.md`

La legalidad, la identidad propia y el alcance del MVP tienen prioridad sobre ideas nuevas, expansión narrativa o mejoras visuales.

---

## 5. Protocolo obligatorio antes de implementar

Antes de escribir código, modificar archivos o proponer una solución, el agente debe:

1. Identificar qué tipo de tarea está resolviendo:
   - Código;
   - Diseño;
   - Narrativa;
   - UI/UX;
   - QA;
   - Marketing;
   - Producción;
   - Legal/IP.

2. Consultar los documentos relacionados según el mapa de documentación.

3. Indicar brevemente qué archivos usó como base cuando la decisión pueda afectar arquitectura, alcance, narrativa o IP.

4. Implementar solo lo necesario para el MVP, salvo que el usuario indique explícitamente lo contrario.

5. No inventar sistemas grandes si no están en `MVP_BACKLOG.md` o `TECHNICAL_SPEC.md`.

6. No expandir narrativa, facciones, combate, exploración, economía compleja o finales múltiples si la tarea pertenece al MVP inicial.

---

## 6. Regla de planificación antes de código

Antes de escribir o modificar código, el agente debe indicar:

1. Qué archivos va a crear o modificar.
2. Qué función cumple cada archivo en una línea.
3. Qué módulo del MVP está trabajando.
4. Qué criterio de aceptación busca cumplir.

No debe hacer cambios grandes sin explicar primero el impacto.

Para cambios pequeños y evidentes, puede avanzar directamente, pero debe mantener el cambio limitado al objetivo pedido.

---

## 7. Orden modular de desarrollo

El agente debe trabajar por módulos. No debe saltar a módulos futuros si el módulo actual no está funcional.

### Módulo 1 — Estructura base Godot
Objetivo: crear estructura mínima del proyecto, carpetas, escena inicial y configuración base.

### Módulo 2 — Escena principal del puesto de control
Estado: Completado

Implementado:
- Escena `ControlDesk.tscn` con layout completo de 4 zonas.
- Panel izquierdo: solicitante (nombre, origen, destino, motivo, diálogo).
- Panel central: área de documentos con 3 pestañas y vista activa.
- Panel derecho: herramientas (escáner, alertas).
- Barra inferior: botones APROBAR (verde), RETENER (ámbar), RECHAZAR (rojo).
- Barra superior: día, título del puesto, créditos.
- Script `ControlDesk.gd` con tema verde fósforo aplicado por código.
- `Main.tscn` actualizado con botón COMENZAR que carga ControlDesk.
- Script `Main.gd` con navegación de escena.

Archivos principales:
- `game/scenes/main/ControlDesk.tscn`
- `game/scripts/ui/ControlDesk.gd`
- `game/scenes/main/Main.tscn`
- `game/scripts/ui/Main.gd`

Pendientes:
- Ninguno para Módulo 2.

---

### Módulo 3 — Sistema de carga de datos JSON
Estado: Completado

Implementado:
- `day_01.json` — configuración del día, fecha actual 298.12, lista de 10 solicitantes.
- `applicants_day_01.json` — 10 solicitantes completos con flags, truth y diálogo.
- `documents_day_01.json` — 17 documentos (transit_pass, bio_cert, ingress_permit) con campos comparables.
- `rules_day_01.json` — 4 reglas del Día 1 con tipo de validación y penalización.
- `DataLoader.gd` — clase estática con métodos load_day(), load_applicants(), load_documents(), load_rules().
- `ControlDesk.gd` — carga datos en _ready() e imprime resumen en consola.

Archivos principales:
- `game/data/days/day_01.json`
- `game/data/applicants/applicants_day_01.json`
- `game/data/documents/documents_day_01.json`
- `game/data/rules/rules_day_01.json`
- `game/scripts/data/DataLoader.gd`

Pendientes:
- Ninguno para Módulo 3.

---

### Módulo 4 — Sistema de solicitantes
Estado: Completado

Implementado:
- `ApplicantQueue.gd` — cola con señales `applicant_changed` y `day_ended`, avance por índice.
- `ControlDesk.gd` — muestra nombre, origen, destino, motivo y diálogo del solicitante actual.
- Contador "SOLICITANTE X / 10" actualizado en cada cambio.
- Botones de decisión deshabilitados al inicio y al fin del turno.
- Escáner básico activo: detecta flags `biological_anomaly` y `suspicious_dialogue`.
- Al terminar los 10 solicitantes muestra "TURNO CERRADO" y bloquea decisiones.
- Pestañas de documentos (Tab1, Tab2, Tab3) conectadas a `_show_doc_by_type()`.

Archivos principales:
- `game/scripts/systems/ApplicantQueue.gd`
- `game/scripts/ui/ControlDesk.gd` (actualizado)

Bugs corregidos:
- `get_index()` renombrado a `get_current_index()` — conflicta con built-in `Node.get_index()` de Godot 4, causaba "Could not resolve external class member".
- Variables `:=` desde `Dictionary.get()` explicitadas como `: String =` — Godot trata como error el warning de tipo Variant inferido.
- `var is_active := (tab == active_btn)` → `: bool =` — Godot no puede inferir bool desde comparación en este contexto.
- `var k := key.replace(...)` → `var k: String = str(key).replace(...)` — `key` al iterar un Dictionary es Variant, hay que convertir con `str()` antes de llamar métodos de String.

Pendientes:
- Ninguno para Módulo 4.

---

### Nota técnica — Conflictos con métodos built-in de Node (Godot 4)

**IMPORTANTE:** No usar estos nombres como métodos propios en clases que extiendan `Node` o `Control`:
- `get_index()` → usar nombre descriptivo como `get_current_index()`.
- `get_name()`, `get_parent()`, `get_children()`, `get_class()` → ídem.

Verificar siempre que el nombre del método no exista en la API de `Node` antes de usarlo.

---

### Módulo 5 — Sistema de documentos
Estado: Completado

Implementado:
- Pestañas conectadas a transit_pass, bio_cert, ingress_permit.
- Pestañas se habilitan/deshabilitan según documentos del solicitante.
- Primer documento disponible se muestra automáticamente.
- `_render_document()` formatea campos del JSON como "CAMPO: valor".
- `_set_active_tab()` resalta la pestaña activa visualmente.
- Escáner detecta 6 tipos de flags con mensaje descriptivo.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd` (actualizado)

Pendientes:
- Ninguno para Módulo 5.

---

### Módulo 6 — Sistema de decisiones
Estado: Completado

Implementado:
- `DecisionSystem.gd` — registra decisiones, evalúa corrección vs `truth.correct_decision`, calcula delta de créditos.
- Penalizaciones: aprobación incorrecta -10/-15 (según risk_level), rechazo incorrecto -10, retención incorrecta -5.
- Signal `decision_recorded` actualiza créditos en barra de estado y muestra feedback en área de documentos.
- `_make_decision()` en ControlDesk centraliza el flujo: deshabilita botones → registra → avanza cola.
- `get_summary()` disponible para el Módulo 8 (reporte final).

Archivos principales:
- `game/scripts/systems/DecisionSystem.gd`
- `game/scripts/ui/ControlDesk.gd` (actualizado)

Pendientes:
- Ninguno para Módulo 6.

---

### Módulo 7 — Motor de reglas e inconsistencias
Estado: Completado

Implementado:
- `RuleEngine.gd` — clase estática, 4 tipos de validación: document_required, field_not_expired, name_consistency, field_not_empty.
- Violaciones mostradas automáticamente al cargar cada solicitante.
- Escáner agrega sus flags al panel sin borrar las violaciones de reglas.
- JSON corregido: bio_cert_008, truth.violations de applicants 4 y 6.

Casos que disparan reglas: applicant_002 (vencido), applicant_003 (sello PENDIENTE).
Casos por escáner: applicants 004, 005, 007, 008, 010.
Casos de juicio: applicants 006, 010.

Archivos principales:
- `game/scripts/systems/RuleEngine.gd`
- `game/scripts/ui/ControlDesk.gd` (actualizado)

Pendientes:
- Ninguno para Módulo 7.

---

### Módulo 8 — Reporte final del día
Estado: Completado

Implementado:
- `DayReport.tscn` + `DayReport.gd` — escena de reporte con resumen, lista de decisiones y consecuencia.
- `DayReport.pending_summary` (static var) recibe el resumen desde ControlDesk vía `decision_system.get_summary()`.
- Resumen muestra: procesados, decisiones correctas, errores, créditos finales.
- Lista de decisiones: [OK] verde / [!] rojo por cada caso, con nombre, decisión y delta de créditos.
- Consecuencia narrativa en 4 niveles según errores (0, 1-2, 3-5, 6+), con tono institucional.
- Botón "REINICIAR DIA" vuelve a ControlDesk y limpia el summary.
- ControlDesk: al fin del día, espera 1.5s y navega automáticamente al reporte.

Archivos principales:
- `game/scenes/main/DayReport.tscn`
- `game/scripts/ui/DayReport.gd`
- `game/scripts/ui/ControlDesk.gd` (actualizado)

Pendientes:
- Ninguno para Módulo 8.

---

### Módulo 9 — Escáner básico
Estado: Completado

Implementado:
- Uso único por solicitante. Reseteo automático al llegar el siguiente.
- Delay 0.4s con "ESCANEANDO..." antes de mostrar resultado.
- Informe formal en área de documentos con anomalías, riesgo y recomendación institucional.
- Alertas preservan violaciones de reglas y agregan resultados del escáner separados.
- Botón cambia a "[ ESCANER USADO ]" y se deshabilita tras el uso.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd` (actualizado)

Pendientes:
- Ninguno para Módulo 9.

---

### Módulo 10 — Diálogos e interrogatorio simple ✓ Completado
Objetivo: agregar frase inicial y 2-3 preguntas funcionales.
Implementado: 3 botones de pregunta dinámicos (motivo/origen/carga) en el panel del solicitante. Respuestas visibles en dialogue_text. Alertas de contradicción anexadas a alerts_list cuando la respuesta contradice los documentos. Datos en applicants_day_01.json (campos questions y question_alerts).

### Módulo 11 — Feedback visual y sonoro ✓ Completado
Objetivo: agregar sonidos de sello, alerta, confirmación y feedback visual básico.
Implementado: SoundManager.gd genera tonos PCM sin archivos externos (AudioStreamWAV). Sonidos: aprobar (440Hz punchy), rechazar (sweep descendente), retener (300Hz suave), alerta (900Hz corto), escáner (sweep ascendente). Flash de modulate en barra de decisiones (verde/rojo/ámbar) y flash de créditos al perder créditos.

### Módulo 12 — Pulido del Día 1
Objetivo: mejorar claridad, ritmo, textos y errores del primer día jugable.

### Módulo 13 — Playtest interno
Objetivo: validar comprensión, tensión, justicia del sistema y deseo de jugar otro día.

### Módulo 14 — Expansión a Día 2
Objetivo: agregar nueva regla, nuevo documento o nueva herramienta solo después de validar el Día 1.

---

## 8. Regla principal de propiedad intelectual

El proyecto puede inspirarse en el tono grimdark, la burocracia imperial, la ciencia ficción oscura y los simuladores de inspección, pero **no debe copiar Warhammer 40k ni ninguna franquicia existente**.

### Prohibido usar

- Nombres protegidos de franquicias.
- Facciones equivalentes por nombre.
- Iconografía reconocible.
- Razas o conceptos directos.
- Estética demasiado idéntica.
- Lore externo como base oficial del juego.
- Términos como Imperium, Inquisición, Adeptus, Mechanicus, Astartes, Space Marines, Primarca, Xenos, Servo-cráneo o Trono Dorado.

### Permitido

- Imperios galácticos propios.
- Instituciones originales.
- Fanatismo administrativo.
- Horror burocrático.
- Tecnología retrofuturista.
- Decadencia social.
- Decisiones morales extremas.
- Facciones burocráticas originales.
- Simbología administrativa propia.

Cuando haya duda, el agente debe proponer una alternativa original.

---

## 9. Estilo de respuesta esperado

El agente debe responder en español, con tono ejecutivo, claro y útil.

Debe evitar:

- relleno innecesario;
- teoría excesiva;
- respuestas genéricas;
- prometer trabajo futuro;
- pedir confirmaciones innecesarias cuando pueda avanzar con supuestos razonables;
- ampliar el alcance sin necesidad;
- usar términos protegidos o demasiado parecidos a franquicias existentes.

Debe entregar:

- decisiones claras;
- tablas cuando ayuden;
- listas accionables;
- ejemplos concretos;
- archivos o bloques listos para usar;
- riesgos y mitigaciones;
- pasos implementables;
- criterios de aceptación.

---

## 10. Regla de eficiencia

El agente debe evitar respuestas largas innecesarias.

Cuando modifique código:

- No repetir archivos completos si solo cambia una sección.
- Mostrar solo los cambios relevantes cuando sea posible.
- Usar comentarios breves.
- Evitar explicar conceptos obvios.
- Priorizar entregables ejecutables sobre teoría.
- No reescribir todo un sistema si basta con un cambio puntual.

---

## 11. Protocolo cuando algo falle

Si aparece un error:

1. Mostrar el error exacto.
2. Explicar la causa probable en pocas líneas.
3. Dar máximo 2 opciones de solución.
4. Indicar cuál opción recomienda y por qué.
5. No reescribir arquitectura completa salvo que sea necesario.

Si el error revela deuda técnica, documentarla como pendiente en lugar de resolverla con una expansión no solicitada.

---

## 12. Principios de diseño del juego

Cada sugerencia debe respetar estos principios:

1. **Burocracia opresiva:** el jugador opera dentro de una máquina institucional fría.
2. **Tensión moral:** las reglas chocan con la humanidad del solicitante.
3. **Información incompleta:** el jugador decide con dudas.
4. **Consecuencia visible:** cada decisión debe tener costo.
5. **Progresión simple:** una nueva regla o herramienta por día.
6. **Universo propio:** evitar dependencia de IP externa.
7. **MVP primero:** no ampliar alcance sin validar el loop.
8. **Datos separados del código:** solicitantes, documentos y reglas deben poder vivir en JSON.
9. **Claridad antes que complejidad:** el jugador debe entender qué revisar y por qué.
10. **UI como núcleo:** la interfaz es parte central de la experiencia, no solo presentación.

---

## 13. Jerarquía de prioridades

Cuando haya conflicto entre opciones, priorizar en este orden:

1. Legalidad y originalidad de la IP.
2. Alcance cerrado del MVP.
3. Jugabilidad clara.
4. Prototipado rápido.
5. Arquitectura simple.
6. Experiencia emocional.
7. Escalabilidad técnica.
8. Estética.
9. Lore expandido.
10. Marketing.

---

## 14. Alcance del MVP

El MVP debe enfocarse en construir una versión mínima jugable que pruebe el loop principal.

### El MVP incluye

- 1 puesto de control.
- 1 día jugable.
- 10 solicitantes.
- 3 documentos.
- 1 herramienta de escáner.
- 3 decisiones principales:
  - Aprobar;
  - Rechazar;
  - Retener.
- 1 reporte final.
- 1 consecuencia narrativa.
- 1 forma de reiniciar el día.

### El MVP no incluye

- árbol narrativo completo;
- finales múltiples;
- combate;
- exploración;
- inventario complejo;
- cinemáticas;
- traducción multi-idioma;
- tienda completa de Steam;
- arte final;
- multijugador;
- economía compleja;
- facciones completamente simuladas.

---

## 15. Agentes especializados sugeridos

### 15.1. Game Design Agent

Responsable de:

- loop principal;
- reglas diarias;
- economía de tiempo;
- dificultad;
- rejugabilidad;
- sistemas de error y penalización.

Debe consultar principalmente:

1. `GAME_DESIGN.md`
2. `MVP_BACKLOG.md`
3. `PROJECT.md`

---

### 15.2. Narrative Design Agent

Responsable de:

- universo;
- facciones;
- tono;
- personajes recurrentes;
- dilemas morales;
- finales múltiples futuros.

Debe consultar principalmente:

1. `NARRATIVE_BIBLE.md`
2. `IP_SAFETY.md`
3. `PROJECT.md`

---

### 15.3. UI/UX Agent

Responsable de:

- interfaz del puesto de control;
- documentos;
- flujo de revisión;
- claridad de errores;
- feedback visual;
- accesibilidad.

Debe consultar principalmente:

1. `TECHNICAL_SPEC.md`
2. `GAME_DESIGN.md`
3. `PROJECT.md`
4. `IP_SAFETY.md`

---

### 15.4. Technical Agent

Responsable de:

- arquitectura del proyecto;
- estructura de datos;
- implementación del MVP;
- persistencia;
- sistema de reglas;
- tests básicos.

Debe favorecer:

- Godot 4;
- GDScript;
- datos en JSON;
- reglas separadas del código;
- componentes reutilizables;
- facilidad para agregar nuevos días y casos;
- implementación incremental.

Debe consultar principalmente:

1. `TECHNICAL_SPEC.md`
2. `MVP_BACKLOG.md`
3. `GAME_DESIGN.md`
4. `PROJECT.md`

---

### 15.5. QA Agent

Responsable de:

- pruebas de casos;
- validación de reglas;
- inconsistencias documentales;
- bugs de decisión;
- regresión;
- balance básico.

Debe consultar principalmente:

1. `MVP_BACKLOG.md`
2. `GAME_DESIGN.md`
3. `TECHNICAL_SPEC.md`

---

### 15.6. Steam Marketing Agent

Responsable de:

- posicionamiento;
- tags de Steam;
- cápsulas de venta;
- descripción corta;
- descripción larga;
- trailer script;
- screenshots clave;
- diferenciación frente a juegos similares.

Debe consultar principalmente:

1. `STEAM_MARKETING.md`
2. `PROJECT.md`
3. `IP_SAFETY.md`
4. `NARRATIVE_BIBLE.md`

---

### 15.7. Legal/IP Risk Reviewer

Responsable de:

- detectar similitudes peligrosas;
- revisar nombres;
- revisar símbolos;
- revisar facciones;
- revisar estética;
- proponer alternativas originales.

Debe consultar principalmente:

1. `IP_SAFETY.md`
2. `PROJECT.md`
3. `NARRATIVE_BIBLE.md`
4. `STEAM_MARKETING.md`

---

## 16. Reglas para trabajo con código

Cuando el agente trabaje en código:

1. Usar Godot 4 y GDScript, salvo instrucción contraria.
2. Mantener una estructura simple y legible.
3. No mezclar datos de solicitantes directamente en lógica si puede evitarse.
4. Priorizar JSON para solicitantes, documentos, reglas y días.
5. Implementar primero el flujo completo aunque sea visualmente simple.
6. Evitar sistemas prematuros.
7. Crear nombres de archivos claros.
8. Mantener funciones pequeñas y comprensibles.
9. Añadir comentarios solo donde aclaren reglas de juego.
10. No introducir dependencias innecesarias.

---

## 17. Convenciones de nombres para Godot

Escenas:

- PascalCase: `MainMenu.tscn`, `ControlDesk.tscn`, `DayReport.tscn`.

Scripts:

- PascalCase cuando representen una clase o sistema: `ApplicantQueue.gd`, `RuleEngine.gd`, `ReportSystem.gd`.

Archivos JSON:

- snake_case: `day_01.json`, `applicants_day_01.json`, `documents_day_01.json`.

Variables y funciones:

- snake_case, siguiendo convención GDScript: `current_applicant`, `load_next_applicant()`.

IDs de datos:

- snake_case con prefijo: `applicant_001`, `document_001`, `rule_001`.

Decisiones:

- usar valores constantes en inglés: `approve`, `reject`, `hold`.

Carpetas:

- minúsculas y descriptivas: `scenes`, `scripts`, `data`, `assets`, `tests`, `docs`.

---

## 18. Reglas para trabajo narrativo

Cuando el agente trabaje narrativa:

1. Mantener tono frío, seco, institucional y opresivo.
2. Usar lenguaje del mundo:
   - admisión;
   - sello;
   - pureza;
   - tránsito;
   - sector;
   - umbral;
   - registro;
   - retención;
   - cuarentena;
   - autorización;
   - anomalía;
   - expediente;
   - decreto;
   - ventanilla;
   - protocolo.
3. Evitar nombres o conceptos demasiado asociados a franquicias externas.
4. Priorizar dilemas morales sobre exposición de lore.
5. Escribir diálogos cortos y funcionales.
6. Hacer que cada caso enseñe una regla, revele una tensión o produzca una consecuencia.

---

## 19. Reglas para UI/UX

Cuando el agente trabaje interfaz:

1. La pantalla debe comunicar claramente:
   - solicitante actual;
   - documentos disponibles;
   - datos relevantes;
   - herramientas;
   - botones de decisión;
   - estado del día.
2. La interfaz debe sentirse administrativa, retrofuturista y opresiva.
3. La estética no debe sacrificar legibilidad.
4. Evitar saturar con texto.
5. El jugador debe poder tomar una decisión con pocos clics.
6. Los errores deben ser entendibles después del reporte.
7. La UI del MVP puede ser simple, pero debe ser clara.

---

## 20. Reglas jugables implementadas

Registrar aquí las reglas activas del prototipo.

### Día 1 — Control básico
Estado: pendiente de implementación.

Reglas esperadas:

- Todo solicitante debe tener Pase de Tránsito.
- El Pase de Tránsito debe estar vigente.
- El nombre debe coincidir entre documentos cuando existan documentos múltiples.
- El destino debe estar autorizado por la regla del día.
- Decisiones disponibles: `approve`, `reject`, `hold`.

Cuando una regla sea implementada en código, agregar:

- archivo donde vive la regla;
- archivo JSON relacionado;
- criterio de prueba;
- resultado esperado.

---

## 21. Registro de módulos completados

Esta sección debe mantenerse actualizada para evitar que el agente reconstruya lo ya hecho.

Formato obligatorio:

```md
### Módulo X — Nombre
Estado: Completado / Parcial / Pendiente

Implementado:
- ...

Archivos principales:
- ...

Pendientes:
- ...
```

### Módulo 1 — Estructura base Godot
Estado: Completado

Implementado:
- Documentación inicial del proyecto.
- Proyecto Godot 4 creado en `game/`.
- Estructura de carpetas según `TECHNICAL_SPEC.md`.
- Escena principal `Main.tscn` funcional (fondo verde fósforo, título).
- Script base `GameManager.gd` con enum de estados del juego.

Archivos principales:
- `game/project.godot`
- `game/scenes/main/Main.tscn`
- `game/scripts/core/GameManager.gd`

Pendientes:
- Ninguno para Módulo 1.

---

## 22. Reglas para control de alcance

Cada vez que aparezca una idea nueva, evaluar:

1. ¿Hace más claro el loop principal?
2. ¿Aumenta la tensión o solo agrega complejidad?
3. ¿Puede probarse en el MVP?
4. ¿Requiere arte, sistemas o narrativa adicional?
5. ¿Puede dejarse para una versión posterior?

Si no fortalece el MVP, debe ir al backlog futuro.

No agregar nuevos sistemas hasta que el jugador quiera jugar un segundo día.

---

## 23. Definición de listo

Una tarea se considera lista cuando:

- tiene objetivo claro;
- está implementada o documentada;
- se puede probar;
- no rompe la coherencia del universo;
- no aumenta el alcance innecesariamente;
- respeta la regla de IP propia;
- cumple su criterio de aceptación;
- no contradice el MVP.

---

## 24. Definición de hecho para el MVP

El MVP está hecho cuando existe:

- una escena jugable del puesto de control;
- al menos 10 solicitantes;
- al menos 3 documentos;
- al menos 5 inconsistencias posibles;
- al menos 3 decisiones;
- un reporte final;
- una consecuencia narrativa;
- una forma de reiniciar el día;
- feedback claro al jugador.

---

## 25. Convenciones de nombres del universo

Usar nombres originales.

Ejemplos válidos:

- Ministerio de Admisión Planetaria.
- Oficio de Pureza Cívica.
- Liga Mercantil de Rutas.
- Clero del Sello.
- Milicia Orbital.
- Ciudad-Colmena Ceniza.
- Puerto de Entrada 7.
- Sector Umbral.
- Casa Veyr.
- Supervisor Halvek.
- Mira Senn.
- Oficial Rauth.

Evitar nombres directamente asociados a franquicias existentes.

---

## 26. Formato recomendado para tareas

Cada tarea debe registrarse así:

```md
## Tarea: [Nombre]

**Objetivo:**  
**Tipo:** Diseño / Narrativa / UI / Código / QA / Marketing / Producción / Legal  
**Módulo:**  
**Prioridad:** Alta / Media / Baja  
**Documentos base:**  
**Archivos a crear/modificar:**  
**Criterio de aceptación:**  
**Notas:**  
```

---

## 27. Instrucción base para agentes

> Trabaja como parte de un equipo indie que desarrolla un simulador narrativo de inspección migratoria en un imperio galáctico oscuro. Antes de implementar cualquier tarea, consulta los documentos del proyecto según el mapa de documentación definido en este archivo. Trabaja por módulos, prioriza un MVP jugable en Godot 4, decisiones morales, claridad de reglas, datos separados del código, universo propio y bajo riesgo legal. No copies Warhammer 40k ni ninguna IP existente. Entrega resultados concretos, accionables y listos para implementar.

