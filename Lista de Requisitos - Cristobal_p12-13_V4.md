
# SÓLO PÁGINAS 12 - 13


## 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | Lograr una automatización confiable y explicable: que ninguna factura, envío, cobro o tarea falle en silencio ni se duplique | Ampliación |
| BR-02 | Asegurar el control económico y la trazabilidad: saber quién hizo qué y por qué, y que nadie altere silenciosamente el histórico | Ampliación |
| BR-03 | Que la estructura del sistema permita evolucionar sin reescribirlo | Ampliación |
| BR-04 | Obtener visibilidad financiera contable fiable (facturado, cobrado, pendiente, vencido, previsión) | Entrevista / Ampliación |
| BR-05 | Proteger los datos de clientes, contactos y documentos frente a accesos y exportaciones indebidas | Entrevista / Ampliación |
| BR-06 | La aplicación no debe usar automáticamente datos de facturación para campañas comerciales | Entrevista / Ampliación |


## 3. Requisitos de usuario

| ID | Actor | Requisito de usuario |
| --- | --- | --- |
| UR-04 | Lector / Administrador | Saber qué facturas están pagadas, pendientes, vencidas o en disputa, y por qué. |
| UR-06 | Lector / Administrador | Recibir notificaciones internas de los eventos relevantes de mis clientes (pago confirmado, vencida, rebote, disputa, aprobación rechazada…). |
| UR-10 | Lector / Administrador | Comentar internamente en clientes, facturas e incidencias, con notas restringidas cuando proceda. |
| UR-16 | Lector / Administrador / Superadministrador | No perder trabajo (borradores automáticos, deshacer cuando proceda) y recibir mensajes de error comprensibles ("falta el NIF fiscal", no "error 422"). |
| UR-18 | Administrador | Asignar, desasignar, reasignar y delegar temporalmente clientes a usuarios. |
| UR-20 | Administrador | Ver un dashboard financiero (semanal, mensual, trimestral, anual) con cifras que pueda desglosar, e informes exportables. |
| UR-27 | Administrador | Programar informes periódicos y fijar objetivos mensuales/anuales de facturación y cobro. |
| UR-28 | Superadministrador | Configurar el sistema de plazos (plazo de pago, cadencia de recordatorios, calendario). |
| UR-40 | Superadministrador | Configurar el sistema de monedas, impuestos, tarifas, rangos. |
| UR-29 | Superadministrador | Consultar y filtrar la auditoría para saber quién hizo qué, cuándo y por qué, sin poder reescribir el pasado. |
| UR-30 | Superadministrador / Administrador | Ver una pantalla de monitoreo: última generación recurrente, cola de emails, errores, último backup correcto; y el registro de ejecución de procesos automáticos. |
| UR-35 | Superadministrador | Desplegar sistema de pruebas automáticas y entornos reproducibles. |
| UR-39 | Administrador / Superadministrador | Poder localizar qué datos personales se tienen de un contacto y anonimizarlos cuando legalmente proceda, sin invalidar el histórico contable. |
| UR-41 | Administrador | Consultar tipos de cambio y reglas de conversión de divisa aplicados a la consolidación de informes. |
| UR-42 | Lector / Administrador	| Consultar la trazabilidad y el estado detallado de entrega de cada mensaje individual enviado. |
| UR-19.1 | Administrador / Superadministrador | Disponer de una bandeja donde consultar si mis solicitudes económicas han sido aprobadas, rechazadas o están pendientes. |
| UR-19.2 | Administrador / Superadministrador | Ver los comentarios explicativos del aprobador cuando revise mi solicitud para entender el motivo de la decisión. |
| UR-19.3 | Administrador / Superadministrador | Que el sistema me impida aprobar mis propias solicitudes sensibles para garantizar la separación de funciones. |
| UR-22.1 | Administrador | Poder ejecutar el cierre formal de un mes o trimestre contable cuando finalice el periodo. |
| UR-22.2 | Administrador | Que el sistema me impida modificar por error facturas o cobros pertenecientes a un periodo cerrado. |
| UR-22.3 | Superadministrador | Poder reabrir periodos cerrados únicamente ingresando un motivo obligatorio que quede registrado. |
| UR-36.1 | Gestoría / administrador | Generar y descargar en un solo archivo (ZIP/CSV) toda la información y PDF contables del periodo. |
| UR-36.2 | Administrador | Consultar la fecha y autoría de la última generación del paquete contable para confirmar su envío a la gestoría. |
| UR-36.3 | Gestoría / administrador | Diferenciar si un paquete contable es la versión inicial o una regeneración posterior para evitar duplicidades o confusiones. |
| UR-38.1 | Persona de contacto del cliente | Registrar mi idioma preferido para recibir todas las comunicaciones en mi idioma. |
| UR-38.2 | Persona de contacto del cliente | Indicar cuál es mi canal preferido para recibir notificaciones e impresos. |
| UR-38.3 | Administrador / Cliente | Gestionar los permisos de envío de forma independiente para cada canal según la normativa de protección de datos. |
| UR-29.1 | Superadministrador | Consultar en la auditoría del sistema qué usuario realizó exportaciones masivas de datos y con qué criterios. |
| UR-29.2 | Superadministrador | Que cualquier fichero de datos exportado incluya en sus metadatos quién y cuándo lo descargó para disuadir fugas de información. |
| UR-06.1 | Lector / Administrador | Recibir una alerta cuando una factura supere el límite tolerable de días vencida. |
| UR-06.2 | Lector / Administrador | Ser notificado si la deuda de un cliente supera el límite económico permitido para bloquear nuevas acciones. |
| UR-06.3 | Lector / Administrador | Enterarme cuando fallen repetidamente los envíos hacia un contacto para corregir sus datos de entrega. |
| UR-06.4 | Lector / Administrador | Recibir un aviso sobre revisiones pendientes que lleven más de una semana sin gestión. |

Los que tienen "." para poder diferenciarlos son los NUEVOS que han sido "desdoblados" divididos. 


## 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-06.1 |	El sistema deberá disponer de una bandeja de entrada donde el solicitante consulte el estado de sus solicitudes económicas. | UR-19.1 |
| FR-06.2 |	El sistema deberá incluir y mostrar el comentario explícito registrado por el aprobador al autorizar o rechazar una solicitud. | UR-19.2 |
| FR-06.3 |	El sistema deberá validar e impedir que el usuario solicitante sea el mismo que apruebe operaciones económicas sensibles. | UR-19.3 |
| FR-10.1 |	El sistema deberá permitir a un administrador autorizado ejecutar el cierre administrativo de un mes o trimestre. | UR-22.1 |
| FR-10.2 |	El sistema deberá bloquear la modificación, creación o borrado ordinario de elementos económicos dentro de un periodo cerrado. | UR-22.2 |
| FR-10.3 |	El sistema deberá requerir permisos superiores (Superadministrador) y la justificación obligatoria de un motivo para reabrir un periodo cerrado. | UR-22.3 |
| FR-11.1 |	El sistema deberá recopilar y empaquetar automáticamente en un archivo ZIP/CSV las facturas emitidas, rectificativas, cobros y sus correspondientes PDF del periodo seleccionado. | UR-36.1 |
| FR-11.2 |	El sistema deberá registrar la trazabilidad de la generación del paquete, incluyendo fecha/hora, usuario y el periodo exacto que cubre. | UR-36.2 |
| FR-11.3 |	El sistema deberá asignar e identificar un número de versión distinto cada vez que se vuelva a generar el paquete contable de un mismo periodo. | UR-36.3 |
| FR-13.1 |	El sistema deberá almacenar el idioma preferido de comunicación asignado a cada contacto del cliente. | UR-38.1 |
| FR-13.2 |	El sistema deberá registrar el canal de comunicación preferido para la entrega de notificaciones del contacto. | UR-38.2 |
| FR-13.3 |	El sistema deberá gestionar y verificar el consentimiento explícito individual para cada canal de envío. | UR-38.3 |
| FR-16.1 |	El sistema deberá registrar automáticamente en el log de auditoría cada exportación masiva realizada, capturando usuario, fecha/hora y los filtros de búsqueda aplicados. | UR-29.1 |
| FR-16.2 |	El sistema deberá incrustar en el archivo exportado los metadatos o referencias de trazabilidad (usuario generador, marca de tiempo y filtros utilizados). | UR-29.2 |
| FR-18.1 | El sistema deberá permitir configurar y emitir una alerta cuando una factura permanezca en estado vencido más de días parametrizables. | UR-06.1 |
| FR-18.2 | El sistema deberá emitir una alerta cuando el saldo de deuda acumulada de un cliente supere un umbral determinado. | UR-06.2 |
| FR-18.3 |	El sistema deberá detectar y notificar la acumulación de más de 3 fallos consecutivos en el envío de comunicaciones a un cliente. | UR-06.3 |
| FR-18.4 |	El sistema deberá emitir una alerta cuando una revisión o incidencia anual permanezca sin resolver tras transcurrir una semana. | UR-06.4 |
| FR-01 | El sistema deberá clasificar facturas por proyecto o línea de negocio con categorías administrables cuyo renombrado no destruya el histórico (opcional) | UR-20 |
| FR-02 | El sistema deberá controlar objetivos mensual/anual de facturación y cobro, informativos y con histórico de cambios para no falsear comparaciones con otros anteriores | UR-27 |
| FR-03 | El sistema deberá permitir mover una comunicación o recordatorio que cae en fin de semana o festivo al siguiente día laborable, según un calendario laboral | UR-28 |
| FR-04 | El sistema deberá emitir cada factura en una moneda concreta y conservarla; el importe original y el importe convertido para informes | UR-40 |
| FR-05 | El sistema deberá convertir importes a una moneda base para reporting con un tipo de cambio registrado, sin alterar nunca el total legal de la factura | UR-41 |
| FR-07 | El sistema deberá permitir reasignar clientes con una aprobación a otro administrador o definir suplentes, registrando la reasignación | UR-18 |
| FR-08 | El sistema deberá ejecutar las tareas largas en segundo plano con estado (pendiente, procesando, completado, completado con errores) y seguirán existiendo aunque el usuario cierre la pestaña | UR-30 |
| FR-09 | El sistema deberá impedir duplicados por doble clic o reintento en emisión, envío y conciliación, informando adecuadamente | UR-16 |
| FR-12 | El sistema deberá mostrar el estado de cada mensaje (en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado) | UR-42 |
| FR-14 | El sistema deberá distinguir comunicaciones operativas de facturación de campañas comerciales y no reutilizará automáticamente datos de facturación para marketing | UR-39 |
| FR-15 | El sistema deberá soportar dos niveles de visibilidad en comentarios: ordinario y nota restringida solo para administradores | UR-10 |
| FR-17 | El sistema deberá cargarse con datos ficticios para demos, sin mezclarlos con producción (opcional) | UR-35 |
| FR-19 | El sistema deberá impedir eliminar o inactivar el único contacto de facturación de un cliente activo, emitiendo una advertencia explícita | UR-04 |


## 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-01 | Rendimiento | Las operaciones pesadas no bloquearán la interfaz y se ejecutarán en segundo plano con aviso | Generar 3.000 facturas con PDF; la UI sigue operativa y muestra estado y progreso | Deberá hacerse test de estrés |
| NFR-02 | Integridad de datos | Los importes usarán precisión decimal exacta; los totales cuadrarán y el PDF mostrará exactamente lo almacenado | Utilizar el tipo de dato adecuado para operaciones con dinero | Test unitarios con multiples situaciones |
| NFR-03 | Protección de datos de prueba | No se usarán datos reales de clientes en repositorios, demos ni capturas | Revisión de repositorio y memoria sin datos reales de personas | Datos automaticamente anonimizables siguiendo el RGPD |
| NFR-04 | Usabilidad / Control | Idempotencia en UI por doble clic | Interfaz deshabilita botones de acción económica tras el primer clic y envía clave de idempotencia |


## 6. Suposiciones y decisiones de análisis

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | No implementarlo (Sobreingeniería) | El cliente dice "Si lo implementáis", no deja claro que sea un requisito. | FR-01 |


## 7. Dudas, ambigüedades y cuestiones pendientes

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|
| Q-01 | Frases como: "datos ficticios para demos", "Observabilidad de emails y WhatsApp simulados." | Ampliación | FR-17. Tener que simular todo sistemas externos | Pendiente |


## 9. Glosario

| Término | Definición |
| --- | --- |
| imputarse | Asignar o clasificar el importe de una factura puntual a un proyecto interno, centro de coste o línea de negocio específica para su posterior análisis en informes. |
| prospecto importado | Estado inicial o posible situación en la que se encuentra la ficha de un cliente potencial traído al sistema mediante una importación de datos antes de ser activado. |
| dashboard | Panel de control visual dirigido a administradores donde se muestran métricas, números clave e indicadores financieros (facturado, cobrado, pendiente, vencido, previsión) con opción de desglose hasta el detalle. |
| API | Interfaz de comunicación que permite a la aplicación interna interactuar de forma controlada y segura con otros sistemas externos o futuros (como Brain u otros agentes de IA) para consultar clientes, deudas o registrar solicitudes bajo las mismas reglas de negocio. |
| reporting | Proceso de consolidación y generación de informes de datos financieros o de gestión en el que, si intervienen monedas extranjeras, se convierten los importes a una moneda base usando un tipo de cambio registrado. |
| aprobador | Usuario (administrador o superadministrador) encargado de revisar, autorizar o rechazar solicitudes de operaciones económicas sensibles (como descuentos o cambios manuales de importe) a través de una bandeja de entrada. |
| claves de idempotencia | Mecanismo técnico o de interfaz utilizado en operaciones largas o críticas (emisión, envío, conciliación) para evitar que la acción se procese o ejecute dos veces al hacer doble clic o recargar la página. |
| conciliación | Proceso de asociar y verificar un movimiento o evento de cobro (proveniente de Stripe, Revolut o banco) con su factura correspondiente, ya sea de forma automática, propuesta por el sistema o resuelta manualmente por una persona. |





# NO HACER CASO A LO DE ABAJO - VIEJO OLVIDAR - ANTES DEL DESDOBLE

fr-06, fr-10, fr-11, fr-13, fr-16, fr-18

## 4.1. Requisitos funcionales

| FR-06 | El sistema deberá ofrecer una bandeja de aprobaciones donde el solicitante vea pendiente/aprobada/rechazada y el comentario del aprobador; para operaciones sensibles el aprobador no puede ser el solicitante | UR-19 |
| FR-10 | El sistema deberá permitir a un administrador autorizado cerrar un mes o trimestre; en un periodo cerrado no se permitirán cambios ordinarios en elementos económicos; reabrirlo requerirá permiso superior y motivo | UR-22 |
| FR-11 | El sistema deberá generar un paquete mensual o trimestral para la gestoría (facturas emitidas, rectificativas, cobros y PDF en ZIP/CSV), registrando cuándo se generó y qué periodo cubre, y distinguiendo versiones si se regenera | UR-36 |
| FR-13 | El sistema deberá registrar por contacto el idioma de comunicación, el canal preferido y el consentimiento para cada canal (email, WhatsApp) | UR-38 |
| FR-16 | El sistema deberá auditar toda exportación masiva de datos sensibles con usuario, fecha/hora, filtros y el fichero llevará esos datos como metadatos o referencia | UR-29 |
| FR-18 | El sistema deberá configurar alertas con un conjunto condiciones (factura vencida más de N días, deuda acumulada superior a X, tres fallos de envío, revisión anual sin resolver en una semana) | UR-06 |

