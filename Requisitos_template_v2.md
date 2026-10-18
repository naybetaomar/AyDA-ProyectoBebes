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
| BR-01 | Representar la relacion comercial de cada cliente de forma independiente de sus facturas y del producto | Entrevista ampliada |
| BR-02 | Administrar clientes y facturacion mediante una herramienta interna independiente n | Entrevista ampliada |
| BR-03 | Conocer la situacion global del negocio sin revisar cada cliente individualmente a medida que crezca la cartera | Entrevista ampliada |
| BR-04 | Poder gestionar empresas internacionales sin asumir que todas usan formatos fiscales o domicilios españoles | Entrevista ampliada |
| BR-05 | Conservar el historial de clientes, contactos, relaciones comerciales y facturas durante el plazo permitido por la ley | Entrevista ampliada |

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
| UR-01 | Personal administrativo | Poder registrar y consultar la informacion de la empresa, incluido pais, identificacion fiscal y moneda | entrevista |
| UR-02 | Personal administrativo | Poder gestionar uno o varios contactos de cada empresa | entrevista |
| UR-03 | Personal administrativo | Poder consultar la informacion de la relacion comercial: fecha de inicio, servicio o plan, tarifa, condiciones de pago, responsable interno y documentos firmados | entrevista |
| UR-04 | Personal administrativo | Poder preparar y emitir facturas, y revisar el calculo prorrateado antes de emitirlas | entrevista |
| UR-05 | Personal administrativo | Poder consultar el estado de cobro, el historial y la trazabilidad de las facturas | entrevista |
| UR-06 | Personal administrativo | Poder borrar un borrador de factura que no se haya emitido | entrevista |
| UR-07 | Personal administrativo | Poder programar la emision de facturas futuras | entrevista |
| UR-08 | Superadministrador | Poder configurar el rango de las tarifas | entrevista |
| UR-09 | Personal administrativo | Poder recibir avisos para revisar los rangos de precios y consultar el rango propuesto | entrevista |
| UR-10 | Personal administrativo | Poder modificar los impuestos de una factura segun las reglas establecidas o de forma extraordinaria | entrevista |
| UR-11 | Personal administrativo | Poder proponer una factura nueva o modificada | entrevista |
| UR-12 | Administrador | Poder recibir las propuestas de factura y aprobarlas o rechazarlas | entrevista |
| UR-13 | Superadministrador | Poder configurar el umbral de facturacion | entrevista |
| UR-14 | Superadministrador | Poder autorizar una factura que supere el umbral de facturacion | entrevista |
| UR-15 | Superadministrador | Poder configurar la serie de las facturas | entrevista |
| UR-16 | Personal administrativo | Poder gestionar facturas puntuales y recurrentes | Primera sesion, confirmada en entrevista ampliada |
| UR-17 | Personal administrativo | Poder generar y consultar las facturas en formato PDF | Primera sesion, confirmada en entrevista ampliada |
| UR-18 | Personal administrativo | Poder hacer seguimiento de los cobros y enviar recordatorios de pago | entrevista |
| UR-19 | Administrador | Poder gestionar usuarios y asignar permisos | entrevista |
| UR-20 | Personal administrativo | Poder consultar de forma global la situacion de los clientes y las facturas sin abrir cada cliente | entrevista |
| UR-21 | Personal administrativo | Poder consultar los clientes con fecha de inicio futura y pendientes de activacion | entrevista |


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
| FR-01 | El sistema deberá permitir registrar y consultar el nombre comercial, la razon social, el identificador fiscal, el domicilio fiscal, el pais y la moneda de trabajo de una empresa | UR-01 |
| FR-02 | El sistema deberá permitir registrar varias personas de contacto para una empresa | UR-02 |
| FR-03 | El sistema deberá permitir marcar una persona de contacto como inactiva sin eliminar las facturas ni el historico asociado a ella | UR-02 |
| FR-04 | Al enviar una factura, el sistema deberá guardar los destinatarios y direcciones utilizados en ese envio | UR-02, UR-17 |
| FR-05 | El sistema deberá permitir registrar la factura de una empresa incluyendo fecha de inicio, servicio o plan, tarifa, responsable interno , condiciones de pago y documentos firmados | UR-03 |
| FR-06 | El sistema deberá permitir seleccionar los impuestos aplicables entre los impuestos previamente configurados | UR-10 |
| FR-07 | El sistema deberá permitir crear facturas puntuales | UR-04, UR-16 |
| FR-08 | El sistema deberá permitir configurar la facturacion recurrente mensual de una relacion comercial aprobada | UR-04, UR-16 |
| FR-09 | El sistema deberá generar las facturas recurrentes mensuales el dia uno para las relaciones comerciales activas, de manera automatica | UR-16 |
| FR-10 | Para un alta durante el mes, se cobrar cada dia 1|  UR-16 |
| FR-11 | Antes de confirmar el alta, el sistema deberá mostrar al usuario el importe prorrateado y la mensualidad normal calculados, para que pueda revisarlos | UR-04 |
| FR-12 | El sistema deberá permitir indicar explicitamente una excepcion comercial para iniciar la facturacion el mes siguiente sin cobrar prorrateo | UR-16 |
| FR-13 | El sistema deberá permitir establecer una fecha de inicio futura y mostrar la relacion comercial como pendiente de activacion hasta esa fecha | UR-21 |
| FR-14 | El sistema no deberá generar facturas ni recordatorios de cobro antes de la fecha de inicio futura de una relacion comercial | UR-18, UR-21 |
| FR-15 | El sistema deberá permitir programar la emision de facturas para una fecha futura | UR-07 |
| FR-16 | El sistema deberá generar y permitir consultar la representacion PDF de una factura | UR-17 |
| FR-17 | El sistema deberá permitir registrar el estado de cobro de cada factura y consultar las facturas pendientes, vencidas, pagadas o parcialmente conciliadas | UR-05, UR-18 |
| FR-18 | El sistema deberá permitir registrar los pagos o la parte pagada dejando ver que hay importe pendiente | UR-05 |
| FR-19 | El sistema deberá permitir enviar recordatorios de cobro para facturas vencidas y registrar que se enviaron | UR-18 |
| FR-20 | El sistema deberá mostrar un resumen global de clientes y facturas para consultar | UR-20 |
| FR-21 | El sistema deberá permitir al superadministrador configurar los rangos de facturacion anual y sus precios sin modificar el codigo de la aplicacion | UR-08 |
| FR-22 | El sistema deberá permitir registrar la facturacion anual verificada de un cliente y señalar cuándo corresponde revisar su rango de tarifa | UR-09 |
| FR-23 | El sistema deberá proponer el rango de tarifa correspondiente a partir de la facturacion anual verificada y de los rangos configurados | UR-09 |
| FR-24 | El sistema deberá exigir validacion humana antes de aplicar un cambio de rango de tarifa y registrar quién lo aprobo, cuándo, el precio anterior y el nuevo | UR-09 |
| FR-25 | Un cambio en la configuracion de tarifas no deberá modificar los importes ni los datos de las facturas historicas ya emitidas | UR-08, UR-09 |
| FR-26 | El sistema deberá permitir preparar propuestas de excepcion comercial, como descuentos, meses gratuitos o precios acordados para servicios adicionales | UR-11 |
| FR-27 | El sistema deberá permitir configurar los umbrales y niveles de aprobacion para excepciones comerciales y cambios economicos | UR-12, UR-13, UR-14 |
| FR-28 | El sistema deberá dejar pendiente de aprobacion una factura que incluya un cambio manual de importe, un descuento extraordinario, una fecha de vencimiento excepcional o un importe puntual que supere el umbral configurado, indicar el motivo y dirigirla al aprobador que corresponda | UR-11, UR-12, UR-13, UR-14 |
| FR-29 | El sistema deberá permitir al administrador o superadministrador, segun las reglas configuradas, aprobar o rechazar las propuestas pendientes y registrar la decision | UR-12, UR-14 |
| FR-30 | El sistema deberá permitir configurar las series de facturacion al superadministrador | UR-15 |
| FR-31 | El sistema deberá asignar al emitir una factura un numero definitivo unico dentro de su serie | UR-15 |
| FR-32 | Un borrador no deberá consumir el numero definitivo de una factura | UR-06, UR-15 |
| FR-33 | Si falla el envio de una factura ya emitida, reintentar el envio no deberá crear otra factura ni asignar un numero nuevo | UR-15, UR-17 |
| FR-34 | El sistema deberá permitir modificar o borrar una factura antes de emitirla  | UR-04, UR-05, UR-06 |
| FR-35 | Para corregir una factura emitida, el sistema deberá conservar la factura original y permitir registrar la factura rectificativa | UR-05 |
| FR-36 | El sistema deberá permitir borrar únicamente borradores que nunca se hayan emitido | UR-06 |
| FR-37 | El sistema deberá permitir al administrador gestionar usuarios y asignarles permisos de acceso | UR-19 |


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
| NFR-01 | Independencia | La aplicacion  deberá funcionar como herramienta independiente de la empresa, sin depender de su interfaz o disponibilidad para las operaciones administrativas | Se pueden completar los flujos administrativos principales mientras Brain no está disponible |
| NFR-02 | Rapidez de usuar | Las operaciones administrativas frecuentes deberán poder realizarse con pocos pasos | El alta normal de una empresa no debe de tener menos de 5 clicks |
| NFR-03 | Escalabilidad | La aplicacion deberá permitir consultar la situacion global del negocio  independiente del numero de cliente | Poder ver el global sin abrir los clientes uno por uno |
| NFR-04 | Compatibilidad movil | La aplicacion deberá poder utilizarse desde un telefono movil | Debe poder realizar los requisitos funcionales desde el movil |
| NFR-05 | Seguridad y permisos | El acceso a datos y operaciones deberá limitarse segun los permisos asignados a cada usuario | Una jerarquia de permisos deja poder realizar y observar los datos y funciones permitidos para cada rol|
| NFR-06 | Integridad y auditoria | Los cambios economicos y las acciones sobre facturas emitidas deberán ser trazables y no alterarse el historico | Para cada cambio sujeto a auditoria se conserva usuario, fecha y valores anteriores y nuevos; una factura emitida mantiene su contenido original |
| NFR-07 | Internacionalizacion | El almacenamiento de empresas deberá admitir paises sin imponer formatos exclusivos de España | Se pueden registrar empresas de distintos paises sin exigir formatos |
| NFR-08 | Privacidad y conservacion | La conservacion y eliminacion de datos deberá ajustarse a las obligaciones legales aplicables | Antes de aceptar el sistema se documentan los plazos y reglas de conservacion y se comprueba que el borrado logico y las restricciones de acceso los respetan |


## 5. Reglas de negocio

Reglas del dominio o de la organización que condicionan el comportamiento del sistema
pero que no representan por sí mismas una funcionalidad.

| ID | Regla |
|---|---|
| RB-01 | una factura tiene una id unica solo cuando esta emitida |
| RB-02 | se factura el dia 1 del mes y desde el dia que empezo la relacion |
| RB-03 | No se puede eliminar datos de la empresa y la factura hasta que la ley lo permita|
| RB-04 | Todas las excepciones deben ser aceptadas por un superadministrados|


## 6. Suposiciones y decisiones de análisis

En esta sección se documentarán las decisiones tomadas por el equipo cuando la
información proporcionada por el cliente no sea suficiente para determinar unívocamente
un requisito.

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | Prorrateo segun el porcentaje de dias que le falta con la cantidad de dias que tiene el mes | Justo para el cliente | FR-10, FR-11 |
| A-02 |  | ... | ... |


## 7. Dudas, ambigüedades y cuestiones pendientes

Se incluirán aquí aspectos de la información proporcionada por el cliente que sean
ambiguos, incompletos, contradictorios o que requieran aclaración.

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|

| Q-02 | ¿Cuáles serán los estados y transiciones definitivos de una factura, y qué procedimiento legal se aplicará para anularla o rectificarla? | Entrevista ampliada / gestoría | FR-17, FR-35 | Pendiente de validar con gestoría |
| Q-03 | ¿Cuándo se considera vencida una factura y con qué frecuencia y canal se enviarán recordatorios? | Entrevista ampliada | FR-17, FR-19 | Pendiente de definir |
| Q-04 | ¿Qué fuente se utilizará para verificar la facturacion anual y desde qué fecha se aplicará un cambio de rango aprobado? | Entrevista ampliada | FR-22 a FR-25 | Pendiente de definir |
| Q-05 | ¿Qué umbrales concretos y roles de aprobacion se aplicarán a descuentos, cambios de importe, vencimientos excepcionales y facturas puntuales? | Entrevista ampliada | FR-27 a FR-29 | Pendiente de configurar por el negocio |
| Q-06 | ¿Qué plazos y excepciones legales determinan la conservacion o eliminacion de los datos historicos? | Entrevista ampliada / asesoramiento legal | FR-03, FR-34 a FR-36, NFR-08 | Pendiente de validar legalmente |
| Q-07 | ¿Qué tiempos máximos de respuesta se exigirán para las operaciones frecuentes y para el resumen de 1000 clientes? | Entrevista ampliada | NFR-02, NFR-03 | Pendiente de acordar |
| Q-08 | ¿Qué dispositivos y tamaños de pantalla móviles se incluirán en las pruebas de aceptación? | Primera sesion | NFR-04 | Pendiente de definir |
| Q-09 | ¿Qué impuestos estarán precargados y quién tendrá permisos para mantenerlos? | Entrevista ampliada | FR-06 | Pendiente de definir |
| Q-10 | ¿Qué significa exactamente “observar el inicio de las facturas iniciales” en el requisito original UR-35? | Entrevista ampliada pag3 | Requisito de usuario UR-35 | Pendiente de aclarar |


## 8. Trazabilidad

La tabla permitirá comprobar la relación entre las necesidades de negocio,
los requisitos de usuario y los requisitos del sistema.

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
|---|---|---|
| BR-01 | UR-C03 | FR-05 |
| BR-02 | UR-C01, UR-C19 | FR-01, FR-37, NFR-01 |
| BR-03 | UR-C20 | FR-20, NFR-03 |
| BR-04 | UR-C01, UR-C10 | FR-01, FR-06, NFR-07 |
| BR-05 | UR-C02, UR-C05 | FR-03, FR-17, FR-34, FR-35, FR-36, NFR-06, NFR-08 |


## 9. Glosario

| Término | Definición |
|---|---|
| ... | ... |
