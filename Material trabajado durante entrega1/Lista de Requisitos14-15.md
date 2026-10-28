# Informe de Especificación de Requisitos Ampliados página 14-15

#### 1.3. Actores y partes interesadas

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Superadministrador | Usuario con los máximos privilegios de administración y configuración global del sistema. | Modificar parámetros del sistema, gestionar altas y roles de usuarios, y acceder a revisiones globales. |
| Administrador | Personal administrativo de la empresa con acceso completo. | Gestionar todos los clientes y facturas, asignar clientes a los lectores, consultar dashboards y configurar la retención de informes. |
| Lector | Personal administrativo de la empresa con acceso limitado. | Operar sobre la información de los clientes que tenga asignados. |
| Cliente | Empresa cliente del servicio. | Recibir las facturas y recordatorios con datos fiscales correctos. |
| Pasarela/Banco | Banco donde se registran los movimientos, transferencias y cobros automáticos. | Dar el registro de las operaciones para confirmar que cada factura se haya pagado. |
| Brain | Plataforma propia de la empresa que gestiona las cuentas de los clientes. | Consultar de forma automática con una API si hay pagos pendientes antes de dar de baja a un cliente o autorizar una operación. |

---

### 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | El sistema deberá automatizar la creación mensual de facturas recurrentes. | Transcripción |
| BR-02 | El sistema deberá automatizar el seguimiento y las notificaciones de los cobros pendientes. | Transcripción |
| BR-03 | La empresa deberá ser escalable sin necesidad de incrementar el personal administrativo. | Transcripción |
| BR-04 | El sistema deberá registrar y justificar cada cambio de estado en el momento del cobro. | Transcripción ampliada|
| BR-05 | El sistema deberá garantizar la continuidad del flujo de facturación masiva ante errores puntuales en registros individuales. | Transcripción ampliada |
| BR-06 | La empresa deberá cumplir con las políticas legales de conservación y protección de facturas emitidas. | Transcripción y Transcripción ampliada |
| BR-07 | La empresa deberá proteger la privacidad de los clientes ante solicitudes de anonimización manteniendo los registros contables. | Transcripción y Transcripción ampliada |

---

### 3. Requisitos de usuario

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-01 | Superadministrador / Administrador | El administrador deberá registrar la información fiscal y operativa de nuevos clientes. | Transcripción y Transcripción ampliada |
| UR-02 | Superadministrador / Administrador | El administrador deberá establecer el tipo de cobro (suscripción o pago puntual) a cada cliente. | Transcripción y Transcripción ampliada |
| UR-03 | Superadministrador / Administrador / Lector | El usuario deberá conservar su información redactada ante interrupciones accidentales durante la edición de facturas. | Transcripción ampliada |
| UR-04 | Superadministrador / Administrador / Lector | El usuario deberá encontrar clientes y registros aplicando filtros. | Transcripción y Transcripción ampliada |
| UR-05 | Superadministrador / Administrador / Lector | El usuario deberá poder deshacer modificaciones accidentales exceptuando las legalmente irreversibles. | Transcripción ampliada |
| UR-06 | Superadministrador / Administrador / Lector | El usuario deberá comprender el nivel de irreversibilidad legal y riesgo de una acción antes de su confirmación final. | Transcripción ampliada |
| UR-07 | Superadministrador / Administrador / Lector | El personal deberá poder identificar y resolver las incidencias y excepciones técnicas de los procesos de cobro. | Transcripción ampliada |
| UR-08 | Superadministrador / Administrador | El administrador deberá delimitar el acceso a la información asignando clientes específicos a cada usuario con rol Lector. | Transcripción |
| UR-09 | Superadministrador / Administrador | El administrador deberá poder analizar la evolución global mediante un dashboard. | Transcripción |
| UR-10 | Superadministrador / Administrador | El sistema deberá reclamar la deuda de clientes inactivos o dados de baja. | Transcripción y Transcripción ampliada |
| UR-11 | Superadministrador | El superadministrador deberá poder establecer un tiempo de retención de almacenamiento temporal para informes. | Transcripción ampliada |
| UR-12 | Superadministrador | El superadministrador deberá poder configurar los vencimientos y recurrencia de notificaciones. | Transcripción y Transcripción ampliada |
| UR-13 | Superadministrador | El superadministrador deberá poder evaluar la eficiencia operativa mediante un dashboard. | Transcripción ampliada |
| UR-14 | Brain | Brain deberá obtener el estado actualizado de pagos pendientes de cualquier cliente. | Transcripción |

---

### 4. Requisitos del sistema

#### 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | El sistema deberá registrar los campos obligatorios de cliente: nombre, NIF/CIF, dirección fiscal, sector y contactos. | UR-01 |
| FR-02 | El sistema deberá permitir la carga masiva de clientes y contactos desde archivos CSV. | UR-01 |
| FR-03 | El sistema deberá vincular cada cliente a un modelo de cobro de suscripción recurrente o de servicio puntual. | UR-02 |
| FR-04 | El sistema deberá crear las facturas de las suscripciones el primer día de cada mes para los clientes en estado activo. | UR-02 |
| FR-05 | El sistema deberá calcular el importe basado en los días efectivos restantes del mes en curso de nueva suscripción. | UR-02 |
| FR-06 | El sistema deberá autoguardar borradores periódicos durante redacción de facturas. | UR-03 |
| FR-07 | El sistema deberá disponer filtros de búsqueda basados en ubicación, sector comercial, estado de pago y fechas. | UR-04 |
| FR-08 | El sistema deberá poder deshacer acciones que no tengan inmutabilidad legal. | UR-05 |
| FR-09 | El sistema deberá requerir una confirmación explícita informando de la imposibilidad de restauración antes de ejecutar borrados o envíos a Hacienda. | UR-06 |
| FR-10 | El sistema deberá notificar al empleado responsable ante la interrupción en el envío o proceso de validación de una factura. | UR-07 |
| FR-11 | El sistema deberá capturar las notificaciones de eventos duplicados emitidas por la pasarela de pagos y reportarlas. | UR-07 |
| FR-12 | El sistema deberá aislar y excluir a los clientes que generen errores de procesamiento, prosiguiendo con el cobro del resto del conjunto. | UR-07 |
| FR-13 | El sistema deberá restringir la visualización y edición del rol Lector estrictamente al conjunto de clientes vinculados a su perfil por un administrador. | UR-08 |
| FR-14 | El sistema deberá autenticar a los usuarios validando obligatoriamente el uso de un correo de la empresa. | UR-08 |
| FR-15 | El sistema deberá generar un dashboard resumiendo la facturación total y deuda pendiente semanalmente, mensualmente y anualmente. | UR-09 |
| FR-16 | El sistema deberá suspender la generación de facturas futuras recurrentes para aquellos clientes dados de baja. | UR-10 |
| FR-17 | El sistema deberá continuar el envío de avisos de impago sobre las facturas emitidas no pagadas. | UR-10 |
| FR-18 | El sistema deberá eliminar del servidor los archivos exportados temporalmente una vez superado su tiempo de caducidad. | UR-11 |
| FR-19 | El sistema deberá poder ajustar la recurrencia de los avisos y cobros según la configuración del Superadministrador. | UR-12 |
| FR-20 | El sistema deberá recopilar el tiempo invertido en generar acciones críticas, los fallos devueltos por el sistema y el conteo de clics de los usuarios de forma anonima. | UR-13 |
| FR-21 | El sistema deberá exponer una API que responda con el estado de deuda asociado a un identificador de cliente. | UR-14 |
| FR-22 | El sistema deberá comparar el identificador de la pasarela con el identificador de la factura para marcar su estado como "Cobrada". | UR-07 |
| FR-23 | El sistema deberá guardar de forma permanente los datos de confirmación de la pasarela de pago en la factura en cuanto esta cambie su estado a "Cobrada". | UR-07 |
| FR-24 | El sistema deberá transmitir las facturas emitidas en formato digital mediante la vía de contacto registrada del cliente (correo o whatsapp). | UR-01, UR-12 |
| FR-25 | El sistema deberá ejecutar el cálculo financiero mediante programación determinista tradicional sin usar IA. | UR-13 |
| FR-26 | El sistema deberá desactivar completamente sus funciones de apoyo basadas en inteligencia artificial de forma configurable (opcional). | UR-13 |

#### 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-01 | Usabilidad / Facilidad de aprendizaje | El sistema deberá posibilitar que un usuario administrativo asimile el alta de un cliente de forma directa. | Al menos el 90% de los sujetos de prueba sin experiencia completarán el alta de suscripción al primer intento. |
| NFR-02 | Usabilidad / Eficiencia | El sistema deberá requerir una carga mínima de interacciones para las operaciones fundamentales de la empresa. | El proceso completo de creación y emisión de una factura puntual requerirá la ejecución de menos de 5 clics. |
| NFR-03 | Usabilidad / Eficiencia | El sistema deberá procesar las búsquedas de clientes de forma fluida. | Las consultas y filtrados del catálogo de clientes devolverán los datos solicitados en un tiempo inferior a 3 segundos. |
| NFR-04 | Usabilidad / Consistencia | El sistema deberá estandarizar la disposición de la intefaz. | Los botones principales de guardado y navegación estarán ubicados en lugares idénticos en todas las pantallas. |
| NFR-05 | Escalabilidad | El sistema deberá ser escalable en la base de datos sin degradación para el usuario. | Soportará la operación simultánea de 2.500 clientes sin superar 5 segundos de latencia. |
| NFR-07 | Confiabilidad | El sistema deberá garantizar la validación del procesamiento de facturación frente a registros corruptos. | El procesamiento finalizará con un 100% de registros válidos, almacenando los corruptos en una cola de excepciones. |
| NFR-08 | Seguridad y Privacidad | El sistema deberá mantener el carácter inmutable y exacto de los documentos fiscales emitidos. | La anonimización posterior de un cliente mantendrá el archivo del PDF generado intacto. |
| NFR-09 | Mantenibilidad / Arquitectura | El sistema deberá adoptar prácticas formales que garanticen el relevo a futuro. | El proyecto será un sistema modular con convenciones, migraciones de base de datos, pruebas y documentación de despliegue. |
| NFR-10 | Mantenibilidad / Centralización | El sistema deberá agrupar la lógica de reglas de facturación en un mismo lugar. | La variación de un plazo de cobro no requerirá cambio de todo el código y se gestionará mediante el cambio de una sola constante. |
| NFR-11 | Robustez | El sistema deberá procesar la contabilidad usando operaciones aritméticas convencionales. | Todo cálculo numérico, vencimiento e IVA se resolverá exclusivamente con algoritmos clásicos y verificables, sin IA. |
| NFR-12 | Integridad y Legalidad | El sistema deberá garantizar la persistencia de las facturas. | Las facturas en PDF dispondrán de un bloqueo contra modificaciones o borrados directos en la base de datos durante el plazo legal obligatorio. |
