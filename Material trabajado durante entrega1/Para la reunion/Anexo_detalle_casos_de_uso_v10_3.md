# Anexo — Detalle de cada requisito funcional para los casos de uso (v10.3)

Cada FR de la v10 es una capacidad. Aquí se conserva, sin perder nada, el detalle de la v9 que lo compone: pasos de interacción, condiciones y valores concretos. Sirve para redactar el flujo y las condiciones de cada caso de uso, o para convertirlos en reglas de negocio si el grupo lo prefiere.

Los UR no cambian de número: cada caso de uso parte del UR de siempre y se apoya en los FR de esta tabla.

## FR-01 — El sistema deberá permitir registrar y consultar los datos identificativos y fiscales de la empresa cliente.
*UR: UR-01, UR-02*

| FR v9 | Detalle |
|---|---|
| FR-01 | El sistema deberá registrar el nombre comercial, razón social, identificador fiscal, domicilio fiscal, país y moneda de trabajo de una empresa. |
| FR-02 | El sistema deberá mostrar los datos identificativos y fiscales registrados de una empresa. |

## FR-02 — El sistema deberá permitir gestionar los contactos de una empresa cliente.
*UR: UR-03*

| FR v9 | Detalle |
|---|---|
| FR-03 | El sistema deberá registrar múltiples personas de contacto vinculadas a una empresa. |
| FR-04 | El sistema deberá permitir marcar una persona de contacto como inactiva conservando intactos sus registros e historial contable asociado. |
| FR-196 | El sistema deberá impedir eliminar o inactivar el único contacto de facturación de un cliente activo, emitiendo una advertencia explícita |

## FR-03 — El sistema deberá registrar la relación comercial de una empresa.
*UR: UR-04*

| FR v9 | Detalle |
|---|---|
| FR-05 | El sistema deberá registrar la relación comercial de una empresa incluyendo fecha de inicio, servicio o plan, tarifa, responsable interno, condiciones de pago y documentos firmados. |

## FR-04 — El sistema deberá permitir crear facturas puntuales con varias líneas e impuestos aplicables seleccionados de los configurados.
*UR: UR-05, UR-11, UR-17, UR-23*

| FR v9 | Detalle |
|---|---|
| FR-06 | El sistema deberá permitir asignar los impuestos aplicables a una factura seleccionándolos de una lista de impuestos configurados. |
| FR-07 | El sistema deberá permitir crear facturas de modalidad puntual. |
| FR-34 | El sistema deberá permitir emitir facturas puntuales compuestas por múltiples líneas con concepto, cantidad, precio unitario, porcentaje de descuento y tipo de impuesto aplicable |

## FR-05 — El sistema deberá permitir configurar la facturación recurrente mensual de una relación comercial aprobada.
*UR: UR-05, UR-17*

| FR v9 | Detalle |
|---|---|
| FR-08 | El sistema deberá permitir configurar la facturación recurrente mensual vinculada a una relación comercial aprobada. |

## FR-06 — El sistema deberá generar automáticamente cada mes las facturas recurrentes, con prorrateo del primer mes salvo excepción comercial aprobada.
*UR: UR-06, UR-17, UR-105*

| FR v9 | Detalle |
|---|---|
| FR-09 | El sistema deberá generar automáticamente el día uno de cada mes las facturas recurrentes mensuales de las relaciones comerciales activas. |
| FR-10 | El sistema deberá calcular el importe cobrado equivalente a los días restantes del mes en curso para los contratos iniciados a mitad de mes. |
| FR-11 | El sistema deberá mostrar el importe prorrateado y la mensualidad normal antes de la confirmación final del alta. |
| FR-12 | El sistema deberá permitir registrar una excepción comercial explícita para aplazar el inicio de la facturación al mes siguiente sin cobrar prorrateo. |

## FR-07 — El sistema deberá permitir asignar una fecha de inicio futura a una relación comercial.
*UR: UR-18, UR-19*

| FR v9 | Detalle |
|---|---|
| FR-13 | El sistema deberá permitir asignar una fecha de inicio futura a una relación comercial manteniendo su estado como pendiente de activación. |
| FR-14 | El sistema no deberá generar facturas ni recordatorios de cobro antes de la fecha de inicio futura de una relación comercial. |

## FR-08 — El sistema deberá permitir programar la emisión automática de facturas para una fecha futura.
*UR: UR-09*

| FR v9 | Detalle |
|---|---|
| FR-15 | El sistema deberá permitir programar la emisión automática de facturas para una fecha futura. |

## FR-09 — El sistema deberá registrar el estado de cobro de cada factura y sus transiciones, y permitir listar y filtrar las facturas por estado.
*UR: UR-07, UR-18*

| FR v9 | Detalle |
|---|---|
| FR-16 | El sistema deberá registrar las transiciones de estado de cobro de cada factura (pendiente, vencida, parcialmente conciliada, pagada, anulada o incobrable). |
| FR-17 | El sistema deberá listar y filtrar las facturas emitidas según su estado de cobro. |

## FR-10 — El sistema deberá permitir configurar los rangos de facturación anual y sus tarifas sin modificar el código fuente.
*UR: UR-10*

| FR v9 | Detalle |
|---|---|
| FR-18 | El sistema deberá permitir al superadministrador configurar los rangos de facturación anual y sus tarifas sin modificar el código fuente. |

## FR-11 — El sistema deberá permitir proponer excepciones comerciales y gestionar su aprobación, dejando pendientes las facturas afectadas y registrando la decisión.
*UR: UR-12, UR-13, UR-14, UR-15*

| FR v9 | Detalle |
|---|---|
| FR-19 | El sistema deberá permitir registrar propuestas de excepciones comerciales (descuentos, meses gratuitos o precios especiales). |
| FR-21 | El sistema deberá suspender la emisión de facturas que incluyan modificaciones manuales de importe, descuentos, fechas excepcionales o importes que superen los umbrales, asignándolas a estado pendiente de aprobación. |
| FR-22 | El sistema deberá registrar la decisión de aprobación o rechazo emitida por el perfil autorizado sobre las facturas pendientes. |

## FR-12 — El sistema deberá permitir parametrizar los umbrales económicos y los niveles de aprobación de las excepciones comerciales.
*UR: UR-13, UR-14, UR-15*

| FR v9 | Detalle |
|---|---|
| FR-20 | El sistema deberá permitir parametrizar los umbrales económicos y niveles de aprobación requeridos para autorizar excepciones comerciales. |

## FR-13 — El sistema deberá permitir configurar las series de facturación y asignar un número correlativo único al emitir cada factura.
*UR: UR-16*

| FR v9 | Detalle |
|---|---|
| FR-23 | El sistema deberá permitir al superadministrador configurar las series de facturación. |
| FR-24 | El sistema deberá asignar un número definitivo único correlativo dentro de su serie únicamente en el momento de emitir la factura. |

## FR-14 — El sistema deberá permitir gestionar borradores de factura.
*UR: UR-05, UR-08, UR-16, UR-96*

| FR v9 | Detalle |
|---|---|
| FR-25 | El sistema no deberá consumir un número definitivo para facturas en estado de borrador. |
| FR-26 | El sistema deberá permitir modificar el contenido de una factura mientras permanezca en estado de borrador. |
| FR-27 | El sistema deberá permitir eliminar únicamente borradores de facturas que no hayan sido emitidas. |
| FR-197 | El sistema deberá autoguardar borradores periódicos durante redacción de facturas. |

## FR-15 — El sistema deberá permitir pausar una suscripción y avisar de su reactivación.
*UR: UR-20, UR-21*

| FR v9 | Detalle |
|---|---|
| FR-28 | El sistema deberá permitir pausar una suscripción activa registrando el motivo, la fecha de inicio y la fecha prevista de reactivación |
| FR-29 | Si una suscripción está en pausa, el sistema deberá detener la generación de mensualidades sin alterar ni cancelar las facturas impagadas pendientes |
| FR-30 | Al alcanzarse la fecha prevista de reactivación de una suscripción, el sistema deberá notificar al responsable asignado para solicitar confirmación explícita antes de reanudar la facturación |

## FR-16 — El sistema deberá permitir registrar la baja de un cliente.
*UR: UR-22*

| FR v9 | Detalle |
|---|---|
| FR-31 | El sistema deberá recibir o registrar solicitudes de baja comprobando la existencia de deudas pendientes |
| FR-32 | Si no hay deudas, el sistema deberá cerrar la recurrencia comercial en la fecha efectiva |
| FR-33 | Si hay deudas, el sistema deberá detener la generación de nuevas mensualidades a partir de la fecha de baja, y mantener activo el flujo de cobro/recobro sobre las facturas pendientes anteriores |

## FR-17 — El sistema deberá permitir administrar un catálogo de conceptos reutilizables y usarlos, con ajustes, en facturas puntuales sin afectar a las ya emitidas.
*UR: UR-23*

| FR v9 | Detalle |
|---|---|
| FR-35 | El sistema deberá permitir administrar un catálogo de conceptos reutilizables con un precio orientativo y un impuesto asignado por defecto |
| FR-36 | El sistema deberá permitir ajustar la descripción y el precio al añadir un concepto del catálogo a una factura puntual. Los cambios posteriores en los elementos del catálogo no deberán afectar a las facturas ya emitidas |

## FR-18 — El sistema deberá permitir validar y previsualizar una factura antes de emitirla.
*UR: UR-24, UR-64*

| FR v9 | Detalle |
|---|---|
| FR-37 | El sistema deberá ofrecer una vista previa de la factura antes de su emisión |
| FR-38 | El sistema deberá evaluar el importe total de la factura antes de emitirla y mostrar una advertencia al usuario si el importe se desvía más de un porcentaje configurable respecto a la media de las facturas anteriores del cliente, sin bloquear la emisión |
| FR-161 | El sistema deberá bloquear la emisión de una factura si falta un dato fiscal imprescindible, e indicar qué dato falta |

## FR-19 — El sistema deberá generar el PDF de cada factura emitida y conservar su versión original inalterable.
*UR: UR-29*

| FR v9 | Detalle |
|---|---|
| FR-39 | El sistema deberá generar la representación en PDF del documento incluyendo logo corporativo, tipografía, datos fiscales, numeración, fechas, desglose de líneas, bases, impuestos, totales, condiciones de pago y contacto de soporte |
| FR-40 | El sistema deberá almacenar la versión original del PDF emitido garantizando que las modificaciones futuras en los activos corporativos no alteren los documentos históricos |

## FR-20 — El sistema deberá enviar la factura emitida al contacto de facturación por correo electrónico o, de forma simulada, por WhatsApp.
*UR: UR-30*

| FR v9 | Detalle |
|---|---|
| FR-41 | El sistema deberá enviar automáticamente la factura por correo electrónico al contacto de facturación en el momento de su emisión |
| FR-42 | El sistema deberá permitir la simulación del envío de facturas por WhatsApp únicamente para los contactos que dispongan de un número válido y hayan otorgado su consentimiento |

## FR-21 — El sistema deberá permitir gestionar los fallos de envío de una factura y reintentar el envío.
*UR: UR-25*

| FR v9 | Detalle |
|---|---|
| FR-43 | El sistema deberá registrar cada intento de envío almacenando el canal utilizado, destinatario, fecha, hora y el resultado obtenido sea éxito o fallo |
| FR-44 | Ante un rebote o un fallo de correo, el sistema deberá marcar el envío como fallido y generar una incidencia de entrega |
| FR-243 | Ante un rebote o un fallo de correo, el sistema deberá notificar al responsable asignado |
| FR-244 | Tras un fallo de envío, el sistema deberá permitir modificar los datos de contacto y reintentar el envío sin duplicar la factura |

## FR-22 — El sistema deberá enviar recordatorios de pago automáticos según una cadencia configurable, respetando el vencimiento acordado con cada cliente.
*UR: UR-31, UR-49*

| FR v9 | Detalle |
|---|---|
| FR-45 | El sistema deberá enviar recordatorios automáticos según la cadencia configurada por el superadministrador |
| FR-46 | El sistema deberá adaptar el envío de avisos de impago respetando la fecha de vencimiento acordada específicamente con el cliente sobre el valor por defecto |

## FR-23 — El sistema deberá permitir marcar una factura como «en disputa», sin cambiar su estado de cobro, para suspender temporalmente sus recordatorios.
*UR: UR-26*

| FR v9 | Detalle |
|---|---|
| FR-47 | El sistema deberá permitir marcar una factura con la marca "en disputa", sin cambiar su estado de cobro, registrando un motivo y una fecha de revisión, para suspender temporalmente el envío de recordatorios automáticos |

## FR-24 — El sistema deberá permitir dar de baja contable una deuda como «anulada» o «incobrable» con aprobación administrativa y motivo, sin poder catalogarla como «pagada».
*UR: UR-27*

| FR v9 | Detalle |
|---|---|
| FR-48 | El sistema deberá permitir clasificar una deuda como "anulada" o "incobrable" si hay una previa aprobación administrativa y registro de motivo, evitando en todo momento catalogarla como "pagada" |

## FR-25 — El sistema deberá simular la recepción de eventos de pago de la pasarela, permitir consultar las transacciones y no contabilizar dos veces un mismo evento.
*UR: UR-32, UR-99*

| FR v9 | Detalle |
|---|---|
| FR-49 | El sistema deberá simular la recepción de eventos o notificaciones de pago externas de Stripe |
| FR-50 | El sistema deberá permitir la consulta de transacciones |
| FR-51 | El sistema deberá identificar las notificaciones o eventos de pago duplicados recibidos por pasarelas externas para no contabilizar los cobros repetidamente |
| FR-204 | El sistema deberá guardar de forma permanente los datos de confirmación de la pasarela de pago en la factura en cuanto esta cambie su estado a "pagada". |

## FR-26 — El sistema deberá conciliar los cobros recibidos con las facturas, derivando a revisión manual los casos que no se identifiquen con claridad.
*UR: UR-28*

| FR v9 | Detalle |
|---|---|
| FR-52 | El sistema deberá procesar movimientos bancarios o de pasarelas (importe, fecha, moneda, concepto, referencia) y vincularlos automáticamente a la factura correspondiente si la referencia coincide con una única factura |
| FR-53 | El sistema deberá derivar a una bandeja de revisión manual los movimientos cuya referencia no identifique con claridad una única factura (sin referencia o ambigua) |
| FR-54 | Ante un cobro por un importe inferior al total de la factura, el sistema deberá asociar el movimiento a la factura, registrar la diferencia y mantener la factura en estado "parcialmente conciliada" |
| FR-242 | Ante un cobro por un importe superior al total de la factura, el sistema deberá asociar el movimiento a la factura, registrar la diferencia y señalarla como pendiente de revisión ("cobro excesivo") |

## FR-27 — El sistema deberá permitir deshacer una conciliación conservando su traza.
*UR: UR-28*

| FR v9 | Detalle |
|---|---|
| FR-55 | En caso de deshacer o revertir una conciliación previa, el sistema deberá conservar la traza histórica guardando quién o qué regla la realizó, quién la deshizo y la justificación dada |

## FR-28 — El sistema deberá gestionar notificaciones internas por cliente: responsable asignado, bandeja, estado leída o resuelta y prioridad.
*UR: UR-34*

| FR v9 | Detalle |
|---|---|
| FR-56 | El sistema deberá gestionar notificaciones internas diferenciadas de los correos enviados a clientes |
| FR-57 | Cada cliente deberá tener un responsable interno asignado para recibir eventos relevantes (pago confirmado, factura vencida, rebote, disputa, revisión anual) |
| FR-58 | El sistema deberá ofrecer una bandeja global de notificaciones para administradores y bandeja específica para los Lectores |
| FR-60 | El sistema deberá permitir marcar una notificación como leída o como resuelta/atendida, distinguiendo ambos estados |
| FR-61 | Las notificaciones deberán incorporar una prioridad |

## FR-29 — El sistema deberá permitir configurar el canal de recepción de las notificaciones internas.
*UR: UR-35*

| FR v9 | Detalle |
|---|---|
| FR-59 | El sistema deberá permitir al superadministrador configurar el canal de recepción de notificaciones (in-app, email, resumen diario) |

## FR-30 — El sistema deberá ofrecer una pantalla de trabajo diario con las tareas y alertas pendientes y acceso directo al elemento afectado.
*UR: UR-33*

| FR v9 | Detalle |
|---|---|
| FR-62 | El sistema deberá ofrecer una pantalla de trabajo diario que muestre vencimientos, pagos pendientes de conciliación, problemas de entrega, aprobaciones pendientes y revisiones |
| FR-63 | El sistema deberá permitir al usuario saltar directamente desde la pantalla de trabajo diario al elemento afectado para resolverlo en pocos clics |

## FR-31 — El sistema deberá ofrecer un dashboard financiero con las cifras de facturación y cobro.
*UR: UR-36*

| FR v9 | Detalle |
|---|---|
| FR-64 | El sistema deberá ofrecer a los administradores un dashboard financiero con métricas de facturación, cobros, pendientes, vencidos, tiempo medio de cobro, ingresos recurrentes e historial |

## FR-32 — El sistema deberá generar informes financieros y operativos filtrables y exportables a CSV y PDF, respetando los permisos del usuario.
*UR: UR-36, UR-42*

| FR v9 | Detalle |
|---|---|
| FR-65 | Los informes financieros y operativos deberán poder filtrarse por periodo, cliente, responsable, país, sector, estado y tipo de factura |
| FR-66 | El sistema deberá permitir exportar los resultados de informes a formato CSV y PDF |
| FR-67 | Las exportaciones deberán respetar rigurosamente los permisos de acceso del usuario |

## FR-33 — El sistema deberá ofrecer una búsqueda global de clientes y facturas con filtros y vistas guardables.
*UR: UR-37*

| FR v9 | Detalle |
|---|---|
| FR-68 | El sistema deberá proporcionar una búsqueda global por nombre comercial, razón social, NIF, persona de contacto, número de factura y correo |
| FR-69 | El sistema deberá mantener y aplicar filtros de ubicación, sector comercial, estado de pago y fechas |
| FR-70 | El sistema deberá permitir guardar filtros y vistas frecuentes de trabajo |

## FR-34 — El sistema deberá permitir importar clientes desde un fichero CSV.
*UR: UR-38*

| FR v9 | Detalle |
|---|---|
| FR-71 | El sistema deberá permitir importar clientes desde ficheros CSV con previsualización previa |
| FR-72 | En la importación de CSV, el usuario deberá poder mapear columnas, revisar errores y decidir si importa filas válidas o corrige el fichero |
| FR-73 | El sistema deberá alertar si detecta NIFs duplicados durante la importación |
| FR-74 | La importación completa deberá registrarse como operación con resumen de registros creados, actualizados y rechazados |

## FR-35 — El sistema deberá permitir importar el histórico de facturas como migración, sin enviar emails ni consumir numeración oficial.
*UR: UR-39*

| FR v9 | Detalle |
|---|---|
| FR-75 | El sistema deberá permitir la importación administrativa de histórico de facturas, separada de la emisión ordinaria |
| FR-76 | Las facturas históricas importadas no deberán disparar emails ni consumir numeración oficial, quedando marcadas como migradas |

## FR-36 — El sistema deberá permitir el acceso de los usuarios internos con credenciales corporativas, sin autorregistro.
*UR: UR-40*

| FR v9 | Detalle |
|---|---|
| FR-77 | El acceso de usuarios internos deberá realizarse mediante correo y contraseña del dominio corporativo autorizado |
| FR-78 | El sistema deberá prohibir estrictamente el autorregistro de usuarios |

## FR-37 — El sistema deberá permitir crear o invitar usuarios internos y desactivarlos preservando el rastro de sus acciones.
*UR: UR-40*

| FR v9 | Detalle |
|---|---|
| FR-79 | El superadministrador o administrador con permisos deberá poder crear o invitar usuarios internos |
| FR-80 | El sistema deberá permitir desactivar cuentas de usuarios que abandonen la empresa preservando el rastro de sus acciones |

## FR-38 — El sistema deberá permitir recuperar la contraseña mediante un enlace temporal con caducidad.
*UR: UR-41*

| FR v9 | Detalle |
|---|---|
| FR-81 | El sistema deberá permitir la recuperación de contraseñas |
| FR-82 | Los enlaces de recuperación de contraseña deberán caducar a las 24 horas de su emisión (supuesto A-18) |

## FR-39 — El sistema deberá distinguir los roles de superadministrador, administrador y lector, limitando al lector a las operaciones sobre sus clientes asignados.
*UR: UR-42*

| FR v9 | Detalle |
|---|---|
| FR-83 | El sistema deberá distinguir roles de superadministrador, administrador y lector |
| FR-84 | El Lector deberá poder gestionar información operativa, crear facturas autorizadas y seguir cobros de sus clientes asignados |
| FR-85 | El Lector no deberá poder autoasignarse clientes, modificar tarifas globales, crear series ni ver el dashboard financiero global |

## FR-40 — El sistema deberá permitir asignar, desasignar y reasignar clientes a los usuarios, trasladando al nuevo responsable las tareas pendientes y el histórico.
*UR: UR-43*

| FR v9 | Detalle |
|---|---|
| FR-86 | El administrador deberá poder asignar y desasignar clientes a los usuarios |
| FR-87 | Al reasignar un cliente, el nuevo responsable deberá heredar tareas pendientes manteniendo el histórico de acciones |

## FR-41 — El sistema deberá permitir delegar temporalmente los clientes de un usuario en un suplente, con caducidad automática.
*UR: UR-44*

| FR v9 | Detalle |
|---|---|
| FR-88 | El administrador deberá poder delegar temporalmente los clientes de un usuario a un suplente durante un intervalo |
| FR-89 | Las delegaciones temporales deberán caducar automáticamente al finalizar el intervalo |

## FR-42 — El sistema deberá evitar sobrescrituras por edición concurrente y mantener la consistencia de las operaciones monetarias críticas.
*UR: UR-45*

| FR v9 | Detalle |
|---|---|
| FR-90 | El sistema deberá detectar conflictos de edición concurrente en facturas para evitar sobrescrituras silenciosas |
| FR-91 | Las operaciones monetarias críticas, numeración y conciliación deberán mantener consistencia ante accesos concurrentes |

## FR-43 — El sistema deberá registrar una auditoría de negocio inalterable de las operaciones clave y permitir al superadministrador consultarla y filtrarla.
*UR: UR-46*

| FR v9 | Detalle |
|---|---|
| FR-92 | El sistema deberá registrar un log de auditoría de negocio detallado para operaciones clave (creación de clientes, cambios fiscales, emisión, descuentos, reasignaciones, disputas, conciliaciones) |
| FR-93 | Los registros de auditoría no deberán ser editables por usuarios normales |
| FR-94 | El superadministrador deberá poder consultar y filtrar la auditoría sin poder reescribirla |

## FR-44 — El sistema deberá realizar copias de seguridad automáticas de datos y documentos y permitir su restauración.
*UR: UR-47*

| FR v9 | Detalle |
|---|---|
| FR-95 | El sistema deberá realizar copias de seguridad automáticas de datos y documentos con política definida |
| FR-96 | El sistema deberá permitir restaurar las copias de seguridad |

## FR-45 — El sistema deberá permitir descargar documentos solo a los usuarios autorizados, con enlaces temporales que caducan.
*UR: UR-48*

| FR v9 | Detalle |
|---|---|
| FR-97 | Un usuario autenticado solo deberá poder descargar documentos autorizados |
| FR-98 | Los enlaces temporales de descarga de documentos deberán caducar |

## FR-46 — El sistema deberá permitir generar y enviar facturas y recordatorios mediante plantillas editables.
*UR: UR-49*

| FR v9 | Detalle |
|---|---|
| FR-99 | El sistema deberá completar automáticamente en las plantillas de comunicación las variables: nombre de empresa, número de factura, importe y fecha de vencimiento |
| FR-225 | El sistema deberá disponer de plantillas editables, por quien tenga permiso, para factura, recordatorio previo, vencimiento, impago, disputa resuelta y revisión de datos |
| FR-226 | El sistema deberá registrar qué plantilla se utilizó en cada envío |

## FR-47 — El sistema deberá mantener un historial de versiones de los registros y documentos modificados.
*UR: UR-07*

| FR v9 | Detalle |
|---|---|
| FR-100 | El sistema deberá mantener un historial de versiones para los registros y documentos modificados |

## FR-48 — El sistema deberá incluir una funcionalidad integrada de búsqueda de direcciones.
*UR: UR-108*

| FR v9 | Detalle |
|---|---|
| FR-101 | El sistema deberá incluir una funcionalidad integrada de búsqueda de direcciones |

## FR-49 — El sistema deberá funcionar correctamente con el zoom del navegador ampliado.
*UR: UR-52*

| FR v9 | Detalle |
|---|---|
| FR-102 | El sistema deberá funcionar con el zoom del navegador ampliado sin perder funcionalidad |

## FR-50 — El sistema deberá generar informes específicos de la aplicación y resúmenes semanales y mensuales.
*UR: UR-51*

| FR v9 | Detalle |
|---|---|
| FR-103 | El sistema deberá generar informes específicos de la aplicación (con detalle de facturas que fallaron en meses anteriores) y resúmenes periódicos semanales y mensuales |

## FR-51 — El sistema deberá permitir gestionar presupuestos (opcional).
*UR: UR-54*

| FR v9 | Detalle |
|---|---|
| FR-104 | El sistema deberá generar presupuestos (opcional) |
| FR-105 | El sistema deberá permitir enviar el presupuesto al cliente (opcional) |
| FR-106 | Un usuario con permiso deberá poder marcar un presupuesto como aceptado o rechazado (opcional) |
| FR-107 | El sistema deberá permitir adjuntar al presupuesto la evidencia de la aceptación (opcional) |
| FR-108 | Si el presupuesto está aceptado, el sistema deberá convertirlo en factura reutilizando las líneas (opcional) |

## FR-52 — El sistema deberá permitir generar una factura rectificativa vinculada a la factura original y recalcular el saldo del cliente.
*UR: UR-55*

| FR v9 | Detalle |
|---|---|
| FR-109 | El sistema no deberá permitir que se modifiquen facturas emitidas |
| FR-110 | En caso de error en una factura emitida, un administrador deberá poder generar una factura rectificativa vinculada a la factura original |
| FR-111 | Si el importe de la rectificativa supera el umbral configurado, esta deberá ser aprobada antes de emitirse |
| FR-112 | El sistema deberá proponer los datos a rectificar a partir de la factura original |
| FR-113 | El sistema deberá recalcular el saldo del cliente a través de la factura rectificativa |

## FR-53 — El sistema deberá ofrecer un dashboard con el saldo y las facturas pendientes y pagadas de los clientes asignados al usuario, con acceso al detalle de cada cifra.
*UR: UR-56*

| FR v9 | Detalle |
|---|---|
| FR-114 | El sistema deberá generar un dashboard que muestre el saldo, las facturas pendientes y las facturas pagadas de los clientes asignados al usuario. |
| FR-115 | El sistema deberá permitir consultar el detalle de los registros que componen cada cifra del dashboard. |

## FR-54 — El sistema deberá gestionar la campaña anual de revisión de planes: listar los clientes a revisar y obtener y registrar su facturación anual.
*UR: UR-57*

| FR v9 | Detalle |
|---|---|
| FR-116 | El sistema deberá iniciar a principios de cada año una campaña de revisión que lista los clientes cuya facturación anual deberá revisarse |
| FR-117 | El sistema deberá obtener la facturación anual de una fuente simulada o de entrada manual |
| FR-118 | El sistema deberá registrar la fuente y la fecha de cada dato de facturación anual |
| FR-119 | Si el dato de facturación anual no está disponible, el sistema deberá dejar la revisión en estado pendiente |

## FR-55 — El sistema deberá proponer el rango de facturación que corresponde a cada cliente y aplicar el cambio de plan tras su verificación.
*UR: UR-57*

| FR v9 | Detalle |
|---|---|
| FR-120 | El sistema deberá proponer el rango de facturación que corresponda según el importe anual registrado y las reglas de asignación de rangos configuradas. |
| FR-121 | En caso de propuesta de cambio de plan, el administrador deberá verificar la propuesta de nuevo rango |
| FR-122 | Si el cambio de plan es válido, el sistema deberá aplicar el nuevo precio a partir de una fecha de efecto |
| FR-123 | El sistema deberá registrar quién aprobó el cambio de plan, cuándo, y el precio anterior y el nuevo |

## FR-56 — El sistema deberá mostrar el estado del sistema: emails pendientes, errores de integración, último backup y última generación recurrente.
*UR: UR-58*

| FR v9 | Detalle |
|---|---|
| FR-124 | El sistema deberá mostrar el número de emails pendientes de envío |
| FR-125 | El sistema deberá mostrar los errores de integración, ordenados del más reciente al más antiguo |
| FR-126 | El sistema deberá mostrar la fecha y el resultado del último backup realizado |
| FR-127 | El sistema deberá mostrar la última ejecución de la generación recurrente |

## FR-57 — El sistema deberá mostrar el historial de cada cliente.
*UR: UR-59*

| FR v9 | Detalle |
|---|---|
| FR-128 | El sistema deberá mostrar el historial de cada cliente (alta, cambio de responsables, cambios de tarifa, facturas emitidas, pagos, incidencias, pausas, baja, reactivación) |

## FR-58 — El sistema deberá gestionar las sesiones de los usuarios autenticados.
*UR: UR-60*

| FR v9 | Detalle |
|---|---|
| FR-129 | El sistema deberá cerrar sesión automáticamente tras 30 minutos de inactividad |
| FR-146 | Tras 5 intentos fallidos de login consecutivos, el sistema deberá bloquear temporalmente el acceso del usuario durante 15 minutos |
| FR-147 | El sistema deberá invalidar la sesión de un usuario desactivado por un administrador |

## FR-59 — El sistema deberá exponer una API para que sistemas externos consulten clientes, estado de deuda, facturas y obligaciones pendientes.
*UR: UR-61*

| FR v9 | Detalle |
|---|---|
| FR-130 | El sistema deberá exponer una API que permita a sistemas externos consultar clientes, estado de deuda y facturas |
| FR-138 | El sistema deberá permitir consultar, a partir de un identificador de cliente, si existen obligaciones pendientes y el detalle mínimo autorizado |

## FR-60 — El sistema deberá permitir que sistemas externos envíen solicitudes controladas.
*UR: UR-61*

| FR v9 | Detalle |
|---|---|
| FR-131 | La API deberá permitir crear solicitudes controladas |
| FR-132 | Las solicitudes controladas deberán pasar por validación o aprobación y no deberán modificar datos directamente |
| FR-133 | La API deberá aplicar las mismas reglas de negocio y validaciones que la interfaz |
| FR-137 | El sistema deberá recibir solicitudes de baja y crear la tarea 'darse de baja' sin eliminar directamente la recurrencia |

## FR-61 — El sistema deberá limitar las solicitudes de cada consumidor de la API y registrar sus llamadas importantes.
*UR: UR-61*

| FR v9 | Detalle |
|---|---|
| FR-134 | Las credenciales de un consumidor de la API no deberán permitir acceder a la interfaz de usuario, ni las de un usuario acceder a la API |
| FR-135 | El sistema deberá limitar el número de solicitudes que cada consumidor de la API puede realizar durante un intervalo de tiempo, según los límites configurados. |
| FR-136 | El sistema deberá registrar las llamadas importantes a la API (quién la hizo, cuándo y qué operación) |

## FR-62 — El sistema deberá registrar los errores técnicos con un código de incidencia que permita correlacionarlos.
*UR: UR-62*

| FR v9 | Detalle |
|---|---|
| FR-139 | El sistema deberá registrar los errores en logs técnicos |
| FR-141 | El sistema deberá generar un código de incidencia que permita correlacionar el error |

## FR-63 — El sistema no deberá mostrar al usuario final información técnica de los errores.
*UR: UR-63*

| FR v9 | Detalle |
|---|---|
| FR-140 | El sistema no deberá mostrar al usuario final información técnica del error (trazas, mensajes internos, rutas del servidor) |

## FR-64 — El sistema deberá permitir dar de alta clientes validando sus datos.
*UR: UR-64*

| FR v9 | Detalle |
|---|---|
| FR-142 | Antes de dar de alta a un cliente, el sistema deberá buscar duplicados: coincidencias en nombre o razón social, mismo identificador fiscal, mismo email o teléfono |
| FR-143 | Si encuentra duplicados, el sistema deberá mostrárselos al usuario, para que decida si crear un nuevo cliente o usar el existente |
| FR-144 | El sistema deberá validar el formato de email |
| FR-145 | El sistema deberá validar el identificador fiscal siempre que el país sea conocido (NIF/CIF en España o VAT). Si no se conoce, la validación deberá quedar pendiente |
| FR-163 | El sistema deberá eliminar los espacios sobrantes de los datos introducidos (nombre, razón social, email e identificador fiscal) |

## FR-65 — El sistema deberá permitir guardar los datos fiscales del emisor como configuración.
*UR: UR-65*

| FR v9 | Detalle |
|---|---|
| FR-148 | El sistema deberá guardar los datos fiscales del emisor como configuración |

## FR-66 — El sistema deberá permitir trabajar con varias entidades emisoras y elegir con cuál se emite cada factura (opcional).
*UR: UR-65, UR-66*

| FR v9 | Detalle |
|---|---|
| FR-149 | El sistema deberá permitir tener varias entidades emisoras (opcional) |
| FR-150 | El sistema deberá identificar a cada entidad con series de numeración (opcional) |
| FR-151 | Al emitir una factura, un usuario con permiso deberá poder seleccionar la entidad emisora correspondiente (opcional) |

## FR-67 — El sistema deberá permitir adjuntar documentos de tipos y formatos permitidos a clientes y facturas.
*UR: UR-67*

| FR v9 | Detalle |
|---|---|
| FR-152 | El sistema deberá permitir adjuntar documentos a clientes y facturas, además del PDF que genera el sistema |
| FR-153 | Cada adjunto deberá tener un tipo (pedido del cliente, presupuesto aceptado, justificante de pago, documento de la gestoría, otro) y una descripción |
| FR-154 | El sistema deberá admitir solo formatos de una lista permitida: PDF, JPG/PNG, DOCX, XLSX y CSV. Los ejecutables y scripts (.exe, .bat, .js…) se deberán rechazar |

## FR-68 — El sistema deberá mostrar al usuario el fallo de creación de una factura y el estado de envío de una factura, distinguiéndolos.
*UR: UR-53*

| FR v9 | Detalle |
|---|---|
| FR-155 | El sistema deberá mostrar al usuario el fallo de creación de una factura y su causa |
| FR-156 | El sistema deberá registrar y mostrar al usuario el estado de envío de una factura (enviada o fallo de envío), distinto del estado de cada mensaje (FR-192) |

## FR-69 — El sistema deberá permitir corregir los datos de una revisión anual, calculando el impacto y exigiendo aprobación expresa para toda regularización retroactiva.
*UR: UR-57*

| FR v9 | Detalle |
|---|---|
| FR-157 | En caso de descubrir que un dato de una revisión anual era incorrecto, el sistema deberá permitir corregir la ficha de revisión, registrando la corrección |
| FR-158 | El sistema deberá calcular el impacto potencial de la corrección sobre el precio de los meses afectados |
| FR-159 | El sistema no deberá emitir facturas retroactivas automáticamente |
| FR-160 | Toda regularización retroactiva deberá requerir una acción explícita y la aprobación de un administrador |

## FR-70 — El sistema deberá permitir guardar un cliente con datos no imprescindibles pendientes como excepción controlada, registrando qué datos faltan.
*UR: UR-64*

| FR v9 | Detalle |
|---|---|
| FR-162 | El sistema deberá permitir guardar un cliente sin los datos convenientes (el teléfono del contacto) como excepción controlada, y registrar qué datos faltan |

## FR-71 — El sistema deberá permitir marcar clientes como favoritos y mostrar los consultados recientemente.
*UR: UR-68*

| FR v9 | Detalle |
|---|---|
| FR-164 | El sistema deberá permitir marcar clientes como favoritos |
| FR-165 | El sistema deberá mostrar los clientes consultados recientemente |

## FR-72 — El sistema deberá comprobar los permisos del usuario en cada acceso a un cliente o a una factura, incluso mediante URL directa.
*UR: UR-60*

| FR v9 | Detalle |
|---|---|
| FR-166 | El sistema deberá comprobar los permisos del usuario en cada acceso a un cliente o a una factura, aunque se acceda mediante una URL directa, y rechazar el acceso si no le corresponde |

## FR-73 — El sistema deberá permitir al solicitante consultar el estado de sus solicitudes económicas y el comentario del aprobador.
*UR: UR-78, UR-79*

| FR v9 | Detalle |
|---|---|
| FR-167 | El sistema deberá disponer de una bandeja de entrada donde el solicitante consulte el estado de sus solicitudes económicas. |
| FR-168 | El sistema deberá incluir y mostrar el comentario explícito registrado por el aprobador al autorizar o rechazar una solicitud. |

## FR-74 — El sistema deberá impedir que un usuario apruebe sus propias solicitudes sensibles.
*UR: UR-80*

| FR v9 | Detalle |
|---|---|
| FR-169 | El sistema deberá validar e impedir que el usuario solicitante sea el mismo que apruebe operaciones económicas sensibles. |

## FR-75 — El sistema deberá permitir cerrar un mes o trimestre contable y bloquear la modificación ordinaria de lo económico en un periodo cerrado.
*UR: UR-81, UR-82*

| FR v9 | Detalle |
|---|---|
| FR-170 | El sistema deberá permitir a un administrador autorizado ejecutar el cierre administrativo de un mes o trimestre. |
| FR-171 | El sistema deberá bloquear la modificación, creación o borrado ordinario de elementos económicos dentro de un periodo cerrado. |

## FR-76 — El sistema deberá permitir reabrir un periodo cerrado solo al superadministrador y con un motivo obligatorio.
*UR: UR-83*

| FR v9 | Detalle |
|---|---|
| FR-172 | El sistema deberá requerir permisos superiores (Superadministrador) y la justificación obligatoria de un motivo para reabrir un periodo cerrado. |

## FR-77 — El sistema deberá permitir generar el paquete contable de un periodo y consultar quién y cuándo lo generó y de qué versión es.
*UR: UR-84, UR-85, UR-86*

| FR v9 | Detalle |
|---|---|
| FR-173 | El sistema deberá recopilar y empaquetar automáticamente en un archivo ZIP/CSV las facturas emitidas, rectificativas, cobros y sus correspondientes PDF del periodo seleccionado. |
| FR-174 | El sistema deberá registrar la trazabilidad de la generación del paquete, incluyendo fecha/hora, usuario y el periodo exacto que cubre. |
| FR-175 | El sistema deberá asignar e identificar un número de versión distinto cada vez que se vuelva a generar el paquete contable de un mismo periodo. |

## FR-78 — El sistema deberá registrar por contacto el idioma, el canal preferido y el consentimiento de envío de cada canal.
*UR: UR-87, UR-88, UR-89*

| FR v9 | Detalle |
|---|---|
| FR-176 | El sistema deberá almacenar el idioma preferido de comunicación asignado a cada contacto del cliente. |
| FR-177 | El sistema deberá registrar el canal de comunicación preferido para la entrega de notificaciones del contacto. |
| FR-178 | El sistema deberá gestionar y verificar el consentimiento explícito individual para cada canal de envío. |

## FR-79 — El sistema deberá auditar cada exportación masiva e incrustar en el fichero exportado los datos de trazabilidad.
*UR: UR-90, UR-91*

| FR v9 | Detalle |
|---|---|
| FR-179 | El sistema deberá registrar automáticamente en el log de auditoría cada exportación masiva realizada, capturando usuario, fecha/hora y los filtros de búsqueda aplicados. |
| FR-180 | El sistema deberá incrustar en el archivo exportado los metadatos o referencias de trazabilidad (usuario generador, marca de tiempo y filtros utilizados). |

## FR-80 — El sistema deberá emitir alertas configurables sobre facturas vencidas, deuda de cliente, fallos repetidos de envío y revisiones sin gestionar.
*UR: UR-92, UR-93, UR-94, UR-95*

| FR v9 | Detalle |
|---|---|
| FR-181 | El sistema deberá permitir configurar y emitir una alerta cuando una factura permanezca en estado vencido más de días parametrizables. |
| FR-182 | El sistema deberá emitir una alerta cuando el saldo de deuda acumulada de un cliente supere un umbral determinado. |
| FR-183 | El sistema deberá detectar y notificar la acumulación de más de 3 fallos consecutivos en el envío de comunicaciones a un cliente. |
| FR-184 | El sistema deberá emitir una alerta cuando una revisión o incidencia anual permanezca sin resolver tras transcurrir una semana. |

## FR-81 — El sistema deberá permitir clasificar las facturas por proyecto o línea de negocio con categorías administrables (opcional).
*UR: UR-107*

| FR v9 | Detalle |
|---|---|
| FR-185 | El sistema deberá clasificar facturas por proyecto o línea de negocio con categorías administrables cuyo renombrado no destruya el histórico (opcional) |

## FR-82 — El sistema deberá permitir fijar objetivos mensuales y anuales de facturación y cobro, con histórico de cambios.
*UR: UR-71*

| FR v9 | Detalle |
|---|---|
| FR-186 | El sistema deberá controlar objetivos mensual/anual de facturación y cobro, informativos y con histórico de cambios para no falsear comparaciones con otros anteriores |

## FR-83 — El sistema deberá permitir trasladar al siguiente día laborable las comunicaciones que caigan en fin de semana o festivo, según un calendario laboral.
*UR: UR-72*

| FR v9 | Detalle |
|---|---|
| FR-187 | El sistema deberá permitir mover una comunicación o recordatorio que cae en fin de semana o festivo al siguiente día laborable, según un calendario laboral |

## FR-84 — El sistema deberá emitir cada factura en una moneda concreta conservando su importe original.
*UR: UR-73*

| FR v9 | Detalle |
|---|---|
| FR-188 | El sistema deberá emitir cada factura en una moneda concreta y conservar su importe original |

## FR-85 — El sistema deberá convertir importes a una moneda base para informes con un tipo de cambio registrado, sin alterar el total legal de la factura.
*UR: UR-76*

| FR v9 | Detalle |
|---|---|
| FR-189 | El sistema deberá convertir importes a una moneda base para reporting con un tipo de cambio registrado, sin alterar nunca el total legal de la factura |

## FR-86 — El sistema deberá ejecutar las tareas largas en segundo plano, con estado, aunque el usuario cierre la pestaña.
*UR: UR-58*

| FR v9 | Detalle |
|---|---|
| FR-190 | El sistema deberá ejecutar las tareas largas en segundo plano con estado (pendiente, procesando, completado, completado con errores) y mantenerlas aunque el usuario cierre la pestaña |

## FR-87 — El sistema deberá impedir duplicados por doble clic o reintento en emisión, envío y conciliación.
*UR: UR-70*

| FR v9 | Detalle |
|---|---|
| FR-191 | El sistema deberá impedir duplicados por doble clic o reintento en emisión, envío y conciliación, mostrando un aviso de que la operación ya se está procesando |

## FR-88 — El sistema deberá mostrar el estado de entrega de cada mensaje enviado.
*UR: UR-77*

| FR v9 | Detalle |
|---|---|
| FR-192 | El sistema deberá mostrar el estado de cada mensaje (en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado) |

## FR-89 — El sistema deberá distinguir las comunicaciones operativas de facturación de las campañas comerciales, sin reutilizar automáticamente datos de facturación para marketing.
*UR: UR-109*

| FR v9 | Detalle |
|---|---|
| FR-193 | El sistema deberá distinguir comunicaciones operativas de facturación de campañas comerciales y no deberá reutilizar automáticamente datos de facturación para marketing |

## FR-90 — El sistema deberá permitir comentar internamente en clientes, facturas e incidencias.
*UR: UR-69*

| FR v9 | Detalle |
|---|---|
| FR-194 | El sistema deberá soportar dos niveles de visibilidad en comentarios: ordinario y nota restringida solo para administradores |
| FR-239 | El sistema deberá permitir mencionar a otro usuario en un comentario y generarle una notificación |
| FR-240 | El sistema no deberá enviar los comentarios internos al cliente |

## FR-91 — El sistema deberá cargarse con datos ficticios para demostraciones (opcional).
*UR: UR-74*

| FR v9 | Detalle |
|---|---|
| FR-195 | El sistema deberá cargarse con datos ficticios para demos, sin mezclarlos con producción (opcional) |

## FR-92 — El sistema deberá permitir deshacer acciones que no tengan inmutabilidad legal.
*UR: UR-97*

| FR v9 | Detalle |
|---|---|
| FR-198 | El sistema deberá permitir deshacer acciones que no tengan inmutabilidad legal. |

## FR-93 — El sistema deberá exigir confirmación explícita antes de ejecutar borrados, informando de que no podrán restaurarse.
*UR: UR-98*

| FR v9 | Detalle |
|---|---|
| FR-199 | El sistema deberá requerir una confirmación explícita informando de la imposibilidad de restauración antes de ejecutar borrados. |

## FR-94 — El sistema deberá notificar al responsable los fallos de procesos de cobro y aislar a los clientes con error sin detener el resto.
*UR: UR-99*

| FR v9 | Detalle |
|---|---|
| FR-200 | El sistema deberá notificar al empleado responsable ante la interrupción en el envío o proceso de validación de una factura. |
| FR-201 | El sistema deberá aislar y excluir a los clientes que generen errores de procesamiento, prosiguiendo con el procesamiento del resto de clientes. |

## FR-95 — El sistema deberá eliminar los archivos exportados temporales al superar su tiempo de caducidad.
*UR: UR-100*

| FR v9 | Detalle |
|---|---|
| FR-202 | El sistema deberá eliminar del servidor los archivos exportados temporalmente una vez superado su tiempo de caducidad. |

## FR-96 — El sistema deberá recopilar de forma anónima métricas de uso y mostrar al superadministrador un dashboard de eficiencia operativa.
*UR: UR-101*

| FR v9 | Detalle |
|---|---|
| FR-203 | El sistema deberá recopilar el tiempo invertido en generar acciones críticas, los fallos devueltos por el sistema y el conteo de clics de los usuarios de forma anónima. |
| FR-241 | El sistema deberá mostrar al Superadministrador un dashboard de eficiencia operativa con las métricas recogidas |

## FR-97 — El sistema deberá ejecutar el cálculo financiero de forma determinista, sin usar inteligencia artificial.
*UR: UR-110*

| FR v9 | Detalle |
|---|---|
| FR-205 | El sistema deberá ejecutar el cálculo financiero mediante programación determinista tradicional sin usar IA. |

## FR-98 — El sistema deberá permitir desactivar las funciones de apoyo basadas en inteligencia artificial (opcional).
*UR: UR-110*

| FR v9 | Detalle |
|---|---|
| FR-206 | El sistema deberá desactivar completamente sus funciones de apoyo basadas en inteligencia artificial de forma configurable (opcional). |

## FR-99 — El sistema deberá permitir localizar y anonimizar los datos personales de un contacto cuando legalmente proceda, conservando identificadores y auditoría.
*UR: UR-75*

| FR v9 | Detalle |
|---|---|
| FR-207 | El sistema deberá permitir localizar todos los datos personales que conserva de un contacto |
| FR-208 | El sistema deberá permitir anonimizar los datos personales de un contacto en los registros operativos cuando legalmente proceda |
| FR-209 | El sistema deberá conservar los identificadores y los registros de auditoría de un contacto anonimizado |

## FR-100 — El sistema deberá recuperar, tras una caída, las facturas recurrentes no generadas sin duplicar las ya generadas.
*UR: UR-102*

| FR v9 | Detalle |
|---|---|
| FR-210 | Al restablecerse tras una caída, el sistema deberá detectar las facturas recurrentes que no se generaron en su fecha |
| FR-211 | El sistema deberá generar las facturas recurrentes pendientes tras una caída sin duplicar las ya generadas |

## FR-101 — El sistema deberá registrar cada ejecución de los procesos automáticos con su duración, los elementos procesados y los fallos con su causa.
*UR: UR-53, UR-58*

| FR v9 | Detalle |
|---|---|
| FR-212 | El sistema deberá registrar cada ejecución de los procesos automáticos (generación mensual, recordatorios, conciliación e informes programados) con su fecha y hora de inicio y de fin |
| FR-213 | El sistema deberá registrar en cada ejecución cuántos clientes ha procesado y cuántas facturas ha creado |
| FR-214 | El sistema deberá registrar en cada ejecución los elementos que han fallado y la causa de cada fallo |

## FR-102 — El sistema deberá permitir programar informes periódicos y enviarlos a las personas indicadas (opcional).
*UR: UR-111*

| FR v9 | Detalle |
|---|---|
| FR-215 | El sistema deberá permitir al administrador indicar a quién se envían los resúmenes periódicos (opcional) |
| FR-216 | El sistema deberá enviar los informes programados que contengan detalle de clientes solo a usuarios con permiso para verlos (opcional) |
| FR-217 | El sistema deberá enviar en los informes programados una notificación con enlace autenticado al informe en lugar de adjuntarlo (opcional) |

## FR-103 — El sistema deberá gestionar la configuración global con validación previa y auditoría de los cambios.
*UR: UR-103*

| FR v9 | Detalle |
|---|---|
| FR-218 | El sistema deberá validar los cambios de configuración global antes de aplicarlos |
| FR-219 | El sistema deberá registrar en la auditoría quién cambia la configuración global, cuándo, y el valor anterior y el nuevo |
| FR-220 | El sistema deberá aplicar un cambio de configuración global a partir del momento de su validación |

## FR-104 — El sistema deberá permitir al superadministrador configurar el logo y la plantilla de las facturas.
*UR: UR-103*

| FR v9 | Detalle |
|---|---|
| FR-221 | El sistema deberá permitir al superadministrador configurar el logo y la plantilla de las facturas |

## FR-105 — El sistema deberá permitir probar los cambios de plantillas y de reglas de recordatorio antes de activarlos.
*UR: UR-104*

| FR v9 | Detalle |
|---|---|
| FR-222 | El sistema deberá permitir enviar a un usuario un correo de prueba con una plantilla de comunicación antes de activar un cambio |
| FR-223 | El sistema deberá permitir previsualizar el calendario de recordatorios que resultaría de una regla para un cliente de ejemplo |
| FR-224 | El sistema deberá avisar en la previsualización de una plantilla cuando falte alguna de sus variables |

## FR-106 — El sistema deberá permitir proponer valores por defecto en las altas frecuentes de clientes.
*UR: UR-105*

| FR v9 | Detalle |
|---|---|
| FR-227 | El sistema deberá proponer en las altas frecuentes valores por defecto de país, moneda, vencimiento y tarifa sugerida según el rango |

## FR-107 — El sistema deberá permitir realizar acciones masivas sobre un conjunto de clientes.
*UR: UR-106*

| FR v9 | Detalle |
|---|---|
| FR-228 | El sistema deberá mostrar cuántos elementos afecta una acción masiva antes de ejecutarla |
| FR-229 | El sistema deberá pedir confirmación antes de ejecutar una acción masiva destructiva o sensible |
| FR-230 | El sistema deberá mostrar al terminar una acción masiva el resultado con los elementos correctos y los erróneos |
| FR-231 | El sistema no deberá permitir marcar facturas como pagadas mediante una acción masiva |

## FR-108 — El sistema deberá permitir etiquetar clientes (opcional).
*UR: UR-107*

| FR v9 | Detalle |
|---|---|
| FR-232 | El sistema deberá permitir crear etiquetas y asignarlas a clientes (opcional) |
| FR-233 | El sistema no deberá sustituir con etiquetas manuales los estados derivados, como «impagado» (opcional) |

## FR-109 — El sistema deberá permitir gestionar incidencias de facturación asociadas a un cliente.
*UR: UR-50*

| FR v9 | Detalle |
|---|---|
| FR-234 | El sistema deberá permitir abrir una incidencia de facturación asociada a un cliente y, opcionalmente, a una factura |
| FR-235 | El sistema deberá permitir asignar a cada incidencia un responsable, un estado y una prioridad |
| FR-236 | El sistema deberá permitir añadir adjuntos a una incidencia |
| FR-237 | El sistema deberá permitir a un Administrador indicar que una incidencia pause los recordatorios de las facturas afectadas |
| FR-238 | El sistema deberá exigir registrar la resolución al cerrar una incidencia |
