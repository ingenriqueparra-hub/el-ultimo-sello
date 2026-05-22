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
- 10 a 15 solicitantes.
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

