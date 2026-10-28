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
| Personal administrativo / lector | ... | ... |
| Administrador | ... | ... |
| Superadministrador | ... | ... |


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
| BR-01 | El sistema deberá representar la relación comercial de cada cliente de forma independiente de sus facturas y del producto. | Entrevista ampliada |
| BR-02 | El personal deberá administrar clientes y facturación mediante una herramienta interna independiente. | Entrevista ampliada |
| BR-03 | El administrador deberá conocer la situación global del negocio sin revisar cada cliente individualmente a medida que crezca la cartera. | Entrevista ampliada |
| BR-04 | El sistema deberá procesar empresas internacionales sin asumir que todas usan formatos fiscales o domicilios españoles. | Entrevista ampliada |
| BR-05 | El sistema deberá conservar el historial de clientes, contactos, relaciones comerciales y facturas durante el plazo permitido por la ley. | Entrevista ampliada |

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
| UR-01 | Personal administrativo | El personal administrativo deberá poder registrar la información fiscal y operativa de la empresa (país, identificación fiscal y moneda). | Entrevista |
| UR-02 | Personal administrativo | El personal administrativo deberá poder consultar la información registrada de la empresa. | Entrevista |
| UR-03 | Personal administrativo | El personal administrativo deberá poder gestionar los contactos asociados a cada empresa cliente. | Entrevista |
| UR-04 | Personal administrativo | El personal administrativo deberá poder consultar la información de la relación comercial (fecha de inicio, plan, tarifa, condiciones de pago, responsable e historial). | Entrevista |
| UR-05 | Personal administrativo | El personal administrativo deberá poder preparar y emitir facturas. | Entrevista |
| UR-06 | Personal administrativo | El personal administrativo deberá poder revisar el cálculo prorrateado del importe de una factura antes de su emisión. | Entrevista |
| UR-07 | Personal administrativo | El personal administrativo deberá poder consultar el estado de cobro, el historial y la trazabilidad de las facturas. | Entrevista |
| UR-08 | Personal administrativo | El personal administrativo deberá poder borrar un borrador de factura que no se haya emitido. | Entrevista |
| UR-09 | Personal administrativo | El personal administrativo deberá poder programar la emisión de facturas para fechas futuras. | Entrevista |
| UR-10 | Superadministrador | El superadministrador deberá poder configurar el rango y precios de las tarifas globales. | Entrevista |
| UR-11 | Personal administrativo | El personal administrativo deberá poder recibir avisos de revisión de rangos de precios y consultar el rango propuesto. | Entrevista |
| UR-12 | Personal administrativo | El personal administrativo deberá poder modificar los impuestos aplicables a una factura. | Entrevista |
| UR-13 | Personal administrativo | El personal administrativo deberá poder proponer facturas nuevas o modificadas que requieran revisión. | Entrevista |
| UR-14 | Administrador | El administrador deberá poder revisar las propuestas de facturas recibidas y registrar su aprobación o rechazo. | Entrevista |
| UR-15 | Superadministrador | El superadministrador deberá poder configurar los umbrales de facturación para las aprobaciones extraordinarias. | Entrevista |
| UR-16 | Superadministrador | El superadministrador deberá poder autorizar facturas que superen el umbral de facturación configurado. | Entrevista |
| UR-17 | Superadministrador | El superadministrador deberá poder configurar la serie y numeración de las facturas. | Entrevista |
| UR-18 | Personal administrativo | El personal administrativo deberá poder gestionar facturas de modalidad puntual y recurrente. | Primera sesión |
| UR-19 | Personal administrativo | El personal administrativo deberá poder generar y consultar las facturas en formato PDF. | Primera sesión |
| UR-20 | Personal administrativo | El personal administrativo deberá poder hacer el seguimiento de cobros y enviar recordatorios de pago. | Entrevista |
| UR-21 | Administrador | El administrador deberá poder gestionar los usuarios del sistema y asignar sus permisos de acceso. | Entrevista |
| UR-22 | Personal administrativo | El personal administrativo deberá poder consultar de forma global la situación de clientes y facturas sin abrir cada cliente de manera individual. | Entrevista |
| UR-23 | Personal administrativo | El personal administrativo deberá poder consultar la lista de clientes con fecha de inicio futura pendientes de activación. | Entrevista |


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
| FR-08 | El sistema deberá poder crear facturas de modalidad puntual. | UR-05, UR-18 |
| FR-09 | El sistema deberá poder configurar la facturación recurrente mensual vinculada a una relación comercial aprobada. | UR-05, UR-18 |
| FR-10 | El sistema deberá poder generar automáticamente el día uno de cada mes las facturas recurrentes mensuales de las relaciones comerciales activas. | UR-18 |
| FR-11 | El sistema deberá poder calcular el importe cobrado equivalente a los días restantes del mes en curso para los contratos iniciados a mitad de mes. | UR-06, UR-18 |
| FR-12 | El sistema deberá poder calcular y mostrar el importe prorrateado y la mensualidad normal antes de la confirmación final del alta. | UR-06 |
| FR-13 | El sistema deberá poder registrar una excepción comercial explícita para aplazar el inicio de la facturación al mes siguiente sin cobrar prorrateo. | UR-18 |
| FR-14 | El sistema deberá poder asignar una fecha de inicio futura a una relación comercial manteniendo su estado como pendiente de activación. | UR-23 |
| FR-15 | El sistema no deberá poder generar facturas ni recordatorios de cobro antes de la fecha de inicio futura de una relacion comercial. | UR-20, UR-23 |
| FR-16 | El sistema deberá poder programar la emisión automática de facturas para una fecha futura. | UR-09 |
| FR-17 | El sistema deberá poder generar y mostrar la representación en archivo PDF de una factura. | UR-19 |
| FR-18 | El sistema deberá poder registrar las transiciones de estado de cobro de cada factura (pendiente, vencida, pagada o parcialmente conciliada). | UR-07, UR-20 |
| FR-19 | El sistema deberá poder listar y filtrar las facturas emitidas según su estado de cobro. | UR-07 |
| FR-20 | El sistema deberá poder registrar pagos parciales reflejando de forma transparente el saldo e importe pendiente restante. | UR-07 |
| FR-21 | El sistema deberá poder transmitir recordatorios de cobro para facturas vencidas y registrar la fecha del envío. | UR-20 |
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
| FR-37 | El sistema deberá poder mantener el número y la factura original sin generar duplicados ante el reintento de envío de una factura emitida. | UR-17, UR-19 |
| FR-38 | El sistema deberá poder permitir modificar el contenido de una factura mientras permanezca en estado de borrador. | UR-05, UR-08 |
| FR-39 | El sistema deberá poder conservar la factura original emitida y registrar una factura rectificativa vinculada para realizar correcciones legales. | UR-07 |
| FR-40 | El sistema deberá poder eliminar únicamente borradores de facturas que no hayan sido emitidas. | UR-08 |
| FR-41 | El sistema deberá poder permitir al administrador gestionar los usuarios de la plataforma y asignar sus permisos de acceso. | UR-21 |


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

## 5. Reglas de negocio

Reglas del dominio o de la organización que condicionan el comportamiento del sistema
pero que no representan por sí mismas una funcionalidad.

| ID | Regla |
|---|---|
| RB-01 | Una factura dispondrá de un ID único únicamente cuando haya alcanzado el estado de emitida. |
| RB-02 | Las facturas recurrentes se emitirán el día 1 de cada mes y desde el dia que empezo la relación. |
| RB-03 | Los datos de empresas y facturas emitidas no se podrán eliminar definitivamente hasta transcurrido el plazo exigido por la legislación contable. |
| RB-04 | Toda excepción, requerirá la aprobación de un usuario con rol Administrador o Superadministrador. |


## 6. Suposiciones y decisiones de análisis

En esta sección se documentarán las decisiones tomadas por el equipo cuando la
información proporcionada por el cliente no sea suficiente para determinar unívocamente
un requisito.

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | Prorrateo calculado como la proporción exacta de días restantes del mes de alta respecto al total de días de dicho mes. | Garantiza un cálculo justo para el cliente. | FR-11, FR-12 |
| A-02 | Implementación mediante interfaz web responsiva multidispositivo. | Permite operar desde teléfonos móviles y tabletas sin requerir aplicaciones independientes. | NFR-04 |


## 7. Dudas, ambigüedades y cuestiones pendientes

Se incluirán aquí aspectos de la información proporcionada por el cliente que sean
ambiguos, incompletos, contradictorios o que requieran aclaración.

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|



## 8. Trazabilidad

La tabla permitirá comprobar la relación entre las necesidades de negocio,
los requisitos de usuario y los requisitos del sistema.

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
|---|---|---|
| BR-01 | UR-04, UR-06 | FR-06, FR-11, FR-12, FR-13 |
| BR-02 | UR-01, UR-02, UR-21 | FR-01, FR-02, FR-41, NFR-01 |
| BR-03 | UR-22 | FR-22, NFR-03 |
| BR-04 | UR-01, UR-12 | FR-01, FR-07, NFR-07 |
| BR-05 | UR-03, UR-07 | FR-04, FR-18, FR-39, FR-40, NFR-06, NFR-08 |


## 9. Glosario

| Término | Definición |
|---|---|
| ... | ... |
