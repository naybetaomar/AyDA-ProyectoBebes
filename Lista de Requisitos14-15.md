# Informe de Especificación de Requisitos Ampliados página 14-15

#### 1.3. Actores y partes interesadas

| Actor / stakeholder | Descripción | Intereses principales |
|---|---|---|
| Superadministrador | Usuario con los máximos privilegios de administración y configuración global del sistema. | Modificar parámetros del sistema (plazos de pago, frecuencia de recordatorios), gestionar altas y roles de usuarios, y acceder a revisiones globales. |
| Administrador | Personal administrativo de la empresa con acceso completo. | Gestionar todos los clientes y facturas, asignar clientes a los lectores, consultar dashboards y configurar la retención de informes. |
| Lector | Personal administrativo de la empresa con acceso limitado. | Consultar, emitir facturas y realizar operaciones exclusivamente sobre los clientes y facturas que tenga asignados. |
| Cliente | Empresa cliente del servicio. | Recibir las facturas y recordatorios con datos fiscales correctos. |
| Banco | Banco donde se registran los movimientos, transferencias y cobros automáticos. | Dar el registro de las operaciones para confirmar que cada factura se haya pagado. |
| Brain | Plataforma propia de la empresa que gestiona las cuentas de los clientes. | Consultar de forma automática con una API si hay pagos pendientes antes de dar de baja a un cliente o autorizar una operación. |

---

### 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | Automatizar todo el proceso de emisión de facturas recurrentes y seguimiento de cobros, evitando hacer las facturas a mano y escribir los recordatorios uno a uno. | Transcripción [P035, P038, P213, P214] |
| BR-02 | Permitir que la administración gestione miles de clientes sin necesidad de contratar a más personal administrativo. | Transcripción [P034, P171] |
| BR-03 | Asegurar que cada cambio en el estado de un cobro quede registrado y justificado, y que el sistema avise de inmediato al responsable si ocurre algún fallo o error automático. | Transcripción ampliada |
| BR-04 | Garantizar que las facturas mensuales no se detengan por errores en clientes concretos; los fallos puntuales se aislarán para que el resto siga procesándose. | Transcripción ampliada|
| BR-05 | Cumplir con la ley de conservación de facturas y, al mismo tiempo, respetar la privacidad de los clientes anonimizando sus datos cuando lo soliciten. | Transcripción [P084, P085, P100, P185] y Transcripción ampliada |
| BR-06 | Permitir la gestión de la facturación desde cualquier lugar o dispositivo, haciendo el proceso lo más rápido y sencillo posible. | Transcripción [P043, P045, P046, P216, P217] |

---

### 3. Requisitos de usuario

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-01 | Superadministrador / Administrador | Registrar nuevos clientes y definir si pagarán de forma recurrente o puntual en menos de un minuto y casi sin ayuda. | Transcripción [P038, P042, P043, P216] y Transcripción ampliada |
| UR-02 | Superadministrador / Administrador / Lector | Guardar automáticamente las facturas en borrador mientras se redactan, para no perder la información si se corta la conexión o se cierra la pestaña por accidente. | Transcripción ampliada |
| UR-03 | Superadministrador / Administrador / Lector | Encontrar cualquier cliente o factura en segundos usando filtros rápidos (estado, fechas, tipo o ubicación), sin tener que navegar por menús complicados. | Transcripción [P141] y Transcripción |
| UR-04 | Superadministrador / Administrador / Lector | Poder deshacer errores o acciones por accidente, y ver un aviso claro que explique el riesgo antes de hacer cambios que no se puedan revertir por ley. | Transcripción ampliada |
| UR-05 | Personal administrativo | Revisar y solucionar fácilmente los errores puntuales de los clientes que hayan quedado en pausa. | Transcripción ampliada |
| UR-06 | Superadministrador / Administrador / Lector | Asignar a cada usuario con rol Lector la cartera específica de clientes que le corresponde gestionar. | Transcripción [P118, P119, P147, P149, P200, P201] |
| UR-07 | Superadministrador / Administrador | Ver un dashboard con resúmenes semanales, mensuales y anuales para saber cuánto se ha facturado y qué cobros están pendientes. | Transcripción [P103, P104, P130, P131] |
| UR-08 | Superadministrador / Administrador | Definir cuánto tiempo se guardan los informes y descargas generadas antes de borrarlos, para no llenar la memoria del servidor. | Transcripción ampliada |
| UR-09 | Superadministrador | Definir los ajustes generales de facturación (días de plazo para cobrar y cada cuánto enviar avisos) y administrar el acceso de los usuarios al sistema. | Transcripción [P133, P134, P144, P151] y Transcripción ampliada |
| UR-10 | Superadministrador | Ver datos generales sobre el rendimiento del sistema y los fallos ocurridos. | Transcripción ampliada |
| UR-11 | Superadministrador / Administrador / Lector | Enviar automáticamente las facturas emitidas y los avisos de cobro por correo electrónico o WhatsApp. | Transcripción [P088, P101] |
| UR-12 | Brain  | Comprobar automáticamente con API si un cliente que pide la baja tiene alguna factura pendiente de pago. | Transcripción [P202, P203, P212] |

---

### 4. Requisitos del sistema

#### 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | Permitir registrar y editar los datos de cada cliente: razón social, NIF/CIF, dirección fiscal, sector, ubicación y contactos de facturación. | UR-01 |
| FR-02 | Permitir la carga masiva de clientes y contactos desde archivos CSV. | UR-01 |
| FR-03 | Asignar a cada cliente su forma de cobro: cuota fija mensual de suscripción (según lo que facture al año) o cobros puntuales por servicios extra. | UR-01 |
| FR-04 | Crear automáticamente el día 1 de cada mes las facturas de suscripción para todos los clientes activos. | UR-01 |
| FR-05 | Calcular y cobrar solo los días restantes del mes cuando un cliente con suscripción se dé de alta a mitad de mes. | UR-01 |
| FR-06 | Crear las facturas en PDF con el diseño de la empresa. | UR-01 |
| FR-07 | Guardar automáticamente en borrador las facturas puntuales mientras se redactan o editan, para evitar perder datos. | UR-02 |
| FR-08 | Permitir deshacer acciones o cambios erróneos realizados en la plataforma. | UR-04 |
| FR-09 | Mostrar un aviso claro antes de realizar acciones irreversibles explicando las consecuencias de no poder volver atrás. | UR-04 |
| FR-10 | Enviar automáticamente la factura en PDF al cliente por correo electrónico o WhatsApp, incluyendo el contacto del soporte técnico. | UR-11 |
| FR-11 | Enviar automáticamente los avisos de cobro: recordatorio previo el día 3, aviso de vencimiento el día 5 y avisos cada 2-3 días para facturas pendientes. | UR-11 |
| FR-12 | Comprobar y marcar automáticamente las facturas como pagadas examinando los datos con la pasarela de pago y el banco. | UR-03 |
| FR-13 | Guardar justificante que demuestre por qué una factura pasó a "Pagada". | UR-03 |
| FR-14 | Avisar de inmediato al responsable si falla el envío de una factura, se interrumpe un proceso automático o no cuadra un pago. | UR-05 |
| FR-15 | Procesar cada cliente por separado en la facturación mensual, aislando los errores puntuales para que no detengan el cobro al resto de clientes. | UR-05 |
| FR-16 | Filtrar y borrar los avisos duplicados que envíe la pasarela de pago para evitar registrar dos veces el mismo pago. | UR-05 |
| FR-17 | Cuando un cliente se dé de baja, cancelar sus facturas futuras pero continuar reclamando las facturas que ya tuviera pendientes. | UR-12 |
| FR-18 | Permitir buscar clientes y facturas mediante filtros rápidos. | UR-03 |
| FR-19 | Mostrar un dashboard con resúmenes semanales, mensuales y anuales, accesible solo para administradores. | UR-07 |
| FR-20 | Permitir al Administrador asignar clientes a usuarios con rol Lector, para que solo puedan ver o editar la información de esos clientes en concreto. | UR-06 |
| FR-21 | Exigir correo de la empresa y contraseña para iniciar sesión en la plataforma. | UR-01, UR-06 |
| FR-22 | Permitir que el Superadministrador defina los ajustes generales, como los días de plazo para el cobro y la frecuencia de los avisos de impago. | UR-09 |
| FR-23 | Fijar un plazo de caducidad para los informes y descargas generadas, eliminándolos automáticamente cuando pase ese tiempo. | UR-08 |
| FR-24 | Permitir la anonimización de los datos personales de un contacto (cumpliendo con la Ley de Protección de Datos) sin modificar las facturas históricas ya emitidas. | UR-01 |
| FR-25 | Recopilar datos generales sobre el rendimiento del sistema sin rastrear ni identificar a los empleados. | UR-10 |
| FR-26 | Ofrecer una integración con API para que otros sistemas autorizados puedan consultar si un cliente tiene facturas o deudas pendientes. | UR-12 |

#### 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-01 | Usabilidad / Facilidad de aprendizaje | Permitir que un usuario administrativo sin formación previa complete el alta de un cliente y la configuración de su suscripción casi sin ayuda. | Al menos el 90% de los usuarios deben completar el alta y la suscripción con éxito al primer intento usando solo la interfaz. |
| NFR-02 | Usabilidad / Eficiencia | Permitir realizar las tareas habituales (dar de alta un cliente, emitir una factura o revisar pagos) en pocos pasos y de forma ágil. | Tardar menos de 1 minuto en crear y emitir una factura o dar de alta a un cliente en condiciones normales. |
| NFR-03 | Usabilidad / Eficiencia | Encontrar cualquier cliente o factura mediante los buscadores y filtros de forma prácticamente instantánea. | Mostrar los resultados de búsqueda o filtrado en menos de 5 segundos. |
| NFR-04 | Usabilidad / Consistencia | Mantener una interfaz clara y coherente, situando los botones siempre en el mismo sitio y evitando avisos molestos o innecesarios. | Colocar los botones de acción en posiciones fijas en todas las pantallas y pedir confirmación solo al realizar acciones destructivas o irreversibles. |
| NFR-05 | Usabilidad / Portabilidad | Garantizar que la aplicación se adapte y funcione correctamente en cualquier pantalla o dispositivo. | Poder usar todas las funciones de consulta, emisión y seguimiento desde ordenador, tablet o móvil sin perder contenido ni agilidad. |
| NFR-06 | Escalabilidad | Preparar la arquitectura del sistema para soportar una gran cantidad de datos y usuarios sin que se vuelva lenta. | Soportar la gestión y facturación de al menos 2.500 clientes activos simultáneamente sin fallos de rendimiento. |
| NFR-07 | Confiabilidad | Garantizar que el cobro mensual continúe aunque surjan errores puntuales, sin duplicar cobros. | Procesar correctamente al 100% de los clientes válidos y registrar las excepciones, sin que un fallo individual detenga al resto. |
| NFR-08 | Seguridad y Privacidad | Proteger los datos fiscales mediante permisos y cuidar la privacidad de los empleados en los datos de uso. | Exigir correo de la empresa y restringir el acceso a datos fiscales según permisos |
| NFR-09 | Mantenibilidad / Arquitectura | Estructurar y documentar el código de forma clara para que cualquier equipo pueda mantenerlo o mejorarlo fácil. | Desarrollar un sistema modular con convenciones, migraciones de base de datos, pruebas y documentación de despliegue. |
| NFR-10 | Mantenibilidad / Centralización | Reunir todos los ajustes en una zona. | Modificar los plazos de pago, avisos y tarifas desde un solo módulo central, sin tener que cambiar todo el código de la aplicación. |
| NFR-11 | Robustez | Asegurar que los cálculos de facturas, fechas y cobros sean siempre exactos. | Realizar los cálculos mediante programación tradicional, sin IA. |
| NFR-12 | Integridad y Legalidad | Proteger las facturas emitidas para que no se puedan alterar y guardarlas el tiempo que exige la ley. | Mantener inalterables los PDF de las facturas durante al menos 5 años, aunque el cliente se dé de baja o se anonimicen sus datos. |