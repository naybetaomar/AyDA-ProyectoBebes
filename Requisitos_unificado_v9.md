# Requisitos

> Documento unificado  (borrador). Generado a partir de los bloques de Imad (1-3), Guille (4-5), Loraine (6-7), Ana (8-9), Naybet (10-11), Cristóbal (12-13) y Luca (14-15). 

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

**Fuera del alcance**

- Altas o bajas comerciales del producto principal (Brain).
- Integración real con pasarelas de pago o proveedores de mensajería (se simulan Stripe, WhatsApp y correo).
- Consultoría o asesoría fiscal automatizada; integración con Verifactu en la fase inicial (se prevé exportar un paquete para la gestoría).
- Procesamiento directo de pagos reales.

### 1.3. Actores y partes interesadas

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Superadministrador | Persona con acceso a la configuración global del sistema | Configurar umbrales de aprobación, rangos y tarifas, series de numeración y recordatorios |
| Administrador | Empleado con permisos de gestión de operación, clientes, facturas, asignaciones y aprobaciones, sin acceso a la configuración global | Supervisar el estado del sistema, consultar el histórico de cualquier cliente, gestionar cambios de plan anuales, corregir errores con facturas rectificativas y gestionar el control de acceso |
| Lector | Empleado que trabaja sobre los clientes que tiene asignados | Realizar sus operaciones diarias, conocer el saldo y las facturas pendientes y pagadas de sus clientes y tener claro el estado real de los envíos |
| Sistema externo | Sistema de terceros o de Turbine (como Brain) que consume la API de la aplicación | Consultar deuda, facturas y clientes y solicitar bajas sin saltarse las reglas del sistema |
| Pasarela de pagos (Stripe simulado) | Servicio externo que notifica los cobros | Que los pagos se reflejen correctamente en las facturas, sin contabilizar dos veces el mismo evento |
| Planificador (tareas automáticas) | Disparador de procesos sin intervención humana | Generación mensual, recordatorios, campaña anual y caducidad de delegaciones |

Gestoría y persona de contacto del cliente son partes interesadas, no actores del sistema.

## 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | Reducir el trabajo manual de la facturación y del seguimiento de cobros, y poder crecer hacia miles de clientes sin aumentar de forma proporcional el personal administrativo | Entrevista ampliada (Imad BR-03; Loraine BR-01; Ana BR-01; Luca BR-01, BR-03) |
| BR-02 | Mantener la independencia operativa de la herramienta administrativa respecto al producto principal (Brain) | Entrevista ampliada (Imad BR-02; Loraine BR-02) |
| BR-03 | Garantizar la integridad legal, contable e histórica de la facturación (lo emitido no se altera, las correcciones quedan vinculadas) con trazabilidad de quién hizo qué y por qué | Entrevista ampliada (Guille BR-02; Loraine BR-03; Ana BR-02; Cristóbal BR-02; Luca BR-04) |
| BR-04 | Conseguir una automatización fiable y explicable: ninguna factura, envío, cobro o tarea falla en silencio ni se duplica, y un fallo puntual no detiene al resto | Entrevista ampliada (Cristóbal BR-01; Luca BR-05) |
| BR-05 | Obtener visibilidad financiera fiable (facturado, cobrado, pendiente, vencido) con cifras reconciliables, también a nivel global del negocio | Entrevista ampliada (Imad BR-03; Cristóbal BR-04) |
| BR-06 | Proteger los datos de clientes, contactos y documentos y cumplir la normativa de privacidad sin perder la conservación exigida por ley | Entrevista ampliada (Imad BR-05; Cristóbal BR-05; Luca BR-06, BR-07) |
| BR-07 | Permitir que el sistema evolucione (nuevos planes, canales, monedas, sociedades, países) sin reescribirlo | Entrevista ampliada (Cristóbal BR-03) |
| BR-08 | Poder gestionar la facturación de forma rápida y sencilla desde cualquier dispositivo | Entrevista ampliada (Ana; Naybet) |
| BR-09 | Representar la relación comercial entre Turbine y sus empresas clientes, con múltiples contactos, de forma independiente de las facturas y del producto | Entrevista ampliada (Imad BR-01; Loraine) |
| BR-10 | Garantizar la continuidad del recobro de las deudas pendientes tras una pausa o una baja del cliente | Entrevista ampliada (Guille BR-01) |
| BR-11 | Optimizar la tasa de cobro mediante notificaciones, seguimiento de impagos y conciliación de cobros | Entrevista ampliada (Guille BR-03; Ana BR-02; Luca BR-02) |
| BR-12 | Procesar empresas clientes internacionales sin asumir formatos fiscales, domicilios, monedas o idiomas españoles | Entrevista ampliada (Imad BR-04) |
| BR-13 | Facilitar la coordinación interna: asignación de clientes a empleados, incidencias y acceso limitado a los clientes asignados | Entrevista ampliada (Ana BR-03) |
| BR-14 | Evitar que los datos de facturación se usen automáticamente para campañas comerciales | Entrevista ampliada (Cristóbal BR-06) |

## 3. Requisitos de usuario

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-01 | Lector / Administrador | Poder registrar la información fiscal y operativa de la empresa (país, identificación fiscal y moneda). | Entrevista |
| UR-02 | Lector / Administrador | Poder consultar la información registrada de la empresa. | Entrevista |
| UR-03 | Lector / Administrador | Poder gestionar los contactos asociados a cada empresa cliente. | Entrevista |
| UR-04 | Lector / Administrador | Poder consultar la información de la relación comercial (fecha de inicio, plan, tarifa, condiciones de pago, responsable e historial). | Entrevista |
| UR-05 | Lector / Administrador | Poder preparar y emitir facturas. | Entrevista |
| UR-06 | Lector / Administrador | Poder revisar el cálculo prorrateado del importe de una factura antes de su emisión. | Entrevista |
| UR-07 | Lector / Administrador | Poder consultar el estado de cobro, el historial y la trazabilidad de las facturas. | Entrevista |
| UR-08 | Lector / Administrador | Poder borrar un borrador de factura que no se haya emitido. | Entrevista |
| UR-09 | Lector / Administrador | Poder programar la emisión de facturas para fechas futuras. | Entrevista |
| UR-10 | Superadministrador | Poder configurar el rango y precios de las tarifas globales. | Entrevista |
| UR-11 | Lector / Administrador | Poder modificar los impuestos aplicables a una factura. | Entrevista |
| UR-12 | Lector / Administrador | Poder proponer facturas nuevas o modificadas que requieran revisión. | Entrevista |
| UR-13 | Administrador | Poder revisar las propuestas de facturas recibidas y registrar su aprobación o rechazo. | Entrevista |
| UR-14 | Superadministrador | Poder configurar los umbrales de facturación para las aprobaciones extraordinarias. | Entrevista |
| UR-15 | Superadministrador | Poder autorizar facturas que superen el umbral de facturación configurado. | Entrevista |
| UR-16 | Superadministrador | Poder configurar la serie y numeración de las facturas. | Entrevista |
| UR-17 | Lector / Administrador | Poder gestionar facturas de modalidad puntual y recurrente. | Primera sesión |
| UR-18 | Lector / Administrador | Poder hacer el seguimiento de cobros y enviar recordatorios de pago. | Entrevista |
| UR-19 | Lector / Administrador | Poder consultar la lista de clientes con fecha de inicio futura pendientes de activación. | Entrevista |
| UR-20 | Lector | Poder pausar temporalmente una suscripción indicando motivo y fechas, congelando la generación de mensualidades sin afectar a las facturas impagadas | Entrevista página 4 |
| UR-21 | Lector / Administrador | Poder recibir alertas de reactivación de suscripciones pausadas para confirmar la reanudación del cobro | Entrevista página 4 |
| UR-22 | Lector | Poder registrar la baja de un cliente deteniendo cobros futuros pero manteniendo el flujo de recobro sobre las deudas no saldadas | Entrevista página 4-5 |
| UR-23 | Lector | Poder confeccionar facturas puntuales utilizando conceptos frecuentes de un catálogo ligero | Entrevista página 4-5 |
| UR-24 | Lector | Poder previsualizar la factura y disponer de bloqueos automáticos en caso de faltar datos fiscales antes de su emisión | Entrevista página 4-5 |
| UR-25 | Lector | Poder gestionar incidencias de envío de correo para corregir los datos de contacto y realizar reintentos sin emitir facturas duplicadas | Entrevista página 4-5 |
| UR-26 | Administrador | Poder pausar el envío automático de recordatorios marcando facturas "en disputa" mientras se investiga una disconformidad | Entrevista página 4-5 |
| UR-27 | Administrador | Poder dar de baja contable una deuda clasificándola como "anulada" o "incobrable" tras aprobación administrativa | Entrevista página 4-5 |
| UR-28 | Lector | Poder revisar en una bandeja de trabajo los movimientos bancarios o de pasarela no conciliados automáticamente o con importes parciales/excesivos | Entrevista página 4-5 |
| UR-29 | Lector / Administrador | Poder disponer de la factura emitida en PDF, con su aspecto y contenido inalterables aunque cambie la marca o el catálogo | Unificación del bloque 4-5 (validado por Naybet) |
| UR-30 | Lector / Administrador | Poder enviar las facturas emitidas al contacto de facturación por correo electrónico o WhatsApp (simulado) | Unificación del bloque 4-5 (validado por Naybet) |
| UR-31 | Superadministrador | Poder configurar la cadencia de los recordatorios automáticos de impago y que respeten el vencimiento acordado con cada cliente | Unificación del bloque 4-5 (validado por Naybet) |
| UR-32 | Lector / Administrador | Poder consultar los cobros notificados por la pasarela de pagos sin que un mismo evento se contabilice dos veces | Unificación del bloque 4-5 (validado por Naybet) |
| UR-33 | Lector / Administrador | Poder disponer de una pantalla de trabajo diaria útil que muestre alertas y tareas pendientes para resolverlas con pocos clics | Transcripción ampliada (Página 6) |
| UR-34 | Lector | Poder recibir notificaciones relevantes de los clientes asignados y distinguir las ya leídas de las ya resueltas | Transcripción ampliada (Página 6) |
| UR-35 | Superadministrador | Poder configurar canales y preferencias de notificación (in-app, email, resumen diario) para evitar saturación | Transcripción ampliada (Página 6) |
| UR-36 | Administrador | Poder consultar un dashboard financiero con cifras reales y generar informes filtrables y exportables a CSV y PDF | Transcripción ampliada (Página 6) |
| UR-37 | Lector / Administrador / Superadministrador | Poder realizar búsquedas globales rápidas y guardar vistas o filtros frecuentes | Transcripción ampliada (Página 6) |
| UR-38 | Lector / Administrador / Superadministrador | Poder importar clientes desde CSV con previsualización, mapeo y control de duplicados (NIF) | Transcripción ampliada (Página 6) |
| UR-39 | Administrador | Poder importar histórico de facturas en modo migración sin disparar emails ni consumir numeración oficial | Transcripción ampliada (Página 6) |
| UR-40 | Administrador / Superadministrador | Poder gestionar altas, invitaciones y desactivaciones de usuarios internos manteniendo el histórico de auditoría | Transcripción ampliada (Página 6) |
| UR-41 | Lector / Administrador / Superadministrador | Poder recuperar la contraseña mediante un enlace temporal con caducidad | Transcripción ampliada (Página 6) |
| UR-42 | Lector | Poder trabajar exclusivamente sobre los clientes asignados, con permisos operativos limitados y sin acceso a la configuración global | Transcripción ampliada (Página 7) |
| UR-43 | Administrador | Poder asignar y desasignar clientes, heredando el nuevo responsable las tareas pendientes y manteniendo el histórico | Transcripción ampliada (Página 7) |
| UR-44 | Administrador | Poder delegar temporalmente los clientes de un usuario (por vacaciones) sin necesidad de compartir contraseñas | Transcripción ampliada (Página 7) |
| UR-45 | Lector / Administrador / Superadministrador | Poder evitar sobrescribir cambios de otros usuarios mediante la detección de conflictos de edición concurrente | Transcripción ampliada (Página 7) |
| UR-46 | Superadministrador | Poder consultar y filtrar los registros de auditoría de negocio sin poder alterar el pasado | Transcripción ampliada (Página 7) |
| UR-47 | Superadministrador | Poder disponer de copias de seguridad automáticas y un mecanismo de restauración probado y demostrable | Transcripción ampliada (Página 7) |
| UR-48 | Lector / Administrador / Superadministrador | Poder descargar únicamente los documentos e información para los cuales posea permisos válidos | Transcripción ampliada (Página 7) |
| UR-49 | Lector / Administrador | Poder redactar y enviar facturas y recordatorios previos por correo electrónico utilizando plantillas que completen automáticamente variables clave (nombre de empresa, número de factura, importe y vencimiento) | Notas de requisitos |
| UR-50 | Lector / Administrador | Poder abrir y seguir incidencias de facturación sobre un cliente | Notas de requisitos |
| UR-51 | Lector / Administrador / Superadministrador | Poder consultar informes detallados de la aplicación (incluyendo facturas que fallaron en meses anteriores) así como resúmenes semanales y mensuales | Notas de requisitos |
| UR-52 | Lector / Administrador | Poder utilizar la aplicación desde diferentes dispositivos (ordenador, tablet y móvil), en idioma español o inglés, adaptada a la zona horaria de España | Notas de requisitos |
| UR-53 | Lector | Poder distinguir entre una factura que existe pero no se pudo enviar y una factura que no se pudo crear | Cliente / entrevista |
| UR-54 | Lector | Poder preparar un presupuesto para un cliente, enviarlo y registrar si lo acepta o lo rechaza, para convertirlo en factura sin volver a introducir los datos (opcional) | Cliente / entrevista |
| UR-55 | Administrador | Poder corregir un error de una factura ya emitida sin alterarla, de forma que el saldo del cliente refleje la corrección | Cliente / entrevista |
| UR-56 | Lector | Poder conocer de un vistazo el saldo, las facturas pendientes y las pagadas, y comprobar de dónde sale cada cifra (limitado a clientes asignados) | Cliente / entrevista |
| UR-57 | Administrador | Poder revisar cada año si un cliente sigue en el plan que le corresponde y decidir el cambio, sin que se alteren las facturas pasadas | Cliente / entrevista |
| UR-58 | Administrador | Poder conocer el estado del sistema (emails pendientes, errores de integración, último backup, última generación recurrente) | Cliente / entrevista |
| UR-59 | Administrador | Poder consultar la historia de cada cliente | Cliente / entrevista |
| UR-60 | Administrador | Poder garantizar que solo las personas autorizadas acceden al sistema y a cada cliente o factura | Cliente / entrevista |
| UR-61 | Sistema externo | Poder consultar datos de clientes, deuda y facturas, y enviar solicitudes (como la de baja de un cliente), de forma que el sistema aplique siempre sus reglas de negocio | Cliente / entrevista |
| UR-62 | Administrador | Poder identificar y localizar la causa de un error del sistema a partir de un código de incidencia | Cliente / entrevista |
| UR-63 | Lector / Administrador | Poder ver un mensaje comprensible ante un error, sin información técnica interna del sistema | Cliente / entrevista |
| UR-64 | Lector | Poder dar de alta clientes con datos correctos y sin duplicados, y saber qué datos faltan para poder facturarles | Cliente / entrevista |
| UR-65 | Superadministrador | Poder configurar los datos fiscales del emisor | Cliente / entrevista |
| UR-66 | Administrador | Poder elegir, si Turbine factura desde varias sociedades, con cuál se emite cada factura (opcional) | Cliente / entrevista |
| UR-67 | Lector | Poder adjuntar a un cliente o a una factura los documentos que lo justifican (pedido, presupuesto aceptado, justificante) de forma segura | Cliente / entrevista |
| UR-68 | Lector | Poder acceder rápidamente a los clientes con los que trabaja con más frecuencia | Cliente / entrevista |
| UR-69 | Lector / Administrador | Poder comentar internamente en clientes, facturas e incidencias, con notas restringidas cuando proceda. | Ampliación / entrevista |
| UR-70 | Lector / Administrador / Superadministrador | Poder evitar duplicados por doble clic o reintento al emitir, enviar o conciliar. | Ampliación / entrevista |
| UR-71 | Administrador | Poder fijar objetivos mensuales/anuales de facturación y cobro. | Ampliación / entrevista |
| UR-72 | Superadministrador | Poder configurar el sistema de plazos (plazo de pago y calendario laboral). | Ampliación / entrevista |
| UR-73 | Superadministrador | Poder configurar las monedas en las que se emiten las facturas. | Ampliación / entrevista |
| UR-74 | Superadministrador | Poder cargar datos ficticios para demostraciones sin mezclarlos con los de producción (opcional) | Ampliación / entrevista |
| UR-75 | Administrador / Superadministrador | Poder localizar qué datos personales se tienen de un contacto y anonimizarlos cuando legalmente proceda, sin invalidar el histórico contable. | Ampliación / entrevista |
| UR-76 | Administrador | Poder consultar tipos de cambio y reglas de conversión de divisa aplicados a la consolidación de informes. | Ampliación / entrevista |
| UR-77 | Lector / Administrador | Poder consultar la trazabilidad y el estado detallado de entrega de cada mensaje individual enviado. | Ampliación / entrevista |
| UR-78 | Administrador / Superadministrador | Poder consultar en una bandeja el estado (aprobada, rechazada o pendiente) de las solicitudes económicas realizadas. | Ampliación / entrevista |
| UR-79 | Administrador / Superadministrador | Poder ver los comentarios explicativos del aprobador sobre una solicitud, para entender el motivo de la decisión. | Ampliación / entrevista |
| UR-80 | Administrador / Superadministrador | Poder garantizar la separación de funciones: nadie aprueba sus propias solicitudes sensibles. | Ampliación / entrevista |
| UR-81 | Administrador | Poder ejecutar el cierre formal de un mes o trimestre contable cuando finalice el periodo. | Ampliación / entrevista |
| UR-82 | Administrador | Poder evitar modificar por error facturas o cobros de un periodo cerrado. | Ampliación / entrevista |
| UR-83 | Superadministrador | Poder reabrir periodos cerrados únicamente ingresando un motivo obligatorio que quede registrado. | Ampliación / entrevista |
| UR-84 | Administrador | Poder generar y descargar en un solo archivo (ZIP/CSV) toda la información y PDF contables del periodo. | Ampliación / entrevista |
| UR-85 | Administrador | Poder consultar la fecha y autoría de la última generación del paquete contable para confirmar su envío a la gestoría. | Ampliación / entrevista |
| UR-86 | Administrador | Poder diferenciar si un paquete contable es la versión inicial o una regeneración posterior para evitar duplicidades o confusiones. | Ampliación / entrevista |
| UR-87 | Lector / Administrador | Poder registrar el idioma preferido de un contacto para enviarle las comunicaciones en su idioma. | Ampliación / entrevista |
| UR-88 | Lector / Administrador | Poder indicar el canal preferido de un contacto para recibir notificaciones e impresos. | Ampliación / entrevista |
| UR-89 | Lector / Administrador | Poder gestionar los permisos de envío de forma independiente para cada canal según la normativa de protección de datos. | Ampliación / entrevista |
| UR-90 | Superadministrador | Poder consultar en la auditoría del sistema qué usuario realizó exportaciones masivas de datos y con qué criterios. | Ampliación / entrevista |
| UR-91 | Superadministrador | Poder identificar quién y cuándo descargó cualquier fichero de datos exportado, para disuadir fugas de información. | Ampliación / entrevista |
| UR-92 | Lector / Administrador | Poder recibir una alerta cuando una factura supere el límite tolerable de días vencida. | Ampliación / entrevista |
| UR-93 | Lector / Administrador | Poder recibir una notificación cuando la deuda de un cliente supera el límite económico permitido, para bloquear nuevas acciones. | Ampliación / entrevista |
| UR-94 | Lector / Administrador | Poder recibir un aviso cuando fallen repetidamente los envíos hacia un contacto, para corregir sus datos de entrega. | Ampliación / entrevista |
| UR-95 | Lector / Administrador | Poder recibir un aviso sobre revisiones pendientes que lleven más de una semana sin gestión. | Ampliación / entrevista |
| UR-96 | Lector / Administrador / Superadministrador | Poder conservar su información redactada ante interrupciones accidentales durante la edición de facturas. | Transcripción ampliada |
| UR-97 | Lector / Administrador / Superadministrador | Poder deshacer modificaciones accidentales exceptuando las legalmente irreversibles. | Transcripción ampliada |
| UR-98 | Lector / Administrador / Superadministrador | Poder comprender el nivel de irreversibilidad legal y riesgo de una acción antes de su confirmación final. | Transcripción ampliada |
| UR-99 | Lector / Administrador / Superadministrador | Poder identificar y resolver las incidencias y excepciones técnicas de los procesos de cobro. | Transcripción ampliada |
| UR-100 | Superadministrador | Poder establecer un tiempo de retención de almacenamiento temporal para informes. | Transcripción ampliada |
| UR-101 | Superadministrador | Poder evaluar la eficiencia operativa mediante un dashboard. | Transcripción ampliada |
| UR-102 | Administrador | Poder confiar en que una caída breve del sistema no hace perder ni duplicar emisiones o generaciones mensuales de facturas | Transcripción ampliada (Página 8) |
| UR-103 | Superadministrador | Poder gestionar la configuración global del sistema con cambios validados y auditados, sin que afecten a lo ya emitido | Transcripción ampliada (Página 8) |
| UR-104 | Administrador / Superadministrador | Poder probar los cambios de plantillas y de reglas de recordatorio antes de activarlos | Transcripción ampliada (Páginas 8 y 9) |
| UR-105 | Lector / Administrador | Poder dar de alta clientes de forma ágil, con valores por defecto y revisando el resultado antes de confirmar | Transcripción ampliada (Página 9) |
| UR-106 | Lector / Administrador | Poder ejecutar acciones masivas sobre clientes con control del alcance y del resultado | Transcripción ampliada (Página 9) |
| UR-107 | Lector / Administrador | Poder etiquetar clientes para organizarlos de forma flexible (opcional) | Transcripción ampliada (Página 9) |
| UR-108 | Lector / Administrador | Poder buscar direcciones al registrar los datos de un cliente | Notas de requisitos |
| UR-109 | Administrador / Superadministrador | Poder asegurar que los datos de facturación no se usan automáticamente para campañas comerciales | Ampliación / entrevista |
| UR-110 | Superadministrador | Poder confiar en que el cálculo financiero es determinista y no depende de inteligencia artificial | Transcripción ampliada |
| UR-111 | Administrador | Poder programar informes periódicos y su envío a las personas que indique (opcional) | Ampliación / entrevista |

## 4. Requisitos del sistema

### 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | El sistema deberá registrar el nombre comercial, razón social, identificador fiscal, domicilio fiscal, país y moneda de trabajo de una empresa. | UR-01 |
| FR-02 | El sistema deberá mostrar los datos identificativos y fiscales registrados de una empresa. | UR-02 |
| FR-03 | El sistema deberá registrar múltiples personas de contacto vinculadas a una empresa. | UR-03 |
| FR-04 | El sistema deberá permitir marcar una persona de contacto como inactiva conservando intactos sus registros e historial contable asociado. | UR-03 |
| FR-05 | El sistema deberá registrar la relación comercial de una empresa incluyendo fecha de inicio, servicio o plan, tarifa, responsable interno, condiciones de pago y documentos firmados. | UR-04 |
| FR-06 | El sistema deberá permitir asignar los impuestos aplicables a una factura seleccionándolos de una lista de impuestos configurados. | UR-11 |
| FR-07 | El sistema deberá permitir crear facturas de modalidad puntual. | UR-05, UR-17 |
| FR-08 | El sistema deberá permitir configurar la facturación recurrente mensual vinculada a una relación comercial aprobada. | UR-05, UR-17 |
| FR-09 | El sistema deberá generar automáticamente el día uno de cada mes las facturas recurrentes mensuales de las relaciones comerciales activas. | UR-17 |
| FR-10 | El sistema deberá calcular el importe cobrado equivalente a los días restantes del mes en curso para los contratos iniciados a mitad de mes. | UR-06, UR-17 |
| FR-11 | El sistema deberá mostrar el importe prorrateado y la mensualidad normal antes de la confirmación final del alta. | UR-06, UR-105 |
| FR-12 | El sistema deberá permitir registrar una excepción comercial explícita para aplazar el inicio de la facturación al mes siguiente sin cobrar prorrateo. | UR-17 |
| FR-13 | El sistema deberá permitir asignar una fecha de inicio futura a una relación comercial manteniendo su estado como pendiente de activación. | UR-19 |
| FR-14 | El sistema no deberá generar facturas ni recordatorios de cobro antes de la fecha de inicio futura de una relación comercial. | UR-18, UR-19 |
| FR-15 | El sistema deberá permitir programar la emisión automática de facturas para una fecha futura. | UR-09 |
| FR-16 | El sistema deberá registrar las transiciones de estado de cobro de cada factura (pendiente, vencida, parcialmente conciliada, pagada, anulada o incobrable). | UR-07, UR-18 |
| FR-17 | El sistema deberá listar y filtrar las facturas emitidas según su estado de cobro. | UR-07 |
| FR-18 | El sistema deberá permitir al superadministrador configurar los rangos de facturación anual y sus tarifas sin modificar el código fuente. | UR-10 |
| FR-19 | El sistema deberá permitir registrar propuestas de excepciones comerciales (descuentos, meses gratuitos o precios especiales). | UR-12 |
| FR-20 | El sistema deberá permitir parametrizar los umbrales económicos y niveles de aprobación requeridos para autorizar excepciones comerciales. | UR-13, UR-14, UR-15 |
| FR-21 | El sistema deberá suspender la emisión de facturas que incluyan modificaciones manuales de importe, descuentos, fechas excepcionales o importes que superen los umbrales, asignándolas a estado pendiente de aprobación. | UR-12, UR-13, UR-14, UR-15 |
| FR-22 | El sistema deberá registrar la decisión de aprobación o rechazo emitida por el perfil autorizado sobre las facturas pendientes. | UR-13, UR-15 |
| FR-23 | El sistema deberá permitir al superadministrador configurar las series de facturación. | UR-16 |
| FR-24 | El sistema deberá asignar un número definitivo único correlativo dentro de su serie únicamente en el momento de emitir la factura. | UR-16 |
| FR-25 | El sistema no deberá consumir un número definitivo para facturas en estado de borrador. | UR-08, UR-16 |
| FR-26 | El sistema deberá permitir modificar el contenido de una factura mientras permanezca en estado de borrador. | UR-05, UR-08 |
| FR-27 | El sistema deberá permitir eliminar únicamente borradores de facturas que no hayan sido emitidas. | UR-08 |
| FR-28 | El sistema deberá permitir pausar una suscripción activa registrando el motivo, la fecha de inicio y la fecha prevista de reactivación | UR-20 |
| FR-29 | Si una suscripción está en pausa, el sistema deberá detener la generación de mensualidades sin alterar ni cancelar las facturas impagadas pendientes | UR-20 |
| FR-30 | Al alcanzarse la fecha prevista de reactivación de una suscripción, el sistema deberá notificar al responsable asignado para solicitar confirmación explícita antes de reanudar la facturación | UR-21 |
| FR-31 | El sistema deberá recibir o registrar solicitudes de baja comprobando la existencia de deudas pendientes | UR-22 |
| FR-32 | Si no hay deudas, el sistema deberá cerrar la recurrencia comercial en la fecha efectiva | UR-22 |
| FR-33 | Si hay deudas, el sistema deberá detener la generación de nuevas mensualidades a partir de la fecha de baja, y mantener activo el flujo de cobro/recobro sobre las facturas pendientes anteriores | UR-22 |
| FR-34 | El sistema deberá permitir emitir facturas puntuales compuestas por múltiples líneas con concepto, cantidad, precio unitario, porcentaje de descuento y tipo de impuesto aplicable | UR-23 |
| FR-35 | El sistema deberá permitir administrar un catálogo de conceptos reutilizables con un precio orientativo y un impuesto asignado por defecto | UR-23 |
| FR-36 | El sistema deberá permitir ajustar la descripción y el precio al añadir un concepto del catálogo a una factura puntual. Los cambios posteriores en los elementos del catálogo no deberán afectar a las facturas ya emitidas | UR-23 |
| FR-37 | El sistema deberá ofrecer una vista previa de la factura antes de su emisión | UR-24 |
| FR-38 | El sistema deberá evaluar el importe total de la factura antes de emitirla y mostrar una advertencia al usuario si el importe se desvía más de un porcentaje configurable respecto a la media de las facturas anteriores del cliente, sin bloquear la emisión | UR-24 |
| FR-39 | El sistema deberá generar la representación en PDF del documento incluyendo logo corporativo, tipografía, datos fiscales, numeración, fechas, desglose de líneas, bases, impuestos, totales, condiciones de pago y contacto de soporte | UR-29 |
| FR-40 | El sistema deberá almacenar la versión original del PDF emitido garantizando que las modificaciones futuras en los activos corporativos no alteren los documentos históricos | UR-29 |
| FR-41 | El sistema deberá enviar automáticamente la factura por correo electrónico al contacto de facturación en el momento de su emisión | UR-30 |
| FR-42 | El sistema deberá permitir la simulación del envío de facturas por WhatsApp únicamente para los contactos que dispongan de un número válido y hayan otorgado su consentimiento | UR-30 |
| FR-43 | El sistema deberá registrar cada intento de envío almacenando el canal utilizado, destinatario, fecha, hora y el resultado obtenido sea éxito o fallo | UR-25 |
| FR-44 | Ante un rebote o un fallo de correo, el sistema deberá marcar el envío como fallido y generar una incidencia de entrega | UR-25 |
| FR-45 | El sistema deberá enviar recordatorios automáticos según la cadencia configurada por el superadministrador | UR-31, UR-49 |
| FR-46 | El sistema deberá adaptar el envío de avisos de impago respetando la fecha de vencimiento acordada específicamente con el cliente sobre el valor por defecto | UR-31 |
| FR-47 | El sistema deberá permitir marcar una factura con la marca "en disputa", sin cambiar su estado de cobro, registrando un motivo y una fecha de revisión, para suspender temporalmente el envío de recordatorios automáticos | UR-26 |
| FR-48 | El sistema deberá permitir clasificar una deuda como "anulada" o "incobrable" si hay una previa aprobación administrativa y registro de motivo, evitando en todo momento catalogarla como "pagada" | UR-27 |
| FR-49 | El sistema deberá simular la recepción de eventos o notificaciones de pago externas de Stripe | UR-32 |
| FR-50 | El sistema deberá permitir la consulta de transacciones | UR-32 |
| FR-51 | El sistema deberá identificar las notificaciones o eventos de pago duplicados recibidos por pasarelas externas para no contabilizar los cobros repetidamente | UR-32 |
| FR-52 | El sistema deberá procesar movimientos bancarios o de pasarelas (importe, fecha, moneda, concepto, referencia) y vincularlos automáticamente a la factura correspondiente si la referencia coincide con una única factura | UR-28 |
| FR-53 | El sistema deberá derivar a una bandeja de revisión manual los movimientos cuya referencia no identifique con claridad una única factura (sin referencia o ambigua) | UR-28 |
| FR-54 | Ante un cobro por un importe inferior al total de la factura, el sistema deberá asociar el movimiento a la factura, registrar la diferencia y mantener la factura en estado "parcialmente conciliada" | UR-28 |
| FR-55 | En caso de deshacer o revertir una conciliación previa, el sistema deberá conservar la traza histórica guardando quién o qué regla la realizó, quién la deshizo y la justificación dada | UR-28 |
| FR-56 | El sistema deberá gestionar notificaciones internas diferenciadas de los correos enviados a clientes | UR-34 |
| FR-57 | Cada cliente deberá tener un responsable interno asignado para recibir eventos relevantes (pago confirmado, factura vencida, rebote, disputa, revisión anual) | UR-34 |
| FR-58 | El sistema deberá ofrecer una bandeja global de notificaciones para administradores y bandeja específica para los Lectores | UR-34 |
| FR-59 | El sistema deberá permitir al superadministrador configurar el canal de recepción de notificaciones (in-app, email, resumen diario) | UR-35 |
| FR-60 | El sistema deberá permitir marcar una notificación como leída o como resuelta/atendida, distinguiendo ambos estados | UR-34 |
| FR-61 | Las notificaciones deberán incorporar una prioridad | UR-34 |
| FR-62 | El sistema deberá ofrecer una pantalla de trabajo diario que muestre vencimientos, pagos pendientes de conciliación, problemas de entrega, aprobaciones pendientes y revisiones | UR-33 |
| FR-63 | El sistema deberá permitir al usuario saltar directamente desde la pantalla de trabajo diario al elemento afectado para resolverlo en pocos clics | UR-33 |
| FR-64 | El sistema deberá ofrecer a los administradores un dashboard financiero con métricas de facturación, cobros, pendientes, vencidos, tiempo medio de cobro, ingresos recurrentes e historial | UR-36 |
| FR-65 | Los informes financieros y operativos deberán poder filtrarse por periodo, cliente, responsable, país, sector, estado y tipo de factura | UR-36 |
| FR-66 | El sistema deberá permitir exportar los resultados de informes a formato CSV y PDF | UR-36 |
| FR-67 | Las exportaciones deberán respetar rigurosamente los permisos de acceso del usuario | UR-36, UR-42 |
| FR-68 | El sistema deberá proporcionar una búsqueda global por nombre comercial, razón social, NIF, persona de contacto, número de factura y correo | UR-37 |
| FR-69 | El sistema deberá mantener y aplicar filtros de ubicación, sector comercial, estado de pago y fechas | UR-37 |
| FR-70 | El sistema deberá permitir guardar filtros y vistas frecuentes de trabajo | UR-37 |
| FR-71 | El sistema deberá permitir importar clientes desde ficheros CSV con previsualización previa | UR-38 |
| FR-72 | En la importación de CSV, el usuario deberá poder mapear columnas, revisar errores y decidir si importa filas válidas o corrige el fichero | UR-38 |
| FR-73 | El sistema deberá alertar si detecta NIFs duplicados durante la importación | UR-38 |
| FR-74 | La importación completa deberá registrarse como operación con resumen de registros creados, actualizados y rechazados | UR-38 |
| FR-75 | El sistema deberá permitir la importación administrativa de histórico de facturas, separada de la emisión ordinaria | UR-39 |
| FR-76 | Las facturas históricas importadas no deberán disparar emails ni consumir numeración oficial, quedando marcadas como migradas | UR-39 |
| FR-77 | El acceso de usuarios internos deberá realizarse mediante correo y contraseña del dominio corporativo autorizado | UR-40 |
| FR-78 | El sistema deberá prohibir estrictamente el autorregistro de usuarios | UR-40 |
| FR-79 | El superadministrador o administrador con permisos deberá poder crear o invitar usuarios internos | UR-40 |
| FR-80 | El sistema deberá permitir desactivar cuentas de usuarios que abandonen la empresa preservando el rastro de sus acciones | UR-40 |
| FR-81 | El sistema deberá permitir la recuperación de contraseñas | UR-41 |
| FR-82 | Los enlaces de recuperación de contraseña deberán caducar a las 24 horas de su emisión (supuesto A-18) | UR-41 |
| FR-83 | El sistema deberá distinguir roles de superadministrador, administrador y lector | UR-42 |
| FR-84 | El Lector deberá poder gestionar información operativa, crear facturas autorizadas y seguir cobros de sus clientes asignados | UR-42 |
| FR-85 | El Lector no deberá poder autoasignarse clientes, modificar tarifas globales, crear series ni ver el dashboard financiero global | UR-42 |
| FR-86 | El administrador deberá poder asignar y desasignar clientes a los usuarios | UR-43 |
| FR-87 | Al reasignar un cliente, el nuevo responsable deberá heredar tareas pendientes manteniendo el histórico de acciones | UR-43 |
| FR-88 | El administrador deberá poder delegar temporalmente los clientes de un usuario a un suplente durante un intervalo | UR-44 |
| FR-89 | Las delegaciones temporales deberán caducar automáticamente al finalizar el intervalo | UR-44 |
| FR-90 | El sistema deberá detectar conflictos de edición concurrente en facturas para evitar sobrescrituras silenciosas | UR-45 |
| FR-91 | Las operaciones monetarias críticas, numeración y conciliación deberán mantener consistencia ante accesos concurrentes | UR-45 |
| FR-92 | El sistema deberá registrar un log de auditoría de negocio detallado para operaciones clave (creación de clientes, cambios fiscales, emisión, descuentos, reasignaciones, disputas, conciliaciones) | UR-46 |
| FR-93 | Los registros de auditoría no deberán ser editables por usuarios normales | UR-46 |
| FR-94 | El superadministrador deberá poder consultar y filtrar la auditoría sin poder reescribirla | UR-46 |
| FR-95 | El sistema deberá realizar copias de seguridad automáticas de datos y documentos con política definida | UR-47 |
| FR-96 | El sistema deberá permitir restaurar las copias de seguridad | UR-47 |
| FR-97 | Un usuario autenticado solo deberá poder descargar documentos autorizados | UR-48 |
| FR-98 | Los enlaces temporales de descarga de documentos deberán caducar | UR-48 |
| FR-99 | El sistema deberá completar automáticamente en las plantillas de comunicación las variables: nombre de empresa, número de factura, importe y fecha de vencimiento | UR-49 |
| FR-100 | El sistema deberá mantener un historial de versiones para los registros y documentos modificados | UR-07 |
| FR-101 | El sistema deberá incluir una funcionalidad integrada de búsqueda de direcciones | UR-108 |
| FR-102 | El sistema deberá funcionar con el zoom del navegador ampliado sin perder funcionalidad | UR-52 |
| FR-103 | El sistema deberá generar informes específicos de la aplicación (con detalle de facturas que fallaron en meses anteriores) y resúmenes periódicos semanales y mensuales | UR-51 |
| FR-104 | El sistema deberá generar presupuestos (opcional) | UR-54 |
| FR-105 | El sistema deberá permitir enviar el presupuesto al cliente (opcional) | UR-54 |
| FR-106 | Un usuario con permiso deberá poder marcar un presupuesto como aceptado o rechazado (opcional) | UR-54 |
| FR-107 | El sistema deberá permitir adjuntar al presupuesto la evidencia de la aceptación (opcional) | UR-54 |
| FR-108 | Si el presupuesto está aceptado, el sistema deberá convertirlo en factura reutilizando las líneas (opcional) | UR-54 |
| FR-109 | El sistema no deberá permitir que se modifiquen facturas emitidas | UR-55 |
| FR-110 | En caso de error en una factura emitida, un administrador deberá poder generar una factura rectificativa vinculada a la factura original | UR-55 |
| FR-111 | Si el importe de la rectificativa supera el umbral configurado, esta deberá ser aprobada antes de emitirse | UR-55 |
| FR-112 | El sistema deberá proponer los datos a rectificar a partir de la factura original | UR-55 |
| FR-113 | El sistema deberá recalcular el saldo del cliente a través de la factura rectificativa | UR-55 |
| FR-114 | El sistema deberá generar un dashboard que muestre el saldo, las facturas pendientes y las facturas pagadas de los clientes asignados al usuario. | UR-56 |
| FR-115 | El sistema deberá permitir consultar el detalle de los registros que componen cada cifra del dashboard. | UR-56 |
| FR-116 | El sistema deberá iniciar a principios de cada año una campaña de revisión que lista los clientes cuya facturación anual deberá revisarse | UR-57 |
| FR-117 | El sistema deberá obtener la facturación anual de una fuente simulada o de entrada manual | UR-57 |
| FR-118 | El sistema deberá registrar la fuente y la fecha de cada dato de facturación anual | UR-57 |
| FR-119 | Si el dato de facturación anual no está disponible, el sistema deberá dejar la revisión en estado pendiente | UR-57 |
| FR-120 | El sistema deberá proponer el rango de facturación que corresponda según el importe anual registrado y las reglas de asignación de rangos configuradas. | UR-57 |
| FR-121 | En caso de propuesta de cambio de plan, el administrador deberá verificar la propuesta de nuevo rango | UR-57 |
| FR-122 | Si el cambio de plan es válido, el sistema deberá aplicar el nuevo precio a partir de una fecha de efecto | UR-57 |
| FR-123 | El sistema deberá registrar quién aprobó el cambio de plan, cuándo, y el precio anterior y el nuevo | UR-57 |
| FR-124 | El sistema deberá mostrar el número de emails pendientes de envío | UR-58 |
| FR-125 | El sistema deberá mostrar los errores de integración, ordenados del más reciente al más antiguo | UR-58 |
| FR-126 | El sistema deberá mostrar la fecha y el resultado del último backup realizado | UR-58 |
| FR-127 | El sistema deberá mostrar la última ejecución de la generación recurrente | UR-58 |
| FR-128 | El sistema deberá mostrar el historial de cada cliente (alta, cambio de responsables, cambios de tarifa, facturas emitidas, pagos, incidencias, pausas, baja, reactivación) | UR-59 |
| FR-129 | El sistema deberá cerrar sesión automáticamente tras 30 minutos de inactividad | UR-60 |
| FR-130 | El sistema deberá exponer una API que permita a sistemas externos consultar clientes, estado de deuda y facturas | UR-61 |
| FR-131 | La API deberá permitir crear solicitudes controladas | UR-61 |
| FR-132 | Las solicitudes controladas deberán pasar por validación o aprobación y no deberán modificar datos directamente | UR-61 |
| FR-133 | La API deberá aplicar las mismas reglas de negocio y validaciones que la interfaz | UR-61 |
| FR-134 | Las credenciales de un consumidor de la API no deberán permitir acceder a la interfaz de usuario, ni las de un usuario acceder a la API | UR-61 |
| FR-135 | El sistema deberá limitar el número de solicitudes que cada consumidor de la API puede realizar durante un intervalo de tiempo, según los límites configurados. | UR-61 |
| FR-136 | El sistema deberá registrar las llamadas importantes a la API (quién la hizo, cuándo y qué operación) | UR-61 |
| FR-137 | El sistema deberá recibir solicitudes de baja y crear la tarea 'darse de baja' sin eliminar directamente la recurrencia | UR-61 |
| FR-138 | El sistema deberá permitir consultar, a partir de un identificador de cliente, si existen obligaciones pendientes y el detalle mínimo autorizado | UR-61 |
| FR-139 | El sistema deberá registrar los errores en logs técnicos | UR-62 |
| FR-140 | El sistema no deberá mostrar al usuario final información técnica del error (trazas, mensajes internos, rutas del servidor) | UR-63 |
| FR-141 | El sistema deberá generar un código de incidencia que permita correlacionar el error | UR-62 |
| FR-142 | Antes de dar de alta a un cliente, el sistema deberá buscar duplicados: coincidencias en nombre o razón social, mismo identificador fiscal, mismo email o teléfono | UR-64 |
| FR-143 | Si encuentra duplicados, el sistema deberá mostrárselos al usuario, para que decida si crear un nuevo cliente o usar el existente | UR-64 |
| FR-144 | El sistema deberá validar el formato de email | UR-64 |
| FR-145 | El sistema deberá validar el identificador fiscal siempre que el país sea conocido (NIF/CIF en España o VAT). Si no se conoce, la validación deberá quedar pendiente | UR-64 |
| FR-146 | Tras 5 intentos fallidos de login consecutivos, el sistema deberá bloquear temporalmente el acceso del usuario durante 15 minutos | UR-60 |
| FR-147 | El sistema deberá invalidar la sesión de un usuario desactivado por un administrador | UR-60 |
| FR-148 | El sistema deberá guardar los datos fiscales del emisor como configuración | UR-65 |
| FR-149 | El sistema deberá permitir tener varias entidades emisoras (opcional) | UR-65 |
| FR-150 | El sistema deberá identificar a cada entidad con series de numeración (opcional) | UR-65 |
| FR-151 | Al emitir una factura, un usuario con permiso deberá poder seleccionar la entidad emisora correspondiente (opcional) | UR-66 |
| FR-152 | El sistema deberá permitir adjuntar documentos a clientes y facturas, además del PDF que genera el sistema | UR-67 |
| FR-153 | Cada adjunto deberá tener un tipo (pedido del cliente, presupuesto aceptado, justificante de pago, documento de la gestoría, otro) y una descripción | UR-67 |
| FR-154 | El sistema deberá admitir solo formatos de una lista permitida: PDF, JPG/PNG, DOCX, XLSX y CSV. Los ejecutables y scripts (.exe, .bat, .js…) se deberán rechazar | UR-67 |
| FR-155 | El sistema deberá mostrar al usuario el fallo de creación de una factura y su causa | UR-53 |
| FR-156 | El sistema deberá registrar y mostrar al usuario el estado de envío de una factura (enviada o fallo de envío), distinto del estado de cada mensaje (FR-192) | UR-53 |
| FR-157 | En caso de descubrir que un dato de una revisión anual era incorrecto, el sistema deberá permitir corregir la ficha de revisión, registrando la corrección | UR-57 |
| FR-158 | El sistema deberá calcular el impacto potencial de la corrección sobre el precio de los meses afectados | UR-57 |
| FR-159 | El sistema no deberá emitir facturas retroactivas automáticamente | UR-57 |
| FR-160 | Toda regularización retroactiva deberá requerir una acción explícita y la aprobación de un administrador | UR-57 |
| FR-161 | El sistema deberá bloquear la emisión de una factura si falta un dato fiscal imprescindible, e indicar qué dato falta | UR-24, UR-64 |
| FR-162 | El sistema deberá permitir guardar un cliente sin los datos convenientes (el teléfono del contacto) como excepción controlada, y registrar qué datos faltan | UR-64 |
| FR-163 | El sistema deberá eliminar los espacios sobrantes de los datos introducidos (nombre, razón social, email e identificador fiscal) | UR-64 |
| FR-164 | El sistema deberá permitir marcar clientes como favoritos | UR-68 |
| FR-165 | El sistema deberá mostrar los clientes consultados recientemente | UR-68 |
| FR-166 | El sistema deberá comprobar los permisos del usuario en cada acceso a un cliente o a una factura, aunque se acceda mediante una URL directa, y rechazar el acceso si no le corresponde | UR-60 |
| FR-167 | El sistema deberá disponer de una bandeja de entrada donde el solicitante consulte el estado de sus solicitudes económicas. | UR-78 |
| FR-168 | El sistema deberá incluir y mostrar el comentario explícito registrado por el aprobador al autorizar o rechazar una solicitud. | UR-79 |
| FR-169 | El sistema deberá validar e impedir que el usuario solicitante sea el mismo que apruebe operaciones económicas sensibles. | UR-80 |
| FR-170 | El sistema deberá permitir a un administrador autorizado ejecutar el cierre administrativo de un mes o trimestre. | UR-81 |
| FR-171 | El sistema deberá bloquear la modificación, creación o borrado ordinario de elementos económicos dentro de un periodo cerrado. | UR-82 |
| FR-172 | El sistema deberá requerir permisos superiores (Superadministrador) y la justificación obligatoria de un motivo para reabrir un periodo cerrado. | UR-83 |
| FR-173 | El sistema deberá recopilar y empaquetar automáticamente en un archivo ZIP/CSV las facturas emitidas, rectificativas, cobros y sus correspondientes PDF del periodo seleccionado. | UR-84 |
| FR-174 | El sistema deberá registrar la trazabilidad de la generación del paquete, incluyendo fecha/hora, usuario y el periodo exacto que cubre. | UR-85 |
| FR-175 | El sistema deberá asignar e identificar un número de versión distinto cada vez que se vuelva a generar el paquete contable de un mismo periodo. | UR-86 |
| FR-176 | El sistema deberá almacenar el idioma preferido de comunicación asignado a cada contacto del cliente. | UR-87 |
| FR-177 | El sistema deberá registrar el canal de comunicación preferido para la entrega de notificaciones del contacto. | UR-88 |
| FR-178 | El sistema deberá gestionar y verificar el consentimiento explícito individual para cada canal de envío. | UR-89 |
| FR-179 | El sistema deberá registrar automáticamente en el log de auditoría cada exportación masiva realizada, capturando usuario, fecha/hora y los filtros de búsqueda aplicados. | UR-90 |
| FR-180 | El sistema deberá incrustar en el archivo exportado los metadatos o referencias de trazabilidad (usuario generador, marca de tiempo y filtros utilizados). | UR-91 |
| FR-181 | El sistema deberá permitir configurar y emitir una alerta cuando una factura permanezca en estado vencido más de días parametrizables. | UR-92 |
| FR-182 | El sistema deberá emitir una alerta cuando el saldo de deuda acumulada de un cliente supere un umbral determinado. | UR-93 |
| FR-183 | El sistema deberá detectar y notificar la acumulación de más de 3 fallos consecutivos en el envío de comunicaciones a un cliente. | UR-94 |
| FR-184 | El sistema deberá emitir una alerta cuando una revisión o incidencia anual permanezca sin resolver tras transcurrir una semana. | UR-95 |
| FR-185 | El sistema deberá clasificar facturas por proyecto o línea de negocio con categorías administrables cuyo renombrado no destruya el histórico (opcional) | UR-36 |
| FR-186 | El sistema deberá controlar objetivos mensual/anual de facturación y cobro, informativos y con histórico de cambios para no falsear comparaciones con otros anteriores | UR-71 |
| FR-187 | El sistema deberá permitir mover una comunicación o recordatorio que cae en fin de semana o festivo al siguiente día laborable, según un calendario laboral | UR-72 |
| FR-188 | El sistema deberá emitir cada factura en una moneda concreta y conservar su importe original | UR-73 |
| FR-189 | El sistema deberá convertir importes a una moneda base para reporting con un tipo de cambio registrado, sin alterar nunca el total legal de la factura | UR-76 |
| FR-190 | El sistema deberá ejecutar las tareas largas en segundo plano con estado (pendiente, procesando, completado, completado con errores) y mantenerlas aunque el usuario cierre la pestaña | UR-58 |
| FR-191 | El sistema deberá impedir duplicados por doble clic o reintento en emisión, envío y conciliación, mostrando un aviso de que la operación ya se está procesando | UR-70 |
| FR-192 | El sistema deberá mostrar el estado de cada mensaje (en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado) | UR-77 |
| FR-193 | El sistema deberá distinguir comunicaciones operativas de facturación de campañas comerciales y no deberá reutilizar automáticamente datos de facturación para marketing | UR-109 |
| FR-194 | El sistema deberá soportar dos niveles de visibilidad en comentarios: ordinario y nota restringida solo para administradores | UR-69 |
| FR-195 | El sistema deberá cargarse con datos ficticios para demos, sin mezclarlos con producción (opcional) | UR-74 |
| FR-196 | El sistema deberá impedir eliminar o inactivar el único contacto de facturación de un cliente activo, emitiendo una advertencia explícita | UR-03 |
| FR-197 | El sistema deberá autoguardar borradores periódicos durante redacción de facturas. | UR-96 |
| FR-198 | El sistema deberá permitir deshacer acciones que no tengan inmutabilidad legal. | UR-97 |
| FR-199 | El sistema deberá requerir una confirmación explícita informando de la imposibilidad de restauración antes de ejecutar borrados. | UR-98 |
| FR-200 | El sistema deberá notificar al empleado responsable ante la interrupción en el envío o proceso de validación de una factura. | UR-99 |
| FR-201 | El sistema deberá aislar y excluir a los clientes que generen errores de procesamiento, prosiguiendo con el procesamiento del resto de clientes. | UR-99 |
| FR-202 | El sistema deberá eliminar del servidor los archivos exportados temporalmente una vez superado su tiempo de caducidad. | UR-100 |
| FR-203 | El sistema deberá recopilar el tiempo invertido en generar acciones críticas, los fallos devueltos por el sistema y el conteo de clics de los usuarios de forma anónima. | UR-101 |
| FR-204 | El sistema deberá guardar de forma permanente los datos de confirmación de la pasarela de pago en la factura en cuanto esta cambie su estado a "pagada". | UR-99 |
| FR-205 | El sistema deberá ejecutar el cálculo financiero mediante programación determinista tradicional sin usar IA. | UR-110 |
| FR-206 | El sistema deberá desactivar completamente sus funciones de apoyo basadas en inteligencia artificial de forma configurable (opcional). | UR-110 |
| FR-207 | El sistema deberá permitir localizar todos los datos personales que conserva de un contacto | UR-75 |
| FR-208 | El sistema deberá permitir anonimizar los datos personales de un contacto en los registros operativos cuando legalmente proceda | UR-75 |
| FR-209 | El sistema deberá conservar los identificadores y los registros de auditoría de un contacto anonimizado | UR-75 |
| FR-210 | Al restablecerse tras una caída, el sistema deberá detectar las facturas recurrentes que no se generaron en su fecha | UR-102 |
| FR-211 | El sistema deberá generar las facturas recurrentes pendientes tras una caída sin duplicar las ya generadas | UR-102 |
| FR-212 | El sistema deberá registrar cada ejecución de los procesos automáticos (generación mensual, recordatorios, conciliación e informes programados) con su fecha y hora de inicio y de fin | UR-58 |
| FR-213 | El sistema deberá registrar en cada ejecución cuántos clientes ha procesado y cuántas facturas ha creado | UR-58 |
| FR-214 | El sistema deberá registrar en cada ejecución los elementos que han fallado y la causa de cada fallo | UR-58, UR-53 |
| FR-215 | El sistema deberá permitir al administrador indicar a quién se envían los resúmenes periódicos (opcional) | UR-111 |
| FR-216 | El sistema deberá enviar los informes programados que contengan detalle de clientes solo a usuarios con permiso para verlos (opcional) | UR-111 |
| FR-217 | El sistema deberá enviar en los informes programados una notificación con enlace autenticado al informe en lugar de adjuntarlo (opcional) | UR-111 |
| FR-218 | El sistema deberá validar los cambios de configuración global antes de aplicarlos | UR-103 |
| FR-219 | El sistema deberá registrar en la auditoría quién cambia la configuración global, cuándo, y el valor anterior y el nuevo | UR-103 |
| FR-220 | El sistema deberá aplicar un cambio de configuración global a partir del momento de su validación | UR-103 |
| FR-221 | El sistema deberá permitir al superadministrador configurar el logo y la plantilla de las facturas | UR-103 |
| FR-222 | El sistema deberá permitir enviar a un usuario un correo de prueba con una plantilla de comunicación antes de activar un cambio | UR-104 |
| FR-223 | El sistema deberá permitir previsualizar el calendario de recordatorios que resultaría de una regla para un cliente de ejemplo | UR-104 |
| FR-224 | El sistema deberá avisar en la previsualización de una plantilla cuando falte alguna de sus variables | UR-104 |
| FR-225 | El sistema deberá disponer de plantillas editables, por quien tenga permiso, para factura, recordatorio previo, vencimiento, impago, disputa resuelta y revisión de datos | UR-49 |
| FR-226 | El sistema deberá registrar qué plantilla se utilizó en cada envío | UR-49 |
| FR-227 | El sistema deberá proponer en las altas frecuentes valores por defecto de país, moneda, vencimiento y tarifa sugerida según el rango | UR-105 |
| FR-228 | El sistema deberá mostrar cuántos elementos afecta una acción masiva antes de ejecutarla | UR-106 |
| FR-229 | El sistema deberá pedir confirmación antes de ejecutar una acción masiva destructiva o sensible | UR-106 |
| FR-230 | El sistema deberá mostrar al terminar una acción masiva el resultado con los elementos correctos y los erróneos | UR-106 |
| FR-231 | El sistema no deberá permitir marcar facturas como pagadas mediante una acción masiva | UR-106 |
| FR-232 | El sistema deberá permitir crear etiquetas y asignarlas a clientes (opcional) | UR-107 |
| FR-233 | El sistema no deberá sustituir con etiquetas manuales los estados derivados, como «impagado» (opcional) | UR-107 |
| FR-234 | El sistema deberá permitir abrir una incidencia de facturación asociada a un cliente y, opcionalmente, a una factura | UR-50 |
| FR-235 | El sistema deberá permitir asignar a cada incidencia un responsable, un estado y una prioridad | UR-50 |
| FR-236 | El sistema deberá permitir añadir adjuntos a una incidencia | UR-50 |
| FR-237 | El sistema deberá permitir a un Administrador indicar que una incidencia pause los recordatorios de las facturas afectadas | UR-50 |
| FR-238 | El sistema deberá exigir registrar la resolución al cerrar una incidencia | UR-50 |
| FR-239 | El sistema deberá permitir mencionar a otro usuario en un comentario y generarle una notificación | UR-69 |
| FR-240 | El sistema no deberá enviar los comentarios internos al cliente | UR-69 |
| FR-241 | El sistema deberá mostrar al Superadministrador un dashboard de eficiencia operativa con las métricas recogidas | UR-101 |
| FR-242 | Ante un cobro por un importe superior al total de la factura, el sistema deberá asociar el movimiento a la factura, registrar la diferencia y señalarla como pendiente de revisión ("cobro excesivo") | UR-28 |
| FR-243 | Ante un rebote o un fallo de correo, el sistema deberá notificar al responsable asignado | UR-25 |
| FR-244 | Tras un fallo de envío, el sistema deberá permitir modificar los datos de contacto y reintentar el envío sin duplicar la factura | UR-25 |

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

## 5. Reglas de negocio

| ID | Regla |
|---|---|
| RB-01 | Una factura dispondrá de un ID único únicamente cuando haya alcanzado el estado de emitida. |
| RB-02 | Las facturas recurrentes se emitirán el día 1 de cada mes; la primera, en el mes de alta, se calcula por prorrateo desde el día de inicio de la relación, salvo excepción comercial aprobada (FR-12). |
| RB-03 | Los datos de empresas y facturas emitidas no se podrán eliminar definitivamente hasta transcurrido el plazo exigido por la legislación contable. |
| RB-04 | Toda excepción requerirá la aprobación de un usuario con rol Administrador o Superadministrador; las que superen el umbral configurado requerirán la de un Superadministrador. |
| RB-05 | La pausa de una suscripción detiene la generación de nuevas mensualidades recurrentes pero no cancela ni modifica los derechos de cobro de las facturas emitidas anteriormente que continúen impagadas |
| RB-06 | Las modificaciones en las tarifas o impuestos por defecto de los conceptos del catálogo de productos no afectarán de forma retroactiva a las facturas ni suscripciones previamente emitidas |
| RB-07 | La representación en PDF de una factura emitida es inalterable |
| RB-08 | Una deuda perdonada no puede ser clasificada ni contabilizada como "pagada", debiendo pasar explícitamente al estado "anulada" o "incobrable" |
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

## 6. Suposiciones y decisiones de análisis

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | Prorrateo calculado como la proporción exacta de días restantes del mes de alta respecto al total de días de dicho mes. | Garantiza un cálculo justo para el cliente. | FR-10, FR-11 |
| A-02 | Implementación mediante interfaz web responsiva multidispositivo. | Permite operar desde teléfonos móviles y tabletas sin requerir aplicaciones independientes. | NFR-17 |
| A-03 | Se adopta integración simulada para Stripe, WhatsApp y correo electrónico | Cumplir objetivos funcionales sin dependencia de contratos con proveedores reales de pago o mensajería | FR-41, FR-42, FR-49 |
| A-04 | La búsqueda de direcciones se resolverá mediante un componente de autocompletado estándar o servicio de mapas integrado. | Derivado de la nota "búsqueda de dirección". | FR-101 |
| A-05 | El tamaño máximo por archivo adjunto es de 10 MB | El cliente pidió un límite "razonable" sin concretarlo | NFR-25 |
| A-06 | La sesión se cierra tras 30 minutos de inactividad | El cliente pidió una expiración "razonable" | FR-129 |
| A-07 | Se bloquea el acceso 15 minutos tras 5 intentos fallidos de login | El cliente pidió protección básica sin convertirla en "un infierno de bloqueos" | FR-146 |
| A-08 | La lista de formatos permitidos es PDF, JPG/PNG, DOCX, XLSX y CSV | El cliente pidió limitar formatos sin concretarlos | FR-154 |
| A-09 | La regularización retroactiva la aprueba un administrador | El cliente pidió que fuera "explícita y aprobada" sin indicar quién | FR-160 |
| A-10 | Los criterios de detección de duplicados son nombre o razón social, identificador fiscal, email y teléfono | El cliente habló de duplicados "razonables" y citó el identificador fiscal | FR-142 |
| A-11 | El teléfono del contacto es el dato "conveniente" que puede faltar | Es el único ejemplo citado por el cliente | FR-162 |
| A-12 | Los límites de uso de la API quedan por definir | El cliente pidió límites "razonables" | FR-135 |
| A-13 | Los requisitos marcados como (opcional) son ampliaciones | El cliente los presentó como ampliaciones y no como parte del primer despliegue | FR-104, FR-105, FR-106, FR-107, FR-108, FR-149, FR-150, FR-151, FR-195, FR-206 |
| A-14 | La clasificación de facturas por proyecto o línea de negocio se considera opcional y no se implementa en el primer despliegue | El cliente dice "Si lo implementáis", no deja claro que sea un requisito. | FR-185 |
| A-15 | Los informes programados se envían como notificación con enlace autenticado, no como adjunto | El cliente planteó el adjunto y el enlace como alternativas y pidió cuidado con la información sensible | FR-216, FR-217 |
| A-16 | Se consideran opcionales los informes programados y las etiquetas | El cliente los presentó con «puede estar bien» y «pueden ayudarnos» | FR-215 a FR-217, FR-232, FR-233 |
| A-17 | Las cifras de los criterios de rendimiento y de uso (3 segundos, 5.000 clientes, 300 usuarios, 5 clics) son concreciones del equipo | El cliente pidió «prácticamente inmediato» y «pocos clics» sin dar cifras | NFR-13, NFR-14, NFR-34 |
| A-18 | Los enlaces de recuperación de contraseña caducan a las 24 horas de su emisión | No se concretó el plazo; se propone 24 horas | FR-82 |

## 7. Dudas, ambigüedades y cuestiones pendientes

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|
| Q-01 | Criterio exacto de umbrales económicos para aprobación de descuentos por el superadministrador | Transcripción ampliada | Configuración de flujos de aprobación | Pendiente de definición parametrizable |
| Q-02 | Calendario de festivos y días laborables exacto para el cálculo de vencimientos en diferentes países | Transcripción ampliada | Automatización de recordatorios | Resuelta: configuración basada en calendario configurable de España para fase inicial |
| Q-03 | ¿Cómo debe actuar exactamente el sistema ante un fallo en el envío masivo de correos de facturas de meses anteriores? ¿Debe reintentar de forma autónoma o registrar una alerta crítica en el informe? | Notas de notas de la app / informe de fallos | Alto para la fiabilidad de envíos | Pendiente |
| Q-04 | ¿Qué permisos específicos tendrán los empleados suplentes sobre los clientes asignados a compañeros ausentes? | Decisiones de equipo | Medio para la gestión de incidencias | Pendiente |
| Q-05 | Frases como: "datos ficticios para demos", "Observabilidad de emails y WhatsApp simulados." | Ampliación | FR-195. Tener que simular todo sistemas externos | Pendiente |
| Q-06 | ¿Qué plazos legales de conservación se aplican a cada tipo de dato? | Transcripción ampliada (Página 8) | RB-17, RB-18, FR-208 | Pendiente |
| Q-07 | ¿Un cambio de configuración afecta a facturas nuevas, a condiciones nuevas o a ambas? | Transcripción ampliada (Página 8) | FR-220 | Pendiente: el cliente dice «según definamos» |
| Q-08 | ¿Qué son las «políticas de automatización» que el superadministrador configura? | Transcripción ampliada (Página 8) | UR-103 | Pendiente |
| Q-09 | ¿Se necesita un entorno de prueba separado o basta con simular y previsualizar? | Transcripción ampliada (Página 8) | UR-104 | El cliente admite «al menos una forma de simular»; se cubre con simulación |
| Q-10 | ¿La reasignación de clientes requiere la aprobación de otro administrador? | Ampliación | FR-86, FR-87 | Pendiente |
| Q-11 | ¿Qué ocurre si el único Superadministrador es quien propone una excepción que supera el umbral, dado que nadie puede aprobar lo suyo? | Revisión del grupo | RB-04, UR-15 | Pendiente |
| Q-12 | ¿Qué estado debe tener una factura con un cobro superior a su total y qué se hace con el importe sobrante (devolución, saldo a favor, abono en la siguiente factura)? | Revisión del grupo | FR-242 | Pendiente: el cliente solo pide señalar la diferencia para revisión |

## 8. Trazabilidad

Asignación BR → UR → FR/NFR revisada UR por UR. Un UR puede colgar de más de un BR; los FR heredan los BR de su UR. Los NFR se asignan por su categoría (propuesta, pendiente de revisar por quien sea dueño de la trazabilidad).

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
|---|---|---|
| BR-01 | UR-05, UR-09, UR-17, UR-23, UR-33, UR-38, UR-49, UR-101 | FR-07, FR-08, FR-26, FR-15, FR-09, FR-10, FR-12, FR-34, FR-35, FR-36, FR-62, FR-63, FR-71, FR-72, FR-73, FR-74, FR-99, FR-45, FR-225, FR-226, FR-203, NFR-02, NFR-06, NFR-13, NFR-14, NFR-30, NFR-33, NFR-34, NFR-35, NFR-40, NFR-41, FR-241 |
| BR-02 | UR-61 | FR-130, FR-131, FR-132, FR-133, FR-134, FR-135, FR-136, FR-137, FR-138, NFR-01 |
| BR-03 | UR-06, UR-08, UR-12, UR-13, UR-14, UR-15, UR-16, UR-24, UR-27, UR-29, UR-39, UR-45, UR-46, UR-55, UR-59, UR-67, UR-78, UR-79, UR-80, UR-81, UR-82, UR-83, UR-103, UR-106 | FR-10, FR-11, FR-25, FR-26, FR-27, FR-19, FR-21, FR-20, FR-22, FR-23, FR-24, FR-37, FR-38, FR-161, FR-48, FR-39, FR-40, FR-75, FR-76, FR-90, FR-91, FR-92, FR-93, FR-94, FR-109, FR-110, FR-111, FR-112, FR-113, FR-128, FR-152, FR-153, FR-154, FR-167, FR-168, FR-169, FR-170, FR-171, FR-172, FR-218, FR-219, FR-220, FR-221, FR-228, FR-229, FR-230, FR-231, NFR-03, NFR-31, NFR-43 |
| BR-04 | UR-25, UR-32, UR-47, UR-53, UR-58, UR-62, UR-63, UR-70, UR-77, UR-94, UR-95, UR-99, UR-102, UR-104, UR-110 | FR-43, FR-44, FR-49, FR-50, FR-51, FR-95, FR-96, FR-155, FR-156, FR-124, FR-125, FR-126, FR-127, FR-190, FR-212, FR-213, FR-214, FR-139, FR-141, FR-140, FR-191, FR-192, FR-183, FR-184, FR-200, FR-201, FR-204, FR-210, FR-211, FR-222, FR-223, FR-224, NFR-15, NFR-22, NFR-36, FR-205, FR-206, FR-243, FR-244 |
| BR-05 | UR-36, UR-51, UR-56, UR-71, UR-84, UR-85, UR-86, UR-111 | FR-64, FR-65, FR-66, FR-67, FR-185, FR-103, FR-114, FR-115, FR-186, FR-215, FR-216, FR-217, FR-173, FR-174, FR-175 |
| BR-06 | UR-41, UR-48, UR-60, UR-75, UR-89, UR-90, UR-91, UR-100 | FR-81, FR-82, FR-97, FR-98, FR-129, FR-146, FR-147, FR-166, FR-207, FR-208, FR-209, FR-178, FR-179, FR-180, FR-202, NFR-05, NFR-07, NFR-08, NFR-09, NFR-10, NFR-11, NFR-12, NFR-25, NFR-26, NFR-28, NFR-32, NFR-37 |
| BR-07 | UR-10, UR-11, UR-35, UR-57, UR-65, UR-66, UR-72, UR-74, UR-103 | FR-18, FR-06, FR-59, FR-116, FR-117, FR-118, FR-119, FR-120, FR-121, FR-122, FR-123, FR-157, FR-158, FR-159, FR-160, FR-148, FR-149, FR-150, FR-151, FR-187, FR-195, FR-218, FR-219, FR-220, FR-221, NFR-19, NFR-20, NFR-21, NFR-23, NFR-24, NFR-27, NFR-29, NFR-38, NFR-39, NFR-44, NFR-45 |
| BR-08 | UR-37, UR-52, UR-68, UR-96, UR-97, UR-98, UR-105, UR-106 | FR-68, FR-69, FR-11, FR-70, FR-102, FR-164, FR-165, FR-197, FR-198, FR-199, FR-227, FR-228, FR-229, FR-230, FR-231, NFR-17, NFR-18, NFR-46 |
| BR-09 | UR-01, UR-02, UR-03, UR-04, UR-19, UR-54, UR-64, UR-108 | FR-01, FR-02, FR-03, FR-04, FR-196, FR-05, FR-13, FR-14, FR-104, FR-105, FR-106, FR-107, FR-108, FR-142, FR-143, FR-144, FR-145, FR-161, FR-162, FR-163, FR-101 |
| BR-10 | UR-20, UR-21, UR-22 | FR-28, FR-29, FR-30, FR-31, FR-32, FR-33 |
| BR-11 | UR-07, UR-18, UR-26, UR-28, UR-30, UR-31, UR-92, UR-93 | FR-16, FR-17, FR-100, FR-14, FR-47, FR-52, FR-53, FR-54, FR-55, FR-41, FR-42, FR-45, FR-46, FR-181, FR-182, FR-242 |
| BR-12 | UR-01, UR-73, UR-76, UR-87, UR-88 | FR-01, FR-188, FR-189, FR-176, FR-177, NFR-04, NFR-16, NFR-42 |
| BR-13 | UR-34, UR-40, UR-42, UR-43, UR-44, UR-50, UR-69, UR-107 | FR-56, FR-57, FR-58, FR-60, FR-61, FR-77, FR-78, FR-79, FR-80, FR-67, FR-83, FR-84, FR-85, FR-86, FR-87, FR-88, FR-89, FR-234, FR-235, FR-236, FR-237, FR-238, FR-194, FR-239, FR-240, FR-232, FR-233 |
| BR-14 | UR-109 | FR-193 |

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
| dashboard | Panel de control visual con métricas, números clave e indicadores financieros (facturado, cobrado, pendiente, vencido, previsión) y desglose hasta el detalle. Los administradores ven el global; el Lector, solo sus clientes asignados. |
| API | Interfaz de comunicación que permite a la aplicación interna interactuar de forma controlada y segura con otros sistemas externos o futuros (como Brain u otros agentes de IA) para consultar clientes, deudas o registrar solicitudes bajo las mismas reglas de negocio. |
| reporting | Proceso de consolidación y generación de informes de datos financieros o de gestión en el que, si intervienen monedas extranjeras, se convierten los importes a una moneda base usando un tipo de cambio registrado. |
| aprobador | Usuario (administrador o superadministrador) encargado de revisar, autorizar o rechazar solicitudes de operaciones económicas sensibles (como descuentos o cambios manuales de importe) a través de una bandeja de entrada. |
| claves de idempotencia | Mecanismo técnico o de interfaz utilizado en operaciones largas o críticas (emisión, envío, conciliación) para evitar que la acción se procese o ejecute dos veces al hacer doble clic o recargar la página. |
| NIF | Número de Identificación Fiscal utilizado para identificar unívocamente a los clientes y empresas. |
| Plantilla de comunicación | Formato de correo predefinido que incluye campos dinámicos para automatizar la relación con el cliente. |
| Incidencia | Seguimiento administrativo interno asociado a un cliente y, opcionalmente, a una factura. No es un sistema de tickets para clientes ni debe confundirse con el código de incidencia técnico de un error (FR-141). |
| Estado de factura | La factura tiene tres estados independientes: documental (borrador, pendiente de aprobación, emitida, rectificada), de cobro (pendiente, vencida, parcialmente conciliada, pagada, anulada, incobrable) y de envío (enviada, fallo de envío). Sobre el estado de cobro pueden superponerse las marcas «en disputa» y «cobro excesivo». |
