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

### 2.1. Requisitos Funcionales

#### Página 6

- RF59: El sistema debe gestionar notificaciones internas, distintas de los emails enviados a los clientes.
- RF60: Cada cliente debe tener un responsable interno al que le llegan los eventos relevantes: pago confirmado, factura vencida, rebote de email, disputa abierta, revisión anual pendiente, aprobación rechazada, etc.
- RF61: El administrador debe poder ver una bandeja global de notificaciones y el usuario debe ver únicamente las suyas.
- RF62: El superadministrador debe poder elegir qué notificaciones se reciben dentro de la aplicación, cuáles por email y cuáles en un resumen diario para determinadas categorías.
- RF63: El sistema debe permitir marcar las notificaciones como leídas.
- RF64: El sistema debe permitir dar por atendidas determinadas notificaciones (por ejemplo, una deuda), distinguiendo "leída" de "resuelta". Las alertas informativas (por ejemplo, "pago recibido") pueden quedar simplemente leídas.
- RF65: Las notificaciones deben tener estados y prioridades.
- RF66: El sistema debe ofrecer una pantalla de trabajo diaria que muestre: facturas que vencen pronto, facturas vencidas, pagos que necesitan conciliación, clientes con problemas de entrega, aprobaciones pendientes, revisiones anuales que tocan y tareas asignadas al usuario.
- RF67: Desde la pantalla de trabajo diaria el usuario debe poder saltar al elemento y resolverlo con pocos clics.
- RF68: El sistema debe ofrecer a los administradores un dashboard financiero con: facturado en la semana, mes, trimestre y año; cobrado; pendiente; vencido; tiempo medio de cobro; evolución; clientes con mayor deuda; ingresos recurrentes esperados del mes; facturación puntual; y previsión sencilla basada en las recurrencias activas.
- RF69: Los informes deben poder filtrarse por periodo, cliente, responsable interno, país, sector, estado de factura, tipo (recurrente o puntual) y, si tiene sentido, moneda.
- RF70: El sistema debe permitir exportar resultados a CSV y un informe legible a PDF.
- RF71: La exportación debe respetar los permisos del usuario (un usuario que solo ve cinco clientes no puede exportar los datos de todos los clientes).
- RF72: El sistema debe ofrecer una búsqueda global por parte del nombre comercial, razón social, NIF, persona de contacto, número de factura o correo.
- RF73: El sistema debe mantener los filtros de ubicación y sector.
- RF74: El sistema debe permitir guardar filtros o vistas frecuentes (por ejemplo, "mis impagados de más de 15 días").
- RF75: El sistema debe permitir importar clientes desde un CSV con una previsualización antes de confirmar.
- RF76: En la importación de clientes, el usuario debe poder mapear columnas, ver los errores y decidir si corrige el fichero o importa solo las filas válidas, según la política definida.
- RF77: Si se detecta un NIF duplicado durante la importación, el sistema debe avisar.
- RF78: La importación completa debe quedar registrada como una operación, con resumen de creados, actualizados, rechazados y motivos.
- RF79: El sistema debe contemplar una importación administrativa de histórico de facturas, distinta de la emisión de facturas nuevas.
- RF80: Una factura histórica importada no debe disparar el envío de un email al cliente ni consumir una numeración nueva, y debe quedar marcada como migrada, con su número y documento original si se dispone de ellos.
- RF81: El acceso de los usuarios internos debe hacerse con email y contraseña, y el email debe pertenecer al dominio corporativo autorizado.
- RF82: El sistema no debe permitir el autorregistro de usuarios.
- RF83: El superadministrador, o un administrador con permiso, debe poder crear o invitar usuarios.
- RF84: Si un usuario deja Turbine, el sistema debe permitir desactivar su cuenta sin borrar el rastro de las acciones que realizó.
- RF85: El sistema debe permitir la recuperación de contraseña.
- RF86: Los enlaces de recuperación de contraseña deben caducar tras un tiempo razonable.

#### Página 7

- RF87: El sistema debe distinguir tres tipos de rol: superadministrador (configuración profunda), administrador (gestiona operación, clientes, facturas, asignaciones y aprobaciones según permisos) y usuario operativo (trabaja sobre lo que tiene asignado).
- RF88: El sistema debe disponer de un modelo coherente de autorización de permisos.
- RF89: El usuario operativo debe poder tener clientes concretos asignados, y sobre ellos puede ver y modificar la información operativa, crear facturas si su permiso lo permite, seguir cobros y descargar documentos.
- RF90: El usuario operativo no debe poder darse a sí mismo acceso a otro cliente, cambiar tarifas globales, crear series de facturación ni ver el dashboard financiero global.
- RF91: Un administrador debe poder asignar y desasignar clientes.
- RF92: Si cambia la asignación de un cliente, el nuevo responsable debe heredar las tareas pendientes y el histórico debe seguir indicando quién hizo cada acción anteriormente.
- RF93: Un administrador debe poder delegar los clientes de un usuario a otra persona durante un intervalo (sustitución temporal), sin perder la asignación principal.
- RF94: La delegación temporal debe caducar automáticamente al terminar el intervalo.
- RF95: El sistema debe detectar los conflictos de edición concurrente sobre una misma factura (o bloquearla de forma razonable) para que no se sobrescriban cambios silenciosamente.
- RF96: Las operaciones monetarias críticas, la numeración y la conciliación deben ser consistentes aunque dos personas las ejecuten casi a la vez.
- RF97: El sistema debe registrar una auditoría que permita saber quién creó un cliente, cambió un dato fiscal, emitió una factura, cambió un vencimiento, aprobó un descuento, reasignó un cliente, marcó una disputa, hizo una conciliación manual y cambió la configuración.
- RF98: La auditoría no debe ser editable por usuarios normales.
- RF99: El superadministrador debe poder consultar y filtrar la auditoría, pero no reescribirla.
- RF100: El sistema debe realizar copias de seguridad automáticas de datos y documentos con una política definida.
- RF101: El sistema debe permitir restaurar las copias de seguridad, y el mecanismo de restauración debe poder demostrarse.
- RF102: Las facturas, datos fiscales y contactos no deben ser accesibles mediante URLs públicas adivinables.
- RF103: Un usuario autenticado solo debe poder descargar los documentos que tiene permiso para ver.
- RF104: Si se generan enlaces temporales de descarga, estos deben caducar.
- 
### 2.3. Requisitos No Funcionales

#### Página 6

- RNF13: Las contraseñas no deben almacenarse en texto plano.
- RNF14: Las comunicaciones deben ir cifradas.
- RNF15: Los secretos de Stripe, aunque sea simulado, no deben estar en el repositorio.
- RNF16: El diseño de la autenticación no debe impedir incorporar en el futuro el doble factor de autenticación (aunque no sea obligatorio en el alcance mínimo).

#### Página 7

- RNF17: Los permisos no deben estar dispersos en condicionales por todo el código; debe existir un modelo coherente de autorización.
- RNF18: Una copia de seguridad debe poder probarse restaurándola (una copia que nunca se ha probado no es fiable).
- RNF19: El sistema de backup no necesita ser un almacenamiento distribuido, pero el mecanismo debe estar diseñado y demostrado.
- RNF20: Si por normativa hay que purgar datos personales, debe poder anonimizarse sin destruir la trazabilidad necesaria de la auditoría.
- RNF21: El sistema debe aplicar minimización y conservación de datos personales (sin que ello suponga asesoramiento jurídico).

### 2.4. Requisitos de Usuario

#### Página 6

- RU2: El usuario quiere ver al entrar una pantalla de trabajo diaria útil (no decorativa) con lo que requiere su atención y poder resolverlo con pocos clics.
- RU3: El responsable interno de un cliente quiere recibir las notificaciones relevantes de ese cliente y distinguir las ya leídas de las ya resueltas.
- RU4: El superadministrador quiere poder elegir qué notificaciones recibe por la aplicación, por email o en resumen diario, para no recibir cientos de correos al día.
- RU5: El administrador quiere un dashboard financiero con cifras reales y poder generar informes filtrables, exportables a CSV y PDF.
- RU6: El usuario quiere encontrar rápidamente un cliente o factura con una búsqueda global y guardar filtros frecuentes.
- RU7: El usuario quiere importar clientes desde un CSV con previsualización para evitar que entren datos corruptos.
- RU8: El administrador quiere poder importar el histórico de facturas para una migración futura sin que se envíen emails ni se consuma numeración.
- RU9: El superadministrador o administrador quiere crear o invitar a los usuarios internos y desactivarlos cuando se vayan, sin perder el rastro de sus acciones.
- RU10: El usuario quiere poder recuperar su contraseña mediante un enlace que caduque.

#### Página 7

- RU11: El usuario operativo quiere trabajar sobre los clientes que tiene asignados, sin poder acceder a otros ni a la configuración global.
- RU12: El administrador quiere asignar y desasignar clientes, y que el nuevo responsable herede las tareas pendientes manteniendo el histórico.
- RU13: El administrador quiere delegar temporalmente los clientes de una persona (por ejemplo, vacaciones) sin compartir contraseñas.
- RU14: El usuario quiere que la aplicación detecte los conflictos de edición para que nadie sobrescriba silenciosamente los cambios de otro.
- RU15: El superadministrador quiere poder consultar quién hizo cada acción relevante (auditoría) sin poder alterar el pasado.
- RU16: El responsable del sistema quiere disponer de copias de seguridad automáticas que se puedan restaurar.
- RU17: El usuario autenticado quiere descargar solo los documentos que tiene permiso para ver.
