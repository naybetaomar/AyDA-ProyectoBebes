
# SÓLO REQUISITOS PÁGINAS 12 - 13, + Añadidos

> Dejo sin poner numeración hasta que este todo.

## 1.3. Actores y partes interesadas

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Persona de contacto del cliente | Persona(s) de la empresa cliente | Recibir comunicaciones en el canal e idioma adecuados |
| Stripe (simulado) | Sistema externo donde se reflejan cobros | Consultas de pago fiables, sin duplicar cobros |
| Brain / agentes de IA | Consumidores futuros de la API | Consultar clientes, deuda y facturas, y crear solicitudes controladas, sin saltarse reglas |


## 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-00 | Lograr una automatización confiable y explicable: que ninguna factura, envío, cobro o tarea falle en silencio ni se duplique | Ampliación |
| BR-00 | Asegurar el control económico y la trazabilidad: saber quién hizo qué y por qué, y que nadie altere silenciosamente el histórico | Ampliación |
| BR-00 | Que la estructura del sistema permita evolucionar (nuevos planes, frecuencias, canales, sociedades emisoras, monedas, países) sin reescribirlo | Ampliación |
| BR-00 | Obtener visibilidad financiera contable fiable (facturado, cobrado, pendiente, vencido, previsión) con cifras reconciliables | Entrevista / Ampliación |
| BR-00 | Proteger los datos de clientes, contactos y documentos frente a accesos y exportaciones indebidas | Entrevista / Ampliación |


## 3. Requisitos de usuario

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-00 | Administrador / Superadministrador | Aprobar o rechazar solicitudes económicas sensibles desde una bandeja, con suplentes cuando el aprobador no esté | Ampliación |
| UR-00 | Administrador | Cerrar periodos administrativamente y generar el paquete mensual/trimestral para la gestoría | Ampliación |
| UR-00 | Administrador | Programar informes periódicos y fijar objetivos mensuales/anuales de facturación y cobro | Ampliación |
| UR-00 | Superadministrador / Administrador | Ver una pantalla de monitoreo con cosas como última generación recurrente, cola de emails, errores de integración, último backup correcto; y el registro de ejecución de procesos automáticos | Ampliación |
| UR-00 | Administrador / Superadministrador | Poder localizar qué datos personales se tienen de un contacto y anonimizarlos cuando legalmente proceda, sin invalidar el histórico contable | Ampliación |


## 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-00 | El sistema podrá clasificar facturas por proyecto o línea de negocio con categorías administrables cuyo renombrado no destruya el histórico | UR-00 |
| FR-00 | El sistema permitirá configurar alertas con un conjunto condiciones (factura vencida más de N días, deuda acumulada superior a X, tres fallos de envío, revisión anual sin resolver en una semana) | UR-00 |
| FR-00 | El sistema permitirá configurar objetivos mensual/anual de facturación y cobro (solo administradores), informativos y con histórico de cambios para no falsear comparaciones con otros anteriores | UR-00 |
| FR-00 | El sistema deberá permitir mover una comunicación o recordatorio que cae en fin de semana o festivo al siguiente día laborable, según un calendario laboral (fines de semana y festivos) | UR-00 |
| FR-00 | El sistema deberá emitir cada factura en una moneda concreta y conservarla; el importe original y el importe convertido para informes | UR-00 |
| FR-00 | El sistema podrá convertir importes a una moneda base para reporting con un tipo de cambio registrado, sin alterar nunca el total legal de la factura | UR-00 |
| FR-00 | El sistema deberá ofrecer una bandeja de aprobaciones donde el solicitante vea pendiente/aprobada/rechazada y el comentario del aprobador; para operaciones sensibles el aprobador no podrá ser el solicitante | UR-00|
| FR-00 | El sistema deberá permitir reasignar clientes con una aprobación a otro administrador o definir suplentes, registrando la reasignación | UR-00 |
| FR-00 | Las tareas largas se ejecutarán en segundo plano con estado (pendiente, procesando, completado, completado con errores) y seguirán existiendo aunque el usuario cierre la pestaña | UR-00 |
| FR-00 | El sistema deberá impedir duplicados por doble clic o reintento en emisión, envío y conciliación, informando "ya se está procesando" | UR-00 |
| FR-00 | El sistema deberá permitir a un administrador autorizado cerrar un mes o trimestre; en un periodo cerrado no se permitirán cambios ordinarios en elementos económicos; reabrirlo requerirá permiso superior y motivo | UR-00 |
| FR-00 | El sistema deberá generar un paquete mensual o trimestral para la gestoría (facturas emitidas, rectificativas, cobros y PDF en ZIP/CSV), registrando cuándo se generó y qué periodo cubre, y distinguiendo versiones si se regenera | UR-00|
| FR-00 | El sistema deberá mostrar el estado de cada mensaje (en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado) | UR-00 |
| FR-00 | El sistema deberá registrar por contacto el idioma de comunicación, el canal preferido y el consentimiento para cada canal (email, WhatsApp) | UR-00 |
| FR-00 | El sistema deberá distinguir comunicaciones operativas de facturación de campañas comerciales y no reutilizará automáticamente datos de facturación para marketing | UR-00 |
| FR-00 | El sistema deberá soportar dos niveles de visibilidad en comentarios: ordinario (ámbito del cliente) y nota restringida visible solo para administradores | UR-00 |
| FR-00 | Toda exportación masiva de datos sensibles se auditará (usuario, fecha/hora, filtros) y el fichero llevará esos datos como metadatos o referencia | UR-00 |
| FR-00 | El sistema podrá cargarse con datos ficticios para demos, sin mezclarlos con producción | UR-00 |


## 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-00 | Rendimiento | Las operaciones pesadas no bloquearán la interfaz y se ejecutarán en segundo plano con aviso | Generar 3.000 facturas con PDF; la UI sigue operativa y muestra estado y progreso | Deberá hacerse test de estres |
| NFR-00 | Integridad de datos | Los importes usarán precisión decimal exacta; los totales cuadrarán y el PDF mostrará exactamente lo almacenado | Ninguna operación económica usa coma flotante | Test unitarios con multiples situaciones |
| NFR-00 | Protección de datos de prueba | No se usarán datos reales de clientes en repositorios, demos ni capturas | Revisión de repositorio y memoria sin datos reales; datos sintéticos generables | Datos automaticamente anonimizables siguiendo el RGPD |
