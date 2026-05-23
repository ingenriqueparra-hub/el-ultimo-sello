# TECHNICAL_SPEC.md
# Especificación técnica inicial — **El Último Sello**

---

## 1. Motor recomendado

**Godot 4**.

Motivos:

- excelente para juegos 2D;
- rápido para UI;
- gratuito;
- exportación sencilla a PC;
- adecuado para prototipos con datos;
- bajo costo de entrada.

---

## 2. Estructura sugerida de carpetas

```text
project/
├── assets/
│   ├── audio/
│   ├── fonts/
│   ├── icons/
│   ├── images/
│   └── ui/
├── data/
│   ├── applicants/
│   ├── documents/
│   ├── rules/
│   └── days/
├── scenes/
│   ├── main/
│   ├── ui/
│   ├── documents/
│   └── applicants/
├── scripts/
│   ├── core/
│   ├── systems/
│   ├── ui/
│   └── data/
├── tests/
└── docs/
```

---

## 3. Modelo de datos sugerido

### Applicant

```json
{
  "id": "applicant_001",
  "name": "Elias Vorn",
  "type": "citizen",
  "origin": "Sector Bajo Ceniza",
  "destination": "Nivel Industrial 4",
  "purpose": "Trabajo temporal",
  "dialogue_intro": "Vengo por el turno de fundición.",
  "documents": ["transit_pass_001", "bio_cert_001"],
  "flags": [],
  "truth": {
    "should_allow": true,
    "risk_level": "low",
    "notes": "Caso correcto para enseñar reglas básicas."
  }
}
```

### Document

```json
{
  "id": "transit_pass_001",
  "type": "transit_pass",
  "fields": {
    "name": "Elias Vorn",
    "identity_code": "CV-8831",
    "origin": "Sector Bajo Ceniza",
    "destination": "Nivel Industrial 4",
    "expires": "312.44",
    "purpose": "Trabajo temporal",
    "authority_seal": "MAP-7"
  }
}
```

### Rule

```json
{
  "id": "rule_001",
  "day": 1,
  "description": "Todo solicitante debe presentar Pase de Tránsito vigente.",
  "validation": {
    "document_required": "transit_pass",
    "field": "expires",
    "operator": "not_expired"
  },
  "penalty_on_fail": {
    "credits": -5,
    "reputation": -1
  }
}
```

### Decision Result

```json
{
  "applicant_id": "applicant_001",
  "decision": "approve",
  "was_correct": true,
  "errors": [],
  "consequence_tags": ["order_preserved"]
}
```

### Narrative Consequence

```json
{
  "id": "consequence_day_01_clean_shift",
  "day": 1,
  "priority": 10,
  "type": "performance",
  "title": "Turno sin incidentes",
  "body": "El Ministerio registra eficiencia maxima en el puesto. El expediente queda marcado como estable.",
  "conditions": {
    "max_errors": 0,
    "min_credits": 50
  },
  "effects": {
    "institutional_trust": 1,
    "supervisor_suspicion": -1
  },
  "follow_up_flag": "flag_clean_shift"
}
```

Las consecuencias deben vivir en JSON por dia:

- `data/consequences/consequences_day_01.json`
- `data/consequences/consequences_day_02.json`

Los solicitantes importantes pueden declarar ganchos opcionales sin obligar a todos los casos a tener consecuencia:

```json
"narrative_hooks": {
  "on_wrong_approve": "flag_high_risk_approved",
  "on_wrong_reject": "flag_civilian_harm",
  "on_correct_hold": "flag_incident_prevented"
}
```

---

## 4. Sistemas principales

### 4.1. Applicant Queue System
Responsable de:

- cargar solicitantes del día;
- mostrar el actual;
- pasar al siguiente;
- detectar fin del día.

### 4.2. Document System
Responsable de:

- cargar documentos;
- renderizar campos;
- permitir mover/abrir documentos;
- comparar datos.

### 4.3. Rule Engine
Responsable de:

- evaluar documentos;
- detectar inconsistencias;
- calcular si una decisión fue aceptable;
- registrar errores.

### 4.4. Decision System
Responsable de:

- aprobar;
- rechazar;
- retener;
- emitir resultado;
- actualizar variables del día.

### 4.5. Report System
Responsable de:

- sumar decisiones;
- mostrar aciertos y errores;
- calcular multas;
- mostrar consecuencia narrativa.

### 4.6. Dialogue System
Responsable de:

- mostrar frase inicial;
- permitir preguntas;
- revelar respuestas.

### 4.7. Debug Panel (herramienta interna de desarrollo / QA)

**No es una mecánica jugable. No debe estar disponible en builds de release.**

El panel de superposición se activa con la tecla `Y`. Funciona en dos pantallas:

#### 4.7.1. Debug en ControlDesk (inspección activa)

Visible solo para desarrolladores y QA durante el turno de inspección.

Muestra:

- ID y nombre del solicitante actual.
- Decisión correcta esperada (`truth.correct_decision`).
- Nivel de riesgo y notas internas (`truth.risk_level`, `truth.notes`).
- Flags del solicitante (`flags[]`).
- Reglas fallidas detectadas por `RuleEngine` en el turno actual.
- Documentos presentes (por tipo).
- Alertas de contradicción en interrogatorio (`question_alerts`).
- Resultado de la última decisión tomada (decisión, corrección, penalización).
- Acumuladores narrativos actuales (`NarrativeStateSystem`).

#### 4.7.2. Debug en DayReport (reporte final del día)

Visible solo para desarrolladores y QA al terminar el turno.

Muestra:

- Día evaluado.
- Total procesado y cuota.
- Decisiones correctas y errores.
- Créditos finales.
- Lista de decisiones registradas (applicant_id, name, decision, correct_decision, was_correct, risk_level, credit_delta, violations).
- Flags narrativos activados (`activated_flags`).
- Consecuencia narrativa seleccionada (id, type, priority, trigger_flag si existe, title).
- Ruta del archivo de consecuencias usado.
- Indicación si se activó cierre terminal (id del terminal).

Propiedades técnicas (ambos paneles):

- Construido programáticamente (sin escena separada).
- Oculto por defecto (`visible = false`).
- `mouse_filter = MOUSE_FILTER_IGNORE` para no bloquear interacción.
- `z_index = 100` para superponerse al resto de la UI.
- Activado/desactivado con `KEY_Y` en `_input()`.
- El panel de ControlDesk se actualiza al cambiar de solicitante y tras cada decisión.
- El panel de DayReport se actualiza al cargar `pending_summary`.

---

### 4.8. Narrative Consequence System

Responsable de generar el reporte narrativo compuesto del dia.

Entradas:

- resumen de `DecisionSystem` (errores, creditos, correctas, activated_flags);
- consecuencias disponibles en JSON por dia;
- `NarrativeStateSystem` para acumuladores;
- `TerminalEndingSystem` para cierres terminales.

Salida compuesta (`evaluate()` devuelve Dictionary):

```gdscript
{
  "performance":     { ...consecuencia de rendimiento... },
  "incidents":       [ ...lista de incidentes de caso activados... ],
  "synthesis":       "texto de sintesis institucional",
  "effects_applied": { "institutional_trust": X, ... },
}
```

Logica interna:

1. `_select_performance()`: elige la mejor consecuencia `type: "performance"` por `conditions` y `priority`.
2. `_select_incidents()`: recoge todas las consecuencias `type: "case"` cuyos `trigger_flag` esten en `activated_flags`, ordenadas por priority.
3. `_build_synthesis()`: genera texto institucional combinando `tone` del performance y tono/severidad de los incidentes.
4. `_merge_effects()`: suma efectos del performance + todos los incidentes → `NarrativeStateSystem.apply_effects()`.
5. `TerminalEndingSystem.evaluate()` se llama en `DayReport` despues de que los efectos compuestos ya fueron aplicados.

Campos de consecuencias en JSON:

- `type`: "performance" | "case"
- `tone`: "positive" | "negative" | "mixed" | "neutral" (para performance y case)
- `severity`: "minor" | "major" | "critical" (para case, opcional en performance)
- `summary_text`: texto corto para lista de incidentes en UI normal (case)
- `priority`: entero — performance 60-100, case 130-200
- `conditions`: objeto con min/max_errors, min/max_credits, min_correct (performance)
- `trigger_flag`: string del flag narrativo que activa el incidente (case)
- `effects`: deltas de acumuladores

Reglas tecnicas:

- el dictamen de rendimiento siempre se selecciona uno solo;
- todos los incidentes cuyo flag este activo aparecen en el reporte;
- la UI normal muestra max 3 incidentes; el resto queda en expediente;
- los efectos de todos los incidentes se aplican de forma compuesta una sola vez;
- nunca mostrar valores numericos de acumuladores al jugador normal;
- solo el panel debug (tecla Y) muestra efectos, flags y acumuladores;
- `NarrativeConsequenceSystem` no modifica `DayReport` directamente.

Fases de implementacion:

1. Mover consecuencia de rendimiento a JSON.
2. Agregar ganchos narrativos por caso.
3. Persistir acumuladores simples entre dias.
4. Evaluar finales anticipados o cierres terminales.
5. Reporte narrativo compuesto: performance + incidentes + sintesis.

---

## 5. Estados del juego

```text
MAIN_MENU
START_DAY
APPLICANT_ARRIVAL
INSPECTION
DECISION_MADE
NEXT_APPLICANT
DAY_REPORT
GAME_OVER_OR_NEXT_DAY
```

---

## 6. Decisiones técnicas clave

### Datos separados del código
Los solicitantes, documentos y reglas deben vivir en JSON para que sea fácil crear contenido sin tocar lógica.

### MVP sin IA generativa
No usar IA generativa dentro del juego en el MVP. Es mejor tener casos escritos y controlados.

### UI primero
El juego depende de la claridad de la interfaz. La primera inversión técnica debe estar en documentos, layout y decisiones.

### Sin multiplayer
No aporta al MVP.

---

## 7. Riesgos técnicos

| Riesgo | Mitigación |
|---|---|
| Sistema de reglas complejo | Empezar con validaciones simples |
| Mucho contenido manual | Usar plantillas JSON |
| UI confusa | Prototipar en baja fidelidad |
| Dificultad injusta | Playtesting temprano |
| Scope creep | Congelar MVP |

---

## 8. Primera implementación recomendada

Orden sugerido:

1. Crear escena principal.
2. Crear panel de solicitante.
3. Crear documentos hardcodeados.
4. Agregar botones de decisión.
5. Crear 3 solicitantes.
6. Validar manualmente decisiones.
7. Agregar reporte.
8. Pasar datos a JSON.
9. Expandir a 10 solicitantes.
10. Agregar escáner básico.

