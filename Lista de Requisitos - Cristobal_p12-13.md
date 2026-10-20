
## 1. Posibles nuevos actores
- Soporte IT / administradores especiales (En caso de que se vaya a hacer una simulación¿)
- Gestoría de la propia de Turbine. Recibe el paquete de facturas, informes, etc
- Persona de contacto del cliente (Un cliente puede tener varias personas de contacto)
- Lector ->>> Usuario operativo ver PDF

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
| UR-04 | Usuario operativo / Administrador | Saber qué facturas están pagadas, pendientes, vencidas o en disputa, y por qué. |
| UR-06 | Usuario operativo / Administrador | Recibir notificaciones internas de los eventos relevantes de mis clientes (pago confirmado, vencida, rebote, disputa, aprobación rechazada…). |
| UR-10 | Usuario operativo / Administrador | Comentar internamente en clientes, facturas e incidencias, con notas restringidas cuando proceda. |
| UR-16 | Todos | No perder trabajo (borradores automáticos, deshacer cuando proceda) y recibir mensajes de error comprensibles ("falta el NIF fiscal", no "error 422"). |
| UR-18 | Administrador | Asignar, desasignar, reasignar y delegar temporalmente clientes a usuarios. |
| UR-19 | Administrador / Superadministrador | Aprobar o rechazar solicitudes económicas sensibles desde una bandeja, con suplentes cuando el aprobador no esté. |
| UR-20 | Administrador | Ver un dashboard financiero (semanal, mensual, trimestral, anual) con cifras que pueda desglosar, e informes exportables. |
| UR-22 | Administrador | Cerrar periodos administrativamente y generar el paquete mensual/trimestral para la gestoría. |
| UR-27 | Administrador | Programar informes periódicos y fijar objetivos mensuales/anuales de facturación y cobro. |
| UR-28 | Superadministrador | Configurar el sistema de plazos (plazo de pago, cadencia de recordatorios, calendario). | 
| UR-40 | Superadministrador | Configurar el sistema de monedas, impuestos, tarifas, rangos. |
| UR-29 | Superadministrador | Consultar y filtrar la auditoría para saber quién hizo qué, cuándo y por qué, sin poder reescribir el pasado. |
| UR-30 | Superadministrador / Administrador | Ver una pantalla de monitoreo: última generación recurrente, cola de emails, errores de integración, último backup correcto; y el registro de ejecución de procesos automáticos. |
| UR-35 | Superadministrador | Desplegar sistema de pruebas automáticas y entornos reproducibles. |
| UR-36 | Gestoría / administrador | Recibir un paquete periódico de facturas emitidas, rectificativas, cobros y PDF, con versiones identificables. |
| UR-38 | Persona de contacto del cliente | Recibir las comunicaciones por el canal permitido y en el idioma elegido, y que se sepa a quién se enviaron en cada momento. |
| UR-39 | Administrador / Superadministrador | Poder localizar qué datos personales se tienen de un contacto y anonimizarlos cuando legalmente proceda, sin invalidar el histórico contable. |
| UR-41 | Administrador | Consultar tipos de cambio y reglas de conversión de divisa aplicados a la consolidación de informes. |
| UR-42 | Usuario operativo / Administrador	| Consultar la trazabilidad y el estado detallado de entrega de cada mensaje individual enviado. |

## 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | El sistema deberá clasificar facturas por proyecto o línea de negocio con categorías administrables cuyo renombrado no destruya el histórico (opcional) | UR-20 |
| FR-02 | El sistema deberá controlar objetivos mensual/anual de facturación y cobro, informativos y con histórico de cambios para no falsear comparaciones con otros anteriores | UR-27 |
| FR-03 | El sistema deberá permitir mover una comunicación o recordatorio que cae en fin de semana o festivo al siguiente día laborable, según un calendario laboral | UR-28 |
| FR-04 | El sistema deberá emitir cada factura en una moneda concreta y conservarla; el importe original y el importe convertido para informes | UR-40 |
| FR-05 | El sistema deberá convertir importes a una moneda base para reporting con un tipo de cambio registrado, sin alterar nunca el total legal de la factura | UR-41 |
| FR-06 | El sistema deberá ofrecer una bandeja de aprobaciones donde el solicitante vea pendiente/aprobada/rechazada y el comentario del aprobador; para operaciones sensibles el aprobador no puede ser el solicitante | UR-19 |
| FR-07 | El sistema deberá permitir reasignar clientes con una aprobación a otro administrador o definir suplentes, registrando la reasignación | UR-18 |
| FR-08 | Las tareas largas se ejecutarán en segundo plano con estado (pendiente, procesando, completado, completado con errores) y seguirán existiendo aunque el usuario cierre la pestaña | UR-30 |
| FR-09 | El sistema deberá impedir duplicados por doble clic o reintento en emisión, envío y conciliación, informando adecuadamente | UR-16 |
| FR-10 | El sistema deberá permitir a un administrador autorizado cerrar un mes o trimestre; en un periodo cerrado no se permitirán cambios ordinarios en elementos económicos; reabrirlo requerirá permiso superior y motivo | UR-22 |
| FR-11 | El sistema deberá generar un paquete mensual o trimestral para la gestoría (facturas emitidas, rectificativas, cobros y PDF en ZIP/CSV), registrando cuándo se generó y qué periodo cubre, y distinguiendo versiones si se regenera | UR-36 |
| FR-12 | El sistema deberá mostrar el estado de cada mensaje (en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado) | UR-42 |
| FR-13 | El sistema deberá registrar por contacto el idioma de comunicación, el canal preferido y el consentimiento para cada canal (email, WhatsApp) | UR-38 |
| FR-14 | El sistema deberá distinguir comunicaciones operativas de facturación de campañas comerciales y no reutilizará automáticamente datos de facturación para marketing | UR-39 |
| FR-15 | El sistema deberá soportar dos niveles de visibilidad en comentarios: ordinario y nota restringida solo para administradores | UR-10 |
| FR-16 | Toda exportación masiva de datos sensibles se auditará (usuario, fecha/hora, filtros) y el fichero llevará esos datos como metadatos o referencia | UR-29 |
| FR-17 | El sistema deberá cargarse con datos ficticios para demos, sin mezclarlos con producción (opcional) | UR-35 |
| FR-18 | El sistema deberá configurar alertas con un conjunto condiciones (factura vencida más de N días, deuda acumulada superior a X, tres fallos de envío, revisión anual sin resolver en una semana) | UR-06 |
| FR-19 | El sistema impedirá eliminar o inactivar el único contacto de facturación de un cliente activo, emitiendo una advertencia explícita | UR-04 |


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
