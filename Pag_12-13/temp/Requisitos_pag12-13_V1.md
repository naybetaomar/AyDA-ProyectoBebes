7/10726

Páginas 12 y 13


## Requisitos Funcionales

- El sistema debe manejar mutiples estados: pendiente de activación, activo, pausado, baja solicitada, inactivo y bloqueado, ....

- Si se solicita la baja de un cliente con facturas pendientes, el sistema debe permitir la baja pero continuar con el cobro.

- Aviso por eliminación de contacto: Debe alertar al usuario si se intenta eliminar el único contacto de facturación de un cliente activo.

- El sistema debe ofrecer una bandeja de aprobaciones donde se pueda ver el estado y los comentarios del aprobador.

- Debe permitir a los administradores reasignar solicitudes de aprobación o definir suplentes cuando una persona está de vacaciones, registrando dicha reasignación.

- Para el cálculo de vencimientos o envío de recordatorios, el sistema debe permitir configurar fines de semana y un calendario de festivos, moviendo las comunicaciones al siguiente día laborable.

- Una factura debe emitirse y conservarse en la moneda en que se creó. el sistema debe convertir importes a una moneda a un tipo de cambio registrado para informes, sin modificar los totales de las facturas.

- Debe evitar la duplicación de operaciones críticas (emisión, envío, conciliación) por dobles clics, utilizando botones deshabilitados.

- Debe permitir a un administrador marcar un periodo como cerrado administrativamente, impidiendo modificaciones ordinarias. Reabrirlo requiere un permiso superior y registrar el motivo.

- Debe permitir exportar el paquete mensual/trimestral de facturas (en formatos como ZIP o CSV), registrando cuándo se generó y a qué periodo correspondía.

- El sistema debe ofrecer visibilidad sobre el estado de la cola de emails y WhatsApp simulados (en cola, enviados, entregados, fallidos, reintentados).

- Debe guardar si el contacto ha dado su consentimiento para recibir comunicaciones administrativas por WhatsApp o canales similares.

- Cuando corresponda anonimizar a un contacto por protección de datos, la ficha operativa debe anonimizarse sin invalidar ni alterar los documentos contables/PDFs legales emitiéndose o ya emitidos.

## Requisitos No Funcionales y del Sistema

- Las operaciones pesadas (como generar masivamente PDFs) deben ejecutarse en segundo plano informando de su estado sin colapsar el sistema. La interfaz de usuario debe mantenerse activa y fluida durante el procesamiento de tareas largas en segundo plano.

- Precisión decimal absoluta en los cálculos monetarios para garantizar que las sumas cuadren exactamente en el PDF y el dashboard. Los cálculos de importes deben evitar pérdidas de céntimos (no usar tipos float imprecisos). Las reglas de redondeo deben estar documentadas.

- Los usuarios operativos no deben poder acceder a notas administrativas restringidas ni a datos de precios/negociaciones confidenciales si no les corresponde.

- Controles estrictos en las exportaciones masivas para evitar fuga de información sensible sin dejar traza. Todo auditado. Toda reasignación de aprobaciones, cierre o reapertura de periodos, cambio de estado de tareas, exportación de datos y acción de anonimización debe quedar estrictamente registrada de forma inalterable.
