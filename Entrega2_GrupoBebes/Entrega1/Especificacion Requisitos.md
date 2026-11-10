# Requisitos

## 1. Contexto y alcance

### 1.1. Objetivo del sistema

Proporcionar una herramienta interna de gestión administrativa, facturación y cobros para Turbine, independiente del producto principal (Brain), que permita gestionar de forma ágil y automatizada miles de clientes, suscripciones, facturas recurrentes y puntuales, pagos, recordatorios y flujos operativos, con trazabilidad e inmutabilidad de lo emitido y sin requerir un ERP complejo.

### 1.2. Alcance

**Dentro del alcance**

- Control de la relación comercial de cada empresa cliente (contactos, plan, tarifa, pausas y bajas) y de su estado.
- Emisión y ciclo de vida de facturas puntuales y recurrentes (borradores, prorrateo, numeración, aprobaciones, rectificativas, presupuestos opcionales) con PDF inalterable.
- Envío trazable de facturas por correo o WhatsApp (simulado), gestión de incidencias de entrega, recordatorios de impago y seguimiento de cobros.
- Conciliación de cobros con Stripe y banco (simulados), pagos parciales o excesivos y revisión manual de inconsistencias.
- Notificaciones internas, pantalla de trabajo diaria, dashboards e informes, búsqueda, importación de clientes e histórico, auditoría, roles y permisos, copias de seguridad, monitorización y API para sistemas externos.

La prioridad entre estas funciones se define en el apartado 1.4.

**Fuera del alcance**

- Altas o bajas comerciales del producto principal (Brain).
- Integración real con pasarelas de pago o proveedores de mensajería (se simulan Stripe, WhatsApp y correo).
- Consultoría o asesoría fiscal automatizada; integración con Verifactu en la fase inicial (se prevé exportar un paquete para la gestoría).
- Procesamiento directo de pagos reales.

**Alcance de las integraciones**

| Integración | Alcance | Referencia |
|---|---|---|
| Stripe (pasarela) | **Simulada**: recibe eventos de pago, sin contabilizar dos veces el mismo | FR-25, A-03 |
| Banco / Revolut | **Simulada**: movimientos para conciliar | FR-26 |
| Correo electrónico | **Servicio de pruebas** | FR-20, A-03 |
| WhatsApp | **Simulada**, solo con consentimiento y número válido | FR-20, RB-28 |
| CSV de clientes | **Real** | FR-34 |
| API externa | **Subconjunto representativo** con contrato documentado: consulta (CU-57) y solicitud de baja (CU-58) | FR-59 a FR-61 |
| Encapsulación | Cambiar de proveedor no obliga a reescribir el modelo de factura | NFR-27 |

### 1.3. Actores y partes interesadas

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Superadministrador | Persona con acceso a la configuración global del sistema | Configurar umbrales de aprobación, rangos y tarifas, series de numeración y recordatorios |
| Administrador | Empleado con permisos de gestión de operación, clientes, facturas, asignaciones y aprobaciones, sin acceso a la configuración global | Supervisar el estado del sistema, consultar el histórico de cualquier cliente, gestionar cambios de plan anuales, corregir errores con facturas rectificativas y gestionar el control de acceso |
| Lector | Empleado que trabaja sobre los clientes que tiene asignados | Realizar sus operaciones diarias, conocer el saldo y las facturas pendientes y pagadas de sus clientes y tener claro el estado real de los envíos |
| Sistema externo | Sistema de terceros o de Turbine (como Brain) que consume la API de la aplicación | Consultar deuda, facturas y clientes y solicitar bajas sin saltarse las reglas del sistema |
| Pasarela de pagos (Stripe simulado) | Servicio externo que notifica los cobros | Que los pagos se reflejen correctamente en las facturas, sin contabilizar dos veces el mismo evento |

Gestoría y persona de contacto del cliente son partes interesadas, no actores del sistema.

El **Planificador** (tareas automáticas) no es un actor: es un mecanismo interno del sistema que dispara por tiempo la generación mensual, los recordatorios, la campaña anual, la caducidad de delegaciones y las copias de seguridad. En las fichas aparece como «Sistema (tarea programada)». Los actores externos son la pasarela de pagos y los sistemas externos que usan la API.

El cliente habla de «usuario operativo», «administrador» y «superadministrador» y pidió no aferrarse al nombre de los perfiles. En este documento el usuario operativo se llama **Lector**: trabaja sobre los clientes que tiene asignados y puede ver y modificar su información operativa; no es un perfil de solo lectura. La asignación de operaciones a cada rol se recoge en `Matriz_permisos.md`.

### 1.4. Primera versión del sistema

Los casos de uso se clasifican en tres niveles para identificar el producto mínimo viable y el orden de trabajo:

- **Núcleo:** sin ellos Turbine no puede facturar, enviar, cobrar ni controlar quién accede. Forman la primera versión.
- **Complementario:** completan o facilitan el trabajo diario y entran en las siguientes iteraciones.
- **Opcional:** ampliaciones sugeridas por el cliente (A-13).

| Nivel | Casos de uso |
|---|---|
| **Núcleo** (27) | Clientes: CU-01, CU-02, CU-03, CU-09 · Relación comercial: CU-10, CU-14 · Facturación: CU-15, CU-16, CU-17, CU-19, CU-21 · Aprobaciones: CU-22, CU-23, CU-24 · Envío y recordatorios: CU-27, CU-28, CU-29, CU-30 · Cobros: CU-33, CU-34, CU-35 · Notificaciones: CU-37 · Usuarios y auditoría: CU-48, CU-49, CU-50, CU-52 · Configuración: CU-54 |
| **Complementario** (29) | CU-04, CU-05, CU-06, CU-07, CU-11, CU-12, CU-13, CU-18, CU-25, CU-26, CU-31, CU-32, CU-36, CU-38, CU-39, CU-40, CU-41, CU-42, CU-43, CU-45, CU-46, CU-47, CU-51, CU-53, CU-55, CU-56, CU-57, CU-58, CU-59 |
| **Opcional** (3) | CU-08, CU-20, CU-44 |

El núcleo es coherente consigo mismo: sus casos se apoyan en otros del núcleo (por ejemplo, CU-23 usa el umbral de CU-54; CU-29 usa la configuración de CU-30; CU-27 usa los contactos de CU-03 y deriva los fallos de envío a CU-28; la restricción por cartera, RB-15, se apoya en CU-50). Las únicas referencias a casos complementarios son consultas o configuraciones con valores por defecto (CU-31, CU-38, CU-56). CU-09 entra en el núcleo por ser una obligación legal (protección de datos). Dentro de un caso del núcleo, los requisitos marcados «(opcional)» siguen siéndolo (por ejemplo, FR-66 en CU-15 y FR-98 en CU-54).

## 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | Reducir el trabajo manual de la facturación y del seguimiento de cobros, y poder crecer hacia miles de clientes sin aumentar de forma proporcional el personal administrativo | Entrevista |
| BR-02 | Mantener la independencia operativa de la herramienta administrativa respecto al producto principal (Brain) | Entrevista |
| BR-03 | Garantizar la integridad legal, contable e histórica de la facturación (lo emitido no se altera, las correcciones quedan vinculadas) con trazabilidad de quién hizo qué y por qué | Entrevista |
| BR-04 | Conseguir una automatización fiable y explicable: ninguna factura, envío, cobro o tarea falla en silencio ni se duplica, y un fallo puntual no detiene al resto | Entrevista |
| BR-05 | Obtener visibilidad financiera fiable (facturado, cobrado, pendiente, vencido) con cifras reconciliables, también a nivel global del negocio | Entrevista |
| BR-06 | Proteger los datos de clientes, contactos y documentos y cumplir la normativa de privacidad sin perder la conservación exigida por ley | Entrevista |
| BR-07 | Permitir que el sistema evolucione (nuevos planes, canales, monedas, sociedades, países) sin reescribirlo | Entrevista |
| BR-08 | Poder gestionar la facturación de forma rápida y sencilla desde cualquier dispositivo | Entrevista |
| BR-09 | Representar la relación comercial entre Turbine y sus empresas clientes, con múltiples contactos, de forma independiente de las facturas y del producto | Entrevista |
| BR-10 | Garantizar la continuidad del recobro de las deudas pendientes tras una pausa o una baja del cliente | Entrevista |
| BR-11 | Optimizar la tasa de cobro mediante notificaciones, seguimiento de impagos y conciliación de cobros | Entrevista |
| BR-12 | Procesar empresas clientes internacionales sin asumir formatos fiscales, domicilios, monedas o idiomas españoles | Entrevista |
| BR-13 | Facilitar la coordinación interna: asignación de clientes a empleados, incidencias y acceso limitado a los clientes asignados | Entrevista |
| BR-14 | Evitar que los datos de facturación se usen automáticamente para campañas comerciales | Entrevista |

## 3. Requisitos de usuario

La columna **Fuente** indica el origen de cada requisito: *Entrevista* (lo pidió el cliente), *Sugerido por el cliente* (lo propuso como ampliación u opcional) o *Inferencia del equipo* (lo deduce el equipo a partir de lo dicho).

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-01 | Lector / Administrador | Poder registrar la información fiscal y operativa de la empresa (país, identificación fiscal y moneda). | Entrevista |
| UR-02 | Lector / Administrador | Poder consultar la información registrada de la empresa. | Entrevista |
| UR-03 | Lector / Administrador | Poder gestionar los contactos asociados a cada empresa cliente. | Entrevista |
| UR-04 | Lector / Administrador | Poder consultar la información de la relación comercial (fecha de inicio, plan, tarifa, condiciones de pago, responsable e historial). | Entrevista |
| UR-05 | Lector / Administrador | Poder preparar y emitir facturas. | Entrevista |
| UR-06 | Administrador | Poder revisar el cálculo prorrateado del importe de una factura antes de su emisión. | Entrevista |
| UR-07 | Lector / Administrador | Poder consultar el estado de cobro, el historial y la trazabilidad de las facturas. | Entrevista |
| UR-08 | Lector / Administrador | Poder borrar un borrador de factura que no se haya emitido. | Entrevista |
| UR-09 | Lector / Administrador | Poder programar la emisión de facturas para fechas futuras. | Inferencia del equipo |
| UR-10 | Superadministrador | Poder configurar el rango y precios de las tarifas globales. | Entrevista |
| UR-11 | Lector / Administrador | Poder modificar los impuestos aplicables a una factura. | Entrevista |
| UR-12 | Lector / Administrador | Poder proponer facturas nuevas o modificadas que requieran revisión. | Entrevista |
| UR-13 | Administrador | Poder revisar las propuestas de facturas recibidas y registrar su aprobación o rechazo. | Entrevista |
| UR-14 | Superadministrador | Poder configurar los umbrales de facturación para las aprobaciones extraordinarias. | Entrevista |
| UR-15 | Superadministrador | Poder autorizar facturas que superen el umbral de facturación configurado. | Entrevista |
| UR-16 | Superadministrador | Poder configurar la serie y numeración de las facturas. | Entrevista |
| UR-17 | Lector / Administrador | Poder gestionar facturas de modalidad puntual y recurrente. | Entrevista |
| UR-18 | Lector / Administrador | Poder hacer el seguimiento de cobros y enviar recordatorios de pago. | Entrevista |
| UR-19 | Lector / Administrador | Poder consultar la lista de clientes con fecha de inicio futura pendientes de activación. | Entrevista |
| UR-20 | Lector | Poder pausar temporalmente una suscripción indicando motivo y fechas, congelando la generación de mensualidades sin afectar a las facturas impagadas | Entrevista |
| UR-21 | Lector / Administrador | Poder recibir alertas de reactivación de suscripciones pausadas para confirmar la reanudación del cobro | Entrevista |
| UR-22 | Lector | Poder registrar la baja de un cliente deteniendo cobros futuros pero manteniendo el flujo de recobro sobre las deudas no saldadas | Entrevista |
| UR-23 | Lector | Poder confeccionar facturas puntuales utilizando conceptos frecuentes de un catálogo ligero | Entrevista |
| UR-24 | Lector | Poder previsualizar la factura y disponer de bloqueos automáticos en caso de faltar datos fiscales antes de su emisión | Entrevista |
| UR-25 | Lector | Poder gestionar incidencias de envío de correo para corregir los datos de contacto y realizar reintentos sin emitir facturas duplicadas | Entrevista |
| UR-26 | Administrador | Poder pausar el envío automático de recordatorios marcando facturas "en disputa" mientras se investiga una disconformidad | Entrevista |
| UR-27 | Administrador | Poder dar de baja contable una deuda clasificándola como "anulada" o "incobrable" tras aprobación administrativa | Entrevista |
| UR-28 | Administrador | Poder revisar en una bandeja de trabajo los movimientos bancarios o de pasarela no conciliados automáticamente o con importes parciales/excesivos | Entrevista |
| UR-29 | Lector / Administrador | Poder disponer de la factura emitida en PDF, con su aspecto y contenido inalterables aunque cambie la marca o el catálogo | Entrevista |
| UR-30 | Lector / Administrador | Poder enviar las facturas emitidas al contacto de facturación por correo electrónico o WhatsApp (simulado) | Entrevista |
| UR-31 | Superadministrador | Poder configurar la cadencia de los recordatorios automáticos de impago y que respeten el vencimiento acordado con cada cliente | Entrevista |
| UR-32 | Lector / Administrador | Poder consultar los cobros notificados por la pasarela de pagos sin que un mismo evento se contabilice dos veces | Entrevista |
| UR-33 | Lector / Administrador | Poder disponer de una pantalla de trabajo diaria útil que muestre alertas y tareas pendientes para resolverlas con pocos clics | Entrevista |
| UR-34 | Lector | Poder recibir notificaciones relevantes de los clientes asignados y distinguir las ya leídas de las ya resueltas | Entrevista |
| UR-35 | Superadministrador | Poder configurar canales y preferencias de notificación (in-app, email, resumen diario) para evitar saturación | Entrevista |
| UR-36 | Administrador | Poder consultar un dashboard financiero con cifras reales y generar informes filtrables y exportables a CSV y PDF | Entrevista |
| UR-37 | Lector / Administrador / Superadministrador | Poder realizar búsquedas globales rápidas y guardar vistas o filtros frecuentes | Entrevista |
| UR-38 | Lector / Administrador / Superadministrador | Poder importar clientes desde CSV con previsualización, mapeo y control de duplicados (NIF) | Entrevista |
| UR-39 | Administrador | Poder importar histórico de facturas en modo migración sin disparar emails ni consumir numeración oficial | Sugerido por el cliente |
| UR-40 | Administrador / Superadministrador | Poder gestionar altas, invitaciones y desactivaciones de usuarios internos manteniendo el histórico de auditoría (el cambio de rol se añade por inferencia del equipo, A-26) | Entrevista |
| UR-41 | Lector / Administrador / Superadministrador | Poder recuperar la contraseña mediante un enlace temporal con caducidad | Entrevista |
| UR-42 | Lector | Poder trabajar exclusivamente sobre los clientes asignados, con permisos operativos limitados y sin acceso a la configuración global | Entrevista |
| UR-43 | Administrador | Poder asignar y desasignar clientes, heredando el nuevo responsable las tareas pendientes y manteniendo el histórico | Entrevista |
| UR-44 | Administrador | Poder delegar temporalmente los clientes de un usuario (por vacaciones) sin necesidad de compartir contraseñas | Entrevista |
| UR-45 | Lector / Administrador / Superadministrador | Poder evitar sobrescribir cambios de otros usuarios mediante la detección de conflictos de edición concurrente | Entrevista |
| UR-46 | Superadministrador | Poder consultar y filtrar los registros de auditoría de negocio sin poder alterar el pasado | Entrevista |
| UR-47 | Superadministrador | Poder disponer de copias de seguridad automáticas y un mecanismo de restauración probado y demostrable | Entrevista |
| UR-48 | Lector / Administrador / Superadministrador | Poder descargar únicamente los documentos e información para los cuales posea permisos válidos | Entrevista |
| UR-49 | Lector / Administrador | Poder redactar y enviar facturas y recordatorios previos por correo electrónico utilizando plantillas que completen automáticamente variables clave (nombre de empresa, número de factura, importe y vencimiento) | Entrevista |
| UR-50 | Lector / Administrador | Poder abrir y seguir incidencias de facturación sobre un cliente | Entrevista |
| UR-51 | Lector / Administrador / Superadministrador | Poder consultar informes detallados de la aplicación (incluyendo facturas que fallaron en meses anteriores) así como resúmenes semanales y mensuales | Entrevista |
| UR-52 | Lector / Administrador | Poder utilizar la aplicación desde diferentes dispositivos (ordenador, tablet y móvil), en idioma español o inglés, adaptada a la zona horaria de España | Entrevista |
| UR-53 | Lector | Poder distinguir entre una factura que existe pero no se pudo enviar y una factura que no se pudo crear | Entrevista |
| UR-54 | Lector | Poder preparar un presupuesto para un cliente, enviarlo y registrar si lo acepta o lo rechaza, para convertirlo en factura sin volver a introducir los datos (opcional) | Sugerido por el cliente |
| UR-55 | Administrador | Poder corregir un error de una factura ya emitida sin alterarla, de forma que el saldo del cliente refleje la corrección | Entrevista |
| UR-56 | Lector | Poder conocer de un vistazo el saldo, las facturas pendientes y las pagadas, y comprobar de dónde sale cada cifra (limitado a clientes asignados) | Entrevista |
| UR-57 | Administrador | Poder revisar cada año si un cliente sigue en el plan que le corresponde y decidir el cambio, sin que se alteren las facturas pasadas | Entrevista |
| UR-58 | Administrador | Poder conocer el estado del sistema (emails pendientes, errores de integración, último backup, última generación recurrente) | Entrevista |
| UR-59 | Administrador | Poder consultar la historia de cada cliente | Entrevista |
| UR-60 | Administrador | Poder garantizar que solo las personas autorizadas acceden al sistema y a cada cliente o factura | Entrevista |
| UR-61 | Sistema externo | Poder consultar datos de clientes, deuda y facturas, y enviar solicitudes (como la de baja de un cliente), de forma que el sistema aplique siempre sus reglas de negocio | Entrevista |
| UR-62 | Administrador | Poder identificar y localizar la causa de un error del sistema a partir de un código de incidencia | Entrevista |
| UR-63 | Lector / Administrador | Poder ver un mensaje comprensible ante un error, sin información técnica interna del sistema | Entrevista |
| UR-64 | Lector | Poder dar de alta clientes con datos correctos y sin duplicados, y saber qué datos faltan para poder facturarles | Entrevista |
| UR-65 | Superadministrador | Poder configurar los datos fiscales del emisor | Entrevista |
| UR-66 | Administrador | Poder elegir, si Turbine factura desde varias sociedades, con cuál se emite cada factura (opcional) | Entrevista |
| UR-67 | Lector | Poder adjuntar a un cliente o a una factura los documentos que lo justifican (pedido, presupuesto aceptado, justificante) de forma segura | Entrevista |
| UR-68 | Lector | Poder acceder rápidamente a los clientes con los que trabaja con más frecuencia | Entrevista |
| UR-69 | Lector / Administrador | Poder comentar internamente en clientes, facturas e incidencias, con notas restringidas cuando proceda. | Entrevista |
| UR-70 | Lector / Administrador / Superadministrador | Poder evitar duplicados por doble clic o reintento al emitir, enviar o conciliar. | Entrevista |
| UR-71 | Administrador | Poder fijar objetivos mensuales/anuales de facturación y cobro. | Entrevista |
| UR-72 | Superadministrador | Poder configurar el sistema de plazos (plazo de pago y calendario laboral). | Entrevista |
| UR-73 | Superadministrador | Poder configurar las monedas en las que se emiten las facturas. | Entrevista |
| UR-74 | Superadministrador | Poder cargar datos ficticios para demostraciones sin mezclarlos con los de producción | Entrevista |
| UR-75 | Administrador / Superadministrador | Poder localizar qué datos personales se tienen de un contacto y anonimizarlos cuando legalmente proceda, sin invalidar el histórico contable. | Entrevista |
| UR-76 | Administrador | Poder consultar tipos de cambio y reglas de conversión de divisa aplicados a la consolidación de informes. | Entrevista |
| UR-77 | Lector / Administrador | Poder consultar la trazabilidad y el estado detallado de entrega de cada mensaje individual enviado. | Entrevista |
| UR-78 | Lector / Administrador / Superadministrador | Poder consultar en una bandeja el estado (aprobada, rechazada o pendiente) de las solicitudes económicas realizadas. | Entrevista |
| UR-79 | Administrador / Superadministrador | Poder ver los comentarios explicativos del aprobador sobre una solicitud, para entender el motivo de la decisión. | Entrevista |
| UR-80 | Administrador / Superadministrador | Poder garantizar la separación de funciones: nadie aprueba sus propias solicitudes sensibles. | Entrevista |
| UR-81 | Administrador | Poder ejecutar el cierre formal de un mes o trimestre contable cuando finalice el periodo. | Entrevista |
| UR-82 | Administrador | Poder evitar modificar por error facturas o cobros de un periodo cerrado. | Entrevista |
| UR-83 | Superadministrador | Poder reabrir periodos cerrados únicamente ingresando un motivo obligatorio que quede registrado. | Entrevista |
| UR-84 | Administrador | Poder generar y descargar en un solo archivo (ZIP/CSV) toda la información y PDF contables del periodo. | Entrevista |
| UR-85 | Administrador | Poder consultar la fecha y autoría de la última generación del paquete contable para confirmar su envío a la gestoría. | Entrevista |
| UR-86 | Administrador | Poder diferenciar si un paquete contable es la versión inicial o una regeneración posterior para evitar duplicidades o confusiones. | Entrevista |
| UR-87 | Lector / Administrador | Poder registrar el idioma preferido de un contacto para enviarle las comunicaciones en su idioma. | Entrevista |
| UR-88 | Lector / Administrador | Poder indicar el canal preferido de un contacto para recibir notificaciones e impresos. | Entrevista |
| UR-89 | Lector / Administrador | Poder gestionar los permisos de envío de forma independiente para cada canal según la normativa de protección de datos. | Entrevista |
| UR-90 | Superadministrador | Poder consultar en la auditoría del sistema qué usuario realizó exportaciones masivas de datos y con qué criterios. | Entrevista |
| UR-91 | Superadministrador | Poder identificar quién y cuándo descargó cualquier fichero de datos exportado, para disuadir fugas de información. | Entrevista |
| UR-92 | Lector / Administrador | Poder recibir una alerta cuando una factura supere el límite tolerable de días vencida. | Entrevista |
| UR-93 | Lector / Administrador | Poder recibir una notificación cuando la deuda de un cliente supera el límite económico permitido, para bloquear nuevas acciones. | Entrevista |
| UR-94 | Lector / Administrador | Poder recibir un aviso cuando fallen repetidamente los envíos hacia un contacto, para corregir sus datos de entrega. | Entrevista |
| UR-95 | Lector / Administrador | Poder recibir un aviso sobre revisiones pendientes que lleven más de una semana sin gestión. | Entrevista |
| UR-96 | Lector / Administrador / Superadministrador | Poder conservar su información redactada ante interrupciones accidentales durante la edición de facturas. | Entrevista |
| UR-97 | Lector / Administrador / Superadministrador | Poder deshacer modificaciones accidentales exceptuando las legalmente irreversibles. | Entrevista |
| UR-98 | Lector / Administrador / Superadministrador | Poder comprender el nivel de irreversibilidad legal y riesgo de una acción antes de su confirmación final. | Entrevista |
| UR-99 | Lector / Administrador / Superadministrador | Poder identificar y resolver las incidencias y excepciones técnicas de los procesos de cobro. | Entrevista |
| UR-100 | Superadministrador | Poder establecer un tiempo de retención de almacenamiento temporal para informes. | Entrevista |
| UR-101 | Superadministrador | Poder evaluar la eficiencia operativa mediante un dashboard. | Inferencia del equipo |
| UR-102 | Administrador | Poder confiar en que una caída breve del sistema no hace perder ni duplicar emisiones o generaciones mensuales de facturas | Entrevista |
| UR-103 | Superadministrador | Poder gestionar la configuración global del sistema con cambios validados y auditados, sin que afecten a lo ya emitido | Entrevista |
| UR-104 | Administrador / Superadministrador | Poder probar los cambios de plantillas y de reglas de recordatorio antes de activarlos | Entrevista |
| UR-105 | Lector / Administrador | Poder dar de alta clientes de forma ágil, con valores por defecto y revisando el resultado antes de confirmar | Entrevista |
| UR-106 | Lector / Administrador | Poder ejecutar acciones masivas sobre clientes con control del alcance y del resultado | Entrevista |
| UR-107 | Lector / Administrador | Poder etiquetar clientes y clasificar facturas por proyecto o línea de negocio para organizarlos y analizarlos (opcional) | Sugerido por el cliente |
| UR-108 | Lector / Administrador | Poder buscar direcciones al registrar los datos de un cliente | Entrevista |
| UR-109 | Administrador / Superadministrador | Poder asegurar que los datos de facturación no se usan automáticamente para campañas comerciales | Entrevista |
| UR-110 | Superadministrador | Poder confiar en que el cálculo financiero es determinista y no depende de inteligencia artificial | Entrevista |
| UR-111 | Administrador | Poder programar informes periódicos y su envío a las personas que indique (opcional) | Sugerido por el cliente |

## 4. Requisitos del sistema

### 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | El sistema deberá permitir registrar y consultar los datos identificativos y fiscales de la empresa cliente. | UR-01, UR-02 |
| FR-02 | El sistema deberá permitir gestionar los contactos de una empresa cliente. | UR-03 |
| FR-03 | El sistema deberá registrar la relación comercial de una empresa. | UR-04 |
| FR-04 | El sistema deberá permitir crear facturas puntuales con varias líneas e impuestos aplicables seleccionados de los configurados. | UR-05, UR-11, UR-17, UR-23 |
| FR-05 | El sistema deberá permitir configurar la facturación recurrente mensual de una relación comercial aprobada. | UR-05, UR-17 |
| FR-06 | El sistema deberá generar automáticamente cada mes las facturas recurrentes, con prorrateo del primer mes salvo excepción comercial aprobada, y mostrar el cálculo antes de confirmar. | UR-06, UR-17, UR-105 |
| FR-07 | El sistema deberá permitir asignar una fecha de inicio futura a una relación comercial. | UR-18, UR-19 |
| FR-08 | El sistema deberá permitir programar la emisión automática de facturas para una fecha futura. | UR-09 |
| FR-09 | El sistema deberá registrar el estado de cobro de cada factura y sus transiciones, y permitir listar y filtrar las facturas por estado. | UR-07, UR-18 |
| FR-10 | El sistema deberá permitir configurar los rangos de facturación anual y sus tarifas sin modificar el código fuente. | UR-10 |
| FR-11 | El sistema deberá permitir proponer excepciones comerciales y gestionar su aprobación, dejando pendientes las facturas afectadas y registrando la decisión. | UR-12, UR-13, UR-14, UR-15 |
| FR-12 | El sistema deberá permitir parametrizar los umbrales económicos y los niveles de aprobación de las excepciones comerciales. | UR-13, UR-14, UR-15 |
| FR-13 | El sistema deberá permitir configurar las series de facturación y asignar un número correlativo único al emitir cada factura. | UR-16 |
| FR-14 | El sistema deberá permitir gestionar borradores de factura. | UR-05, UR-08, UR-16, UR-96 |
| FR-15 | El sistema deberá permitir pausar una suscripción y avisar de su reactivación. | UR-20, UR-21 |
| FR-16 | El sistema deberá permitir registrar la baja de un cliente. | UR-22 |
| FR-17 | El sistema deberá permitir administrar un catálogo de conceptos reutilizables y usarlos, con ajustes, en facturas puntuales sin afectar a las ya emitidas. | UR-23 |
| FR-18 | El sistema deberá permitir validar y previsualizar una factura antes de emitirla. | UR-24, UR-64 |
| FR-19 | El sistema deberá generar el PDF de cada factura emitida y conservar su versión original inalterable. | UR-29 |
| FR-20 | El sistema deberá enviar la factura emitida al contacto de facturación por correo electrónico o, de forma simulada, por WhatsApp. | UR-30 |
| FR-21 | El sistema deberá permitir gestionar los fallos de envío de una factura y reintentar el envío. | UR-25 |
| FR-22 | El sistema deberá enviar recordatorios de pago automáticos según una cadencia configurable, respetando el vencimiento acordado con cada cliente y dejando de enviarlos cuando la factura se paga (RB-37). | UR-31, UR-49 |
| FR-23 | El sistema deberá permitir marcar una factura como «en disputa», sin cambiar su estado de cobro, para suspender temporalmente sus recordatorios. | UR-26 |
| FR-24 | El sistema deberá permitir dar de baja contable una deuda como «anulada» o «incobrable» con aprobación administrativa y motivo, sin poder catalogarla como «pagada». | UR-27 |
| FR-25 | El sistema deberá simular la recepción de eventos de pago de la pasarela, permitir consultar las transacciones y no contabilizar dos veces un mismo evento. | UR-32, UR-99 |
| FR-26 | El sistema deberá conciliar los cobros recibidos con las facturas, derivando a revisión manual los casos que no se identifiquen con claridad. | UR-28 |
| FR-27 | El sistema deberá permitir deshacer una conciliación conservando su traza. | UR-28 |
| FR-28 | El sistema deberá gestionar notificaciones internas por cliente: responsable asignado, bandeja, estado leída o resuelta y prioridad. | UR-34 |
| FR-29 | El sistema deberá permitir configurar el canal de recepción de las notificaciones internas. | UR-35 |
| FR-30 | El sistema deberá ofrecer una pantalla de trabajo diario con las tareas y alertas pendientes y acceso directo al elemento afectado. | UR-33 |
| FR-31 | El sistema deberá ofrecer un dashboard financiero con las cifras de facturación y cobro. | UR-36 |
| FR-32 | El sistema deberá generar informes financieros y operativos filtrables y exportables a CSV y PDF, respetando los permisos del usuario. | UR-36, UR-42 |
| FR-33 | El sistema deberá ofrecer una búsqueda global de clientes y facturas con filtros y vistas guardables. | UR-37 |
| FR-34 | El sistema deberá permitir importar clientes desde un fichero CSV. | UR-38 |
| FR-35 | El sistema deberá permitir importar el histórico de facturas como migración, sin enviar emails ni consumir numeración oficial. | UR-39 |
| FR-36 | El sistema deberá permitir el acceso de los usuarios internos con credenciales corporativas, sin autorregistro. | UR-40 |
| FR-37 | El sistema deberá permitir crear o invitar usuarios internos y desactivarlos preservando el rastro de sus acciones. | UR-40 |
| FR-38 | El sistema deberá permitir recuperar la contraseña mediante un enlace temporal con caducidad. | UR-41 |
| FR-39 | El sistema deberá distinguir los roles de superadministrador, administrador y lector, limitando al lector a las operaciones sobre sus clientes asignados. | UR-42 |
| FR-40 | El sistema deberá permitir asignar, desasignar y reasignar clientes a los usuarios, trasladando al nuevo responsable las tareas pendientes y el histórico. | UR-43 |
| FR-41 | El sistema deberá permitir delegar temporalmente los clientes de un usuario en un suplente, con caducidad automática. | UR-44 |
| FR-42 | El sistema deberá evitar sobrescrituras por edición concurrente y mantener la consistencia de las operaciones monetarias críticas. | UR-45 |
| FR-43 | El sistema deberá registrar una auditoría de negocio inalterable de las operaciones clave y permitir al superadministrador consultarla y filtrarla. | UR-46 |
| FR-44 | El sistema deberá realizar copias de seguridad automáticas de datos y documentos y permitir su restauración. | UR-47 |
| FR-45 | El sistema deberá permitir descargar documentos solo a los usuarios autorizados, con enlaces temporales que caducan. | UR-48 |
| FR-46 | El sistema deberá permitir generar y enviar facturas y recordatorios mediante plantillas editables. | UR-49 |
| FR-47 | El sistema deberá mantener un historial de versiones de los registros y documentos modificados. | UR-07 |
| FR-48 | El sistema deberá incluir una funcionalidad integrada de búsqueda de direcciones. | UR-108 |
| FR-49 | El sistema deberá funcionar correctamente con el zoom del navegador ampliado. | UR-52 |
| FR-50 | El sistema deberá generar informes específicos de la aplicación y resúmenes semanales y mensuales. | UR-51 |
| FR-51 | El sistema deberá permitir gestionar presupuestos (opcional). | UR-54 |
| FR-52 | El sistema deberá permitir generar una factura rectificativa vinculada a la factura original y recalcular el saldo del cliente. | UR-55 |
| FR-53 | El sistema deberá ofrecer un dashboard con el saldo y las facturas pendientes y pagadas de los clientes asignados al usuario, con acceso al detalle de cada cifra. | UR-56 |
| FR-54 | El sistema deberá gestionar la campaña anual de revisión de planes: listar los clientes a revisar y obtener y registrar su facturación anual. | UR-57 |
| FR-55 | El sistema deberá proponer el rango de facturación que corresponde a cada cliente y aplicar el cambio de plan tras su verificación. | UR-57 |
| FR-56 | El sistema deberá mostrar el estado del sistema: emails pendientes, errores de integración, último backup y última generación recurrente. | UR-58 |
| FR-57 | El sistema deberá mostrar el historial de cada cliente. | UR-59 |
| FR-58 | El sistema deberá gestionar las sesiones de los usuarios autenticados. | UR-60 |
| FR-59 | El sistema deberá exponer una API para que sistemas externos consulten clientes, estado de deuda, facturas y obligaciones pendientes. | UR-61 |
| FR-60 | El sistema deberá permitir que sistemas externos envíen solicitudes controladas. | UR-61 |
| FR-61 | El sistema deberá limitar las solicitudes de cada consumidor de la API y registrar sus llamadas importantes. | UR-61 |
| FR-62 | El sistema deberá registrar los errores técnicos con un código de incidencia que permita correlacionarlos. | UR-62 |
| FR-63 | El sistema no deberá mostrar al usuario final información técnica de los errores. | UR-63 |
| FR-64 | El sistema deberá permitir dar de alta clientes validando sus datos. | UR-64 |
| FR-65 | El sistema deberá permitir guardar los datos fiscales del emisor como configuración. | UR-65 |
| FR-66 | El sistema deberá permitir trabajar con varias entidades emisoras y elegir con cuál se emite cada factura (opcional). | UR-65, UR-66 |
| FR-67 | El sistema deberá permitir adjuntar documentos de tipos y formatos permitidos a clientes y facturas. | UR-67 |
| FR-68 | El sistema deberá mostrar al usuario el fallo de creación de una factura y el estado de envío de una factura, distinguiéndolos. | UR-53 |
| FR-69 | El sistema deberá permitir corregir los datos de una revisión anual, calculando el impacto y exigiendo aprobación expresa para toda regularización retroactiva. | UR-57 |
| FR-70 | El sistema deberá permitir guardar un cliente con datos no imprescindibles pendientes como excepción controlada, registrando qué datos faltan. | UR-64 |
| FR-71 | El sistema deberá permitir marcar clientes como favoritos y mostrar los consultados recientemente. | UR-68 |
| FR-72 | El sistema deberá comprobar los permisos del usuario en cada acceso a un cliente o a una factura, incluso mediante URL directa. | UR-60 |
| FR-73 | El sistema deberá permitir al solicitante consultar el estado de sus solicitudes económicas y el comentario del aprobador. | UR-78, UR-79 |
| FR-74 | El sistema deberá impedir que un usuario apruebe sus propias solicitudes sensibles. | UR-80 |
| FR-75 | El sistema deberá permitir cerrar un mes o trimestre contable y bloquear la modificación ordinaria de lo económico en un periodo cerrado. | UR-81, UR-82 |
| FR-76 | El sistema deberá permitir reabrir un periodo cerrado solo al superadministrador y con un motivo obligatorio. | UR-83 |
| FR-77 | El sistema deberá permitir generar el paquete contable de un periodo y consultar quién y cuándo lo generó y de qué versión es. | UR-84, UR-85, UR-86 |
| FR-78 | El sistema deberá registrar por contacto el idioma, el canal preferido y el consentimiento de envío de cada canal. | UR-87, UR-88, UR-89 |
| FR-79 | El sistema deberá auditar cada exportación masiva e incrustar en el fichero exportado los datos de trazabilidad. | UR-90, UR-91 |
| FR-80 | El sistema deberá emitir alertas configurables sobre facturas vencidas, deuda de cliente, fallos repetidos de envío y revisiones sin gestionar. | UR-92, UR-93, UR-94, UR-95 |
| FR-81 | El sistema deberá permitir clasificar las facturas por proyecto o línea de negocio con categorías administrables (opcional). | UR-107 |
| FR-82 | El sistema deberá permitir fijar objetivos mensuales y anuales de facturación y cobro, con histórico de cambios. | UR-71 |
| FR-83 | El sistema deberá permitir trasladar al siguiente día laborable las comunicaciones que caigan en fin de semana o festivo, según un calendario laboral. | UR-72 |
| FR-84 | El sistema deberá emitir cada factura en una moneda concreta conservando su importe original. | UR-73 |
| FR-85 | El sistema deberá convertir importes a una moneda base para informes con un tipo de cambio registrado, sin alterar el total legal de la factura. | UR-76 |
| FR-86 | El sistema deberá ejecutar las tareas largas en segundo plano, con estado, aunque el usuario cierre la pestaña. | UR-58 |
| FR-87 | El sistema deberá impedir duplicados por doble clic o reintento en emisión, envío y conciliación. | UR-70 |
| FR-88 | El sistema deberá mostrar el estado de entrega de cada mensaje enviado. | UR-77 |
| FR-89 | El sistema deberá distinguir las comunicaciones operativas de facturación de las campañas comerciales, sin reutilizar automáticamente datos de facturación para marketing. | UR-109 |
| FR-90 | El sistema deberá permitir comentar internamente en clientes, facturas e incidencias. | UR-69 |
| FR-91 | El sistema deberá poder cargarse con datos ficticios para demostraciones sin mezclarlos con los de producción. | UR-74 |
| FR-92 | El sistema deberá permitir deshacer acciones que no tengan inmutabilidad legal. | UR-97 |
| FR-93 | El sistema deberá exigir confirmación explícita antes de ejecutar borrados, informando de que no podrán restaurarse. | UR-98 |
| FR-94 | El sistema deberá notificar al responsable los fallos de procesos de cobro y aislar a los clientes con error sin detener el resto. | UR-99 |
| FR-95 | El sistema deberá eliminar los archivos exportados temporales al superar su tiempo de caducidad. | UR-100 |
| FR-96 | El sistema deberá recopilar de forma anónima métricas de uso y mostrar al superadministrador un dashboard de eficiencia operativa. | UR-101 |
| FR-97 | El sistema deberá ejecutar el cálculo financiero de forma determinista, sin usar inteligencia artificial. | UR-110 |
| FR-98 | El sistema deberá permitir desactivar las funciones de apoyo basadas en inteligencia artificial (opcional). | UR-110 |
| FR-99 | El sistema deberá permitir localizar y anonimizar los datos personales de un contacto cuando legalmente proceda, conservando identificadores y auditoría. | UR-75 |
| FR-100 | El sistema deberá recuperar, tras una caída, las facturas recurrentes no generadas sin duplicar las ya generadas. | UR-102 |
| FR-101 | El sistema deberá registrar cada ejecución de los procesos automáticos con su duración, los elementos procesados y los fallos con su causa. | UR-53, UR-58 |
| FR-102 | El sistema deberá permitir programar informes periódicos y enviarlos a las personas indicadas (opcional). | UR-111 |
| FR-103 | El sistema deberá gestionar la configuración global con validación previa y auditoría de los cambios. | UR-103 |
| FR-104 | El sistema deberá permitir al superadministrador configurar el logo y la plantilla de las facturas. | UR-103 |
| FR-105 | El sistema deberá permitir probar los cambios de plantillas y de reglas de recordatorio antes de activarlos. | UR-104 |
| FR-106 | El sistema deberá permitir proponer valores por defecto en las altas frecuentes de clientes. | UR-105 |
| FR-107 | El sistema deberá permitir realizar acciones masivas sobre un conjunto de clientes. | UR-106 |
| FR-108 | El sistema deberá permitir etiquetar clientes (opcional). | UR-107 |
| FR-109 | El sistema deberá permitir gestionar incidencias de facturación asociadas a un cliente. | UR-50 |
| FR-110 | El sistema deberá permitir cambiar el rol de un usuario interno conservando su histórico de auditoría. | UR-40 |

### 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-01 | Independencia | El sistema deberá operar como herramienta independiente de la empresa, sin depender de su interfaz o disponibilidad para las operaciones administrativas. | Se pueden completar los flujos administrativos principales mientras Brain no está disponible. |
| NFR-02 | Escalabilidad | El sistema deberá permitir consultar la situación global del negocio independientemente del número de clientes. | Poder ver el global sin abrir los clientes uno por uno. |
| NFR-03 | Integridad y auditoría | El sistema deberá garantizar la trazabilidad de los cambios económicos. | Para cada cambio sujeto a auditoría se conserva usuario, fecha y valores anteriores y nuevos. |
| NFR-04 | Internacionalización | El sistema deberá soportar el registro de empresas internacionales sin imponer formatos exclusivos de España. | Se pueden registrar empresas de distintos países sin exigir formatos. |
| NFR-05 | Privacidad y conservación | El sistema deberá cumplir con los plazos legales de conservación y eliminación contable. | Antes de aceptar el sistema se documentan los plazos y reglas de conservación y se comprueba que el borrado lógico y las restricciones de acceso los respetan. |
| NFR-06 | Eficiencia | La interfaz del catálogo de productos deberá ofrecer una experiencia de usuario ligera y ágil para la consulta y selección de conceptos frecuentes | La selección de un concepto del catálogo e inserción de la línea en una factura o suscripción se podrá realizar en menos de 3 clics |
| NFR-07 | Seguridad | Las contraseñas no deberán almacenarse en texto plano | Uso de hashing seguro (bcrypt/argon2) |
| NFR-08 | Seguridad | Las comunicaciones deberán estar cifradas | Uso obligatorio de HTTPS/TLS en todo el tráfico web |
| NFR-09 | Seguridad | El diseño de autenticación no deberá impedir la incorporación futura de doble factor (2FA) | Arquitectura de usuarios preparada para la extensión a 2FA |
| NFR-10 | Mantenibilidad | Los permisos no deberán estar dispersos en condicionales arbitrarios | Modelo coherente y centralizado de autorización |
| NFR-11 | Fiabilidad | Las copias de seguridad deberán ser probadas mediante restauración periódica | Existencia de procedimiento de prueba documentado |
| NFR-12 | Privacidad / Cumplimiento | Aplicación de principios de minimización y conservación de datos operativos y personales | Cada dato personal almacenado figura en un inventario documentado con su finalidad |
| NFR-13 | Rendimiento | Las operaciones y búsquedas habituales deberán sentirse prácticamente inmediatas | Con 5.000 clientes de prueba, una búsqueda o apertura habitual responde en menos de 3 segundos (supuesto A-17) |
| NFR-14 | Escalabilidad | El sistema deberá soportar crecimiento a decenas o centenares de usuarios internos y miles de clientes | Una prueba de carga con 300 usuarios internos y 5.000 clientes se supera sin cambiar el modelo de datos y manteniendo los tiempos de NFR-13 (supuesto A-17) |
| NFR-15 | Fiabilidad / Recuperación | Las tareas automáticas periódicas (generación mensual, recordatorios) deberán ser idempotentes y reintentables | Recuperación automática ante caídas sin duplicar documentos ni cobros |
| NFR-16 | Internacionalización | La interfaz y las comunicaciones del sistema deberán soportar los idiomas español e inglés | El usuario podrá cambiar el idioma en la interfaz y todos los textos del sistema se mostrarán correctamente en el idioma seleccionado |
| NFR-17 | Portabilidad / Usabilidad | La aplicación deberá ser responsiva, es decir, ajustarse en función del dispositivo utilizado | Las funcionalidades principales son utilizables desde ordenador, tablet y teléfono móvil |
| NFR-18 | Compatibilidad | La aplicación deberá funcionar en navegadores actuales de escritorio y móvil | Funciona en las versiones actuales de Chrome, Firefox, Edge y Safari, y en los navegadores actuales de Android e iOS |
| NFR-19 | Interoperabilidad | Los PDF deberán abrirse de forma estándar | Un PDF generado se abre en un visor estándar |
| NFR-20 | Interoperabilidad | Los CSV exportados no deberán mostrar caracteres rotos con tildes | Un CSV con tildes y nombres extranjeros se abre sin caracteres rotos |
| NFR-21 | Restricción tecnológica | La aplicación deberá utilizar software libre | Las herramientas y dependencias principales tienen licencia de software libre |
| NFR-22 | Documentación | La aplicación deberá tener documentación de usuario corta; documentación técnica (despliegue, modelo de datos, API y restauración de backup); y documentación de decisiones importantes, configuración y reglas de negocio | Existen los tres tipos de documentación y la de usuario es corta (extensión máxima a definir por el equipo) |
| NFR-23 | Mantenibilidad / Testabilidad | Toda regla de negocio deberá quedar escrita en un test o un escenario, no solo en el código | Cada regla de negocio de la sección 5 tiene al menos un test o escenario asociado |
| NFR-24 | Mantenibilidad / Testabilidad | Los escenarios de aceptación deberán estar escritos en lenguaje sencillo, comprensible para alguien de administración | Un miembro de administración puede leer un escenario de aceptación y explicar qué comprueba |
| NFR-25 | Seguridad | El sistema deberá limitar el tamaño de cada archivo adjunto (10 MB) | Un archivo mayor de 10 MB es rechazado con un mensaje explicativo (supuesto A-05) |
| NFR-26 | Seguridad | Los archivos adjuntos no deberán ejecutarse ni interpretarse en el servidor | Un archivo con código subido como adjunto no se ejecuta |
| NFR-27 | Mantenibilidad / Extensibilidad | Cambiar el proveedor de pagos (por ejemplo, Stripe) no deberá requerir modificar las facturas existentes | Se puede sustituir el proveedor de pagos simulado por otro de prueba sin modificar las facturas ya almacenadas |
| NFR-28 | Seguridad | La configuración y los secretos (por ejemplo, las claves de Stripe simulado) deberán estar separados del código y no almacenarse en el repositorio | El repositorio no contiene claves ni secretos y la configuración se carga desde fuera del código |
| NFR-29 | Despliegue | La aplicación deberá ponerse en marcha de forma reproducible, con al menos un entorno de desarrollo o pruebas y un procedimiento documentado para producción | Existe un procedimiento documentado que permite poner en marcha la aplicación desde cero |
| NFR-30 | Rendimiento | Las operaciones pesadas no deberán bloquear la interfaz | Generar 3.000 facturas con PDF; la UI sigue operativa y muestra estado y progreso; Deberá hacerse test de estrés |
| NFR-31 | Integridad de datos | Los importes deberán usar precisión decimal exacta; los totales deberán cuadrar y el PDF deberá mostrar exactamente lo almacenado | Utilizar el tipo de dato adecuado para operaciones con dinero; Test unitarios con múltiples situaciones |
| NFR-32 | Protección de datos de prueba | No deberán usarse datos reales de clientes en repositorios, demos ni capturas | Revisión de repositorio y memoria sin datos reales de personas; Datos automáticamente anonimizables siguiendo el RGPD |
| NFR-33 | Usabilidad / Facilidad de aprendizaje | El sistema deberá posibilitar que un usuario administrativo asimile el alta de un cliente de forma directa. | Al menos el 90% de los sujetos de prueba sin experiencia completarán el alta de suscripción al primer intento. |
| NFR-34 | Usabilidad / Eficiencia | El sistema deberá requerir una carga mínima de interacciones para las operaciones fundamentales de la empresa. | Crear y emitir una factura puntual requiere como máximo 5 clics, sin contar la vista previa ni las confirmaciones (supuesto A-17) |
| NFR-35 | Usabilidad / Consistencia | El sistema deberá estandarizar la disposición de la interfaz. | Los botones principales de guardado y navegación estarán ubicados en lugares idénticos en todas las pantallas. |
| NFR-36 | Confiabilidad | El sistema deberá garantizar la validación del procesamiento de facturación frente a registros corruptos. | El procesamiento continuará con los registros válidos y almacenará los registros corruptos en una cola de excepciones, sin detenerse. |
| NFR-37 | Seguridad y Privacidad | El sistema deberá mantener el carácter inmutable y exacto de los documentos fiscales emitidos. | La anonimización posterior de un cliente mantendrá el archivo del PDF generado intacto. |
| NFR-38 | Mantenibilidad / Arquitectura | El sistema deberá adoptar prácticas formales que garanticen el relevo a futuro. | El proyecto será un sistema modular con convenciones, migraciones de base de datos, pruebas y documentación de despliegue. |
| NFR-39 | Mantenibilidad / Centralización | El sistema deberá agrupar la lógica de reglas de facturación en un mismo lugar. | La variación de un plazo de cobro no requerirá cambio de todo el código y se gestionará desde un único punto de configuración. |
| NFR-40 | Rendimiento | Las tareas habituales de un usuario deberán completarse en menos de un minuto | Alta de cliente, emisión de una factura y consulta de un saldo se completan en menos de un minuto |
| NFR-41 | Escalabilidad | El sistema deberá soportar un histórico de cientos de miles de facturas sin degradar los listados | Un listado de veinte filas sobre un histórico grande solo transfiere esas veinte filas |
| NFR-42 | Configuración regional | El sistema deberá guardar los instantes de forma consistente y mostrarlos en la zona horaria oficial de España | Un evento de pago recibido con fecha del día anterior en otra zona se muestra en la fecha correcta |
| NFR-43 | Configuración regional | Las fechas legales de factura deberán usar la fecha de negocio que corresponda, no la hora del servidor | Una factura emitida cerca de la medianoche lleva la fecha de negocio esperada, no la del servidor |
| NFR-44 | Accesibilidad | Los controles deberán poder usarse sin depender de pasar el ratón por encima | Todas las acciones disponibles con ratón se pueden hacer con teclado y con pantalla táctil |
| NFR-45 | Accesibilidad | La interfaz deberá ser razonablemente accesible: etiquetas, contraste, teclado y mensajes de error comprensibles | Los formularios tienen etiquetas, se navegan completos con teclado, y los errores indican qué falta |
| NFR-46 | Portabilidad | La versión móvil deberá permitir consultar clientes, aprobar una solicitud urgente, ver impagos, marcar una incidencia y revisar un pago | Las cinco acciones se pueden completar desde un teléfono móvil |
| NFR-47 | Seguridad | La sesión de un usuario deberá cerrarse tras un periodo de inactividad | La sesión se cierra a los 30 minutos sin actividad (supuesto A-06) |
| NFR-48 | Seguridad | El acceso deberá bloquearse temporalmente tras intentos fallidos consecutivos de inicio de sesión | Tras 5 intentos fallidos el acceso queda bloqueado durante 15 minutos (supuesto A-07) |
| NFR-49 | Seguridad | Los enlaces de recuperación de contraseña deberán caducar | Un enlace de recuperación deja de ser válido a las 24 horas de su emisión (supuesto A-18) |
| NFR-50 | Seguridad | Las credenciales de un consumidor de la API no deberán dar acceso a la interfaz de usuario, ni las de un usuario a la API | Una credencial de API es rechazada en la interfaz y una sesión de usuario es rechazada en la API |

## 5. Reglas de negocio

| ID | Regla |
|---|---|
| RB-01 | Una factura dispondrá de un número de factura único únicamente cuando haya alcanzado el estado de emitida. |
| RB-02 | Las facturas recurrentes se emitirán el día 1 de cada mes; la primera, en el mes de alta, se calcula por prorrateo desde el día de inicio de la relación, salvo excepción comercial aprobada (FR-06). |
| RB-03 | Los datos de empresas y facturas emitidas no se podrán eliminar definitivamente hasta transcurrido el plazo exigido por la legislación contable. |
| RB-04 | Toda excepción requerirá la aprobación de un usuario con rol Administrador o Superadministrador; las que superen el umbral configurado requerirán la de un Superadministrador. |
| RB-05 | La pausa de una suscripción detiene la generación de nuevas mensualidades recurrentes pero no cancela ni modifica los derechos de cobro de las facturas emitidas anteriormente que continúen impagadas |
| RB-06 | Las modificaciones en las tarifas o impuestos por defecto de los conceptos del catálogo de productos no afectarán de forma retroactiva a las facturas ni suscripciones previamente emitidas |
| RB-07 | La representación en PDF de una factura emitida es inalterable |
| RB-08 | Una deuda que se deja de reclamar no puede ser clasificada ni contabilizada como «pagada»; debe pasar explícitamente al estado «anulada» o «incobrable», mediante una decisión administrativa con motivo y aprobación. |
| RB-09 | Una factura y un presupuesto conservan identidades e históricos independientes, aunque el presupuesto aceptado reutilice líneas para generar la factura |
| RB-10 | El saldo pendiente de un cliente y la facturación total acumulada son conceptos distintos y reconciliables |
| RB-11 | Una factura emitida no puede editarse silenciosamente ni borrarse; cualquier corrección posterior requiere trazabilidad o emisión de factura rectificativa |
| RB-12 | La relación comercial (suscripción/tarifa) es independiente de las facturas generadas; modificar un precio futuro no reescribe las facturas pasadas |
| RB-13 | Una baja comercial recibida detiene la generación de nuevas cuotas recurrentes pero mantiene activo el flujo de recobro de deudas pendientes anteriores |
| RB-14 | Una factura no podrá considerarse saldada si su estado reflejado en el sistema es de impago, requiriendo validación manual o de cobro para cambiar a estado de pago. |
| RB-15 | El acceso a los datos y carteras de los clientes estará restringido al empleado que los tenga asignados, salvo para los perfiles de administración. |
| RB-16 | Las plantillas de factura y de recordatorio requerirán obligatoriamente la presencia de las variables de empresa, número de factura, importe y vencimiento antes de permitir su envío masivo o individual. |
| RB-17 | Una baja comercial no elimina automáticamente los datos que deban conservarse por obligaciones contables |
| RB-18 | La eliminación o anonimización de datos personales considera los registros activos, los históricos y las copias de seguridad según una política definida |
| RB-19 | Un archivo temporal de informe y un documento contable que debe conservarse tienen políticas de conservación distintas |
| RB-20 | Una incidencia de facturación es un seguimiento administrativo interno, no un sistema de tickets de soporte para los clientes |
| RB-21 | Solo un usuario con rol Administrador o Superadministrador podrá generar facturas rectificativas. |
| RB-22 | Solo un usuario con rol Administrador o Superadministrador podrá hacer que una incidencia pause los recordatorios de las facturas afectadas. |
| RB-23 | No se podrán marcar facturas como pagadas mediante una acción masiva. |
| RB-24 | Una factura rectificativa cuyo importe supere el umbral configurado requerirá aprobación antes de emitirse. |
| RB-25 | Quedarán pendientes de aprobación, sin emitirse, las facturas con modificaciones manuales de importe, descuentos, fechas excepcionales o un importe por encima del umbral configurado. |
| RB-26 | El sistema no emitirá facturas retroactivas de forma automática; toda regularización retroactiva requiere una acción explícita y la aprobación de un Administrador. |
| RB-27 | Un cliente activo no podrá quedarse sin contacto de facturación. |
| RB-28 | La factura solo se enviará por WhatsApp (simulado) a contactos con un número válido y que hayan otorgado su consentimiento. |
| RB-29 | Al llegar la fecha prevista de reactivación de una suscripción pausada, la facturación solo se reanudará tras la confirmación explícita del responsable asignado. |
| RB-30 | No se generarán facturas ni recordatorios de cobro de una relación comercial antes de su fecha de inicio. |
| RB-31 | Las solicitudes enviadas por sistemas externos pasan por validación o aprobación, no modifican datos directamente y aplican las mismas reglas de negocio que la interfaz. |
| RB-32 | Los comentarios internos no se envían al cliente; las notas restringidas solo las ven los administradores. |
| RB-33 | Los informes programados que contengan detalle de clientes solo se envían a usuarios con permiso para verlos (opcional). |
| RB-34 | Las etiquetas manuales no sustituyen los estados derivados de un cliente, como «impagado» (opcional). |
| RB-35 | La plantilla utilizada en cada envío de factura o recordatorio queda registrada. |
| RB-36 | El nuevo plan o precio resultante de una revisión anual tiene una fecha de efecto y no reescribe las facturas de meses anteriores. |
| RB-37 | Al pasar una factura a «pagada» el sistema deja de enviar recordatorios. Con un pago parcial, los recordatorios continúan sobre el saldo pendiente. Si se deshace una conciliación (FR-27), los recordatorios se reanudan según la cadencia configurada. |
| RB-38 | Ningún usuario podrá cambiar su propio rol, y un Administrador no podrá asignar el rol de Superadministrador ni modificar el rol de un Superadministrador ni desactivarlo. |
| RB-39 | El sistema mantendrá siempre al menos un Superadministrador activo: no se podrá desactivar ni cambiar el rol del último. |

### Transiciones de estado

**Estado documental de la factura.** Una factura emitida no vuelve a borrador ni se edita (RB-11); una factura rechazada en la aprobación sí vuelve a borrador, porque no llegó a emitirse.

| De | A | Condición | Quién |
|---|---|---|---|
| Borrador | Pendiente de aprobación | Tiene una modificación manual de importe, descuento o fecha excepcional, o supera el umbral (RB-25) | Lector (CU-22) |
| Borrador | Emitida | Se valida sin necesidad de aprobación; recibe su número de factura único (RB-01) | Lector (CU-15) |
| Pendiente de aprobación | Emitida | Se aprueba (RB-04); no la aprueba quien la propuso (FR-74) | Administrador o Superadministrador (CU-23) |
| Pendiente de aprobación | Borrador | Se rechaza con su motivo; el solicitante puede corregirla y volver a enviarla a aprobación (CU-23, CU-22) | Administrador o Superadministrador (CU-23) |
| Emitida | Rectificada | Se emite una factura rectificativa vinculada; la original no se edita (RB-11) | Administrador (CU-19) |

**Estado de envío de la factura emitida**

| De | A | Condición | Quién |
|---|---|---|---|
| Sin enviar | Enviada | El envío se completa por el canal elegido | Sistema (CU-27) |
| Sin enviar | Fallo de envío | El canal falla | Sistema (CU-27) |
| Fallo de envío | Enviada | Se corrigen los datos de contacto y se reintenta sin duplicar la factura | Lector (CU-28) |

**Estado de cobro de la factura.** Existe solo desde que la factura está emitida; el primero es «pendiente» (A-23).

| De | A | Condición | Quién |
|---|---|---|---|
| Pendiente | Vencida | Llega el vencimiento sin cobro | Sistema |
| Pendiente o vencida | Parcialmente conciliada | Cobro menor que el total | Conciliación (CU-35) |
| Pendiente, vencida o parcialmente conciliada | Pagada | Cobro detectado o validado (RB-14) | Conciliación (CU-34, CU-35) |
| Parcialmente conciliada o pagada | Pendiente, vencida o parcialmente conciliada, según el saldo | Se deshace una conciliación hecha por error; se conserva la traza (FR-27) | Administrador (CU-35) |
| Pendiente, vencida o parcialmente conciliada | Anulada o incobrable | Decisión administrativa con motivo y aprobación (RB-08, FR-24), aplicada al saldo pendiente (A-24) | Baja contable (CU-36) |

Marcas superpuestas, que no cambian el estado de cobro:

| Marca | Cuándo | Efecto |
|---|---|---|
| En disputa | Un administrador la marca (FR-23, CU-31) | Se suspenden los recordatorios mientras dure |
| Cobro excesivo | El cobro conciliado supera el total de la factura (FR-26, CU-35) | La diferencia se señala y queda en la bandeja de revisión de CU-35; el tratamiento del sobrante sigue abierto (Q-12) |

**Estado del cliente**

| De | A | Condición | Quién |
|---|---|---|---|
| Pendiente de activación | Activo | Llega la fecha de inicio (RB-30) | Sistema |
| Activo | Pausado | Se registra una pausa (RB-05) | Lector (CU-11) |
| Pausado | Activo | Llega la fecha prevista y el responsable confirma la reanudación (RB-29) | Lector (CU-11) |
| Activo o pausado | Baja solicitada | Se registra la baja con su fecha (CU-12); si estaba pausado, la pausa termina y la baja sigue su curso | Lector (CU-12) |
| Baja solicitada | Baja efectiva | Llega la fecha de baja: no se generan cuotas nuevas y continúa el recobro (RB-13). Estado final (A-25) | Sistema |

## 6. Suposiciones y decisiones de análisis

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | Prorrateo calculado como la proporción exacta de días de servicio del mes de alta respecto al total de días reales de ese mes (no se asumen meses de 30 días). | Garantiza un cálculo justo para el cliente. | FR-06 |
| A-02 | Implementación mediante interfaz web responsiva multidispositivo. | Permite operar desde teléfonos móviles y tabletas sin requerir aplicaciones independientes. | NFR-17 |
| A-03 | Se adopta integración simulada para Stripe, WhatsApp y correo electrónico | Cumplir objetivos funcionales sin dependencia de contratos con proveedores reales de pago o mensajería | FR-20, FR-25 |
| A-04 | La búsqueda de direcciones se resolverá mediante un componente de autocompletado estándar o servicio de mapas integrado. | Derivado de la nota "búsqueda de dirección". | FR-48 |
| A-05 | El tamaño máximo por archivo adjunto es de 10 MB | El cliente pidió un límite "razonable" sin concretarlo | NFR-25 |
| A-06 | La sesión se cierra tras 30 minutos de inactividad | El cliente pidió una expiración "razonable" | NFR-47 |
| A-07 | Se bloquea el acceso 15 minutos tras 5 intentos fallidos de login | El cliente pidió protección básica sin convertirla en "un infierno de bloqueos" | NFR-48 |
| A-08 | La lista de formatos permitidos es PDF, JPG/PNG, DOCX, XLSX y CSV | El cliente pidió limitar formatos sin concretarlos | FR-67 |
| A-09 | La regularización retroactiva la aprueba un administrador | El cliente pidió que fuera "explícita y aprobada" sin indicar quién | FR-69 |
| A-10 | Los criterios de detección de duplicados son nombre o razón social, identificador fiscal, email y teléfono | El cliente habló de duplicados "razonables" y citó el identificador fiscal | FR-64 |
| A-11 | El teléfono del contacto es el dato "conveniente" que puede faltar | Es el único ejemplo citado por el cliente | FR-70 |
| A-12 | Los límites de uso de la API quedan por definir | El cliente pidió límites "razonables" | FR-61 |
| A-13 | Los requisitos marcados como (opcional) son ampliaciones | El cliente los presentó como ampliaciones y no como parte de la primera versión (apartado 1.4). El nivel opcional de 1.4 agrupa los casos de uso formados por estas ampliaciones (CU-08, CU-20, CU-44) | FR-51, FR-66, FR-98 |
| A-14 | La clasificación de facturas por proyecto o línea de negocio se considera opcional y no se implementa en la primera versión (apartado 1.4) | El cliente dice "Si lo implementáis", no deja claro que sea un requisito. | FR-81 |
| A-15 | Los informes programados se envían como notificación con enlace autenticado, no como adjunto | El cliente planteó el adjunto y el enlace como alternativas y pidió cuidado con la información sensible | FR-102 |
| A-16 | Se consideran opcionales los informes programados y las etiquetas | El cliente los presentó con «puede estar bien» y «pueden ayudarnos» | FR-102, FR-108 |
| A-17 | Las cifras de los criterios de rendimiento y de uso (3 segundos, 5.000 clientes, 300 usuarios, 5 clics) son concreciones del equipo | El cliente pidió «prácticamente inmediato» y «pocos clics» sin dar cifras | NFR-13, NFR-14, NFR-34 |
| A-18 | Los enlaces de recuperación de contraseña caducan a las 24 horas de su emisión | No se concretó el plazo; se propone 24 horas | NFR-49 |
| A-19 | Los roles internos son jerárquicos: el Administrador puede hacer todo lo que hace el Lector, y el Superadministrador todo lo que hace el Administrador, salvo la restricción de que nadie apruebe sus propias solicitudes sensibles. El Lector opera solo sobre los clientes que tiene asignados; los perfiles de administración, sobre todos (RB-15) | El cliente describe tres perfiles de alcance creciente (usuario operativo, administrador, superadministrador) y no indica excepciones; la jerarquía es una asunción del equipo; la asignación por operación está en `Matriz_permisos.md` | FR-39, RB-15, RB-21, RB-22, RB-26 |
| A-20 | El día de alta cuenta como día de servicio. Ejemplo: cuota de 300 € y alta el 22 de octubre (31 días) → 10 días × 300 / 31 = 96,77 € | El cliente pidió una regla coherente y documentada para el prorrateo | FR-06 |
| A-21 | Si el alta es el último día del mes, se factura ese único día (1/N) y la primera mensualidad completa se emite el día 1 siguiente | El cliente pidió que el sistema «sepa qué hacer» en ese caso | FR-06 |
| A-22 | El importe prorrateado se redondea a dos decimales (mitad hacia arriba) una sola vez, sobre el total, y el PDF muestra exactamente ese valor | El cliente pidió documentar la regla de redondeo | FR-06, NFR-31 |
| A-23 | El estado de cobro de una factura existe solo desde que se emite; un borrador o una factura pendiente de aprobación no lo tiene | Decisión del equipo: RB-01 sitúa la asignación del número de factura en la emisión; es lo coherente con los tres estados independientes | RB-01, FR-26 |
| A-24 | La anulación o la declaración de incobrable de una factura parcialmente cobrada se aplica al saldo pendiente; lo cobrado sigue cobrado | Decisión del equipo: es el caso habitual de una deuda parcial que no se va a cobrar | RB-08, FR-24 |
| A-25 | La baja efectiva de un cliente es un estado final; para volver a trabajar con él se crea una nueva relación comercial | Decisión del equipo: evita estados intermedios no pedidos y mantiene el recobro de lo adeudado | RB-13, FR-15 |
| A-26 | Un usuario interno puede cambiar de rol (por ejemplo, un Lector que asciende a Administrador) sin dar de baja su cuenta | Inferencia del equipo: el cliente pidió roles jerárquicos (A-19) y gestionar altas y desactivaciones (UR-40); sin cambio de rol, un ascenso obligaría a desactivar la cuenta y crear otra, rompiendo la continuidad de su histórico | FR-110, RB-38, RB-39 |
| A-27 | Una factura rectificativa con total negativo (abono) no tiene estado de cobro: compensa el saldo pendiente de la factura original. Si lo deja a 0, la original pasa a «pagada»; la validación manual que pide RB-14 es la propia emisión de la rectificativa, que hace un Administrador (RB-21) y se aprueba si supera el umbral (RB-24). Una rectificativa positiva tiene su propio cobro. La rectificación por sustitución queda fuera del alcance | Decisión del equipo (Entrega 2): sigue el RD 1619/2012 (art. 15) y la práctica habitual de facturación; matiza A-23 | FR-52, RB-14, A-23 |
| A-28 | El importe cobrado que supera el saldo de una factura no se aplica a ella: queda sin aplicar en el movimiento de cobro, se revisa en la bandeja de conciliación (CU-35) y la factura se marca con cobro excesivo. El destino del sobrante (devolución, saldo a favor) sigue pendiente (Q-12) | Decisión del equipo (Entrega 2): concreta dónde queda el sobrante sin decidir qué se hace con él | FR-26, Q-12 |

## 7. Dudas, ambigüedades y cuestiones pendientes

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|
| Q-01 | Criterio exacto de umbrales económicos para aprobación de descuentos por el superadministrador | Transcripción ampliada | Configuración de flujos de aprobación | Pendiente de definición parametrizable |
| Q-02 | Calendario de festivos y días laborables exacto para el cálculo de vencimientos en diferentes países | Transcripción ampliada | Automatización de recordatorios | Resuelta: configuración basada en calendario configurable de España para fase inicial |
| Q-03 | ¿Cómo debe actuar exactamente el sistema ante un fallo en el envío masivo de correos de facturas de meses anteriores? ¿Debe reintentar de forma autónoma o registrar una alerta crítica en el informe? | Notas de notas de la app / informe de fallos | Alto para la fiabilidad de envíos | Pendiente |
| Q-04 | ¿Qué permisos específicos tendrán los empleados suplentes sobre los clientes asignados a compañeros ausentes? | Decisiones de equipo | Medio para la gestión de incidencias | Pendiente |
| Q-05 | Frases como: "datos ficticios para demos", "Observabilidad de emails y WhatsApp simulados." | Transcripción ampliada | FR-91. Tener que simular todo sistemas externos | Pendiente |
| Q-06 | ¿Qué plazos legales de conservación se aplican a cada tipo de dato? | Transcripción ampliada | RB-17, RB-18, FR-99 | Pendiente |
| Q-07 | ¿Un cambio de configuración afecta a facturas nuevas, a condiciones nuevas o a ambas? | Transcripción ampliada | FR-103 | Pendiente: el cliente dice «según definamos» |
| Q-08 | ¿Qué son las «políticas de automatización» que el superadministrador configura? | Transcripción ampliada | UR-103 | Pendiente |
| Q-09 | ¿Se necesita un entorno de prueba separado o basta con simular y previsualizar? | Transcripción ampliada | UR-104 | El cliente admite «al menos una forma de simular»; se cubre con simulación |
| Q-10 | ¿La reasignación de clientes requiere la aprobación de otro administrador? | Ampliación | FR-40 | Pendiente |
| Q-11 | ¿Qué ocurre si el único Superadministrador es quien propone una excepción que supera el umbral, dado que nadie puede aprobar lo suyo? | Revisión del grupo | RB-04, UR-15 | Pendiente |
| Q-12 | ¿Qué estado debe tener una factura con un cobro superior a su total y qué se hace con el importe sobrante (devolución, saldo a favor, abono en la siguiente factura)? | Revisión del grupo | FR-26 | Pendiente: el cliente solo pide señalar la diferencia para revisión. Dónde queda el sobrante: supuesto A-28 |
| Q-13 | Al cambiar el rol de un usuario, ¿qué ocurre con sus clientes asignados (un Lector que asciende ya ve todos; un Administrador que baja a Lector necesita asignaciones) y con las solicitudes de excepción que tenga pendientes de resolver? | Revisión del grupo (Entrega 2) | FR-110, FR-40, RB-15 | Pendiente |

## 8. Trazabilidad

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
|---|---|---|
| BR-01 | UR-05, UR-09, UR-17, UR-23, UR-33, UR-38, UR-49, UR-101 | FR-04, FR-05, FR-14, FR-08, FR-06, FR-17, FR-30, FR-34, FR-46, FR-22, FR-96, NFR-02, NFR-06, NFR-13, NFR-14, NFR-30, NFR-33, NFR-34, NFR-35, NFR-40, NFR-41 |
| BR-02 | UR-61 | FR-59, FR-60, FR-61, NFR-01, NFR-50 |
| BR-03 | UR-06, UR-08, UR-12, UR-13, UR-14, UR-15, UR-16, UR-24, UR-27, UR-29, UR-39, UR-45, UR-46, UR-55, UR-59, UR-67, UR-78, UR-79, UR-80, UR-81, UR-82, UR-83, UR-103, UR-106 | FR-06, FR-14, FR-11, FR-12, FR-13, FR-18, FR-24, FR-19, FR-35, FR-42, FR-43, FR-52, FR-57, FR-67, FR-73, FR-74, FR-75, FR-76, FR-103, FR-104, FR-107, NFR-03, NFR-31, NFR-43 |
| BR-04 | UR-25, UR-32, UR-47, UR-53, UR-58, UR-62, UR-63, UR-70, UR-77, UR-94, UR-95, UR-99, UR-102, UR-104, UR-110 | FR-21, FR-25, FR-44, FR-68, FR-56, FR-86, FR-101, FR-62, FR-63, FR-87, FR-88, FR-80, FR-94, FR-100, FR-105, NFR-15, NFR-22, NFR-36, FR-97, FR-98 |
| BR-05 | UR-36, UR-51, UR-56, UR-71, UR-84, UR-85, UR-86, UR-111 | FR-31, FR-32, FR-50, FR-53, FR-82, FR-102, FR-77 |
| BR-06 | UR-41, UR-48, UR-60, UR-75, UR-89, UR-90, UR-91, UR-100 | FR-38, FR-45, FR-58, FR-72, FR-99, FR-78, FR-79, FR-95, NFR-05, NFR-07, NFR-08, NFR-09, NFR-10, NFR-11, NFR-12, NFR-25, NFR-26, NFR-28, NFR-32, NFR-37, NFR-47, NFR-48, NFR-49 |
| BR-07 | UR-10, UR-11, UR-35, UR-57, UR-65, UR-66, UR-72, UR-74, UR-103 | FR-10, FR-04, FR-29, FR-54, FR-55, FR-69, FR-65, FR-66, FR-83, FR-91, FR-103, FR-104, NFR-19, NFR-20, NFR-21, NFR-23, NFR-24, NFR-27, NFR-29, NFR-38, NFR-39, NFR-44, NFR-45 |
| BR-08 | UR-37, UR-52, UR-68, UR-96, UR-97, UR-98, UR-105, UR-106 | FR-33, FR-06, FR-49, FR-71, FR-14, FR-92, FR-93, FR-106, FR-107, NFR-17, NFR-18, NFR-46 |
| BR-09 | UR-01, UR-02, UR-03, UR-04, UR-19, UR-54, UR-64, UR-108 | FR-01, FR-02, FR-03, FR-07, FR-51, FR-64, FR-18, FR-70, FR-48 |
| BR-10 | UR-20, UR-21, UR-22 | FR-15, FR-16 |
| BR-11 | UR-07, UR-18, UR-26, UR-28, UR-30, UR-31, UR-92, UR-93 | FR-09, FR-47, FR-07, FR-23, FR-26, FR-27, FR-20, FR-22, FR-80 |
| BR-12 | UR-01, UR-73, UR-76, UR-87, UR-88 | FR-01, FR-84, FR-85, FR-78, NFR-04, NFR-16, NFR-42 |
| BR-13 | UR-34, UR-40, UR-42, UR-43, UR-44, UR-50, UR-69, UR-107 | FR-28, FR-36, FR-37, FR-110, FR-32, FR-39, FR-40, FR-41, FR-109, FR-90, FR-108, FR-81 |
| BR-14 | UR-109 | FR-89 |

## 9. Glosario

| Término | Definición |
|---|---|
| Factura emitida | Factura validada y emitida oficialmente con numeración única que no puede ser editada silenciosamente |
| Factura rectificativa | Documento legal vinculado a una factura original para corregir errores o importes |
| Borrador de factura | Estado previo a la emisión donde la factura es editable y no consume numeración oficial |
| Presupuesto | Documento previo comercial aceptado o rechazado que puede reutilizar líneas para generar facturas |
| Saldo | Importe pendiente de cobro de un cliente, considerando facturas emitidas, rectificativas y pagos registrados |
| Facturación | Importe total facturado a un cliente en un periodo determinado |
| Campaña de revisión | Proceso anual de revisión de facturación anual y tarifas de clientes |
| Rango de plan | Tramo de facturación anual al que corresponde una tarifa específica configurada |
| Solicitud controlada | Petición externa vía API que requiere validación o aprobación antes de afectar a los datos del sistema |
| Entidad emisora | Sociedad jurídica desde la cual se emiten facturas, con sus respectivas series de numeración |
| Prorrateo | Cálculo proporcional de la cuota mensual cuando un servicio inicia en un día distinto al día 1 del mes |
| Conciliación | Proceso de asociación entre un movimiento de cobro recibido (Stripe/banco) y su factura correspondiente |
| Dashboard | Panel de control visual con métricas, números clave e indicadores financieros (facturado, cobrado, pendiente, vencido, previsión) y desglose hasta el detalle. Los administradores ven el global; el Lector, solo sus clientes asignados. |
| API | Interfaz de comunicación que permite a la aplicación interna interactuar de forma controlada y segura con otros sistemas externos o futuros (como Brain u otros agentes de IA) para consultar clientes, deudas o registrar solicitudes bajo las mismas reglas de negocio. |
| Reporting | Proceso de consolidación y generación de informes de datos financieros o de gestión en el que, si intervienen monedas extranjeras, se convierten los importes a una moneda base usando un tipo de cambio registrado. |
| Aprobador | Usuario (administrador o superadministrador) encargado de revisar, autorizar o rechazar solicitudes de operaciones económicas sensibles (como descuentos o cambios manuales de importe) a través de una bandeja de entrada. |
| Claves de idempotencia | Mecanismo técnico o de interfaz utilizado en operaciones largas o críticas (emisión, envío, conciliación) para evitar que la acción se procese o ejecute dos veces al hacer doble clic o recargar la página. |
| NIF | Número de Identificación Fiscal utilizado para identificar unívocamente a los clientes y empresas. |
| Plantilla de comunicación | Formato de correo predefinido que incluye campos dinámicos para automatizar la relación con el cliente. |
| Incidencia | Seguimiento administrativo interno asociado a un cliente y, opcionalmente, a una factura. No es un sistema de tickets para clientes ni debe confundirse con el código de incidencia técnico de un error (FR-62). |
| Estado de factura | La factura tiene tres estados independientes: documental (borrador, pendiente de aprobación, emitida, rectificada), de cobro (pendiente, vencida, parcialmente conciliada, pagada, anulada, incobrable) y de envío (enviada, fallo de envío). El estado de cobro existe solo desde que la factura está emitida (A-23). Sobre él pueden superponerse las marcas «en disputa» y «cobro excesivo». Las transiciones de cada estado están en la sección 5. |
| Estado del cliente | Situación de un cliente que afecta a la facturación: **pendiente de activación** (relación con fecha de inicio futura; no se generan facturas ni recordatorios, RB-30), **activo**, **pausado** (suscripción en pausa; no se generan mensualidades, RB-05), **baja solicitada** (baja pedida pero aún no efectiva) y **baja efectiva** (desde la fecha de baja no se generan cuotas nuevas pero continúa el recobro de lo adeudado, RB-13). «Baja efectiva» es final (A-25). |
| Anulada / incobrable / condonada | «Anulada» y «incobrable» son los dos estados de baja contable de una deuda (FR-24). Una deuda «condonada» o «perdonada» es una anulada por decisión comercial. Ninguna equivale a «pagada», que exige un cobro detectado o validado (RB-14). «Rectificada» es otro concepto: la factura se corrige con una factura vinculada (RB-11). |
| Cobro excesivo | Marca sobre el estado de cobro que indica que el cobro conciliado supera el total de la factura. No cambia el estado; la diferencia se señala para revisión (FR-26) y su tratamiento está abierto (Q-12). |
