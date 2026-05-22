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

