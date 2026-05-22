# MVP_BACKLOG.md
# Backlog inicial — **El Último Sello**

---

## 1. Objetivo del MVP

Crear una versión jugable mínima que pruebe si el loop de inspección documental, tensión moral y reporte final es entretenido.

---

## 2. Alcance cerrado del MVP

Incluye:

- 1 día jugable.
- 10 solicitantes.
- 3 documentos.
- 1 herramienta de escáner.
- 3 decisiones.
- 1 reporte final.
- 1 consecuencia narrativa.

No incluye:

- árbol narrativo completo;
- finales múltiples;
- combate;
- exploración;
- inventario complejo;
- cinemáticas;
- traducción multi-idioma;
- tienda de Steam completa;
- arte final.

---

## 3. Backlog por prioridad

### P0 — Núcleo jugable

| ID | Tarea | Criterio de aceptación |
|---|---|---|
| P0-01 | Crear escena del puesto de control | Se ve ventanilla, área de documentos y botones de decisión |
| P0-02 | Crear modelo de solicitante | Cada solicitante tiene nombre, origen, destino, motivo y estado |
| P0-03 | Crear documento de tránsito | Documento visible con campos comparables |
| P0-04 | Crear certificado biométrico | Documento visible con ID y anomalías |
| P0-05 | Crear permiso de carga/motivo | Documento visible con datos adicionales |
| P0-06 | Implementar cola de solicitantes | El jugador procesa 10 casos en orden |
| P0-07 | Implementar decisiones | Aprobar, rechazar y retener funcionan |
| P0-08 | Implementar validación básica | El sistema sabe si la decisión fue correcta o riesgosa |
| P0-09 | Implementar reporte final | Muestra aciertos, errores y consecuencia |
| P0-10 | Reiniciar día | Permite volver a jugar el día |

---

### P1 — Tensión y feedback

| ID | Tarea | Criterio de aceptación |
|---|---|---|
| P1-01 | Agregar sonidos de sello | Aprobación/rechazo tienen feedback sonoro |
| P1-02 | Agregar escáner básico | Detecta una anomalía simple |
| P1-03 | Agregar diálogo de solicitante | Cada solicitante tiene una frase inicial |
| P1-04 | Agregar preguntas básicas | El jugador puede hacer 2-3 preguntas |
| P1-05 | Agregar penalizaciones | Errores afectan salario/reputación |
| P1-06 | Agregar consecuencia narrativa | El final cambia según una decisión clave |

---

### P2 — Presentación

| ID | Tarea | Criterio de aceptación |
|---|---|---|
| P2-01 | Mockup visual de documentos | Documentos tienen estilo propio |
| P2-02 | Fondo del puerto | Se percibe ambiente de ciudad/estación |
| P2-03 | UI retrofuturista | Colores y paneles coherentes |
| P2-04 | Pantalla de menú | Permite iniciar partida |
| P2-05 | Pantalla de cierre del día | Presenta resumen con tono narrativo |

---

## 4. Primeros 10 solicitantes del MVP

| # | Tipo | Caso | Decisión esperada |
|---|---|---|---|
| 1 | Ciudadano | Todo correcto | Aprobar |
| 2 | Trabajador | Documento vencido | Rechazar |
| 3 | Refugiada | Falta un sello, pero no hay amenaza | Decisión moral |
| 4 | Mercader | Carga no coincide | Retener |
| 5 | Soldado | ID correcto, anomalía leve | Decisión ambigua |
| 6 | Noble | Exige pasar sin revisión | Depende de regla |
| 7 | Técnico | Lleva dispositivo no declarado | Retener |
| 8 | Madre con niño | Niño con anomalía biológica leve | Decisión moral |
| 9 | Clérigo | Permiso especial válido | Aprobar |
| 10 | Agente encubierto | Documentos perfectos, respuesta contradictoria | Retener |

---

## 5. Milestones

### Milestone 1 — Prototipo de papel
- Casos escritos.
- Documentos diseñados en texto.
- Reglas definidas.

### Milestone 2 — Prototipo interactivo
- Interfaz simple.
- Cola de solicitantes.
- Botones de decisión.

### Milestone 3 — MVP jugable
- Validación de reglas.
- Reporte final.
- Feedback visual/sonoro básico.

### Milestone 4 — Playtest interno
- 5 personas juegan.
- Se mide comprensión, tensión y deseo de repetir.

---

## 6. Métricas de playtest

Preguntar al jugador:

1. ¿Entendiste qué debías hacer?
2. ¿Qué caso recuerdas más?
3. ¿Te pareció justo el sistema?
4. ¿Sentiste presión?
5. ¿Jugarías otro día?
6. ¿Qué parte fue confusa?
7. ¿Qué decisión te incomodó?

---

## 7. Regla de oro del MVP

No agregar sistemas nuevos hasta que el jugador quiera jugar un segundo día.

