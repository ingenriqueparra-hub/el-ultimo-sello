# Guía para agentes IA que trabajen en **El Último Sello**

Este archivo define cómo deben colaborar los agentes de IA en el desarrollo del proyecto.  
Su objetivo es mantener coherencia narrativa, técnica, legal y de producto.

Este archivo funciona como **punto de entrada obligatorio** para Codex y cualquier agente IA.  
Antes de diseñar, programar o modificar cualquier parte del proyecto, el agente debe usar este archivo para saber qué documentación consultar.

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
- criterio de éxito del prototipo.

Usar cuando la tarea tenga que ver con:

- dirección general del juego;
- alcance del producto;
- prioridades;
- decisiones de diseño de alto nivel;
- evaluación de riesgos.

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

3. Resumir brevemente qué archivos usó como base, cuando sea útil para justificar una decisión.

4. Implementar solo lo necesario para el MVP, salvo que el usuario indique explícitamente lo contrario.

5. No inventar sistemas grandes si no están en `MVP_BACKLOG.md` o `TECHNICAL_SPEC.md`.

6. No expandir narrativa, facciones, combate, exploración, economía compleja o finales múltiples si la tarea pertenece al MVP inicial.

---

## 6. Regla principal de propiedad intelectual

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

## 7. Estilo de respuesta esperado

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

## 8. Principios de diseño del juego

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

## 9. Jerarquía de prioridades

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

## 10. Alcance del MVP

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

## 11. Agentes especializados sugeridos

### 11.1. Game Design Agent

Responsable de:

- loop principal;
- reglas diarias;
- economía de tiempo;
- dificultad;
- rejugabilidad;
- sistemas de error y penalización.

Debe producir entregables como:

- core loop;
- ruleset por día;
- tabla de mecánicas;
- matriz de dificultad;
- prototipos de casos.

Debe consultar principalmente:

1. `GAME_DESIGN.md`
2. `MVP_BACKLOG.md`
3. `PROJECT.md`

---

### 11.2. Narrative Design Agent

Responsable de:

- universo;
- facciones;
- tono;
- personajes recurrentes;
- dilemas morales;
- finales múltiples futuros.

Debe mantener el estilo:

- sobrio;
- oscuro;
- institucional;
- humano;
- sin melodrama excesivo.

Debe consultar principalmente:

1. `NARRATIVE_BIBLE.md`
2. `IP_SAFETY.md`
3. `PROJECT.md`

---

### 11.3. UI/UX Agent

Responsable de:

- interfaz del puesto de control;
- documentos;
- flujo de revisión;
- claridad de errores;
- feedback visual;
- accesibilidad.

Debe priorizar:

- legibilidad;
- contraste;
- pocos clics;
- tensión visual;
- sensación de máquina administrativa;
- claridad sobre decoración.

Debe consultar principalmente:

1. `TECHNICAL_SPEC.md`
2. `GAME_DESIGN.md`
3. `PROJECT.md`
4. `IP_SAFETY.md`

---

### 11.4. Technical Agent

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

### 11.5. QA Agent

Responsable de:

- pruebas de casos;
- validación de reglas;
- inconsistencias documentales;
- bugs de decisión;
- regresión;
- balance básico.

Debe crear:

- checklists;
- casos de prueba;
- matriz de reglas contra solicitantes;
- reportes de bugs.

Debe consultar principalmente:

1. `MVP_BACKLOG.md`
2. `GAME_DESIGN.md`
3. `TECHNICAL_SPEC.md`

---

### 11.6. Steam Marketing Agent

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

### 11.7. Legal/IP Risk Reviewer

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

## 12. Reglas para trabajo con código

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

## 13. Reglas para trabajo narrativo

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

## 14. Reglas para UI/UX

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

## 15. Reglas para control de alcance

Cada vez que aparezca una idea nueva, evaluar:

1. ¿Hace más claro el loop principal?
2. ¿Aumenta la tensión o solo agrega complejidad?
3. ¿Puede probarse en el MVP?
4. ¿Requiere arte, sistemas o narrativa adicional?
5. ¿Puede dejarse para una versión posterior?

Si no fortalece el MVP, debe ir al backlog futuro.

No agregar nuevos sistemas hasta que el jugador quiera jugar un segundo día.

---

## 16. Definición de listo

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

## 17. Definición de hecho para el MVP

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

## 18. Convenciones de nombres

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

## 19. Formato recomendado para tareas

Cada tarea debe registrarse así:

```md
## Tarea: [Nombre]

**Objetivo:**  
**Tipo:** Diseño / Narrativa / UI / Código / QA / Marketing / Producción / Legal  
**Prioridad:** Alta / Media / Baja  
**Documentos base:**  
**Criterio de aceptación:**  
**Notas:**  