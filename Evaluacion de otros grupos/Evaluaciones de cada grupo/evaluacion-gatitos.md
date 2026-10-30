# TURBINE | EVALUACIÓN ENTRE GRUPOS

**Ficha de observación desde el papel de cliente · Sesión de pósteres**

**Grupo que evalúa:** (completar)

**Grupo evaluado:** Gatitos

**Fecha:** 27/10/2026

---

## A. Necesidades del cliente y cómo se han planteado

### 01 Sencillez y rapidez
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 02 Uso móvil y desde cualquier lugar
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 03 Clientes y contactos
**Lo observado:** ☐ Se explicó / mostró ☒ Parcialmente ☐ No quedó claro ☐ No lo recuerdo

Hay caso de alta de clientes por el Lector. Incoherencia: el Superadministrador no puede añadir clientes. Sin información sobre contactos múltiples.

### 04 Relación comercial y suscripción
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 05 Tarifas, rangos y revisiones
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 06 Excepciones y aprobaciones
**Lo observado:** ☐ Se explicó / mostró ☒ Parcialmente ☐ No quedó claro ☐ No lo recuerdo

Vimos un flujo de aprobación: el Lector solicita la baja de un cliente y el Administrador la acepta. No vimos descuentos ni precios pactados.

### 07 Facturación recurrente y prorrateo
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 08 Pausas, bajas y reactivaciones
**Lo observado:** ☐ Se explicó / mostró ☒ Parcialmente ☐ No quedó claro ☐ No lo recuerdo

Contemplan la baja (la solicita el Lector y la aprueba el Administrador). No vimos qué pasa con las deudas anteriores ni pausas o reactivaciones.

### 09 Facturas puntuales y conceptos
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 10 Emisión, numeración e histórico
**Lo observado:** ☐ Se explicó / mostró ☒ Parcialmente ☐ No quedó claro ☐ No lo recuerdo

Conservan las facturas durante 5 años. Plazo dudoso (el Código de Comercio exige 6) y sin justificar. No vimos numeración ni rectificativas.

### 11 PDF y entrega al cliente
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 12 Recordatorios e impagos
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 13 Cobros y conciliación
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 14 Usuarios, roles y asignaciones
**Lo observado:** ☐ Se explicó / mostró ☒ Parcialmente ☐ No quedó claro ☐ No lo recuerdo

Tienen 7 actores, pero en la presentación solo mostraron 3 y no supieron justificar por qué esos. En los UML, los roles no heredan entre sí (Lector → Administrador → Superadministrador), cuando el cliente describe perfiles de alcance creciente.

### 15 Notificaciones y trabajo diario
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 16 Consultas, informes y exportaciones
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

### 17 Trazabilidad y seguridad
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información sobre auditoría. Solo conocemos la retención de 5 años.

### 18 Crecimiento y fiabilidad
**Lo observado:** ☐ Se explicó / mostró ☐ Parcialmente ☐ No quedó claro ☒ No lo recuerdo

Sin información.

---

## B. Casos de uso vistos desde el cliente

### Escenario mejor resuelto
La baja de un cliente con aprobación: el Lector la solicita y el Administrador la acepta. Refleja separación de responsabilidades.

### Escenario ausente o poco claro
Los actores. Con solo 3 de 7 actores mostrados, no se entendía quién hace qué. Tampoco quedó claro por qué el Superadministrador no puede dar de alta clientes.

### Situaciones excepcionales
No recordamos que explicaran impagos, correos rebotados o pagos ambiguos. Solo vimos el caso de la baja.

---

## C. Presentación del póster

### Lo que entendí bien
La estructura del trabajo: 26 casos de uso y 6 diagramas UML. El flujo de baja con aprobación.

### Lo que no entendí
Por qué eligieron esos actores y por qué faltaban en la presentación. Para resolver dudas de requisitos usaron una herramienta de IA (Gemini Gem) en vez de responder ellos mismos.

---

## D. Valoración libre del cliente

### Qué me gustó
1. Amplia cobertura: 26 casos de uso y 6 diagramas UML.
2. Flujo de baja con aprobación del Administrador.
3. Definen un plazo de conservación de facturas (aunque haya que revisarlo).

### Qué eché en falta
1. Justificación de los actores (7 definidos, solo 3 presentados).
2. Jerarquía de roles coherente (herencia entre Lector, Administrador y Superadministrador).
3. Que el Superadministrador pueda hacer lo que hace el Lector, como dar de alta clientes.

### Tres preguntas que haría al equipo
1. ¿Por qué esos 7 actores y cuáles son los otros 4?
2. ¿Por qué el Superadministrador no puede añadir clientes y el Lector sí?
3. ¿Por qué conservan las facturas 5 años y en qué se basan?

---

## E. Impresión final (sin nota)

Confianza media. Hay trabajo y volumen (26 casos de uso, 6 diagramas) y un flujo de aprobación razonable. Pero la falta de justificación de actores, la jerarquía de roles incoherente y la dependencia de la IA para responder dudas generan reservas. Antes de aceptarla comprobaría el modelo de roles, el plazo de conservación legal y los flujos de facturación, cobros e impagos, que no vimos.
