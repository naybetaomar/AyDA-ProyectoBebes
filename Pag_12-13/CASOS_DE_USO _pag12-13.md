# SÓLO CASOS DE USO DE PÁGINAS 12 - 13

> Dejo sin poner numeración hasta que este todo.

| ID | Caso de uso | Actor | Descripción | FR |
|---|---|---|---|---|
| UC-00 | Gestionar contactos del cliente | Usuario | Añadir, editar o inactivar personas de contacto, con función, idioma, canal y consentimiento; una persona puede estar en varias empresas | FR-00 |
| UC-00 | Comentar internamente | Usuario | Escribir comentarios en cliente, factura o incidencia, con menciones y notas restringidas a administradores | FR-00 |
| UC-00 | Hacer efectiva la baja | Sistema | En la fecha efectiva, detiene nuevas mensualidades, cancela facturas futuras no emitidas y mantiene el recobro de las emitidas | FR-00 |
| UC-00 | Crear factura puntual | Usuario | Elaborar borrador, impuestos y moneda; advierte importes atípicos | FR-00 |
| UC-00 | Emitir factura | Usuario | Valida datos, asigna serie y número, genera y conserva el PDF; idempotente ante doble clic | FR-00 |
| UC-00 | Resolver aprobación | Administrador | Aprobar o rechazar desde la bandeja con comentario; reasignable a suplente; respeta separación de funciones | FR-00 |
| UC-00 | Cerrar y reabrir periodo | Administrador (cierre) / Superadministrador(reapertura) | Bloquear cambios económicos ordinarios de un mes o trimestre; reabrir exige motivo | FR-00 |
| UC-00 | Enviar factura al cliente | Sistema | Envía por email (y WhatsApp si hay consentimiento) a los contactos de facturación, registrando intento y resultado | FR-00 |
| UC-00 | Gestionar fallo de entrega | Usuario | Ante rebote, la factura no se marca notificada; se abre incidencia, se corrige el contacto o se prueba otro y se reenvía | FR-00 |
| UC-00 | Ejecutar recordatorios y flujo de impago | Sistema | Recordatorio ≈ día 3, aviso al vencimiento y reclamaciones periódicas; respeta vencimiento pactado, calendario laboral, disputas y pausas | FR-00 |
| UC-00 | Configurar alertas | Administrador | Definir reglas parametrizables de un conjunto cerrado de condiciones | FR-00 |
| UC-00 | Consultar dashboard financiero | Administrador | Cifras de facturado, cobrado, pendiente, vencido, recurrentes esperados y previsión | FR-00 |
| UC-00 | Generar informe con filtrado | Administrador | Informe por periodo, cliente, responsable, país, sector, estado, tipo y moneda | FR-00 |
| UC-00 | Exportar datos | Usuario | Exportar a CSV (UTF-8) o PDF respetando permisos, con auditoría de exportaciones masivas | FR-00 |
| UC-00 | Configurar objetivos | Administrador | Fijar objetivos mensual o anual con histórico de cambios | FR-00 |
| UC-00 | Generar paquete para gestoría | Administrador | Exportar facturas, rectificativas, cobros y PDF de un periodo, con versionado | FR-00 |
| UC-00 | Configurar parámetros globales | Superadministrador | Plazo de pago, cadencias, dominio de correo, impuestos, umbrales, canales, calendario laboral; validado, auditado y no retroactivo | FR-00 |
| UC-00 | Consultar auditoría | Superadministrador | Filtrar el registro inmutable de acciones | FR-00 |
| UC-00 | Supervisar estado del sistema y procesos | Administrador | Ver última generación recurrente, cola de envíos, errores de integración, último backup y progreso de tareas en segundo plano | FR-00 |
| UC-00 | Cargar datos de demostración | Superadministrador | Generar datos ficticios aislados de producción | FR-00 |
