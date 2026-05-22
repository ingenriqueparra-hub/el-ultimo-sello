# GAME_DESIGN.md
# Diseño de juego — **El Último Sello**

---

## 1. Género

Simulador narrativo de inspección migratoria con elementos de:

- puzzle documental;
- thriller burocrático;
- toma de decisiones morales;
- gestión ligera de recursos;
- narrativa ramificada.

---

## 2. Core loop detallado

```text
1. Recibir solicitante
2. Leer propósito del solicitante
3. Revisar documentos
4. Comparar datos
5. Usar herramientas disponibles
6. Interrogar si es necesario
7. Detectar errores o señales de riesgo
8. Tomar decisión
9. Registrar consecuencia
10. Pasar al siguiente solicitante
11. Cerrar el día con reporte
```

---

## 3. Decisiones base

### Aprobar ingreso
Permite que el solicitante pase.

Riesgo:
- dejar pasar amenaza;
- violar orden interna;
- perder reputación con facciones de control.

### Rechazar ingreso
Niega el ingreso.

Riesgo:
- castigar inocentes;
- generar quejas;
- perder reputación con facciones humanitarias o mercantiles.

### Retener
Envía al solicitante a revisión.

Riesgo:
- consume recursos;
- puede ser abuso de autoridad;
- puede molestar a facciones poderosas.

### Escalar
Pide decisión superior.

Riesgo:
- reduce autonomía;
- puede proteger al jugador;
- puede generar órdenes injustas.

### Eliminar / neutralizar
Solo disponible en etapas avanzadas o contextos extremos.

Riesgo:
- consecuencias morales;
- sanciones si se usa incorrectamente;
- reputación de brutalidad.

---

## 4. Tipos de solicitantes

| Tipo | Descripción | Riesgo principal |
|---|---|---|
| Ciudadano común | Persona que busca entrar por trabajo o familia | Errores menores, documentos vencidos |
| Refugiado | Viene de una zona colapsada | Falta de documentos, posible infección |
| Mercader | Transporta bienes | Contrabando, sobornos |
| Soldado | Regresa de campaña | Trauma, órdenes especiales |
| Noble | Exige trato preferencial | Presión política |
| Clérigo | Porta reliquias o permisos religiosos | Fanatismo, acusaciones |
| Técnico | Transporta tecnología | IA prohibida, implantes |
| Prisionero trasladado | Custodiado por fuerza armada | Fuga, identidad falsa |
| Niño/familia | Caso emocional | Mutación leve, documentación incompleta |
| Agente encubierto | Parece normal | Datos perfectos pero conducta sospechosa |

---

## 5. Tipos de documentos

### Pase de Tránsito Planetario
Campos:

- nombre;
- código de identidad;
- origen;
- destino;
- fecha de emisión;
- fecha de expiración;
- motivo de tránsito;
- sello de autoridad.

### Certificado Biométrico
Campos:

- nombre;
- código genético;
- edad;
- especie humana declarada;
- anomalías registradas;
- firma médica;
- fecha de prueba.

### Permiso de Carga
Campos:

- propietario;
- tipo de carga;
- peso;
- destino;
- autorización;
- restricciones;
- sello comercial.

### Salvoconducto de Facción
Campos:

- facción emisora;
- rango;
- privilegio;
- vigencia;
- cláusulas especiales.

### Orden Superior
Documento raro que puede contradecir reglas normales.

---

## 6. Inconsistencias posibles

| Inconsistencia | Ejemplo |
|---|---|
| Nombre distinto | “Elias Vorn” vs “Elias Vorm” |
| Código biométrico diferente | ID no coincide |
| Documento vencido | Fecha expirada |
| Origen bloqueado | Sector en cuarentena |
| Destino no autorizado | Quiere ir a zona restringida |
| Sello falso | Autoridad inexistente |
| Motivo inconsistente | Dice turismo, documento dice trabajo |
| Carga no declarada | Escáner detecta masa extra |
| Anomalía genética | Certificado oculta mutación |
| Orden contradictoria | Una facción permite, otra prohíbe |

---

## 7. Presión de tiempo

El juego puede tener un reloj por día.

Opciones:

- modo con tiempo real;
- modo sin tiempo, pero con cuota diaria;
- modo mixto.

Recomendación MVP:

- sin tiempo real al inicio;
- cuota de solicitantes;
- presión por reporte final.

Luego agregar modo de dificultad con tiempo.

---

## 8. Economía del jugador

Variables posibles:

- salario diario;
- multas por error;
- costo de comida familiar;
- medicinas;
- seguridad del hogar;
- reputación;
- favores de facciones.

Para MVP:

- salario;
- multa;
- reputación general;
- consecuencia narrativa.

---

## 9. Progresión de dificultad

La dificultad debe escalar por capas, no por saturación.

El jugador no debe empezar revisando todos los documentos, reglas y excepciones desde el primer día. Cada día debe introducir una nueva capa jugable que se apoya sobre lo aprendido anteriormente.

Principio:

> Primero detectar errores simples, luego interpretar excepciones, finalmente cargar con consecuencias.

### Curva base

| Día | Nueva capa | Qué aprende el jugador | Riesgo principal |
|---|---|---|---|
| Día 1 | Pase de tránsito | Revisar nombre, fecha, origen, destino, motivo y sello | Error documental simple |
| Día 2 | Certificado biométrico | Cruzar datos entre documentos | Identidad inconsistente |
| Día 3 | Sectores en cuarentena | Aplicar reglas externas del día | Documento válido pero origen prohibido |
| Día 4 | Permiso de carga | Revisar mercancías y peso declarado | Contrabando o carga no declarada |
| Día 5 | Facciones | Gestionar privilegios, presión y órdenes contradictorias | Decisión políticamente costosa |
| Día 6 | Interrogatorio | Comparar respuestas contra documentos | Mentira o contradicción verbal |
| Día 7 | Caso narrativo mayor | Resolver dilema con información incompleta | No hay decisión limpia |

### Regla de diseño

La dificultad no debe crecer agregando demasiados campos por solicitante. Debe crecer combinando:

- más documentos;
- más reglas;
- más excepciones;
- más presión moral;
- más consecuencias.

### Ejemplo de escalada

Día 1:
- El pase está vencido.
- Decisión esperada: rechazar.

Día 4:
- El pase es válido.
- El certificado es válido.
- La carga pesa más de lo declarado.
- Decisión esperada: retener.

Día 7:
- Madre con niño.
- Documentos incompletos.
- Niño con anomalía leve.
- Sector de origen en cuarentena.
- Orden superior contradictoria.
- Decisión esperada: ambigua, con consecuencia narrativa.

### Regla de oro

El jugador debe sentir que domina una capa antes de recibir la siguiente.

---

## 10. Panel de debug — Aclaración de diseño

El panel de debug activado con la tecla `Y` **no es una mecánica jugable**.

No debe:

- mostrarse en builds de release ni en builds de playtest con jugadores reales;
- alterar reglas, balance o economía;
- usarse como ayuda al jugador durante la experiencia normal;
- influir en las decisiones del jugador final.

Es exclusivamente una herramienta interna de desarrollo y QA que permite verificar si el sistema evalúa correctamente cada caso, sin modificar el flujo del juego.

Si en el futuro se añade un sistema de "modo estudio" o "modo entrenamiento" para el jugador, debe diseñarse como una feature independiente, con diseño propio, no derivada de este panel.

---

## 11. Condición de victoria

No debe haber una sola victoria.

Finales posibles:

- funcionario obediente;
- denunciante;
- corrupto;
- mártir institucional;
- cómplice de una red;
- salvador de refugiados;
- causante de una catástrofe;
- ascendido por crueldad;
- desaparecido por saber demasiado.

