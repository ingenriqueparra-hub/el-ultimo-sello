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
Objetivo: mostrar ventanilla, área de documentos, panel de solicitante y botones de decisión.

### Módulo 3 — Sistema de carga de datos JSON
Objetivo: cargar solicitantes, documentos y reglas desde archivos JSON.

### Módulo 4 — Sistema de solicitantes
Objetivo: mostrar el solicitante actual, avanzar en cola y detectar fin del día.

### Módulo 5 — Sistema de documentos
Objetivo: renderizar documentos con campos comparables y visualmente claros.

### Módulo 6 — Sistema de decisiones
Objetivo: permitir aprobar, rechazar y retener; registrar cada decisión.

### Módulo 7 — Motor de reglas e inconsistencias
Objetivo: evaluar reglas simples, detectar errores y determinar si la decisión fue correcta o riesgosa.

### Módulo 8 — Reporte final del día
Objetivo: mostrar aciertos, errores, multas, reputación y consecuencia narrativa.

### Módulo 9 — Escáner básico
Objetivo: agregar una herramienta simple de detección de anomalías.

### Módulo 10 — Diálogos e interrogatorio simple
Objetivo: agregar frase inicial y 2-3 preguntas funcionales.

### Módulo 11 — Feedback visual y sonoro
Objetivo: agregar sonidos de sello, alerta, confirmación y feedback visual básico.

### Módulo 12 — Pulido del Día 1
Objetivo: mejorar claridad, ritmo, textos y errores del primer día jugable.

### Módulo 13 — Playtest interno
Objetivo: validar comprensión, tensión, justicia del sistema y deseo de jugar otro día.

### Módulo 14 — Expansión a Día 2
Objetivo: agregar nueva regla, nuevo documento o nueva herramienta solo después de validar el Día 1.

### Módulo 15 — Consecuencias narrativas por capas (✓ Completado — Fases 1-4 + Reporte Compuesto)
Objetivo: separar consecuencia de rendimiento, consecuencia de caso, acumuladores narrativos entre días y cierres terminales futuros.
Fases 1-2: NarrativeConsequenceSystem.gd + JSON por día con consecuencias de rendimiento y caso. narrative_hooks en solicitantes clave. DecisionSystem acumula activated_flags.
Fase 3: NarrativeStateSystem.gd con 4 acumuladores estáticos. apply_effects() llamado al evaluar consecuencia. snapshot/restore para restart correcto. Síntomas narrativos visibles si se cruzan umbrales.
Fase 4: TerminalEndingSystem.gd + terminal_endings.json con 8 finales anticipados. Panel rojo en DayReport al activarse. Restart terminal vuelve a Día 1 con reset completo.
Reporte compuesto (P1-09): NarrativeConsequenceSystem.evaluate() devuelve {performance, incidents, synthesis, effects_applied}. Performance = dictamen único por rendimiento. Incidents = todos los flags activos como incidentes (tone/severity/summary_text). Synthesis = texto institucional generado. Efectos compuestos aplicados una sola vez.

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

## 12.1. Dirección visual obligatoria

El agente no debe asumir que el juego es pixel art puro.

La dirección visual oficial es:

> **Retrofuturismo burocrático analógico.**

El juego debe sentirse como una terminal administrativa vieja, institucional y opresiva, combinada con tecnología industrial pesada, documentos digitales, soportes físicos ritualizados y estética de ciudad-colmena decadente.

### La pantalla actual

La pantalla principal puede representar la **computadora del puesto de control**.

Debe entenderse como el plano administrativo del juego, donde el jugador revisa:

- solicitantes;
- documentos;
- regulaciones;
- herramientas;
- alertas;
- decisiones;
- reportes.

No debe asumirse que toda la experiencia ocurre solo en esa pantalla. En versiones futuras, puede existir una vista del solicitante para observar rostro, postura, anomalías y reacciones.

### Soportes documentales permitidos

Los documentos pueden representarse como:

- fichas digitales;
- tarjetas industriales;
- tablets grandes y toscas;
- expedientes biométricos;
- manifiestos de carga;
- protocolos sellados;
- órdenes ceremoniales;
- salvoconductos de facción.

No limitar el diseño a papeles físicos tradicionales.

### Evitar

Evitar:

- pixel art como obligación;
- hologramas limpios y modernos;
- interfaz futurista elegante;
- estética demasiado parecida a Warhammer 40k;
- documentos idénticos a pasaportes contemporáneos;
- depender solo de texto verde plano sin jerarquía visual.

### Prioridad visual

La interfaz debe priorizar:

1. legibilidad;
2. tensión burocrática;
3. identidad propia;
4. claridad de decisiones;
5. atmósfera opresiva.
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

### Módulo 2 — Escena principal del puesto de control
Estado: Completado

Implementado:
- `ControlDesk.tscn` con layout de puesto: solicitante, documentos, herramientas, barra de estado y decisiones.
- `Main.tscn` con botón de inicio hacia el puesto de control.
- Tema visual verde fósforo aplicado por código.

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
- Datos del Día 1 separados en JSON: día, solicitantes, documentos y reglas.
- `DataLoader.gd` con carga de días, solicitantes, documentos y reglas.
- `ControlDesk.gd` carga datos al iniciar.

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
- `ApplicantQueue.gd` con señales `applicant_changed` y `day_ended`.
- Visualización del solicitante actual y contador de avance.
- Fin de turno al procesar la cuota diaria.
- Corrección técnica: evitar nombres de métodos que colisionan con `Node` en Godot 4, como `get_index()`.

Archivos principales:
- `game/scripts/systems/ApplicantQueue.gd`
- `game/scripts/ui/ControlDesk.gd`

Pendientes:
- Ninguno para Módulo 4.

---

### Módulo 5 — Sistema de documentos
Estado: Completado

Implementado:
- Pestañas de documentos habilitadas según documentos del solicitante.
- Render de campos desde JSON.
- Documento disponible mostrado automáticamente.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd`

Pendientes:
- Ninguno para Módulo 5.

---

### Módulo 6 — Sistema de decisiones
Estado: Completado

Implementado:
- `DecisionSystem.gd` registra decisiones y compara con `truth.correct_decision`.
- Penalizaciones por decisión incorrecta según tipo de decisión y riesgo.
- Resumen disponible para el reporte final.

Archivos principales:
- `game/scripts/systems/DecisionSystem.gd`
- `game/scripts/ui/ControlDesk.gd`

Pendientes:
- Ninguno para Módulo 6.

---

### Módulo 7 — Motor de reglas e inconsistencias
Estado: Completado

Implementado:
- `RuleEngine.gd` evalúa reglas documentales.
- Validaciones base del Día 1 y validación `field_match` para Día 2.
- Violaciones integradas con alertas y flujo de revisión.

Archivos principales:
- `game/scripts/systems/RuleEngine.gd`
- `game/scripts/ui/ControlDesk.gd`
- `game/data/rules/rules_day_01.json`
- `game/data/rules/rules_day_02.json`

Pendientes:
- Ninguno para Módulo 7.

---

### Módulo 8 — Reporte final del día
Estado: Completado

Implementado:
- `DayReport.tscn` y `DayReport.gd` muestran resumen del turno.
- Lista de decisiones con resultado y delta de créditos.
- Consecuencia narrativa básica según errores.
- Reinicio de día y continuación al siguiente día si existe.

Archivos principales:
- `game/scenes/main/DayReport.tscn`
- `game/scripts/ui/DayReport.gd`
- `game/scripts/ui/ControlDesk.gd`

Bugs corregidos:
- `var perf := report.get("performance", {})` → `var perf: Dictionary =` — Dictionary.get() devuelve Variant, `:=` no puede inferir el tipo.
- `var text := str(perf.get("body", ""))` → `var text: String =` — mismo problema.

Pendientes:
- Migrar consecuencia narrativa hardcodeada a datos JSON en Módulo 15.

---

### Módulo 9 — Escáner básico
Estado: Completado

Implementado:
- Escáner de uso único por solicitante.
- Delay breve de escaneo y feedback formal.
- Alertas del escáner separadas de violaciones de reglas.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd`

Pendientes:
- Ninguno para Módulo 9.

---

### Módulo 10 — Diálogos e interrogatorio simple
Estado: Completado

Implementado:
- Preguntas dinámicas por solicitante.
- Respuestas visibles en panel de diálogo.
- Alertas por contradicción entre respuesta y documentos.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd`
- `game/data/applicants/applicants_day_01.json`
- `game/data/applicants/applicants_day_02.json`

Pendientes:
- Ninguno para Módulo 10.

---

### Módulo 11 — Feedback visual y sonoro
Estado: Completado

Implementado:
- `SoundManager.gd` genera sonidos PCM sin archivos externos.
- Sonidos para aprobar, rechazar, retener, alerta y escáner.
- Flash visual en barra de decisiones y créditos.

Archivos principales:
- `game/scripts/systems/SoundManager.gd`
- `game/scripts/ui/ControlDesk.gd`

Pendientes:
- Ninguno para Módulo 11.

---

### Herramienta interna — Panel Debug (DEV-01)
Estado: Completado — cubre ControlDesk y DayReport

Implementado:
- Panel superpuesto activado con tecla `Y`. Funciona en dos pantallas.
- En `ControlDesk`: muestra verdad oculta del caso, reglas fallidas, documentos, alertas, última decisión y acumuladores narrativos.
- En `DayReport`: muestra resumen del turno, lista completa de decisiones, flags narrativos activados, consecuencia seleccionada (id, type, priority, trigger_flag, title), ruta del archivo de consecuencias y cierre terminal si se activó.
- `_selected_consequence` almacenada en `DayReport` para evitar doble evaluación de `NarrativeConsequenceSystem`.
- Oculto por defecto en ambas pantallas. `mouse_filter = MOUSE_FILTER_IGNORE`. `z_index = 100`.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd`
- `game/scripts/ui/DayReport.gd`

Pendientes:
- No incluir en builds públicos o builds de playtest normal.

---

### Módulo 12 — Pulido del Día 1
Estado: Pendiente / En validación

Implementado:
- Flujo base del Día 1 ya puede jugarse con reglas, decisiones, escáner, interrogatorio y reporte.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd`
- `game/scripts/ui/DayReport.gd`
- `game/data/days/day_01.json`
- `game/data/applicants/applicants_day_01.json`

Pendientes:
- Validar claridad, ritmo, textos y errores con playtest no asistido.
- Ajustar solo si el playtest detecta confusión.

---

### Módulo 13 — Playtest interno
Estado: Pendiente

Implementado:
- Métricas de playtest definidas en `MVP_BACKLOG.md`.

Archivos principales:
- `MVP_BACKLOG.md`

Pendientes:
- Realizar playtest interno.
- Registrar hallazgos y priorizar ajustes.

---

### Módulo 14 — Expansión a Día 2
Estado: Completado

Implementado:
- `ControlDesk.day_to_load` (static var, int) controla qué día carga. `_ready()` lo lee; `_load_day_data()` carga créditos desde `credits_start` del JSON.
- `DayReport.gd`: header dinámico "REPORTE DEL TURNO — DIA N". Botón "CONTINUAR — DIA N" (azul) aparece si existe `res://data/days/day_NN.json`. Restart y Continue establecen `ControlDesk.day_to_load` antes de cambiar escena.
- `RuleEngine.gd`: nuevo tipo `field_match` — compara un campo entre dos tipos de documento (ej. codigo_identidad en transit_pass vs bio_cert).
- `rules_day_02.json` — 7 reglas (4 heredadas + 3 nuevas: bio_cert obligatorio, bio_cert no vencido, field_match codigo_identidad).
- `day_02.json` — fecha 299.01, 10 solicitantes 011-020, credits_start 50.
- `applicants_day_02.json` — 10 casos: 2 aprobaciones limpias, pase vencido, código no coincide (Vara Kess LM-4420/LM-4402), sin bio_cert (refugiado), bio_cert vencido, anomalía biológica, nombres inconsistentes (Pola Dren/Pola Gren), carga contradictoria en interrogatorio, sin pase de tránsito.
- `documents_day_02.json` — 19 documentos: 9 transit_pass + 9 bio_cert + 1 ingress_permit.

Archivos principales:
- `game/scripts/ui/ControlDesk.gd` (actualizado)
- `game/scripts/ui/DayReport.gd` (actualizado)
- `game/scripts/systems/RuleEngine.gd` (actualizado)
- `game/data/days/day_02.json`
- `game/data/rules/rules_day_02.json`
- `game/data/applicants/applicants_day_02.json`
- `game/data/documents/documents_day_02.json`

Pendientes:
- Ninguno para Módulo 14.

---

### Módulo 15 — Consecuencias narrativas por capas
Estado: Completado (Fases 1, 2, 3, 4 y 5)

Implementado (Fase 1 — consecuencia de rendimiento):
- `NarrativeConsequenceSystem.gd` — clase estática. Evalúa `consequences_day_NN.json`.
- `consequences_day_01.json` — 5 consecuencias de rendimiento (prioridades 60-100).
- `consequences_day_02.json` — 6 consecuencias de rendimiento (prioridades 60-100 + créditos críticos p85).

Implementado (Fase 2 — consecuencia de caso):
- `DecisionSystem.gd` — acumula `_activated_flags`. Flags incluidos en `get_summary()` como `activated_flags`.
- `applicants_day_01.json` — narrative_hooks en 4 solicitantes: 003 (Sela Driva), 005 (Rhen Axis), 008 (Dara Miren), 010 (Kael Vorn).
- `applicants_day_02.json` — narrative_hooks en 3 solicitantes: 013 (Vara Kess), 016 (Gal Nex), 019 (Thal Vor).
- `consequences_day_01.json` — 10 consecuencias de caso (prioridades 130-200) + 5 de rendimiento.
- `consequences_day_02.json` — 6 consecuencias de caso (prioridades 145-200) + 6 de rendimiento.

Implementado (Fase 3 — acumuladores entre días):
- `NarrativeStateSystem.gd` — clase estática con 4 acumuladores: `institutional_trust`, `security_risk`, `civilian_harm`, `supervisor_suspicion`. Métodos: `apply_effects()`, `snapshot()`, `restore_snapshot()`, `get_accumulators()`, `get_narrative_symptom()`, `reset()`.
- Umbrales visibles al jugador: `security_risk >= 3`, `supervisor_suspicion >= 2`, `civilian_harm >= 2`, `institutional_trust <= -2`.

Implementado (Fase 4 — cierres terminales):
- `TerminalEndingSystem.gd` — evalúa `terminal_endings.json` con condiciones de acumuladores + `min_day`.
- `terminal_endings.json` — 8 finales anticipados, prioridades 130-200.
- `DayReport.gd` — panel rojo + botón NUEVA PARTIDA + reset total en cierre terminal.

Implementado (Fase 5 — reporte narrativo compuesto, P1-09):
- `NarrativeConsequenceSystem.evaluate()` — devuelve `{performance, incidents, synthesis, effects_applied}`.
- `_select_performance()` — elige un solo dictamen de rendimiento por condiciones + prioridad.
- `_select_incidents()` — recoge TODOS los incidentes de caso con trigger_flag activo.
- `_build_synthesis()` — genera texto institucional combinando tone del performance con tone/severity de incidentes.
- `_merge_effects()` — suma efectos de performance + todos los incidentes; aplica una sola vez vía `NarrativeStateSystem.apply_effects()`.
- `DayReport._show_normal_report()` — muestra dictamen de rendimiento + hasta 3 incidentes (summary_text) + síntesis + síntoma.
- Panel debug — secciones separadas: DICTAMEN DE RENDIMIENTO, INCIDENTES DE CASO, SINTESIS, EFECTOS APLICADOS.
- `consequences_day_01.json` y `consequences_day_02.json` — todas las entradas actualizadas con campos `tone`, `severity` (cases), `summary_text` (cases).

Archivos principales:
- `game/scripts/systems/NarrativeConsequenceSystem.gd` (reescrito — Fase 5)
- `game/scripts/systems/NarrativeStateSystem.gd` (Fase 3)
- `game/scripts/systems/TerminalEndingSystem.gd` (Fase 4)
- `game/scripts/systems/DecisionSystem.gd` (Fase 2)
- `game/data/consequences/consequences_day_01.json` (Fases 1+2+3+5)
- `game/data/consequences/consequences_day_02.json` (Fases 1+2+3+5)
- `game/data/endings/terminal_endings.json` (Fase 4)
- `game/data/applicants/applicants_day_01.json` (Fase 2)
- `game/data/applicants/applicants_day_02.json` (Fase 2)
- `game/scripts/ui/DayReport.gd` (Fases 1+3+4+5)
- `game/scripts/ui/ControlDesk.gd` (Fase 3)

Pendientes:
- Ninguno para Módulo 15.

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

> Trabaja como parte de un equipo indie que desarrolla un simulador narrativo de inspección migratoria en un imperio galáctico oscuro. Antes de implementar cualquier tarea, consulta los documentos del proyecto según el mapa de documentación definido en este archivo. Trabaja por módulos, prioriza un MVP jugable en Godot 4, decisiones morales, claridad de reglas, datos separados del código, universo propio y bajo riesgo legal. No copies Warhammer 40k ni ninguna IP existente. No asumas pixel art puro: la dirección visual es retrofuturismo burocrático analógico, con terminales institucionales, soportes documentales híbridos y tecnología pesada. Entrega resultados concretos, accionables y listos para implementar.