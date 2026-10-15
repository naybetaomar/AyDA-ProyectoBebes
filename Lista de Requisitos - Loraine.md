# Requisitos

## 1\. Contexto y alcance

### 1.1. Objetivo del sistema

Proveer una herramienta interna de gestión administrativa, facturación y cobros para Turbine (independiente del producto principal Brain), permitiendo gestionar de forma ágil y eficiente miles de clientes, suscripciones, facturas recurrentes y puntuales, pagos, recordatorios y flujos operativos administrativos sin requerir un ERP complejo.

### 1.2. Alcance

El sistema abarca la gestión comercial y fiscal de clientes (empresas y contactos múltiples), la emisión y ciclo de vida de facturas (recurrentes y puntuales), presupuestos (opcional), notas rectificativas, conciliación bancaria y de pasarelas (Stripe simulado), notificaciones internas, pantallas de trabajo diario, paneles financieros, auditoría, roles y permisos, copias de seguridad e integración mediante API. Quedan explícitamente fuera la gestión de producto principal (Brain), asesoría fiscal internacional automatizada compleja, integraciones obligatorias con Verifactu en la fase inicial, o procesamiento directo de pagos reales sin pasarela simulada.

### 1.3. Actores y partes interesadas

| Actor / stakeholder | Descripción | Intereses principales |
| :---- | :---- | :---- |
| Superadministrador / Proveedor | Usuario con máximo nivel de privilegios en el sistema | Poder editar configuraciones profundas (tarifas, rangos, umbrales de precio, series, dominios permitidos, canales de notificación, auditoría global) |
| Administrador / Responsable | Empleado con privilegios de gestión operativa y de clientes | Supervisar el estado global del sistema, consultar histórico, gestionar cambios de plan anuales, aprobar excepciones comerciales, asignar clientes, garantizar integridad contable y gestionar control de acceso |
| Editor / Trabajador (Usuario operativo) | Empleado con privilegios básicos sobre sus clientes asignados | Realizar operaciones administrativas diarias, conocer saldos, facturas pendientes y pagadas, gestionar envíos, registrar incidencias y consultar su pantalla de trabajo diario |
| Sistema externo (Brain / API) | Sistema externo que consulta datos de clientes, deuda, facturas y solicita bajas | Consultar información y enviar solicitudes validadas sin saltarse las reglas de negocio del sistema |

## 2\. Requisitos de negocio

| ID | Requisito | Fuente |
| :---- | :---- | :---- |
| BR-01 | Reducir el trabajo manual asociado a la generación masiva de facturas y seguimiento de cobros a medida que Turbine crece hacia miles de clientes | Transcripción ampliada |
| BR-02 | Mantener la independencia operativa de la herramienta administrativa respecto al producto principal (Brain) | Transcripción ampliada (Página 1\) |
| BR-03 | Garantizar la integridad legal, contable e histórica de la facturación y de las relaciones comerciales | Transcripción ampliada (Páginas 2-3) |

## 3\. Requisitos de usuario

| ID | Actor | Requisito | Fuente |
| :---- | :---- | :---- | :---- |
| UR-01 | Usuario operativo / Administrador | Poder disponer de una pantalla de trabajo diaria útil que muestre alertas y tareas pendientes para resolverlas con pocos clics | Transcripción ampliada (Página 6\) |
| UR-02 | Responsable interno | Poder recibir notificaciones relevantes de los clientes asignados y distinguir las ya leídas de las ya resueltas | Transcripción ampliada (Página 6\) |
| UR-03 | Superadministrador | Poder configurar canales y preferencias de notificación (in-app, email, resumen diario) para evitar saturación | Transcripción ampliada (Página 6\) |
| UR-04 | Administrador | Poder consultar un dashboard financiero con cifras reales y generar informes filtrables y exportables a CSV y PDF | Transcripción ampliada (Página 6\) |
| UR-05 | Usuario | Poder realizar búsquedas globales rápidas y guardar vistas o filtros frecuentes | Transcripción ampliada (Página 6\) |
| UR-06 | Usuario | Poder importar clientes desde CSV con previsualización, mapeo y control de duplicados (NIF) | Transcripción ampliada (Página 6\) |
| UR-07 | Administrador | Poder importar histórico de facturas en modo migración sin disparar emails ni consumir numeración oficial | Transcripción ampliada (Página 6\) |
| UR-08 | Superadministrador / Administrador | Poder gestionar altas, invitaciones y desactivaciones de usuarios internos manteniendo el histórico de auditoría | Transcripción ampliada (Página 6\) |
| UR-09 | Usuario | Poder recuperar la contraseña mediante un enlace temporal con caducidad | Transcripción ampliada (Página 6\) |
| UR-10 | Usuario operativo | Trabajar exclusivamente sobre los clientes asignados, con permisos operativos limitados y sin acceso a la configuración global | Transcripción ampliada (Página 7\) |
| UR-11 | Administrador | Asignar y desasignar clientes, heredando el nuevo responsable las tareas pendientes y manteniendo el histórico | Transcripción ampliada (Página 7\) |
| UR-12 | Administrador | Delegar temporalmente los clientes de un usuario (por vacaciones) sin necesidad de compartir contraseñas | Transcripción ampliada (Página 7\) |
| UR-13 | Usuario | Que el sistema detecte conflictos de edición concurrente para evitar sobrescribir cambios de otros usuarios | Transcripción ampliada (Página 7\) |
| UR-14 | Superadministrador | Consultar y filtrar los registros de auditoría de negocio sin poder alterar el pasado | Transcripción ampliada (Página 7\) |
| UR-15 | Responsable del sistema | Disponer de copias de seguridad automáticas y un mecanismo de restauración probado y demostrable | Transcripción ampliada (Página 7\) |
| UR-16 | Usuario autenticado | Descargar únicamente los documentos e información para los cuales posea permisos válidos | Transcripción ampliada (Página 7\) |

## 4\. Requisitos del sistema

### 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
| :---- | :---- | :---- |
| FR-01 | El sistema debe gestionar notificaciones internas diferenciadas de los correos enviados a clientes | UR-02 |
| FR-02 | Cada cliente debe tener un responsable interno asignado para recibir eventos relevantes (pago confirmado, factura vencida, rebote, disputa, revisión anual) | UR-02 |
| FR-03 | El sistema debe ofrecer una bandeja global de notificaciones para administradores y bandeja específica para usuarios operativos | UR-02 |
| FR-04 | El sistema debe permitir al superadministrador configurar el canal de recepción de notificaciones (in-app, email, resumen diario) | UR-03 |
| FR-05 | El sistema debe permitir marcar las notificaciones como leídas | UR-02 |
| FR-06 | El sistema debe permitir distinguir entre notificaciones leídas y notificaciones resueltas/atendidas | UR-02 |
| FR-07 | Las notificaciones deben incorporar estados y prioridades | UR-02 |
| FR-08 | El sistema debe ofrecer una pantalla de trabajo diario que muestre vencimientos, pagos pendientes de conciliación, problemas de entrega, aprobaciones pendientes y revisiones | UR-01 |
| FR-09 | El sistema debe permitir al usuario saltar directamente desde la pantalla de trabajo diario al elemento afectado para resolverlo en pocos clics | UR-01 |
| FR-10 | El sistema debe ofrecer a los administradores un dashboard financiero con métricas de facturación, cobros, pendientes, vencidos, tiempo medio de cobro, ingresos recurrentes e historial | UR-04 |
| FR-11 | Los informes financieros y operativos deben poder filtrarse por periodo, cliente, responsable, país, sector, estado y tipo de factura | UR-04 |
| FR-12 | El sistema debe permitir exportar los resultados de informes a formato CSV y PDF | UR-04 |
| FR-13 | Las exportaciones deben respetar rigurosamente los permisos de acceso del usuario | UR-04, UR-10 |
| FR-14 | El sistema debe proporcionar una búsqueda global por nombre comercial, razón social, NIF, persona de contacto, número de factura y correo | UR-05 |
| FR-15 | El sistema debe mantener y aplicar filtros de ubicación y sector | UR-05 |
| FR-16 | El sistema debe permitir guardar filtros y vistas frecuentes de trabajo | UR-05 |
| FR-17 | El sistema debe permitir importar clientes desde ficheros CSV con previsualización previa | UR-06 |
| FR-18 | En la importación de CSV, el usuario debe poder mapear columnas, revisar errores y decidir si importa filas válidas o corrige el fichero | UR-06 |
| FR-19 | El sistema debe alertar si detecta NIFs duplicados durante la importación | UR-06 |
| FR-20 | La importación completa debe registrarse como operación con resumen de registros creados, actualizados y rechazados | UR-06 |
| FR-21 | El sistema debe permitir la importación administrativa de histórico de facturas, separada de la emisión ordinaria | UR-07 |
| FR-22 | Las facturas históricas importadas no deben disparar emails ni consumir numeración oficial, quedando marcadas como migradas | UR-07 |
| FR-23 | El acceso de usuarios internos debe realizarse mediante correo y contraseña del dominio corporativo autorizado | UR-08 |
| FR-24 | El sistema debe prohibir estrictamente el autorregistro de usuarios | UR-08 |
| FR-25 | El superadministrador o administrador con permisos debe poder crear o invitar usuarios internos | UR-08 |
| FR-26 | El sistema debe permitir desactivar cuentas de usuarios que abandonen la empresa preservando el rastro de sus acciones | UR-08 |
| FR-27 | El sistema debe permitir la recuperación de contraseñas | UR-09 |
| FR-28 | Los enlaces de recuperación de contraseña deben caducar en un tiempo razonable | UR-09 |
| FR-29 | El sistema debe distinguir roles de superadministrador, administrador y usuario operativo | UR-10 |
| FR-30 | El sistema debe implementar un modelo centralizado y coherente de autorización de permisos | UR-10 |
| FR-31 | El usuario operativo debe poder gestionar información operativa, crear facturas autorizadas y seguir cobros de sus clientes asignados | UR-10 |
| FR-32 | El usuario operativo no debe poder autoasignarse clientes, modificar tarifas globales, crear series ni ver el dashboard financiero global | UR-10 |
| FR-33 | El administrador debe poder asignar y desasignar clientes a los usuarios | UR-11 |
| FR-34 | Al reasignar un cliente, el nuevo responsable debe heredar tareas pendientes manteniendo el histórico de acciones | UR-11 |
| FR-35 | El administrador debe poder delegar temporalmente los clientes de un usuario a un suplente durante un intervalo | UR-12 |
| FR-36 | Las delegaciones temporales deben caducar automáticamente al finalizar el intervalo | UR-12 |
| FR-37 | El sistema debe detectar conflictos de edición concurrente en facturas para evitar sobrescrituras silenciosas | UR-13 |
| FR-38 | Las operaciones monetarias críticas, numeración y conciliación deben mantener consistencia ante accesos concurrentes | UR-13 |
| FR-39 | El sistema debe registrar un log de auditoría de negocio detallado para operaciones clave (creación de clientes, cambios fiscales, emisión, descuentos, reasignaciones, disputas, conciliaciones) | UR-14 |
| FR-40 | Los registros de auditoría no deben ser editables por usuarios normales | UR-14 |
| FR-41 | El superadministrador debe poder consultar y filtrar la auditoría sin poder reescribirla | UR-14 |
| FR-42 | El sistema debe realizar copias de seguridad automáticas de datos y documentos con política definida | UR-15 |
| FR-43 | El sistema debe permitir la restauración de copias de seguridad mediante un mecanismo demostrado | UR-15 |
| FR-44 | Las facturas, datos fiscales y contactos no deben ser accesibles mediante URLs públicas adivinables | UR-16 |
| FR-45 | Un usuario autenticado solo debe poder descargar documentos autorizados | UR-16 |
| FR-46 | Los enlaces temporales de descarga de documentos deben caducar | UR-16 |

### 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
| :---- | :---- | :---- | :---- |
| NFR-01 | Seguridad | Las contraseñas no deben almacenarse en texto plano | Uso de hashing seguro (bcrypt/argon2) |
| NFR-02 | Seguridad | Las comunicaciones deben estar cifradas | Uso obligatorio de HTTPS/TLS en todo el tráfico web |
| NFR-03 | Seguridad | Los secretos y credenciales de Stripe simulado no deben almacenarse en el repositorio | Carga exclusiva mediante variables de entorno externas |
| NFR-04 | Seguridad | El diseño de autenticación no debe impedir la incorporación futura de doble factor (2FA) | Arquitectura de usuarios preparada para la extensión a 2FA |
| NFR-05 | Mantenibilidad | Los permisos no deben estar dispersos en condicionales arbitrarios | Modelo coherente y centralizado de autorización |
| NFR-06 | Fiabilidad | Las copias de seguridad deben ser probadas mediante restauración periódica | Existencia de procedimiento de prueba documentado |
| NFR-07 | Fiabilidad | El sistema de backup debe estar diseñado y demostrado | Mecanismo seguro de almacenamiento y recuperación de backups |
| NFR-08 | Privacidad | Capacidad de anonimizar datos personales por normativa sin destruir la trazabilidad de auditoría | Anonimización manteniendo integridad de IDs y logs |
| NFR-09 | Privacidad / Cumplimiento | Aplicación de principios de minimización y conservación de datos operativos y personales | Almacenamiento restringido a lo estrictamente necesario |
| NFR-10 | Rendimiento | Las operaciones y búsquedas habituales deben sentirse prácticamente inmediatas | Tiempos de respuesta reducidos para volúmenes de miles de clientes |
| NFR-11 | Escalabilidad | El sistema debe soportar crecimiento a decenas o centenares de usuarios internos y miles de clientes | Diseño modular sin carga excesiva en cliente ni dependencias rígidas de infraestructura |
| NFR-12 | Fiabilidad / Recuperación | Las tareas automáticas periódicas (generación mensual, recordatorios) deben ser idempotentes y reintentables | Recuperación automática ante caídas sin duplicar documentos ni cobros |

## 5\. Reglas de negocio

| ID | Regla |
| :---- | :---- |
| RB-01 | Una factura y un presupuesto conservan identidades e históricos independientes, aunque el presupuesto aceptado reutilice líneas para generar la factura |
| RB-02 | El saldo pendiente de un cliente y la facturación total acumulada son conceptos distintos y reconciliables |
| RB-03 | Una factura emitida no puede editarse silenciosamente ni borrarse; cualquier corrección posterior requiere trazabilidad o emisión de factura rectificativa |
| RB-04 | La relación comercial (suscripción/tarifa) es independiente de las facturas generadas; modificar un precio futuro no reescribe las facturas pasadas |
| RB-05 | El cálculo del prorrateo se realiza dividiendo la cuota mensual entre los días reales del mes en curso y multiplicando por los días de servicio a prestar |
| RB-06 | Las facturas en estado borrador no consumen numeración oficial definitiva, la cual se asigna de forma concurrente y única en el momento de la emisión |
| RB-07 | Una baja comercial recibida detiene la generación de nuevas cuotas recurrentes pero mantiene activo el flujo de recobro de deudas pendientes anteriores |

## 6\. Suposiciones y decisiones de análisis

| ID | Suposición o decisión | Justificación | Requisitos afectados |
| :---- | :---- | :---- | :---- |
| A-01 | El tamaño y formatos permitidos para archivos adjuntos están limitados (PDF, JPG/PNG, DOCX, XLSX, CSV hasta 10 MB) | Petición de control de seguridad y prevención de ejecutables | FR-44, NFR-08 |
| A-02 | La sesión expira tras un periodo razonable de inactividad y se invalidan sesiones de usuarios desactivados | Necesidad de seguridad básica para equipos compartidos | FR-26 |
| A-03 | Se implementa bloqueo temporal tras 5 intentos fallidos de login consecutivos | Protección contra ataques de fuerza bruta sin bloqueo excesivo | FR-23 |
| A-04 | La regularización retroactiva requiere acción explícita y aprobación administrativa | Evitar emisión automática de facturas retroactivas imprevistas | FR-39, RB-04 |
| A-05 | La detección de duplicados de clientes se basa en coincidencias de NIF, razón social, email o teléfono | Prevención de duplicidades en importaciones y altas | FR-19 |
| A-06 | Se adopta integración simulada para Stripe, WhatsApp y correo electrónico | Cumplir objetivos funcionales sin dependencia de contratos con proveedores reales de pago o mensajería | FR-50, FR-51 |

## 7\. Dudas, ambigüedades y cuestiones pendientes

| ID | Cuestión | Origen | Impacto | Estado / resolución |
| :---- | :---- | :---- | :---- | :---- |
| Q-01 | Criterio exacto de umbrales económicos para aprobación de descuentos por el superadministrador | Transcripción ampliada | Configuración de flujos de aprobación | Pendiente de definición parametrizable |
| Q-02 | Calendario de festivos y días laborables exacto para el cálculo de vencimientos en diferentes países | Transcripción ampliada | Automatización de recordatorios | Resuelta: configuración basada en calendario configurable de España para fase inicial |

## 8\. Trazabilidad

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
| :---- | :---- | :---- |
| BR-01 | UR-01, UR-04 | FR-08, FR-10, NFR-10, NFR-11 |
| BR-02 | UR-10 | FR-31, FR-32 |
| BR-03 | UR-07, UR-14, UR-15 | FR-21, FR-22, FR-39, FR-42, NFR-06 |

## 9\. Glosario

| Término | Definición |
| :---- | :---- |
| Factura emitida | Factura validada y emitida oficialmente con numeración única que no puede ser editada silenciosamente |
| Factura rectificativa | Documento legal vinculado a una factura original para corregir errores o importes |
| Borrador de factura | Estado previo a la emisión donde la factura es editable y no consume numeración oficial |
| Presupuesto | Documento previo comercial aceptado o rechazado que puede reutilizar líneas para generar facturas |
| Saldo | Importe pendiente de cobro de un cliente, considerando facturas emitidas, rectificativas y pagos registrados |
| Facturación | Importe total facturado a un cliente en un periodo determinado |
| Campaña de revisión | Proceso anual de revisión de facturación anual y tarifas de clientes |
| Rango de plan | Tramo de facturación anual al que corresponde una tarifa específica configurada |
| Solicitud controlada | Petición externa vía API que requiere validación o aprobación antes de afectar a los datos del sistema |
| Entidad emisora | Sociedad jurídica desde la cual se emiten facturas, con sus respectivas series de numeración |
| Prorrateo | Cálculo proporcional de la cuota mensual cuando un servicio inicia en un día distinto al día 1 del mes |
| Conciliación | Proceso de asociación entre un movimiento de cobro recibido (Stripe/banco) y su factura correspondiente |

