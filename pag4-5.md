Paginas 4 y 5
## 1.1 Objetivo del sistema
El objetivo es proporcionar una gestión, automatizada e inmutable de la facturación y los cobros de la empresa. El sistema busca controlar la relación comercial mediante el soporte de suscripciones dinámicas, la emisión automatizada de facturas (puntuales y recurrentes), la trazabilidad de notificaciones, y la automatización del flujo de recobros y conciliaciones bancarias o por pasarelas de pago, minimizando los errores humanos

## 1.2 Alcance
  # Dentro del alcance:
    · Control del estado de la relación comercial (pausas, bajas...)
    · Generación y emisión de facturas puntuales y recurrentes a partir de un catálogo de conceptos reutilizables
    · Generación y almacenamiento inalterable de los documentos en formato PDF
    · Envío automatizado y trazable de facturas vía correo electrónico o WhatsApp (simulado) con gestión automática de incidencias y rebotes
    · Programación y adaptación de recordatorios automáticos de impago con posibilidad de suspenderlos
    · Anulación de deudas incobrables mediante flujos de aprobación administrativa
    · Integración simulada con Stripe, Revolut y cuentas bancarias para la revisión automática, gestión de pagos parciales/excesivos y revisión manual de inconsistencias

  # Fuera del alcance:
    · Altas o bajas comerciales del producto principal
    · Integración real con pasarelas de pago o proveedores de mensajería
    · Consultoría o asesoría fiscal automatizada

  ## 1.3 Actores y partes interesadas
| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Superadministrador | Persona  con acceso a la configuración global del sistema | Configurar umbrales de aprobación, rangos y tarifas, series de numeración y recordatorios |
| Administrador | Empleado con permisos de gestión de operación, clientes, facturas, asignaciones y aprobaciones, sin acceso a la configuración global | Supervisar el estado del sistema, consultar el histórico de cualquier cliente, gestionar cambios de plan anuales, corregir errores con facturas rectificativas y gestionar el control de acceso |
| Lector | Empleado que trabaja sobre los clientes que tiene asignados | Realizar sus operaciones diarias, conocer el saldo y las facturas pendientes y pagadas de sus clientes y tener claro el estado real de los envíos |
| Sistema externo | Sistema de terceros o de Turbine (como Brain) que consume la API de la aplicación | Consultar deuda, facturas y clientes y solicitar bajas sin saltarse las reglas del sistema |
| Pasarela de pagos (Stripe simulado) | Servicio externo que notifica los cobros | Que los pagos se reflejen correctamente en las facturas, sin contabilizar dos veces el mismo evento |
| Planificador (tareas automáticas) | Disparador de procesos sin intervención humana | Generación mensual, recordatorios, campaña anual y caducidad de delegaciones |


## 2 Requisitos de negocio
|ID|Requisito|Fuente|
|---|---|---|
| BR-01 | Separar la rescisión de contrato de la gestión activa de deudas pendientes para garantizar la continuidad del recobro tras la baja | Entrevista página 4 |
| BR-02 | Garantizar la inmutabilidad legal e histórica de los documentos emitidos frente a cambios en la marca o en el catálogo | Entrevista página 4 |
| BR-03 | Optimizar la tasa de cobro mediante la automatización de notificaciones, seguimiento de impagos y conciliación bancaria inteligente | Entrevista página 4-5 |

## 3 Requisitos de usuario
|ID|Actor|Requisito|Fuente|
|---|---|---|---|
| UR-01 | Lector | Poder pausar temporalmente una suscripción indicando motivo y fechas, congelando la generación de mensualidades sin afectar a las facturas impagadas | Entrevista página 4 |
| UR-02 | Administrador | Poder recibir alertas de reactivación de suscripciones pausadas para confirmar la reanudación del cobro | Entrevista página 4 |
| UR-03 | Lector | Poder registrar la baja de un cliente deteniendo cobros futuros pero manteniendo el flujo de recobro sobre las deudas no saldadas | Entrevista página 4-5 |
| UR-04 | Lector | Poder consultar duplicados por identificador fiscal al dar de alta o reingresar clientes para reactivar expedientes históricos | Entrevista página 4-5 |
| UR-05 | Operador | Poder confeccionar facturas puntuales utilizando conceptos frecuentes de un catálogo ligero | Entrevista página 4-5 |
| UR-06 | Lector | Poder previsualizar la factura y disponer de bloqueos automáticos en caso de faltar datos fiscales antes de su emisión | Entrevista página 4-5 |
| UR-07 | Lector | Poder gestionar incidencias de envío de correo para corregir los datos de contacto y realizar reintentos sin emitir facturas duplicadas | Entrevista página 4-5 |
| UR-08 | Admin | Poder pausar el envío automático de recordatorios marcando facturas "en disputa" mientras se investiga una disconformidad | Entrevista página 4-5 |
| UR-09 | Admin | Poder dar de baja contable una deuda clasificándola como "anulada" o "incobrable" tras aprobación administrativa | Entrevista página 4-5 |
| UR-10 | Lector | Poder revisar en una bandeja de trabajo los movimientos bancarios o de pasarela no conciliados automáticamente o con importes parciales/excesivos | Entrevista página 4-5 | 


## 4.1 Requisitos funcionales
| ID | Requisito | Relacionado con |
|---|---|---| 
| FR-58 | El sistema deberá permitir pausar una suscripción activa registrando el motivo, la fecha de inicio y la fecha prevista de reactivación | UR-01 |
| FR-58b | Si una suscripción esta en pausa, el sistema deberá detener la generación de mensualidades sin alterar ni cancelar las facturas impagadas pendientes | UR-01 |
| FR-58c | Al alcanzarse la fecha prevista de reactivación de una suscripción, el sistema deberá notificar al responsable asignado para solicitar confirmación explícita antes de reanudar la facturación | UR-02 |
| FR-59 | El sistema deberá recibir o registrar solicitudes de baja comprobando la existencia de deudas pendientes | UR-03 |
| FR-59b | Si no hay deudas, el sistema cerrará la recurrencia comercial en la fecha efectiva | UR-03 |
| FR-59c | Si hay deudas, el sistema detendrá la generación de nuevas mensualidades a partir de la fecha de baja, pero mantendrá activo el flujo de cobro/recobro sobre las facturas pendientes anteriores | UR-03 |
| FR-60 | Al dar de alta o el reingreso de un cliente, el sistema deberá buscar coincidencias por identificador fiscal y avisar al usuario para permitir la reactivación de su ficha histórica | UR-04 |
| FR-61 | El sistema deberá permitir emitir facturas puntuales compuestas por múltiples líneas con concepto, cantidad, precio unitario, porcentaje de descuento y tipo de impuesto aplicable | UR-05 |
| FR-62 | El sistema permitirá administrar un catálogo de conceptos reutilizables con un precio orientativo y un impuesto asignado por defecto | UR-06 |
| FR-63 | El sistema deberá permitir ajustar la descripción y el precio al añadir un concepto del catálogo a una factura puntual. Los cambios posteriores en los elementos del catálogo no afectarán a las facturas ya emitidas | UR-06 |
| FR-64 | El sistema deberá ofrecer una vista previa de la factura antes de su emisión  | UR-07 |
| FR-64b | El sistema bloqueará automáticamente el envío de una factura si detecta que falta algún dato fiscal imprescindible, informando del dato que falta | UR-07 |
| FR-65 | El sistema deberá evaluar el importe total de la factura antes de emitirla y mostrar una advertencia al usuario si detecta que sale del patrón habitual del cliente | UR-07 |
| FR-66 | El sistema deberá generar la representación en PDF del documento incluyendo logo corporativo, tipografía, datos fiscales, numeración, fechas, desglose de líneas, bases, impuestos, totales, condiciones de pago y contacto de soporte | UR-08 |
| FR-67 | El sistema deberá almacenar la versión original del PDF emitido garantizando que las modificaciones futuras en los activos corporativos no alteren los documentos históricos | UR-08 |
| FR-68 | El sistema deberá enviar automáticamente la factura por correo electrónico al contacto de facturación en el momento de su emisión | UR-09 |
| FR-68b | El sistema permitirá la simulación del envío de facturas por WhatsApp únicamente para los contactos que dispongan de un número válido y hayan otorgado su consentimiento | UR-09 |
| FR-69 | El sistema deberá registrar cada intento de envío almacenando el canal utilizado, destinatario, fecha, hora y el resultado obtenido sea éxito o fallo | UR-10 |
| FR-70 | Ante un rebote o un fallo de correo, el sistema deberá marcar el fallo, generar una incidencia de entrega, notificar al responsable asignado y permitir modificar los datos de contacto para realizar reintentos sin duplicar la factura | UR-10 |
| FR-71 | El sistema enviará recordatorios automáticos según la cadencia configurada por el superadministrador | UR-11 |
| FR-71b | El sistema deberá adaptar el envío de avisos de impago respetando la fecha de vencimiento acordada específicamente con el cliente  sobre el valor por defecto | UR-11 |
| FR-72 | El sistema deberá permitir marcar una factura en estado "en disputa" o "seguimiento pausado", registrando un motivo y una fecha de revisión, para suspender temporalmente el envío de recordatorios automáticos | UR-12 |
| FR-73 | El sistema deberá permitir clasificar una deuda como "anulada" o "incobrable" si hay una previa aprobación administrativa y registro de motivo, evitando en todo momento catalogarla como "pagada" | UR-13 |
| FR-74 | El sistema deberá simular la recepción de eventos o notificaciones de pago externas de Stripe | UR-14 |
| FR-74b | El sistema debe permitir la consulta de transacciones | UR-14 |
| FR-75 | El sistema deberá identificar las notificaciones o eventos de pago duplicados recibidos por pasarelas externas para no contabilizar los cobros repetidamente | UR-14 |
| FR-76 | El sistema deberá procesar movimientos bancarios o de pasarelas (importe, fecha, moneda, concepto, referencia) y vincularlos automáticamente a la factura correspondiente si existe una coincidencia clara | UR-15 |
| FR-76b | El sistema deberá derivar los movimientos bancarios que carezcan de referencia clara o presenten dudas a una bandeja de revisión manual | UR-15 |
| FR-77 | Ante un cobro por un importe inferior o superior al total de la factura, el sistema deberá asociar el movimiento a la factura, registrar la diferencia y mantener la factura en estado "parcial" o "no saldada" | UR-15 |
| FR-78 | En caso de deshacer o revertir una conciliación previa, el sistema deberá conservar la traza histórica guardando quién o qué regla la realizó, quién la deshizo y la justificación dada | UR-16 |


## 4.2 Requisitos no funcionales
| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-13 | Fiabilidad | El sistema de notificaciones debe gestionar los reintentos tras errores de red o entrega sin provocar duplicidad en la generacion de documentos o cobros | Ante un error de red o de entrega, los reintentos automáticos o manuales del envío no generarán duplicados del documento ni duplicarán los registros de cobro asociados |
| NFR-14 | Eficiencia | La interfaz del catalogo de productos debe ofrecer una experiencia de usuario ligera y agil para la consulta y seleccion de conceptos frecuentes | La selección de un concepto del catálogo e inserción de la línea en una factura o suscripción se podrá realizar en menos de 3 clics |

## 5 Reglas de negocio
| ID | Regla |
|---|---|
| RB-01 | La pausa de una suscripción detiene la generación de nuevas mensualidades recurrentes pero no cancela ni modifica los derechos de cobro de las facturas emitidas anteriormente que continúen impagadas |
| RB-02 | Las modificaciones en las tarifas o impuestos por defecto de los conceptos del catálogo de productos no afectarán de forma retroactiva a las facturas ni suscripciones previamente emitidas |
| RB-03 | La representación en PDF de una factura emitida es inalterable |
| RB-04 | Una deuda perdonada no puede ser clasificada ni contabilizada como "pagada", debiendo pasar explícitamente al estado "anulada" o "incobrable" |
