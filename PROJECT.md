# PROJECT.md
# Proyecto: **El Último Sello**  
## Simulador narrativo de inspección migratoria en un imperio galáctico oscuro

> **Pitch:** Un thriller burocrático de ciencia ficción oscura donde cada sello puede salvar una ciudad-colmena… o condenar a millones.

---

## 1. Visión general

**El Último Sello** es un videojuego indie para Steam inspirado en los simuladores de inspección documental, los thrillers burocráticos y la ciencia ficción grimdark. El jugador asume el rol de un **Oficial de Admisión Planetaria** encargado de controlar el ingreso de personas, mercancías, reliquias, soldados, nobles, refugiados y clérigos a una ciudad-colmena bajo estado de paranoia imperial.

El juego no debe usar nombres, facciones, símbolos, textos, razas, instituciones ni terminología protegida de Warhammer 40k. La inspiración es de tono: imperio decadente, burocracia brutal, fanatismo institucional, horror cósmico, control social, corrupción y decisiones morales extremas.

---

## 2. Fantasía del jugador

El jugador debe sentir que trabaja en una ventanilla pequeña, pero que sus decisiones afectan una estructura gigantesca.

No es “revisar papeles”. Es decidir entre:

- obedecer órdenes crueles;
- proteger a civiles inocentes;
- detectar amenazas reales;
- sobrevivir dentro de una institución opresiva;
- resistir corrupción;
- evitar que el miedo lo convierta en monstruo.

---

## 3. Principios de diseño

La dificultad debe escalar por capas: primero errores documentales simples, luego cruce de documentos, reglas externas, carga, facciones, interrogatorio y dilemas narrativos.

### 3.1. Burocracia con tensión
Cada regla debe parecer administrativa, pero tener consecuencias humanas o políticas.

### 3.2. Decisiones incompletas
El jugador nunca debe tener información perfecta. Debe decidir bajo presión, contradicción y riesgo.

### 3.3. Moral gris
No hay decisiones “limpias”. Ayudar a alguien puede abrir una amenaza. Cumplir la ley puede destruir una familia.

### 3.4. Progresión por complejidad
Cada día agrega una regla, documento, facción, herramienta o tipo de amenaza.

### 3.5. Universo propio
El mundo debe sentirse amplio, antiguo y brutal, pero sin depender de ninguna franquicia existente.

---

## 4. Referencias de experiencia

Referencias mecánicas:

- Papers, Please: inspección documental, reglas diarias, consecuencias familiares.
- Contraband Police: revisión, sospecha, presión institucional.
- Not Tonight: control de acceso y decisiones sociales.
- Beholder: vigilancia, opresión, dilemas morales.
- Death and Taxes: decisiones burocráticas con consecuencias narrativas.

Referencias de tono:

- ciencia ficción imperial decadente;
- horror religioso-administrativo;
- totalitarismo burocrático;
- estética retrofuturista analógica;
- documentos sellados, scanners, permisos, órdenes contradictorias.

---

## 5. Alcance del MVP

El MVP debe demostrar el núcleo jugable en una escala pequeña.

### MVP recomendado

- 1 puesto de control.
- 1 día jugable completo.
- 10 solicitantes.
- 3 documentos base.
- 1 herramienta de verificación.
- 1 regla nueva durante el día.
- 3 tipos de decisión: aprobar, rechazar, retener.
- 1 reporte final del día.
- 1 consecuencia narrativa.

### Documentos del MVP

- Pase de Tránsito Planetario.
- Certificado de Identidad Biométrica.
- Permiso de Carga o Motivo de Ingreso.

### Herramientas del MVP

- Comparador de datos.
- Escáner de pureza biológica básico.
- Registro de alertas.

---

## 6. Loop principal

```text
Llega solicitante
      ↓
Entrega documentos
      ↓
Jugador revisa identidad, destino, motivo, fechas, sellos y restricciones
      ↓
Jugador puede hacer preguntas o activar escáner
      ↓
Sistema revela alertas, contradicciones o señales de riesgo
      ↓
Jugador decide: aprobar, rechazar o retener
      ↓
El caso se registra
      ↓
Al final del día se evalúan errores, sanciones, ingresos y consecuencias
```

---

## 7. Mecánicas principales

### 7.1. Revisión documental
El jugador compara datos entre documentos:

- nombre;
- código biométrico;
- planeta o sector de origen;
- destino;
- fecha de expiración;
- autorización de facción;
- motivo de ingreso;
- tipo de carga;
- restricciones sanitarias;
- marcas de sospecha.

### 7.2. Interrogatorio breve
El jugador puede elegir preguntas limitadas:

- “¿Cuál es el motivo de su ingreso?”
- “¿De dónde proviene?”
- “¿Qué contiene su carga?”
- “¿Tiene autorización superior?”
- “¿Por qué su ruta cambió?”

Las respuestas deben poder contradecir documentos o abrir nuevas sospechas.

### 7.3. Escáner de pureza
No debe ser mágico ni absoluto. Debe mostrar probabilidades o anomalías:

- mutación menor;
- radiación;
- implante no registrado;
- enfermedad;
- señal neuroquímica alterada;
- contaminación desconocida.

### 7.4. Facciones
Cada facción presiona de forma distinta:

- **Ministerio de Admisión:** quiere orden, métricas y obediencia.
- **Oficio de Pureza:** exige detenciones preventivas.
- **Liga Mercantil:** presiona para liberar cargamentos.
- **Clero del Sello:** interpreta sospechas como impureza moral.
- **Milicia Orbital:** exige prioridad para soldados y veteranos.
- **Red de Refugiados:** busca pasar personas vulnerables.
- **Casa Noble local:** quiere privilegios y excepción de controles.

### 7.5. Consecuencias
El juego debe registrar:

- errores administrativos;
- amenazas dejadas pasar;
- inocentes castigados;
- sobornos aceptados;
- reputación con facciones;
- salud, dinero y seguridad familiar;
- estabilidad del puesto de control.

---

## 8. Tono narrativo

El texto debe ser sobrio, seco y opresivo.

Evitar chistes excesivos. El humor, si aparece, debe ser negro o burocrático.

Ejemplo de tono:

> “El sello no pregunta si alguien merece vivir. Solo confirma si puede entrar.”

---

## 9. Estilo visual

### Dirección sugerida

- Interfaz retrofuturista.
- Verde fósforo, ámbar, rojo de alerta, metal oscuro.
- Documentos gastados, sellos imperiales propios, códigos.
- Pantallas con ruido, scanners imperfectos.
- Ventanilla estrecha, rostro del solicitante parcialmente visible.
- Fondo de puerto espacial o ciudad-colmena.

### Evitar

- Calaveras aladas, águilas bicéfalas, servo-cráneos, inquisidores o iconografía reconocible de Warhammer.
- Nombres como Imperium, Inquisición, Herejía, Caos, Xenos, Adeptus, Mechanicus, etc.
- Armaduras o diseños demasiado cercanos a Space Marines.

---

## 10. Nombre provisional

Opciones:

1. El Último Sello
2. Aduana del Trono Negro
3. Puerto Ceniza
4. Sector de Admisión 7
5. Control de Pureza
6. La Ventanilla del Fin
7. Sello de Entrada
8. Checkpoint: Mundo Colmena

Nombre recomendado actual: **El Último Sello**.

---

## 11. Diferenciador comercial

La propuesta no debe venderse solo como “Papers, Please en el espacio”.

Debe posicionarse como:

> **Un simulador de inspección migratoria, horror administrativo y decisiones morales en un imperio galáctico al borde del colapso.**

---

## 12. Plataformas objetivo

Primera plataforma:

- PC / Steam.

Motor recomendado:

- Godot: ideal para 2D, interfaces, bajo costo, rápido prototipado.
- Unity: viable si el equipo ya tiene experiencia.
- GameMaker: viable si se busca velocidad en 2D.
- Unreal: no recomendado para MVP si el juego será principalmente de interfaz 2D.

Recomendación inicial: **Godot 4**.

---

## 13. Riesgos principales

### Riesgo 1: parecer copia
Mitigación: añadir entrevistas, facciones, pureza biológica, consecuencias familiares e investigación narrativa.

### Riesgo 2: exceso de texto
Mitigación: textos cortos, casos memorables, documentos visuales, progresión gradual.

### Riesgo 3: alcance demasiado grande
Mitigación: MVP con un día jugable, pocas reglas y alta rejugabilidad.

### Riesgo 4: problemas legales con IP
Mitigación: universo propio, nombres propios, iconografía original y tono inspirado sin copiar activos ni términos protegidos.

---

## 14. Criterio de éxito del prototipo

El prototipo funciona si el jugador:

- entiende el objetivo en menos de 3 minutos;
- comete al menos un error interesante;
- siente presión de tiempo o riesgo;
- recuerda al menos un caso humano;
- quiere jugar “un día más”.



---

## 15. Estado actual del proyecto

Estado: **Documentación inicial preparada para desarrollo asistido con agentes IA**.

Actualmente existe:

- visión general del juego en `PROJECT.md`;
- guía principal para agentes IA en `CLAUDE.md`;
- guía secundaria para Codex en `AGENTS.md`;
- diseño jugable en `GAME_DESIGN.md`;
- biblia narrativa en `NARRATIVE_BIBLE.md`;
- backlog MVP en `MVP_BACKLOG.md`;
- especificación técnica inicial en `TECHNICAL_SPEC.md`;
- guía de seguridad IP en `IP_SAFETY.md`;
- marketing inicial para Steam en `STEAM_MARKETING.md`;
- mapa de capacidades en `SKILLS.md`.

Aún falta construir:

- proyecto Godot inicial;
- estructura real de carpetas;
- escenas base;
- datos JSON del Día 1;
- sistema de solicitantes;
- sistema de documentos;
- sistema de decisiones;
- motor de reglas;
- reporte final;
- escáner básico.

---

## 16. Forma de trabajo con agentes IA

Todo agente IA debe usar `CLAUDE.md` como punto de entrada principal.

Codex puede usar `AGENTS.md` como archivo secundario de compatibilidad, pero debe priorizar `CLAUDE.md`.

`CLAUDE.md` funciona como router principal del proyecto:

- indica qué documentos consultar;
- define el orden de prioridad entre archivos;
- establece reglas de trabajo por módulo;
- limita el alcance del MVP;
- define convenciones de nombres;
- protege la identidad propia del juego;
- obliga a consultar `TECHNICAL_SPEC.md` y `MVP_BACKLOG.md` antes de escribir código.

Ningún agente debe trabajar por ideas sueltas. Debe trabajar por módulos, con criterios de aceptación claros y cambios limitados.

`AGENTS.md` debe mantenerse sincronizado con estas reglas, pero como archivo secundario para Codex. Si hay conflicto entre `CLAUDE.md` y `AGENTS.md`, priorizar `CLAUDE.md`. Si hay conflicto con documentación de producto, priorizar en este orden: `IP_SAFETY.md`, `PROJECT.md`, `MVP_BACKLOG.md`, `TECHNICAL_SPEC.md`, `GAME_DESIGN.md`.

Ejemplo correcto de instrucción:

> Implementa el Módulo 1: estructura base Godot. Consulta `CLAUDE.md`, `TECHNICAL_SPEC.md` y `MVP_BACKLOG.md`. No avances al Módulo 2.

Ejemplo incorrecto:

> Haz el juego completo.

---

## 17. Orden modular de desarrollo

El desarrollo debe avanzar en módulos cerrados.

| Módulo | Nombre | Objetivo |
|---|---|---|
| 1 | Estructura base Godot | Crear proyecto, carpetas, escena inicial y configuración base |
| 2 | Puesto de control | Crear pantalla principal con ventanilla, documentos y botones |
| 3 | Carga JSON | Cargar solicitantes, documentos y reglas desde datos externos |
| 4 | Sistema de solicitantes | Mostrar solicitante actual y avanzar en cola |
| 5 | Sistema de documentos | Renderizar documentos con campos comparables |
| 6 | Sistema de decisiones | Aprobar, rechazar y retener casos |
| 7 | Motor de reglas | Validar inconsistencias y decisiones |
| 8 | Reporte final | Mostrar aciertos, errores, multas y consecuencia |
| 9 | Escáner básico | Detectar anomalías simples |
| 10 | Diálogo simple | Agregar frase inicial e interrogatorio básico |
| 11 | Feedback visual/sonoro | Agregar sellos, alertas y respuesta sensorial |
| 12 | Pulido Día 1 | Mejorar claridad, ritmo y usabilidad |
| 13 | Playtest interno | Validar comprensión y tensión |
| 14 | Expansión Día 2 | Agregar complejidad solo después de validar el Día 1 |

No se debe avanzar a módulos futuros si el módulo actual no tiene flujo funcional mínimo.

---

## 18. Reglas de control de alcance

El proyecto debe resistir la expansión prematura.

Antes de aceptar una nueva idea, preguntar:

1. ¿Hace más claro el loop principal?
2. ¿Aumenta la tensión o solo agrega complejidad?
3. ¿Puede probarse en el MVP?
4. ¿Requiere arte, sistemas o narrativa adicional?
5. ¿Puede dejarse para una versión posterior?

Si una idea no fortalece el MVP, debe ir al backlog futuro.

El MVP no debe incluir combate, exploración, finales múltiples, facciones completamente simuladas, cinemáticas, economía compleja ni arte final.

---

## 19. Convenciones generales de implementación

### Motor

- Godot 4.
- GDScript.
- Juego 2D basado en interfaz.

### Datos

Los datos deben estar separados del código cuando sea posible:

- solicitantes en JSON;
- documentos en JSON;
- reglas en JSON;
- configuración de días en JSON.

### Nombres técnicos

- Escenas: PascalCase, por ejemplo `ControlDesk.tscn`.
- Scripts: PascalCase, por ejemplo `RuleEngine.gd`.
- Variables y funciones GDScript: snake_case, por ejemplo `current_applicant` y `load_next_applicant()`.
- Archivos JSON: snake_case, por ejemplo `applicants_day_01.json`.
- IDs de datos: snake_case con prefijo, por ejemplo `applicant_001`, `document_001`, `rule_001`.
- Decisiones internas: inglés constante, por ejemplo `approve`, `reject`, `hold`.

---

## 20. Registro de avance del proyecto

Este registro debe actualizarse cuando se complete un módulo importante.

### Documentación inicial

Estado: **Completado**.

Incluye:

- visión general;
- diseño de juego;
- biblia narrativa;
- backlog MVP;
- especificación técnica;
- guía IP;
- marketing inicial;
- guía para agentes IA.

### Módulo 1 — Estructura base Godot

Estado: **Pendiente**.

Pendientes:

- crear proyecto Godot;
- crear carpetas base;
- crear escena inicial;
- crear scripts base;
- validar que el proyecto abre correctamente.

---

## 21. Criterio de preparación para agentes IA

El proyecto está preparado para empezar con agentes IA cuando:

- `CLAUDE.md` esté en la raíz del proyecto como guía principal;
- `AGENTS.md` esté en la raíz del proyecto como guía secundaria para Codex;
- `PROJECT.md`, `TECHNICAL_SPEC.md`, `MVP_BACKLOG.md` y `GAME_DESIGN.md` estén accesibles;
- el agente reciba una tarea modular concreta;
- la tarea indique qué módulo trabajar;
- la tarea no pida construir el juego completo de una sola vez.

Primera tarea recomendada:

```md
Implementa el Módulo 1 — Estructura base Godot.

Consulta:
- CLAUDE.md
- PROJECT.md
- TECHNICAL_SPEC.md
- MVP_BACKLOG.md

Objetivo:
Crear la estructura inicial del proyecto Godot 4, carpetas base y una escena principal vacía que pueda ejecutarse.

No implementar todavía:
- sistema de solicitantes;
- documentos;
- decisiones;
- reglas;
- escáner;
- narrativa avanzada.
```
