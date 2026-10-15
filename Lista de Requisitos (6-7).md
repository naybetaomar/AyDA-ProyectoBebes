# Requisitos

## 1. Contexto y alcance

### 1.1. Objetivo del sistema

Breve descripción del problema que se pretende resolver y del objetivo general del sistema.

### 1.2. Alcance

Descripción de qué responsabilidades corresponden al sistema y, cuando sea relevante, qué elementos quedan explícitamente fuera de su alcance.

### 1.3. Actores y partes interesadas

Identificar las personas, organizaciones o sistemas que interactúan con el sistema o tienen algún interés relevante en su funcionamiento.

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Superadministrador / Proveedor | Usuario con máximo nivel de privilegios | Poder editar todo rango de configuraciones en la aplicación (umbral de precio, rangos, tarifas, ...) |
| Administrador / Responsable | Empleado con casi todos los privilegios, pero sin acceso a la configuración | Supervisar el estado global del sistema y consultar el histórico de cualquier cliente; gestionar los cambios de plan anuales de los clientes; garantizar la integridad de la facturación, corrigiendo errores con facturas rectificativas; gestionar el control de acceso |
| Editor / Trabajador | Empleado con acceso a la aplicación con privilegios básicos | Realizar operaciones administrativas diarias; conocer el saldo y las facturas pendientes y pagadas de los clientes asignados; disponer de un control claro sobre el estado real de los envíos |

## 2. Requisitos

### 2.1. Restricciones

- **Restricción1:** Factura y presupuesto no son lo mismo. Cada documento conserva su identidad e histórico.
- **Restricción2:** El saldo no es lo mismo que la facturación.
- **Restricción3:** Leído no es lo mismo que resuelto. Una notificación abierta no implica que el problema que avisa haya desaparecido.
- **Restricción4:** Auditoría y backup son cosas distintas: la auditoría sirve para saber qué ocurrió; el backup para recuperar el sistema si algo se rompe.
- **Restricción5:** No existe autorregistro de usuarios internos.
- **Restricción6:** El doble factor de autenticación no es obligatorio en el alcance mínimo.

### 2.2. Requisitos Funcionales

RF1: El sistema debe generar facturas en formato pdf
RF2: El sistema debe generar presupuestos (opcional)
RF3: El sistema debe permitir enviar el presupuesto al cliente (opcional)
RF4: Un usuario con permiso debe poder marcar un presupuesto como aceptado o rechazado (opcional)
RF5: El sistema debe permitir adjuntar al presupuesto la evidencia de la aceptación (opcional)
RF6: Si el presupuesto está aceptado, el sistema debe convertirlo en factura reutilizando las líneas (opcional)
RF7: El sistema no debe permitir que se modifiquen facturas emitidas.
RF8: En caso de error en una factura emitida, un administrador debe poder generar una factura rectificativa vinculada a la factura original.
RF9: Si el importe de la rectificativa supera el umbral configurado, esta debe ser aprobada antes de emitirse.
RF10: El sistema debe proponer los datos a rectificar a partir de la factura original.
RF11: El sistema debe recalcular el saldo del cliente a través de la factura rectificativa.
RF12: El sistema debe generar un dashboard que comprueba el saldo, facturas pendientes, facturas pagadas. Cada cifra del dashboard se puede detallar.
RF13: El sistema debe iniciar a principios de cada año una campaña de revisión que lista los clientes cuya facturación anual debe revisarse.
RF14: El sistema debe obtener la facturación anual de datos simulados o de entrada manual, y registrar la fuente y la fecha del dato. Si el dato no está disponible, la revisión queda pendiente.
RF15: El sistema debe proponer el nuevo rango correspondiente
RF16: En caso de propuesta de cambio de plan, el administrador debe verificar la propuesta de nuevo rango.
RF17: Si el cambio es válido, el nuevo precio tiene fecha de efecto. El nuevo precio no reescribe meses anteriores.
RF18: El sistema debe registrar quién aprobó el cambio de plan, cuándo, y el precio anterior y el nuevo.
RF19: El sistema debe monitorear colas de email pendientes.
RF20: El sistema debe monitorear errores de integración recientes.
RF21: El sistema debe monitorear el ultimo backup realizado
RF22: El sistema debe mostrar la ultima ejecución de la generación recurrente.
RF23: El sistema debe mostrar el historial de cada cliente (alta, cambio de responsables, cambios de tarifa, facturas emitidas, pagos, incidencias, pausas, baja, reactivación)
RF24: El sistema debe cerrar sesion automaticamente tras un tiempo de 30 minutos de inactividad.
RF25: El sistema debe exponer una API que permite a sistemas externos (por ejemplo, Brain) consultar clientes, estado de deuda y facturas.
RF26: La API permite crear solicitudes controladas, que pasan por validación o aprobación y no modifican datos directamente.
RF27: La API aplica las mismas reglas de negocio y validaciones que la interfaz. Una llamada externa no puede hacer nada que un usuario no podría hacer.
RF28: La API usa una autenticación separada de la de los usuarios de la interfaz.
RF29: La API aplica límites razonables de uso por consumidor.
RF30: El sistema debe registrar las llamadas importantes a la API (quién la hizo, cuándo y qué operación).
RF31: El sistema debe ser capaz de recibir solicitudes de baja.
RF32: El sistema debe permitir consultar, a partir de un identificador de cliente, si existen obligaciones pendientes y el detalle mínimo autorizado.
RF33: En caso de solicitud de baja, el sistema debe crear la tarea "darse de baja", sin eliminar directamente la recurrencia.
RF34: El sistema debe generar logs técnicos sin mostrar información técnica sensible al usuario
RF35: El sistema debe generar un código de incidencia que permita correlacionar el error.
RF36: Antes de dar de alta, el sistema debe buscar duplicados: coincidencias en nombre o razón social, mismo identificador fiscal, mismo email o teléfono
RF37: Si encuentra duplicados, se le muestra al usuario que decide si crear un nuevo cliente o usar el existente.
RF38: El sistema debe validar el formato de email.
RF39: El sistema debe validar el identificador fiscal siempre que el país sea conocido (NIF/CIF en España o VAT), si no se conoce, la validación queda pendiente.
RF40: Tras 5 intentos fallidos de login consecutivos, el sistema debe bloquear temporalmente el acceso del usuario durante 15 minutos.
RF41: El sistema debe invalidar la sesión de un usuario desactivado por un administrador.
RF42: El sistema debe guardar los datos fiscales del emisor como configuración.
RF43: El sistema puede tener varias entidades emisoras (opcional)
RF44: El sistema debe identificar a cada entidad con series de numeración (opcional)
RF45: Al emitir una factura, un usuario con permiso puede seleccionar una entidad emisora correspondiente (opcional)
RF46: El sistema debe permitir adjuntar documentos a clientes y facturas, además del pdf que genera el sistema.
RF47: Cada adjunto tiene un tipo (pedido del cliente, presupuesto aceptado, justificante de pago, documento de la gestoría, otro) y una descripción.
RF48: El sistema solo admite formatos de una lista permitida: PDF, JPG/PNG, DOCX, XLSX y CSV. Ejecutables y scripts (.exe, .bat, .js…) se rechazan.
RF49: El sistema debe registrar y mostrar al usuario el estado de creación de una factura (creada o no creada).
RF50: El sistema debe registrar y mostrar al usuario el estado de envío de una factura (enviada o fallo de envío).
RF51: En caso de descubrir que un dato de una revisión anual era incorrecto, el sistema debe permitir corregir la ficha de revisión, registrando la corrección.
RF52: El sistema debe calcular el impacto potencial de la corrección sobre el precio de los meses afectados.
RF53: El sistema no debe emitir facturas retroactivas automáticamente. Cualquier regularización debe ser una acción explícita y aprobada por un administrador.
RF54: El sistema debe bloquear la emisión de una factura si falta un dato fiscal imprescindible, e indicar qué dato falta.
RF55: El sistema debe permitir guardar un cliente sin los datos convenientes (el teléfono del contacto) como excepción controlada, y registrar qué datos faltan.
RF56: El sistema debe eliminar los espacios sobrantes de los datos introducidos (nombre, razón social, email e identificador fiscal).
RF57: El sistema debe permitir marcar clientes como favoritos y mostrar los clientes consultados recientemente.
RF58: El sistema debe comprobar los permisos del usuario en cada acceso a un cliente o a una factura, aunque se acceda mediante una URL directa, y rechazar el acceso si no le corresponde.

#### Página 6

RF59: El sistema debe gestionar notificaciones internas, distintas de los emails enviados a los clientes.
RF60: Cada cliente debe tener un responsable interno al que le llegan los eventos relevantes: pago confirmado, factura vencida, rebote de email, disputa abierta, revisión anual pendiente, aprobación rechazada, etc.
RF61: El administrador debe poder ver una bandeja global de notificaciones y el usuario debe ver únicamente las suyas.
RF62: El superadministrador debe poder elegir qué notificaciones se reciben dentro de la aplicación, cuáles por email y cuáles en un resumen diario para determinadas categorías.
RF63: El sistema debe permitir marcar las notificaciones como leídas.
RF64: El sistema debe permitir dar por atendidas determinadas notificaciones (por ejemplo, una deuda), distinguiendo "leída" de "resuelta". Las alertas informativas (por ejemplo, "pago recibido") pueden quedar simplemente leídas.
RF65: Las notificaciones deben tener estados y prioridades.
RF66: El sistema debe ofrecer una pantalla de trabajo diaria que muestre: facturas que vencen pronto, facturas vencidas, pagos que necesitan conciliación, clientes con problemas de entrega, aprobaciones pendientes, revisiones anuales que tocan y tareas asignadas al usuario.
RF67: Desde la pantalla de trabajo diaria el usuario debe poder saltar al elemento y resolverlo con pocos clics.
RF68: El sistema debe ofrecer a los administradores un dashboard financiero con: facturado en la semana, mes, trimestre y año; cobrado; pendiente; vencido; tiempo medio de cobro; evolución; clientes con mayor deuda; ingresos recurrentes esperados del mes; facturación puntual; y previsión sencilla basada en las recurrencias activas.
RF69: Los informes deben poder filtrarse por periodo, cliente, responsable interno, país, sector, estado de factura, tipo (recurrente o puntual) y, si tiene sentido, moneda.
RF70: El sistema debe permitir exportar resultados a CSV y un informe legible a PDF.
RF71: La exportación debe respetar los permisos del usuario (un usuario que solo ve cinco clientes no puede exportar los datos de todos los clientes).
RF72: El sistema debe ofrecer una búsqueda global por parte del nombre comercial, razón social, NIF, persona de contacto, número de factura o correo.
RF73: El sistema debe mantener los filtros de ubicación y sector.
RF74: El sistema debe permitir guardar filtros o vistas frecuentes (por ejemplo, "mis impagados de más de 15 días").
RF75: El sistema debe permitir importar clientes desde un CSV con una previsualización antes de confirmar.
RF76: En la importación de clientes, el usuario debe poder mapear columnas, ver los errores y decidir si corrige el fichero o importa solo las filas válidas, según la política definida.
RF77: Si se detecta un NIF duplicado durante la importación, el sistema debe avisar.
RF78: La importación completa debe quedar registrada como una operación, con resumen de creados, actualizados, rechazados y motivos.
RF79: El sistema debe contemplar una importación administrativa de histórico de facturas, distinta de la emisión de facturas nuevas.
RF80: Una factura histórica importada no debe disparar el envío de un email al cliente ni consumir una numeración nueva, y debe quedar marcada como migrada, con su número y documento original si se dispone de ellos.
RF81: El acceso de los usuarios internos debe hacerse con email y contraseña, y el email debe pertenecer al dominio corporativo autorizado.
RF82: El sistema no debe permitir el autorregistro de usuarios.
RF83: El superadministrador, o un administrador con permiso, debe poder crear o invitar usuarios.
RF84: Si un usuario deja Turbine, el sistema debe permitir desactivar su cuenta sin borrar el rastro de las acciones que realizó.
RF85: El sistema debe permitir la recuperación de contraseña.
RF86: Los enlaces de recuperación de contraseña deben caducar tras un tiempo razonable.

#### Página 7

RF87: El sistema debe distinguir tres tipos de rol: superadministrador (configuración profunda), administrador (gestiona operación, clientes, facturas, asignaciones y aprobaciones según permisos) y usuario operativo (trabaja sobre lo que tiene asignado).
RF88: El sistema debe disponer de un modelo coherente de autorización de permisos.
RF89: El usuario operativo debe poder tener clientes concretos asignados, y sobre ellos puede ver y modificar la información operativa, crear facturas si su permiso lo permite, seguir cobros y descargar documentos.
RF90: El usuario operativo no debe poder darse a sí mismo acceso a otro cliente, cambiar tarifas globales, crear series de facturación ni ver el dashboard financiero global.
RF91: Un administrador debe poder asignar y desasignar clientes.
RF92: Si cambia la asignación de un cliente, el nuevo responsable debe heredar las tareas pendientes y el histórico debe seguir indicando quién hizo cada acción anteriormente.
RF93: Un administrador debe poder delegar los clientes de un usuario a otra persona durante un intervalo (sustitución temporal), sin perder la asignación principal.
RF94: La delegación temporal debe caducar automáticamente al terminar el intervalo.
RF95: El sistema debe detectar los conflictos de edición concurrente sobre una misma factura (o bloquearla de forma razonable) para que no se sobrescriban cambios silenciosamente.
RF96: Las operaciones monetarias críticas, la numeración y la conciliación deben ser consistentes aunque dos personas las ejecuten casi a la vez.
RF97: El sistema debe registrar una auditoría que permita saber quién creó un cliente, cambió un dato fiscal, emitió una factura, cambió un vencimiento, aprobó un descuento, reasignó un cliente, marcó una disputa, hizo una conciliación manual y cambió la configuración.
RF98: La auditoría no debe ser editable por usuarios normales.
RF99: El superadministrador debe poder consultar y filtrar la auditoría, pero no reescribirla.
RF100: El sistema debe realizar copias de seguridad automáticas de datos y documentos con una política definida.
RF101: El sistema debe permitir restaurar las copias de seguridad, y el mecanismo de restauración debe poder demostrarse.
RF102: Las facturas, datos fiscales y contactos no deben ser accesibles mediante URLs públicas adivinables.
RF103: Un usuario autenticado solo debe poder descargar los documentos que tiene permiso para ver.
RF104: Si se generan enlaces temporales de descarga, estos deben caducar.

### 2.3. Requisitos No Funcionales

RNF1: La aplicación debe ser responsiva, es decir, que se ajuste en función del dispositivo utilizado.
RNF2: La aplicación debe funcionar en las versiones actuales de Chrome, Firefox, Edge y Safari, y en los navegadores actuales de Android e iOS.
RNF3: Los PDF deben abrirse de forma estándar y los CSV exportados no deben mostrar caracteres rotos con tildes.
RNF4: La aplicación debe utilizar software libre. (comentarlo en la sesión de grupo)
RNF5: La aplicación debe tener documentación de usuario corta; documentación técnica (despliegue, modelo de datos, API y restauración de backup) y documentación de decisiones importantes, configuración y reglas de negocio.
RNF6: Toda regla de negocio debe quedar escrita en un test o un escenario, no solo en el código ni en la cabeza de alguien. Habrá escenarios de aceptación escritos en lenguaje sencillo, que alguien de administración pueda entender.
RNF7: Hay un tamaño máximo por archivo, 10MB (esto es un supuesto, revisad si os parece bien)
RNF8: Los archivos no se ejecutan ni se interpretan en el servidor.
RNF9: El acceso a un adjunto sigue los permisos de los clientes y la factura a la que está asociado, si no puedes ver la factura, no puedes ver el adjunto
RNF10: Cambiar el proveedor de pagos (por ejemplo, Stripe) no debe requerir modificar el modelo de factura.
RNF11: La configuración y los secretos (por ejemplo, las claves de Stripe simulado) deben estar separados del código y no almacenarse en el repositorio.
RNF12: La aplicación debe poder ponerse en marcha de forma reproducible, con al menos un entorno de desarrollo o pruebas y un procedimiento documentado para producción.

#### Página 6

RNF13: Las contraseñas no deben almacenarse en texto plano.
RNF14: Las comunicaciones deben ir cifradas.
RNF15: Los secretos de Stripe, aunque sea simulado, no deben estar en el repositorio.
RNF16: El diseño de la autenticación no debe impedir incorporar en el futuro el doble factor de autenticación (aunque no sea obligatorio en el alcance mínimo).

#### Página 7

RNF17: Los permisos no deben estar dispersos en condicionales por todo el código; debe existir un modelo coherente de autorización.
RNF18: Una copia de seguridad debe poder probarse restaurándola (una copia que nunca se ha probado no es fiable).
RNF19: El sistema de backup no necesita ser un almacenamiento distribuido, pero el mecanismo debe estar diseñado y demostrado.
RNF20: Si por normativa hay que purgar datos personales, debe poder anonimizarse sin destruir la trazabilidad necesaria de la auditoría.
RNF21: El sistema debe aplicar minimización y conservación de datos personales (sin que ello suponga asesoramiento jurídico).

### 2.4. Requisitos de Usuario

RU1: El usuario debe distinguir entre una factura existente que no se pudo enviar y una factura que no se pudo crear.

#### Página 6

RU2: El usuario quiere ver al entrar una pantalla de trabajo diaria útil (no decorativa) con lo que requiere su atención y poder resolverlo con pocos clics.
RU3: El responsable interno de un cliente quiere recibir las notificaciones relevantes de ese cliente y distinguir las ya leídas de las ya resueltas.
RU4: El superadministrador quiere poder elegir qué notificaciones recibe por la aplicación, por email o en resumen diario, para no recibir cientos de correos al día.
RU5: El administrador quiere un dashboard financiero con cifras reales y poder generar informes filtrables, exportables a CSV y PDF.
RU6: El usuario quiere encontrar rápidamente un cliente o factura con una búsqueda global y guardar filtros frecuentes.
RU7: El usuario quiere importar clientes desde un CSV con previsualización para evitar que entren datos corruptos.
RU8: El administrador quiere poder importar el histórico de facturas para una migración futura sin que se envíen emails ni se consuma numeración.
RU9: El superadministrador o administrador quiere crear o invitar a los usuarios internos y desactivarlos cuando se vayan, sin perder el rastro de sus acciones.
RU10: El usuario quiere poder recuperar su contraseña mediante un enlace que caduque.

#### Página 7

RU11: El usuario operativo quiere trabajar sobre los clientes que tiene asignados, sin poder acceder a otros ni a la configuración global.
RU12: El administrador quiere asignar y desasignar clientes, y que el nuevo responsable herede las tareas pendientes manteniendo el histórico.
RU13: El administrador quiere delegar temporalmente los clientes de una persona (por ejemplo, vacaciones) sin compartir contraseñas.
RU14: El usuario quiere que la aplicación detecte los conflictos de edición para que nadie sobrescriba silenciosamente los cambios de otro.
RU15: El superadministrador quiere poder consultar quién hizo cada acción relevante (auditoría) sin poder alterar el pasado.
RU16: El responsable del sistema quiere disponer de copias de seguridad automáticas que se puedan restaurar.
RU17: El usuario autenticado quiere descargar solo los documentos que tiene permiso para ver.
