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
<!--
A espera de la reunión grupal
-->


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
| UR-01 | Editor | Poder distinguir entre una factura que existe pero no se pudo enviar y una factura que no se pudo crear | Cliente / entrevista |
| UR-02 | Editor | Poder preparar un presupuesto para un cliente, enviarlo y registrar si lo acepta o lo rechaza, para convertirlo en factura sin volver a introducir los datos (opcional) | Cliente / entrevista |
| UR-03 | Administrador | Poder corregir un error de una factura ya emitida sin alterarla, de forma que el saldo del cliente refleje la corrección | Cliente / entrevista |
| UR-04 | Editor | Poder conocer de un vistazo el saldo, las facturas pendientes y las pagadas, y comprobar de dónde sale cada cifra (limitado a clientes asignados) | Cliente / entrevista |
| UR-05 | Administrador | Poder revisar cada año si un cliente sigue en el plan que le corresponde y decidir el cambio, sin que se alteren las facturas pasadas | Cliente / entrevista |
| UR-06 | Administrador | Poder conocer el estado del sistema (emails pendientes, errores de integración, último backup, última generación recurrente) | Cliente / entrevista |
| UR-06b | Administrador | Poder consultar la historia de cada cliente | Cliente / entrevista |
| UR-07 | Administrador | Poder garantizar que solo las personas autorizadas acceden al sistema y a cada cliente o factura | Cliente / entrevista |
| UR-08 | Sistema externo (Brain) | Poder consultar datos de clientes, deuda y facturas, y enviar solicitudes (como la de baja de un cliente), de forma que el sistema aplique siempre sus reglas de negocio | Cliente / entrevista |
| UR-09 | Administrador | Poder identificar y localizar la causa de un error del sistema a partir de un código de incidencia | Cliente / entrevista |
| UR-09b | Editor / Administrador | Poder ver un mensaje comprensible ante un error, sin información técnica interna del sistema | Cliente / entrevista |
| UR-10 | Editor | Poder dar de alta clientes con datos correctos y sin duplicados, y saber qué datos faltan para poder facturarles | Cliente / entrevista |
| UR-11 | Administrador | Poder configurar los datos fiscales del emisor | Cliente / entrevista |
| UR-11b | Administrador | Poder elegir, si Turbine factura desde varias sociedades, con cuál se emite cada factura (opcional) | Cliente / entrevista |
| UR-12 | Editor | Poder adjuntar a un cliente o a una factura los documentos que lo justifican (pedido, presupuesto aceptado, justificante) de forma segura | Cliente / entrevista |
| UR-13 | Editor | Poder acceder rápidamente a los clientes con los que trabaja con más frecuencia | Cliente / entrevista |



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
| FR-01 | El sistema deberá generar facturas en formato PDF | UR-03 | <!-- ¿duplicado del bloque 4-5? decidir en la reunión -->
| FR-02 | El sistema deberá generar presupuestos (opcional) | UR-02 |
| FR-03 | El sistema deberá permitir enviar el presupuesto al cliente (opcional) | UR-02 |
| FR-04 | Un usuario con permiso deberá poder marcar un presupuesto como aceptado o rechazado (opcional) | UR-02 |
| FR-05 | El sistema deberá permitir adjuntar al presupuesto la evidencia de la aceptación (opcional) | UR-02 |
| FR-06 | Si el presupuesto está aceptado, el sistema deberá convertirlo en factura reutilizando las líneas (opcional) | UR-02 |
| FR-07 | El sistema no deberá permitir que se modifiquen facturas emitidas | UR-03 |
| FR-08 | En caso de error en una factura emitida, un administrador deberá poder generar una factura rectificativa vinculada a la factura original | UR-03 |
| FR-09 | Si el importe de la rectificativa supera el umbral configurado, esta deberá ser aprobada antes de emitirse | UR-03 |
| FR-10 | El sistema deberá proponer los datos a rectificar a partir de la factura original | UR-03 |
| FR-11 | El sistema deberá recalcular el saldo del cliente a través de la factura rectificativa | UR-03 |
| FR-12 | El sistema deberá generar un dashboard que muestre el saldo, las facturas pendientes y las facturas pagadas de los clientes asignados al usuario. | UR-04 |
| FR-12b | El sistema deberá permitir consultar el detalle de los registros que componen cada cifra del dashboard. | UR-04 |
| FR-13 | El sistema deberá iniciar a principios de cada año una campaña de revisión que lista los clientes cuya facturación anual debe revisarse | UR-05 |
| FR-14 | El sistema deberá obtener la facturación anual de una fuente simulada o de entrada manual | UR-05 |
| FR-14b | El sistema deberá registrar la fuente y la fecha de cada dato de facturación anual | UR-05 |
| FR-14c | Si el dato de facturación anual no está disponible, el sistema deberá dejar la revisión en estado pendiente | UR-05 |
| FR-15 | El sistema deberá proponer el rango de facturación que corresponda según el importe anual registrado y las reglas de asignación de rangos configuradas. | UR-05 |
| FR-16 | En caso de propuesta de cambio de plan, el administrador deberá verificar la propuesta de nuevo rango | UR-05 |
| FR-17 | Si el cambio de plan es válido, el sistema deberá aplicar el nuevo precio a partir de una fecha de efecto | UR-05 |
| FR-17b | El sistema no deberá modificar las facturas ya emitidas de meses anteriores al aplicar un nuevo precio | UR-05 |
| FR-18 | El sistema deberá registrar quién aprobó el cambio de plan, cuándo, y el precio anterior y el nuevo | UR-05 |
| FR-19 | El sistema deberá mostrar el número de emails pendientes de envío | UR-06 |
| FR-19b | El sistema deberá permitir consultar el estado de procesamiento de los emails pendientes | UR-06 |
| FR-20 | El sistema deberá mostrar los errores de integración, ordenados del más reciente al más antiguo | UR-06 |
| FR-21 | El sistema deberá mostrar la fecha y el resultado del último backup realizado | UR-06 |
| FR-22 | El sistema deberá mostrar la última ejecución de la generación recurrente | UR-06 |
| FR-23 | El sistema deberá mostrar el historial de cada cliente (alta, cambio de responsables, cambios de tarifa, facturas emitidas, pagos, incidencias, pausas, baja, reactivación) | UR-06b |
| FR-24 | El sistema deberá cerrar sesión automáticamente tras 30 minutos de inactividad | UR-07 |
| FR-25 | El sistema deberá exponer una API que permita a sistemas externos consultar clientes, estado de deuda y facturas | UR-08 |
| FR-26 | La API deberá permitir crear solicitudes controladas | UR-08 |
| FR-26b | Las solicitudes controladas deberán pasar por validación o aprobación y no deberán modificar datos directamente | UR-08 |
| FR-27 | La API deberá aplicar las mismas reglas de negocio y validaciones que la interfaz. Una llamada externa no podrá hacer nada que un usuario no podría hacer | UR-08 |
| FR-28 | Las credenciales de un consumidor de la API no deberán permitir acceder a la interfaz de usuario, ni las de un usuario acceder a la API | UR-08 |
| FR-29 | El sistema deberá limitar el número de solicitudes que cada consumidor de la API puede realizar durante un intervalo de tiempo, según los límites configurados. | UR-08 |
| FR-30 | El sistema deberá registrar las llamadas importantes a la API (quién la hizo, cuándo y qué operación) | UR-08 |
| FR-31 | El sistema deberá poder recibir solicitudes de baja y crear la tarea 'darse de baja' sin eliminar directamente la recurrencia | UR-08 |
| FR-32 | El sistema deberá permitir consultar, a partir de un identificador de cliente, si existen obligaciones pendientes y el detalle mínimo autorizado | UR-08 |
| FR-33 | El sistema deberá registrar los errores en logs técnicos | UR-09 |
| FR-33b | El sistema no deberá mostrar al usuario final información técnica del error (trazas, mensajes internos, rutas del servidor) | UR-09b |
| FR-34 | El sistema deberá generar un código de incidencia que permita correlacionar el error | UR-09 |
| FR-35 | Antes de dar de alta a un cliente, el sistema deberá buscar duplicados: coincidencias en nombre o razón social, mismo identificador fiscal, mismo email o teléfono | UR-10 |
| FR-36 | Si encuentra duplicados, el sistema deberá mostrárselos al usuario, que decidirá si crear un nuevo cliente o usar el existente | UR-10 |
| FR-37 | El sistema deberá validar el formato de email | UR-10 |
| FR-38 | El sistema deberá validar el identificador fiscal siempre que el país sea conocido (NIF/CIF en España o VAT). Si no se conoce, la validación quedará pendiente | UR-10 |
| FR-39 | Tras 5 intentos fallidos de login consecutivos, el sistema deberá bloquear temporalmente el acceso del usuario durante 15 minutos | UR-07 |
| FR-40 | El sistema deberá invalidar la sesión de un usuario desactivado por un administrador | UR-07 |
| FR-41 | El sistema deberá guardar los datos fiscales del emisor como configuración | UR-11 |
| FR-42 | El sistema deberá permitir tener varias entidades emisoras (opcional) | UR-11b |
| FR-43 | El sistema deberá identificar a cada entidad con series de numeración (opcional) | UR-11b |
| FR-44 | Al emitir una factura, un usuario con permiso deberá poder seleccionar la entidad emisora correspondiente (opcional) | UR-11b |
| FR-45 | El sistema deberá permitir adjuntar documentos a clientes y facturas, además del PDF que genera el sistema | UR-12 |
| FR-46 | Cada adjunto deberá tener un tipo (pedido del cliente, presupuesto aceptado, justificante de pago, documento de la gestoría, otro) y una descripción | UR-12 |
| FR-47 | El sistema deberá admitir solo formatos de una lista permitida: PDF, JPG/PNG, DOCX, XLSX y CSV. Los ejecutables y scripts (.exe, .bat, .js…) se deberán rechazar | UR-12 |
| FR-48 | El sistema deberá registrar y mostrar al usuario el estado de creación de una factura (creada o no creada) | UR-01 |
| FR-49 | El sistema deberá registrar y mostrar al usuario el estado de envío de una factura (enviada o fallo de envío) | UR-01 |
| FR-50 | En caso de descubrir que un dato de una revisión anual era incorrecto, el sistema deberá permitir corregir la ficha de revisión, registrando la corrección | UR-05 |
| FR-51 | El sistema deberá calcular el impacto potencial de la corrección sobre el precio de los meses afectados | UR-05 |
| FR-52 | El sistema no deberá emitir facturas retroactivas automáticamente | UR-05 |
| FR-52b | Toda regularización retroactiva deberá requerir una acción explícita y la aprobación de un administrador | UR-05 |
| FR-53 | El sistema deberá bloquear la emisión de una factura si falta un dato fiscal imprescindible, e indicar qué dato falta | UR-10 |
| FR-54 | El sistema deberá permitir guardar un cliente sin los datos convenientes (el teléfono del contacto) como excepción controlada, y registrar qué datos faltan | UR-10 |
| FR-55 | El sistema deberá eliminar los espacios sobrantes de los datos introducidos (nombre, razón social, email e identificador fiscal) | UR-10 |
| FR-56 | El sistema deberá permitir marcar clientes como favoritos | UR-13 |
| FR-56b | El sistema deberá mostrar los clientes consultados recientemente | UR-13 |
| FR-57 | El sistema deberá comprobar los permisos del usuario en cada acceso a un cliente o a una factura, aunque se acceda mediante una URL directa, y rechazar el acceso si no le corresponde | UR-07 |


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
| NFR-01 | Portabilidad / Usabilidad | La aplicación deberá ser responsiva, es decir, ajustarse en función del dispositivo utilizado | Las funcionalidades principales son utilizables desde ordenador, tablet y teléfono móvil |
| NFR-02 | Compatibilidad | La aplicación deberá funcionar en navegadores actuales de escritorio y móvil | Funciona en las versiones actuales de Chrome, Firefox, Edge y Safari, y en los navegadores actuales de Android e iOS |
| NFR-03 | Interoperabilidad | Los PDF deberán abrirse de forma estándar | Un PDF generado se abre en un visor estándar |
| NFR-03b | Interoperabilidad | Los CSV exportados no deberán mostrar caracteres rotos con tildes | Un CSV con tildes y nombres extranjeros se abre sin caracteres rotos |
| NFR-04 | Restricción tecnológica | La aplicación deberá utilizar software libre | Las herramientas y dependencias principales tienen licencia de software libre |
| NFR-05 | Documentación | La aplicación deberá tener documentación de usuario corta; documentación técnica (despliegue, modelo de datos, API y restauración de backup); y documentación de decisiones importantes, configuración y reglas de negocio | Existen los tres tipos de documentación y la de usuario es corta (extensión máxima a definir por el equipo) |
| NFR-06 | Mantenibilidad / Testabilidad | Toda regla de negocio deberá quedar escrita en un test o un escenario, no solo en el código | Cada regla de negocio de la sección 5 tiene al menos un test o escenario asociado |
| NFR-06b | Mantenibilidad / Testabilidad | Los escenarios de aceptación deberán estar escritos en lenguaje sencillo, comprensible para alguien de administración | Un miembro de administración puede leer un escenario de aceptación y explicar qué comprueba |
| NFR-07 | Seguridad | El sistema deberá limitar el tamaño de cada archivo adjunto (10 MB) | Un archivo mayor de 10 MB es rechazado con un mensaje explicativo (supuesto A-01) |
| NFR-08 | Seguridad | Los archivos adjuntos no deberán ejecutarse ni interpretarse en el servidor | Un archivo con código subido como adjunto no se ejecuta |
| NFR-09 | Seguridad | El acceso a un adjunto deberá seguir los permisos del cliente y de la factura a la que está asociado | Un usuario que no puede ver la factura no puede ver su adjunto |
| NFR-10 | Mantenibilidad / Extensibilidad | Cambiar el proveedor de pagos (por ejemplo, Stripe) no deberá requerir modificar las facturas existentes | Se puede sustituir el proveedor de pagos simulado por otro de prueba sin modificar las facturas ya almacenadas |
| NFR-11 | Seguridad | La configuración y los secretos (por ejemplo, las claves de Stripe simulado) deberán estar separados del código y no almacenarse en el repositorio | El repositorio no contiene claves ni secretos y la configuración se carga desde fuera del código |
| NFR-12 | Despliegue | La aplicación deberá poder ponerse en marcha de forma reproducible, con al menos un entorno de desarrollo o pruebas y un procedimiento documentado para producción | Existe un procedimiento documentado que permite poner en marcha la aplicación desde cero |


## 5. Reglas de negocio

Reglas del dominio o de la organización que condicionan el comportamiento del sistema
pero que no representan por sí mismas una funcionalidad.

| ID | Regla |
|---|---|


## 6. Suposiciones y decisiones de análisis

En esta sección se documentarán las decisiones tomadas por el equipo cuando la
información proporcionada por el cliente no sea suficiente para determinar unívocamente
un requisito.

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | El tamaño máximo por archivo adjunto es de 10 MB | El cliente pidió un límite "razonable" sin concretarlo | NFR-07 |
| A-02 | La sesión se cierra tras 30 minutos de inactividad | El cliente pidió una expiración "razonable" | FR-24 |
| A-03 | Se bloquea el acceso 15 minutos tras 5 intentos fallidos de login | El cliente pidió protección básica sin convertirla en "un infierno de bloqueos" | FR-39 |
| A-04 | La lista de formatos permitidos es PDF, JPG/PNG, DOCX, XLSX y CSV | El cliente pidió limitar formatos sin concretarlos | FR-47 |
| A-05 | La regularización retroactiva la aprueba un administrador | El cliente pidió que fuera "explícita y aprobada" sin indicar quién | FR-52b |
| A-06 | Los criterios de detección de duplicados son nombre o razón social, identificador fiscal, email y teléfono | El cliente habló de duplicados "razonables" y citó el identificador fiscal | FR-35 |
| A-07 | El teléfono del contacto es el dato "conveniente" que puede faltar | Es el único ejemplo citado por el cliente | FR-54 |
| A-08 | Los límites de uso de la API quedan por definir | El cliente pidió límites "razonables" | FR-29 |
| A-09 | Los requisitos marcados como (opcional) son ampliaciones | El cliente los presentó como ampliaciones y no como parte del primer despliegue | FR-02 a FR-06, FR-42 a FR-44 |


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
| BR-01 | UR-01 | FR-01, FR-02 |
| BR-02 | UR-03 | FR-07, NFR-02 |


## 9. Glosario

| Término | Definición |
|---|---|
| Factura emitida | Factura que ya ha sido emitida y no puede modificarse |
| Factura rectificativa | Documento que corrige una factura emitida y queda vinculado a la original |
| Borrador de factura | Estado previo a la emisión en el que la factura puede editarse o borrarse sin consumir numeración oficial. |
| Presupuesto | Documento previo a una factura que puede ser aceptado o rechazado |
| Saldo | Importe pendiente de cobro de un cliente, considerando facturas, rectificativas y pagos |
| Facturación | Importe total facturado a un cliente en un periodo |
| Campaña de revisión | Proceso anual que lista los clientes cuya facturación anual debe revisarse |
| Rango de plan | Tramo de facturación anual al que corresponde una tarifa |
| Solicitud controlada | Petición externa que pasa por validación o aprobación antes de afectar a los datos |
| Entidad emisora | Sociedad que emite facturas, con sus series de numeración |

