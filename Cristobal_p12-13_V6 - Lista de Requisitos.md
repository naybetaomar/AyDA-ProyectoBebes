# SÓLO PÁGINAS 12 - 13

## 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | Lograr una automatización confiable y explicable: que ninguna factura, envío, cobro o tarea falle en silencio ni se duplique | Ampliación |
| BR-02 | Asegurar el control económico y la trazabilidad: saber quién hizo qué y por qué, y que nadie altere silenciosamente el histórico | Ampliación |
| BR-03 | Que la estructura del sistema permita evolucionar sin reescribirlo | Ampliación |
| BR-04 | Obtener visibilidad financiera contable fiable (facturado, cobrado, pendiente, vencido, previsión) | Entrevista / Ampliación |
| BR-05 | Proteger los datos de clientes, contactos y documentos frente a accesos y exportaciones indebidas | Entrevista / Ampliación |


## 3. Requisitos de usuario

| ID | Actor | Requisito de usuario |
| --- | --- | --- |
| UR-46 | Superadministrador | Consultar y filtrar la auditoría para saber quién hizo qué, cuándo y por qué, sin poder reescribir el pasado. |
| UR-69 | Lector / Administrador | Comentar internamente en clientes, facturas e incidencias, con notas restringidas cuando proceda. |
| UR-71 | Administrador | Programar informes periódicos y fijar objetivos mensuales/anuales de facturación y cobro. |
| UR-72 | Superadministrador | Configurar el sistema de plazos (plazo de pago, cadencia de recordatorios, calendario). |
| UR-75 | Administrador / Superadministrador | Poder localizar qué datos personales se tienen de un contacto y anonimizarlos cuando legalmente proceda (marketing), sin nvalidar el histórico contable. |
| UR-76 | Administrador | Consultar tipos de cambio y reglas de conversión de divisa aplicados a la consolidación de informes. |
| UR-77 | Lector / Administrador | Consultar la trazabilidad y el estado detallado de entrega de cada mensaje individual enviado. |
| UR-78 | Administrador / Superadministrador | Disponer de una bandeja donde consultar si mis solicitudes económicas han sido aprobadas, rechazadas o están pendientes. |
| UR-79 | Administrador / Superadministrador | Ver los comentarios explicativos del aprobador cuando revise mi solicitud para entender el motivo de la decisión. |
| UR-80 | Administrador / Superadministrador | Que el sistema me impida aprobar mis propias solicitudes sensibles para garantizar la separación de funciones. |
| UR-81 | Administrador | Poder ejecutar el cierre formal de un mes o trimestre contable cuando finalice el periodo. |
| UR-82 | Administrador | Que el sistema me impida modificar por error facturas o cobros pertenecientes a un periodo cerrado. |
| UR-83 | Superadministrador | Poder reabrir periodos cerrados únicamente ingresando un motivo obligatorio que quede registrado. |
| UR-84 | Administrador | Generar y descargar en un solo archivo (ZIP/CSV) toda la información y PDF contables del periodo. |
| UR-85 | Administrador | Consultar la fecha y autoría de la última generación del paquete contable para confirmar su envío a la gestoría. |
| UR-86 | Administrador | Diferenciar si un paquete contable es la versión inicial o una regeneración posterior para evitar duplicidades o confusiones. |
| UR-87 | Administrador | Registrar mi idioma preferido para recibir todas las comunicaciones en mi idioma. |
| UR-88 | Administrador | Indicar cuál es mi canal preferido para recibir notificaciones e impresos. |
| UR-89 | Administrador | Gestionar los permisos de envío de forma independiente para cada canal según la normativa de protección de datos. |
| UR-90 | Superadministrador | Consultar en la auditoría del sistema qué usuario realizó exportaciones masivas de datos y con qué criterios. |
| UR-91 | Superadministrador | Que cualquier fichero de datos exportado incluya en sus metadatos quién y cuándo lo descargó para disuadir fugas de información. |
| UR-92 | Lector / Administrador | Recibir una alerta cuando una factura supere el límite tolerable de días vencida. |
| UR-93 | Lector / Administrador | Ser notificado si la deuda de un cliente supera el límite económico permitido para bloquear nuevas acciones. |
| UR-94 | Lector / Administrador | Enterarme cuando fallen repetidamente los envíos hacia un contacto para corregir sus datos de entrega. |
| UR-95 | Lector / Administrador | Recibir un aviso sobre revisiones pendientes que lleven más de una semana sin gestión. |
| UR-107 | Lector / Administrador | Poder etiquetar clientes para organizarlos de forma flexible (opcional) | Transcripción ampliada (Página 9) |
| UR-109 | Administrador / Superadministrador | Poder asegurar que los datos de facturación no se usan automáticamente para campañas comerciales | Ampliación / entrevista |

## 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-92 | El sistema deberá ofrecer un panel de auditoría general que permita consultar, y filtrar los registros de actividad (quién, qué, cuándo y por qué) sin posibilidad de modificación ni borrado. | UR-46 |
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
| FR-184 | El sistema deberá emitir una alerta cuando una revisión o incidencia anual permanezca sin resolver tras transcurrir más de una semana. | UR-95 |
| FR-185 | El sistema deberá clasificar facturas por proyecto o línea de negocio (clientes) con categorías administrables cuyo renombrado no destruya el histórico (opcional) | UR-107 |
| FR-186 | El sistema deberá controlar objetivos mensual/anual de facturación y cobro, informativos y con histórico de cambios para no falsear comparaciones con otros anteriores | UR-71 |
| FR-187 | El sistema deberá permitir mover una comunicación o recordatorio que cae en fin de semana o festivo al siguiente día laborable, según un calendario laboral | UR-72 |
| FR-189 | El sistema deberá convertir importes a una moneda base para reporting con un tipo de cambio registrado, sin alterar nunca el total legal de la factura | UR-76 |
| FR-192 | El sistema deberá mostrar el estado de cada mensaje (en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado) | UR-77 |
| FR-193 | El sistema deberá distinguir comunicaciones operativas de facturación de campañas comerciales y no deberá reutilizar automáticamente datos de facturación para marketing | UR-109 |
| FR-194 | El sistema deberá soportar dos niveles de visibilidad en comentarios: ordinario y nota restringida solo para administradores | UR-69 |
| FR-207 | El sistema deberá permitir localizar todos los datos personales que conserva de un contacto | UR-75 |

## 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-30 | Rendimiento | Las operaciones pesadas no bloquearán la interfaz y se ejecutarán en segundo plano con aviso | Pruebas de estrés; la UI sigue operativa y muestra estado y progreso |
| NFR-31 | Integridad de datos | Los importes usarán precisión decimal exacta; los totales cuadrarán y el PDF mostrará exactamente lo almacenado | Utilizar el tipo de dato adecuado para operaciones con dinero |
| NFR-32 | Protección de datos de prueba | No se usarán datos reales de clientes en repositorios, demos o capturas | Revisión de repositorio y memoria sin datos reales de personas |
| NFR-15 | Usabilidad / Control | Idempotencia en UI por doble clic | Interfaz deshabilita botones de acción económica tras el primer clic y envía clave de idempotencia |


## 7. Dudas, ambigüedades y cuestiones pendientes

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|
| Q-01 | Frases como: "datos ficticios para demos", "Observabilidad de emails y WhatsApp simulados." | Ampliación | Tener que simular todo sistemas externos de comunicación y demos | Pendiente |


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
