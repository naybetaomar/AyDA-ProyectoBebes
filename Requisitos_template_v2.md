# Requisitos

## 1. Contexto y alcance

### 1.1. Objetivo del sistema

Breve descripción del problema que se pretende resolver y del objetivo general del sistema.

### 1.2. Alcance

Descripción de qué responsabilidades corresponden al sistema y, cuando sea relevante,
qué elementos quedan explícitamente fuera de su alcance.

### 1.3. Actores y partes interesadas

Identificar las personas, organizaciones o sistemas que interactúan con el sistema
o tienen algún interés relevante en su funcionamiento.

<!--
EJEMPLO:

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Personal administrativo | Personal de Turbine encargado de gestionar clientes, facturas y cobros | Realizar las tareas administrativas de forma rápida y disponer de información actualizada |
| Administrador | Usuario con permisos sobre la gestión del sistema y sus usuarios | Gestionar usuarios, permisos y configuración |
| Cliente de Turbine | Empresa a la que Turbine presta sus servicios y factura periódicamente | Recibir correctamente sus facturas y comunicaciones relacionadas con los pagos |
| Sistema de pagos | Sistema externo en el que se reflejan los cobros | Proporcionar información que permita determinar si una factura ha sido pagada |

Los elementos anteriores son únicamente un ejemplo de cómo documentar esta sección.
El equipo debe identificar y justificar los actores y stakeholders que considere
adecuados a partir de la información del caso.
-->

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| ... | ... | ... |


## 2. Requisitos de negocio

Los requisitos de negocio describen los objetivos, necesidades o resultados que
la organización pretende conseguir mediante el desarrollo del sistema. No describen
todavía funcionalidades concretas del software.

<!--
EJEMPLO:

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | Reducir el trabajo manual asociado a la generación de facturas y al seguimiento de los cobros | Cliente / entrevista |
| BR-02 | Hacer más eficiente la gestión administrativa a medida que aumente el número de clientes de Turbine | Cliente / entrevista |

Observa que estos requisitos expresan POR QUÉ se necesita el sistema y qué pretende
conseguir la organización. No indican todavía cómo debe hacerlo el software.
-->

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | El sistema deberá representar la relación comercial de cada cliente de forma independiente de sus facturas y del producto, separando la rescisión de contrato de la gestión activa de deudas pendientes para garantizar la continuidad del recobro tras la baja. | Cliente / entrevista / decisión del equipo / otra |
| BR-02 | El personal deberá administrar clientes y facturación mediante una herramienta interna independiente que optimice la tasa de cobro mediante la automatización de notificaciones, seguimiento de impagos y conciliación bancaria inteligente. | ... |
| BR-02 | El administrador deberá conocer la situación global del negocio sin revisar cada cliente individualmente a medida que crezca la cartera. | ... |
| BR-02 | El sistema deberá procesar empresas internacionales sin asumir que todas usan formatos fiscales o domicilios españoles. | ... |
| BR-02 | El sistema deberá conservar el historial de clientes, contactos, relaciones comerciales y facturas durante el plazo permitido por la ley, garantizando la inmutabilidad legal e histórica de los documentos emitidos frente a cambios en la marca o en el catálogo. | ... |






## 3. Requisitos de usuario

Los requisitos de usuario describen las necesidades, objetivos o servicios que los
usuarios esperan obtener del sistema. Deben expresarse desde el punto de vista del
usuario, evitando entrar todavía en detalles internos de implementación.

<!--
EJEMPLO:

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-01 | Personal administrativo | Poder generar y gestionar facturas de los clientes sin tener que realizar manualmente cada facturación mensual | Cliente / entrevista |
| UR-02 | Personal administrativo | Poder conocer qué facturas están pagadas y cuáles siguen pendientes | Cliente / entrevista |
| UR-03 | Administrador | Poder gestionar los usuarios del sistema y determinar a qué clientes puede acceder cada uno | Cliente / entrevista |

Un requisito de usuario expresa QUÉ necesita conseguir un usuario con el sistema,
pero normalmente no especifica todavía todos los comportamientos detallados que
serán necesarios para proporcionarle ese servicio.
-->

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-01 | Personal administrativo | Poder registrar la información fiscal y operativa de la empresa (país, identificación fiscal y moneda), consultando duplicados por identificador fiscal al dar de alta o reingresar clientes para reactivar expedientes históricos. | *Entrevista* / *pág. 4-5* |
| UR-02 | Personal administrativo | Poder consultar la información registrada de la empresa. | *Entrevista* |
| UR-03 | Personal administrativo | Poder gestionar los contactos asociados a cada empresa cliente. | *Entrevista* |
| UR-04 | Personal administrativo | Poder consultar la información de la relación comercial (fecha de inicio, plan, tarifa, condiciones de pago, responsable e historial). | *Entrevista* |
| UR-05 | Personal administrativo | Poder pausar temporalmente una suscripción indicando motivo y fechas, congelando la generación de mensualidades sin afectar a las facturas impagadas. | *Entrevista, pág. 4* |
| UR-06 | Administrador | Poder recibir alertas de reactivación de suscripciones pausadas para confirmar la reanudación del cobro. | *Entrevista, pág. 4* |
| UR-07 | Personal administrativo | Poder registrar la baja de un cliente deteniendo cobros futuros pero manteniendo el flujo de recobro sobre las deudas no saldadas. | *Entrevista, pág. 4-5* |
| UR-08 | Personal administrativo | Poder preparar, gestionar y emitir facturas en modalidad puntual (utilizando conceptos frecuentes de un catálogo ligero) o recurrente. | *Entrevista* / *Primera sesión* |
| UR-09 | Personal administrativo | Poder previsualizar la factura, revisar su cálculo prorrateado y disponer de bloqueos automáticos en caso de faltar datos fiscales antes de su emisión. | *Entrevista, pág. 4-5* |
| UR-10 | Personal administrativo | Poder consultar el estado de cobro, el historial y la trazabilidad de las facturas. | *Entrevista* |
| UR-11 | Personal administrativo | Poder borrar un borrador de factura que no se haya emitido. | *Entrevista* |
| UR-12 | Personal administrativo | Poder programar la emisión de facturas para fechas futuras. | *Entrevista* |
| UR-13 | Superadministrador | Poder configurar el rango y precios de las tarifas globales. | *Entrevista* |
| UR-14 | Personal administrativo | Poder recibir avisos de revisión de rangos de precios y consultar el rango propuesto. | *Entrevista* |
| UR-15 | Personal administrativo | Poder modificar los impuestos aplicables a una factura. | *Entrevista* |
| UR-16 | Personal administrativo | Poder proponer facturas nuevas o modificadas que requieran revisión. | *Entrevista* |
| UR-17 | Administrador | Poder revisar las propuestas de facturas recibidas y registrar su aprobación o rechazo. | *Entrevista* |
| UR-18 | Superadministrador | Poder configurar los umbrales de facturación para las aprobaciones extraordinarias. | *Entrevista* |
| UR-19 | Superadministrador | Poder autorizar facturas que superen el umbral de facturación configurado. | *Entrevista* |
| UR-20 | Superadministrador | Poder configurar la serie y numeración de las facturas. | *Entrevista* |
| UR-21 | Personal administrativo | Poder generar y consultar las facturas en formato PDF. | *Primera sesión* |
| UR-22 | Personal administrativo / Admin | Poder hacer el seguimiento de cobros y enviar recordatorios de pago, pudiendo pausar el envío automático marcando facturas "en disputa" mientras se investiga una disconformidad. | *Entrevista, pág. 4-5* |
| UR-23 | Personal administrativo | Poder gestionar incidencias de envío de correo para corregir los datos de contacto y realizar reintentos sin emitir facturas duplicadas. | *Entrevista, pág. 4-5* |
| UR-24 | Administrador | Poder dar de baja contable una deuda clasificándola como "anulada" o "incobrable" tras aprobación administrativa. | *Entrevista, pág. 4-5* |
| UR-25 | Personal administrativo | Poder revisar en una bandeja de trabajo los movimientos bancarios o de pasarela no conciliados automáticamente o con importes parciales/excesivos. | *Entrevista, pág. 4-5* |
| UR-26 | Administrador | Poder gestionar los usuarios del sistema y asignar sus permisos de acceso. | *Entrevista* |
| UR-27 | Personal administrativo | Poder consultar de forma global la situación de clientes y facturas sin abrir cada cliente de manera individual. | *Entrevista* |
| UR-28 | Personal administrativo | Poder consultar la lista de clientes con fecha de inicio futura pendientes de activación. | *Entrevista* |



## 4. Requisitos del sistema

### 4.1. Requisitos funcionales

Los requisitos funcionales describen comportamientos, servicios u operaciones que
debe proporcionar el sistema. Siempre que sea posible, deben formularse de manera
clara, precisa y verificable.

<!--
EJEMPLO:

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | El sistema deberá permitir crear y almacenar una factura asociada a un cliente | UR-01 |
| FR-02 | El sistema deberá permitir indicar si la facturación de un cliente es puntual o recurrente | UR-01 |
| FR-03 | El sistema deberá generar automáticamente las nuevas facturas correspondientes a una facturación recurrente | UR-01 |
| FR-04 | El sistema deberá registrar si una factura se encuentra pagada o pendiente de pago | UR-02 |
| FR-05 | El sistema deberá permitir al administrador asignar clientes a los usuarios del sistema | UR-03 |

Evita requisitos como "El sistema gestionará las facturas correctamente", porque
no permiten saber con precisión qué comportamiento se espera.

También deben evitarse decisiones de diseño innecesarias, por ejemplo:
"El sistema utilizará una tabla SQL denominada FACTURAS".
Eso corresponde al diseño, no a los requisitos.
-->
| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | El sistema deberá poder registrar el nombre comercial, razón social, identificador fiscal, domicilio fiscal, país y moneda de trabajo de una empresa. | UR-01 |
| FR-02 | El sistema deberá poder mostrar la consulta de los datos identificativos y fiscales registrados de una empresa. | UR-02 |
| FR-03 | El sistema deberá poder registrar múltiples personas de contacto vinculadas a una empresa. | UR-03 |
| FR-04 | El sistema deberá poder marcar una persona de contacto como inactiva conservando intactos sus registros e historial contable asociado. | UR-03 |
| FR-05 | El sistema deberá poder registrar los destinatarios y direcciones de correo utilizados en cada envío de factura. | UR-03, UR-19 |
| FR-06 | El sistema deberá poder registrar la relación comercial de una empresa incluyendo fecha de inicio, servicio o plan, tarifa, responsable interno, condiciones de pago y documentos firmados. | UR-04 |
| FR-07 | El sistema deberá poder asignar los impuestos aplicables a una factura seleccionándolos de una lista de impuestos configurados. | UR-12 |
| FR-08 | El sistema deberá poder crear facturas de modalidad puntual compuestas por múltiples líneas con concepto, cantidad, precio unitario, porcentaje de descuento y tipo de impuesto aplicable. | UR-05, UR-18 |
| FR-09 | El sistema deberá poder configurar la facturación recurrente mensual vinculada a una relación comercial aprobada. | UR-05, UR-18 |
| FR-10 | El sistema deberá poder generar automáticamente el día uno de cada mes las facturas recurrentes mensuales de las relaciones comerciales activas. | UR-18 |
| FR-11 | El sistema deberá poder calcular el importe cobrado equivalente a los días restantes del mes en curso para los contratos iniciados a mitad de mes. | UR-06, UR-18 |
| FR-12 | El sistema deberá poder calcular y mostrar el importe prorrateado y la mensualidad normal antes de la confirmación final del alta, ofreciendo una vista previa de la factura antes de su emisión. | UR-06, UR-07 |
| FR-13 | El sistema deberá poder registrar una excepción comercial explícita para aplazar el inicio de la facturación al mes siguiente sin cobrar prorrateo. | UR-18 |
| FR-14 | El sistema deberá poder asignar una fecha de inicio futura a una relación comercial manteniendo su estado como pendiente de activación. | UR-23 |
| FR-15 | El sistema no deberá poder generar facturas ni recordatorios de cobro antes de la fecha de inicio futura de una relacion comercial. | UR-20, UR-23 |
| FR-16 | El sistema deberá poder programar la emisión automática de facturas para una fecha futura. | UR-09 |
| FR-17 | El sistema deberá generar la representación en PDF del documento incluyendo logo corporativo, tipografía, datos fiscales, numeración, fechas, desglose, impuestos y totales. Deberá almacenar la versión original del PDF emitido garantizando que modificaciones futuras en los activos no alteren los documentos históricos. | UR-08, UR-19 |
| FR-18 | El sistema deberá poder registrar las transiciones de estado de cobro de cada factura (pendiente, vencida, pagada o parcialmente conciliada), clasificando las deudas incobrables tras aprobación previa. | UR-07, UR-13, UR-20 |
| FR-19 | El sistema deberá poder listar y filtrar las facturas emitidas según su estado de cobro. | UR-07 |
| FR-20 | El sistema deberá poder registrar pagos parciales y cobros por importe superior/inferior, asociando el movimiento, registrando la diferencia y manteniendo la factura en estado parcial o no saldada, reflejando el saldo de forma transparente. | UR-07, UR-15 |
| FR-21 | El sistema deberá enviar recordatorios automáticos para facturas vencidas según la cadencia configurada, adaptándolos a fechas de vencimiento acordadas con el cliente, y registrar la fecha de envío. | UR-11, UR-20 |
| FR-22 | El sistema deberá poder mostrar un cuadro de mando con el resumen global consolidado de clientes y facturas. | UR-22 |
| FR-23 | El sistema deberá poder permitir al superadministrador configurar los rangos de facturación anual y sus tarifas sin modificar el código fuente. | UR-10 |
| FR-24 | El sistema deberá poder registrar la facturación anual verificada de un cliente. | UR-11 |
| FR-25 | El sistema deberá poder notificar cuando corresponda revisar el rango de tarifa aplicable a un cliente. | UR-11 |
| FR-26 | El sistema deberá poder calcular la propuesta de tarifa aplicable en función de la facturación anual verificada y los rangos configurados. | UR-11 |
| FR-27 | El sistema deberá poder exigir validación humana previa antes de aplicar un cambio de rango de tarifa. | UR-11 |
| FR-28 | El sistema deberá poder registrar el usuario aprobador, la fecha, la tarifa anterior y la tarifa nueva al modificar el rango de un cliente. | UR-11 |
| FR-29 | El sistema mantendrá inalterados los importes y datos de las facturas históricas emitidas tras cambios en la configuración global de tarifas. | UR-10, UR-11 |
| FR-30 | El sistema deberá poder registrar propuestas de excepciones comerciales (descuentos, meses gratuitos o precios especiales). | UR-13 |
| FR-31 | El sistema deberá poder parametrizar los umbrales económicos y niveles de aprobación requeridos para autorizar excepciones comerciales. | UR-14, UR-15, UR-16 |
| FR-32 | El sistema deberá poder suspender la emisión de facturas que incluyan modificaciones manuales de importe, descuentos, fechas excepcionales o importes que superen los umbrales, asignándolas a estado pendiente de aprobación. | UR-13, UR-14, UR-15, UR-16 |
| FR-33 | El sistema deberá poder registrar la decisión de aprobación o rechazo emitida por el perfil autorizado sobre las facturas pendientes. | UR-14, UR-16 |
| FR-34 | El sistema deberá poder permitir al superadministrador configurar las series de facturación. | UR-17 |
| FR-35 | El sistema deberá poder asignar un número definitivo único correlativo dentro de su serie únicamente en el momento de emitir la factura. | UR-17 |
| FR-36 | El sistema no deberá poder consumir un número definitivo para facturas en estado de borrador. | UR-08, UR-17 |
| FR-37 | El sistema deberá enviar automáticamente la factura al momento de su emisión. Ante reintentos, fallos o rebotes de correo, deberá mantener la factura original sin generar duplicados, marcando el fallo y permitiendo corregir datos de contacto. | UR-09, UR-10, UR-17, UR-19 |
| FR-38 | El sistema deberá poder permitir modificar el contenido de una factura mientras permanezca en estado de borrador. | UR-05, UR-08 |
| FR-39 | El sistema deberá poder conservar la factura original emitida y registrar una factura rectificativa vinculada para realizar correcciones legales. | UR-07 |
| FR-40 | El sistema deberá poder eliminar únicamente borradores de facturas que no hayan sido emitidas. | UR-08 |
| FR-41 | El sistema deberá poder permitir al administrador gestionar los usuarios de la plataforma y asignar sus permisos de acceso. | UR-21 |
| FR-42 | El sistema deberá permitir pausar una suscripción activa registrando el motivo y fechas, deteniendo la generación de mensualidades sin alterar las facturas impagadas, y solicitará confirmación al alcanzar la fecha de reactivación. | UR-01, UR-02 |
| FR-43 | El sistema deberá registrar solicitudes de baja comprobando deudas. Si no hay deudas cerrará la recurrencia; si las hay, detendrá nuevas mensualidades pero mantendrá el flujo de recobro sobre las pendientes. | UR-03 |
| FR-44 | Al dar de alta o reingresar un cliente, el sistema deberá buscar coincidencias por identificador fiscal y avisar al usuario para permitir la reactivación de su ficha histórica. | UR-04 |
| FR-45 | El sistema permitirá administrar un catálogo de conceptos reutilizables con precios e impuestos por defecto. Ajustar estos datos en una factura puntual no afectará al catálogo ni a facturas ya emitidas. | UR-06 |
| FR-46 | El sistema bloqueará automáticamente el envío de una factura si falta un dato fiscal imprescindible y advertirá si el importe total sale del patrón habitual del cliente. | UR-07 |
| FR-47 | El sistema permitirá la simulación del envío de facturas por WhatsApp únicamente para los contactos que dispongan de un número válido y hayan otorgado su consentimiento. | UR-09 |
| FR-48 | El sistema deberá permitir marcar una factura en estado "en disputa" registrando un motivo y fecha de revisión, para suspender temporalmente el envío de recordatorios automáticos. | UR-12 |
| FR-49 | El sistema deberá simular la recepción de eventos de Stripe, permitiendo consultar transacciones e identificando eventos duplicados para no contabilizar cobros repetidamente. | UR-14 |
| FR-50 | El sistema deberá vincular automáticamente movimientos bancarios/pasarela a facturas ante coincidencias claras, y derivar a una bandeja de revisión manual los que carezcan de referencia. | UR-15 |
| FR-51 | En caso de deshacer o revertir una conciliación previa, el sistema deberá conservar la traza histórica (quién, regla, justificación). | UR-16 |


### 4.2. Requisitos no funcionales

Los requisitos no funcionales describen propiedades de calidad, restricciones o
condiciones que debe satisfacer el sistema. Cuando sea posible, deberán incluir
algún criterio que permita determinar si el requisito se cumple.

<!--
EJEMPLO:

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-01 | Usabilidad | Las operaciones administrativas habituales deberán poder realizarse de forma rápida y sencilla | Una operación habitual como generar o consultar una factura debería poder completarse aproximadamente en menos de un minuto |
| NFR-02 | Portabilidad / Usabilidad | La aplicación deberá poder utilizarse desde distintos tipos de dispositivo | Las principales funcionalidades deberán ser utilizables desde ordenador, tableta y teléfono móvil |
| NFR-03 | Escalabilidad | El sistema deberá poder gestionar un crecimiento significativo del número de clientes | El diseño no deberá asumir un número pequeño o fijo de clientes y deberá permitir gestionar potencialmente miles de ellos |

Evita expresiones difíciles de comprobar como:
"La aplicación deberá ser moderna", "muy rápida" o "fácil de usar".

Cuando el cliente emplee expresiones de este tipo, el equipo deberá intentar
transformarlas en criterios más concretos y verificables o documentar la
interpretación realizada.
-->

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-01 | Independencia | El sistema deberá poder operar como herramienta independiente de la empresa, sin depender de su interfaz o disponibilidad para las operaciones administrativas. | Se pueden completar los flujos administrativos principales mientras Brain no está disponible. |
| NFR-02 | Usabilidad / Eficiencia | El sistema deberá poder realizar operaciones administrativas con pocos pasos. | El alta normal de una empresa debe de tener menos de 5 clicks. |
| NFR-03 | Escalabilidad | El sistema deberá permitir consultar la situacion global del negocio independientemente del numero de clientes. | Poder ver el global sin abrir los clientes uno por uno. |
| NFR-04 | Portabilidad | El sistema deberá poder utilizarse desde un telefono movil. | Debe poder realizar los requisitos funcionales desde el movil. |
| NFR-05 | Seguridad y permisos | El sistema deberá poder restringir el acceso segun los permisos asignados a cada usuario. | Un usuario con rol Lector solo podrá visualizar y operar sobre los clientes que tenga explícitamente asignados. |
| NFR-06 | Integridad y auditoría | El sistema deberá poder garantizar la trazabilidad de los cambios económicos e inmutabilidad del histórico. | Para cada cambio sujeto a auditoria se conserva usuario, fecha y valores anteriores y nuevos; una factura emitida mantiene su contenido original. |
| NFR-07 | Internacionalización | El sistema deberá poder soportar el registro de empresas internacionales sin imponer formatos exclusivos de españa. | Se pueden registrar empresas de distintos paises sin exigir formatos. |
| NFR-08 | Privacidad y conservación | El sistema deberá poder cumplir con los plazos legales de conservación y eliminación contable. | Antes de aceptar el sistema se documentan los plazos y reglas de conservacion y se comprueba que el borrado logico y las restricciones de acceso los respetan. |
| NFR-13 | Fiabilidad | El sistema de notificaciones debe gestionar los reintentos tras errores de red o entrega sin provocar duplicidad en la generacion de documentos o cobros | Ante un error de red o de entrega, los reintentos automáticos o manuales del envío no generarán duplicados del documento ni duplicarán los registros de cobro asociados |
| NFR-14 | Eficiencia | La interfaz del catalogo de productos debe ofrecer una experiencia de usuario ligera y agil para la consulta y seleccion de conceptos frecuentes | La selección de un concepto del catálogo e inserción de la línea en una factura o suscripción se podrá realizar en menos de 3 clics |


## 5. Reglas de negocio

Reglas del dominio o de la organización que condicionan el comportamiento del sistema
pero que no representan por sí mismas una funcionalidad.

| ID | Regla |
|---|---|
| RB-01 | Una factura dispondrá de un ID único únicamente cuando haya alcanzado el estado de emitida. |
| RB-02 | Las facturas recurrentes se emitirán el día 1 de cada mes y desde el dia que empezo la relación. |
| RB-03 | Los datos de empresas y facturas emitidas no se podrán eliminar definitivamente hasta transcurrido el plazo exigido por la legislación contable. |
| RB-04 | Toda excepción requerirá la aprobación de un usuario con rol Administrador o Superadministrador. |
| RB-05 | La pausa de una suscripción detiene la generación de nuevas mensualidades recurrentes pero no cancela ni modifica los derechos de cobro de las facturas emitidas anteriormente que continúen impagadas. |
| RB-06 | Las modificaciones en las tarifas o impuestos por defecto de los conceptos del catálogo de productos no afectarán de forma retroactiva a las facturas ni suscripciones previamente emitidas. |
| RB-07 | La representación en PDF de una factura emitida es inalterable. |
| RB-08 | Una deuda perdonada no puede ser clasificada ni contabilizada como "pagada", debiendo pasar explícitamente al estado "anulada" o "incobrable".|


## 6. Suposiciones y decisiones de análisis

En esta sección se documentarán las decisiones tomadas por el equipo cuando la
información proporcionada por el cliente no sea suficiente para determinar unívocamente
un requisito.

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | ... | ... | FR-... |
| A-02 | ... | ... | ... |


## 7. Dudas, ambigüedades y cuestiones pendientes

Se incluirán aquí aspectos de la información proporcionada por el cliente que sean
ambiguos, incompletos, contradictorios o que requieran aclaración.

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|
| Q-01 | ... | Entrevista | ... | Pendiente |
| Q-02 | ... | ... | ... | Resuelta: ... |


## 8. Trazabilidad

La tabla permitirá comprobar la relación entre las necesidades de negocio,
los requisitos de usuario y los requisitos del sistema.

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
|---|---|---|
| BR-01 | UR-04 | FR-06 |
| BR-01 | UR-05 | FR-42 |
| BR-01 | UR-06 | FR-42 |
| BR-01 | UR-07 | FR-43 |
| BR-01 | UR-28 | FR-14, FR-15 |
| BR-02 | UR-02 | FR-02 |
| BR-02 | UR-03 | FR-03, FR-04, FR-05 |
| BR-02 | UR-08 | FR-08, FR-09, FR-10, FR-38, FR-45, NFR-14 |
| BR-02 | UR-09 | FR-11, FR-12, FR-46 |
| BR-02 | UR-10 | FR-18, FR-19 |
| BR-02 | UR-11 | FR-40 |
| BR-02 | UR-12 | FR-16 |
| BR-02 | UR-13 | FR-23 |
| BR-02 | UR-14 | FR-24, FR-25, FR-26, FR-27, FR-28 |
| BR-02 | UR-15 | FR-07 |
| BR-02 | UR-16 | FR-30, FR-31 |
| BR-02 | UR-17 | FR-33 |
| BR-02 | UR-18 | FR-31 |
| BR-02 | UR-19 | FR-32 |
| BR-02 | UR-20 | FR-34, FR-35, FR-36 |
| BR-02 | UR-22 | FR-21, FR-48 |
| BR-02 | UR-23 | FR-37, NFR-13 |
| BR-02 | UR-24 | FR-18 |
| BR-02 | UR-25 | FR-20, FR-49, FR-50, FR-51 |
| BR-02 | UR-26 | FR-41, NFR-05 |
| BR-02 | - | NFR-01, NFR-04 |
| BR-03 | UR-27 | FR-22, NFR-03 |
| BR-04 | UR-01 | FR-01, FR-44, NFR-02, NFR-07 |
| BR-05 | UR-21 | FR-17, NFR-06 |
| BR-05 | - | FR-29, FR-39, NFR-08 |


## 9. Glosario

| Término | Definición |
|---|---|
| ... | ... |
