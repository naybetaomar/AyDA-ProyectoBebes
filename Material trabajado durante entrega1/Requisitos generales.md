# Requisitos



## 1. Contexto y alcance



### 1.1. Objetivo del sistema



Proveer una herramienta interna de gestión administrativa, facturación y cobros para Turbine H (independiente del producto principal Brain). El sistema busca optimizar el envío de facturas por correo electrónico mediante plantillas personalizables, el seguimiento de vencimientos y estados de pago, la asignación de clientes a empleados, el registro de incidencias y la generación de informes y resúmenes periódicos.



### 1.2. Alcance

* **Dentro del alcance:**
  * Creación, gestión y envío de facturas y recordatorios previos por correo electrónico utilizando plantillas con variables dinámicas (nombre de empresa, número de factura, importe y vencimiento)
  * Control y seguimiento de los estados de las facturas (pago e impago) y el NIF de los clientes
  * Gestión de versiones de documentos y registros, así como búsqueda de direcciones
  * Asignación de clientes a empleados y apertura/seguimiento de incidencias.
  * Generación de informes específicos de la aplicación (incluyendo facturas fallidas de meses anteriores) y resúmenes semanales y mensuales
  * Soporte multiplataforma (ordenador, tablet y móvil), multilingüe (español e inglés), zona horaria de España e integración con Zoom
* **Fuera del alcance:**
  * Procesamiento directo de pasarelas de pago bancarias automatizadas (la actualización de estados de pago se gestionará internamente o mediante registro manual/externo).
  * Sistemas contables externos avanzados o ERPs globales fuera del dominio de la aplicación de facturación e incidencias.

### 1.3. Actores y partes interesadas

| Actor / stakeholder | Descripción | Intereses principales |
| :---- | :---- | :---- |
| Superadministrador | Persona  con acceso a la configuración global del sistema | Configurar umbrales de aprobación, rangos y tarifas, series de numeración y recordatorios |
| Administrador | Empleado con permisos de gestión de operación, clientes, facturas, asignaciones y aprobaciones, sin acceso a la configuración global | Supervisar el estado del sistema, consultar el histórico de cualquier cliente, gestionar cambios de plan anuales, corregir errores con facturas rectificativas y gestionar el control de acceso |
| Lector | Empleado que trabaja sobre los clientes que tiene asignados | Realizar sus operaciones diarias, conocer el saldo y las facturas pendientes y pagadas de sus clientes y tener claro el estado real de los envíos |
| Sistema externo | Sistema de terceros o de Turbine (como Brain) que consume la API de la aplicación | Consultar deuda, facturas y clientes y solicitar bajas sin saltarse las reglas del sistema |
| Pasarela de pagos (Stripe simulado) | Servicio externo que notifica los cobros | Que los pagos se reflejen correctamente en las facturas, sin contabilizar dos veces el mismo evento |
| Planificador (tareas automáticas) | Disparador de procesos sin intervención humana | Generación mensual, recordatorios, campaña anual y caducidad de delegaciones |


## 2\. Requisitos de negocio

| ID | Requisito | Fuente |
| :---- | :---- | :---- |
| BR-01 | Reducir drásticamente el trabajo manual mediante la automatización confiable de la creación mensual recurrente de facturas, recordatorios previos y seguimiento de cobros con plantillas estandarizadas, garantizando continuidad ante errores puntuales sin fallos en silencio ni duplicidades | Transcripción / Transcripción ampliada / Notas de requisitos / Ampliación |
| BR-02 | Mantener la independencia operativa de la herramienta administrativa respecto al producto principal (Brain) mediante un sistema interno propio que optimice la tasa de cobro, la gestión de impagos y la conciliación bancaria, permitiendo que la estructura evolucione de forma escalable sin aumentar personal administrativo ni reescribir el software | Transcripción / Transcripción ampliada (Página 1) / Cliente / Entrevista / Ampliación |
| BR-03 | Garantizar la integridad legal, contable e inmutabilidad histórica de la facturación, contactos y relaciones comerciales frente a cambios de marca o catálogo, asegurando el control económico, la trazabilidad (saber quién hizo qué, cuándo y por qué) y el cumplimiento de las políticas de conservación | Transcripción / Transcripción ampliada (Páginas 2-3) / Cliente / Entrevista / Ampliación |
| BR-04 | Mejorar el control financiero y la trazabilidad de la cartera permitiendo al administrador conocer la situación global del negocio sin revisar cada cliente individualmente a medida que crece la cartera, mediante el seguimiento de vencimientos, estados de pago/impago, control de NIF/VAT internacional y visibilidad contable fiable (facturado, cobrado, pendiente, vencido, previsión) | Notas de requisitos / sesión de análisis / Entrevista / Cliente / Ampliación |
| BR-05 | Potenciar la eficiencia operativa y la coordinación interna permitiendo la asignación de clientes a empleados, la gestión de incidencias y el acceso multiplataforma, multilingüe e internacional (sin asumir formatos o domicilios exclusivamente españoles) | Notas de requisitos / sesión de análisis / Cliente / Entrevista |
| BR-06 | Proteger los datos de clientes, contactos y documentos frente a accesos y exportaciones indebidas, garantizando la privacidad y el derecho de anonimización sin invalidar el histórico contable | Transcripción / Transcripción ampliada / Entrevista / Ampliación |
| BR-07 | Garantizar que la aplicación no utilice automáticamente datos de facturación para campañas comerciales | Entrevista / Ampliación |
| BR-08 | Representar la relación comercial de cada cliente de forma independiente de sus facturas y del producto, separando la rescisión de contrato de la gestión activa de deudas pendientes para garantizar la continuidad del recobro tras la baja | Cliente / entrevista / decisión del equipo |



## 3\. Requisitos de usuario

| ID | Actor | Requisito | Fuente |
| :---- | :---- | :---- | :---- |
| UR-01 | Usuario operativo / Administrador | Poder disponer de una pantalla de trabajo diaria útil que muestre alertas (reactivación de pausas, facturas vencidas, revisiones, límites de deuda) y tareas pendientes para resolverlas con pocos clics | Transcripción ampliada (Página 6) / Entrevista (Página 4) / Ampliación |
| UR-02 | Responsable interno | Poder recibir notificaciones relevantes de los clientes asignados y distinguir las ya leídas de las ya resueltas | Transcripción ampliada (Página 6) |
| UR-03 | Superadministrador | Poder configurar canales y preferencias de notificación (in-app, email, resumen diario) para evitar saturación | Transcripción ampliada (Página 6) |
| UR-04 | Administrador / Lector | Poder consultar un dashboard financiero y de eficiencia operativa con cifras reales (semanal, mensual, trimestral, anual) desglosables, consultar de forma global clientes/facturas sin abrir cada ficha individualmente, saber el estado de las facturas (pagadas, pendientes, vencidas, disputa) e informes filtrables y exportables a CSV y PDF | Transcripción ampliada (Página 6) / Transcripción / Entrevista / Ampliación |
| UR-05 | Usuario | Poder realizar búsquedas globales rápidas aplicando filtros (ubicación, sector, estado, fechas) y guardar vistas o filtros frecuentes | Transcripción ampliada (Página 6) / Transcripción |
| UR-06 | Usuario | Poder importar clientes desde CSV con previsualización, mapeo y control de duplicados (NIF) | Transcripción ampliada (Página 6) |
| UR-07 | Administrador | Poder importar histórico de facturas en modo migración sin disparar emails ni consumir numeración oficial | Transcripción ampliada (Página 6) |
| UR-08 | Superadministrador / Administrador | Poder gestionar altas, invitaciones, asignación de permisos y desactivaciones de usuarios internos manteniendo el histórico de auditoría | Transcripción ampliada (Página 6) / Entrevista |
| UR-09 | Usuario | Poder recuperar la contraseña mediante un enlace temporal con caducidad | Transcripción ampliada (Página 6) |
| UR-10 | Usuario operativo / Lector | Trabajar exclusivamente sobre los clientes asignados, delimitando el acceso a la información según rol y con permisos operativos limitados sin acceso a la configuración global | Transcripción ampliada (Página 7) / Transcripción |
| UR-11 | Administrador | Asignar, desasignar, reasignar y delegar temporalmente clientes a usuarios, heredando el nuevo responsable las tareas pendientes y manteniendo el histórico | Transcripción ampliada (Página 7) / Ampliación |
| UR-12 | Administrador | Delegar temporalmente los clientes de un usuario (por vacaciones) sin necesidad de compartir contraseñas | Transcripción ampliada (Página 7) |
| UR-13 | Usuario | Que el sistema detecte conflictos de edición concurrente para evitar sobrescribir cambios de otros usuarios | Transcripción ampliada (Página 7) |
| UR-14 | Superadministrador | Consultar y filtrar los registros de auditoría de negocio para saber quién hizo qué, cuándo y por qué, sin poder alterar el pasado | Transcripción ampliada (Página 7) / Ampliación |
| UR-15 | Responsable del sistema | Disponer de copias de seguridad automáticas y un mecanismo de restauración probado y demostrable | Transcripción ampliada (Página 7) |
| UR-16 | Usuario autenticado / Lector | Descargar únicamente los documentos e información autorizados, conservar la información redactada ante interrupciones accidentales mediante borradores automáticos, poder deshacer modificaciones no irreversibles, comprender el riesgo de una acción antes de confirmarla y recibir mensajes de error comprensibles | Transcripción ampliada (Página 7) / Ampliación |
| UR-17 | Personal administrativo | Poder redactar, programar a fechas futuras y enviar facturas (puntuales o recurrentes) y recordatorios previos por correo electrónico utilizando plantillas que completen automáticamente variables clave (nombre de empresa, número de factura, importe y vencimiento) | Notas de requisitos / Entrevista / Primera sesión |
| UR-18 | Personal administrativo / Empleado | Poder consultar de forma clara los estados de las facturas (pago e impago), el NIF del cliente, las fechas de vencimiento, el historial de versiones de los registros y las propuestas de modificación que requieran revisión | Notas de requisitos / Entrevista |
| UR-19 | Empleado / Administrador | Poder asociar clientes específicos a empleados, gestionar contactos, utilizar herramientas de búsqueda de direcciones y abrir/resolver incidencias y excepciones técnicas de los procesos de cobro | Notas de requisitos / Transcripción ampliada / Entrevista |
| UR-20 | Usuario del sistema | Poder consultar informes detallados de la aplicación (incluyendo facturas que fallaron en meses anteriores) así como resúmenes semanales y mensuales | Notas de requisitos |
| UR-21 | Administrador / Usuario | Poder utilizar la aplicación desde diferentes dispositivos (ordenador, tablet y móvil), en idioma español o inglés, adaptada a la zona horaria de España e integrada con la aplicación Zoom | Notas de requisitos |
| UR-22 | Lector / Personal administrativo | Poder distinguir entre una factura que existe pero no se pudo enviar y una factura que no se pudo crear, hacer seguimiento de cobros, enviar recordatorios y pausar envíos marcando facturas "en disputa" | Cliente / entrevista / Entrevista (Página 4-5) |
| UR-23 | Lector | Poder preparar un presupuesto para un cliente, enviarlo y registrar si lo acepta o lo rechaza, para convertirlo en factura sin volver a introducir los datos (opcional) | Cliente / entrevista |
| UR-24 | Administrador | Poder corregir un error de una factura ya emitida mediante factura rectificativa sin alterar la original, o dar de baja contable una deuda clasificándola como "anulada" o "incobrable" tras aprobación | Cliente / entrevista / Entrevista (Página 4-5) |
| UR-25 | Lector / Personal administrativo | Poder conocer el saldo, las facturas pendientes y pagadas (limitado a asignados) y revisar en una bandeja de trabajo los movimientos de pasarela o banco no conciliados automáticamente | Cliente / entrevista / Entrevista (Página 4-5) |
| UR-26 | Administrador | Poder revisar cada año si un cliente sigue en el plan que le corresponde, recibir avisos de revisión de rangos propuestos y decidir el cambio de precio sin alterar las facturas pasadas | Cliente / entrevista / Entrevista |
| UR-27 | Administrador | Poder conocer el estado del sistema (emails pendientes, errores de integración, último backup, última generación recurrente) mediante pantalla de monitoreo | Cliente / entrevista / Ampliación |
| UR-28 | Administrador / Personal administrativo | Poder consultar el historial completo de cada cliente, las condiciones comerciales y la lista de clientes con fecha de inicio futura pendientes de activación | Cliente / entrevista / Entrevista |
| UR-29 | Sistema externo / Brain | Poder consultar datos de clientes, estado de deuda (incluso inactivos o dados de baja) y facturas, y enviar solicitudes (como la de baja de un cliente), de forma que el sistema aplique siempre sus reglas de negocio | Cliente / entrevista / Transcripción / Transcripción ampliada |
| UR-30 | Administrador | Poder identificar y localizar la causa de un error del sistema a partir de un código de incidencia | Cliente / entrevista |
| UR-31 | Lector / Administrador | Poder ver un mensaje comprensible ante un error, sin información técnica interna del sistema | Cliente / entrevista |
| UR-32 | Lector / Administrador | Poder dar de alta/reingresar clientes registrando su información fiscal y operativa internacional (país, NIF/VAT, dirección, moneda), tipo de cobro (suscripción/puntual) y consultar duplicados por NIF para reactivar expedientes, identificando datos faltantes antes de facturar | Cliente / entrevista / Transcripción / Entrevista (Página 4-5) |
| UR-33 | Superadministrador | Poder configurar los datos fiscales del emisor, así como la serie y numeración oficial de las facturas | Cliente / entrevista / Entrevista |
| UR-34 | Administrador | Poder elegir, si Turbine factura desde varias sociedades, con cuál se emite cada factura (opcional) | Cliente / entrevista |
| UR-35 | Lector | Poder adjuntar a un cliente o a una factura los documentos que lo justifican (pedido, presupuesto aceptado, justificante) de forma segura | Cliente / entrevista |
| UR-36 | Lector | Poder acceder rápidamente a los clientes con los que trabaja con más frecuencia | Cliente / entrevista |
| UR-37 | Lector / Administrador | Comentar internamente en clientes, facturas e incidencias, con notas restringidas cuando proceda | Ampliación |
| UR-38 | Administrador | Programar informes periódicos y fijar objetivos mensuales/anuales de facturación y cobro | Ampliación |
| UR-39 | Superadministrador | Configurar el sistema de plazos, vencimientos, cadencia y recurrencia de notificaciones, recordatorios y calendario laboral | Ampliación / Transcripción / Transcripción ampliada |
| UR-40 | Superadministrador | Configurar el sistema de monedas, impuestos aplicables, tarifas y rangos/precios de planes globales | Ampliación / Entrevista |
| UR-41 | Superadministrador | Desplegar sistema de pruebas automáticas y entornos reproducibles | Ampliación |
| UR-42 | Administrador / Superadministrador | Poder localizar qué datos personales se tienen de un contacto y anonimizarlos cuando legalmente proceda, sin invalidar el histórico contable | Ampliación |
| UR-43 | Administrador | Consultar tipos de cambio y reglas de conversión de divisa aplicados a la consolidación de informes | Ampliación |
| UR-44 | Lector / Administrador | Consultar la trazabilidad y el estado detallado de entrega de cada mensaje individual enviado, gestionando incidencias para corregir datos y reintentar envíos sin duplicar | Ampliación / Entrevista (Página 4-5) |
| UR-45 | Administrador / Superadministrador | Disponer de una bandeja para revisar propuestas de facturas o solicitudes económicas (aprobadas, rechazadas, pendientes), con comentarios explicativos e impidiendo la autoaprobación | Ampliación / Entrevista |
| UR-46 | Administrador / Superadministrador | Ejecutar el cierre formal de un periodo contable (mes/trimestre) impidiendo modificaciones por error, y permitir su reapertura al superadministrador mediante motivo registrado obligatorio | Ampliación |
| UR-47 | Gestoría / Administrador | Generar y descargar en un solo archivo (ZIP/CSV) toda la información y PDF contables del periodo, consultando fecha/autoría de generación y diferenciando versiones iniciales o regeneraciones | Ampliación |
| UR-48 | Persona de contacto / Administrador | Registrar idioma y canal preferidos de notificación del cliente, y gestionar permisos de envío de forma independiente por canal según normativa de datos | Ampliación |
| UR-49 | Superadministrador | Consultar en auditoría qué usuario realizó exportaciones masivas de datos e incluir metadatos de autoría y fecha en cualquier fichero descargado para evitar fugas | Ampliación |
| UR-50 | Lector / Administrador | Recibir notificaciones/alertas cuando una factura supere el límite tolerable de días vencida, la deuda supere el límite económico, fallen envíos repetidamente o haya revisiones pendientes por más de una semana | Ampliación |
| UR-51 | Superadministrador | Establecer un tiempo de retención de almacenamiento temporal para la conservación e informes del sistema | Transcripción ampliada |
| UR-52 | Personal administrativo | Poder pausar temporalmente una suscripción indicando motivo y fechas para congelar la generación de mensualidades sin afectar a facturas impagadas | Entrevista (Página 4) |
| UR-53 | Personal administrativo | Poder registrar la baja de un cliente deteniendo cobros futuros pero manteniendo el flujo de recobro sobre las deudas no saldadas | Entrevista (Página 4-5) |
| UR-54 | Personal administrativo | Poder previsualizar la factura, revisar su cálculo prorrateado, borrar borradores no emitidos y disponer de bloqueos automáticos en caso de faltar datos fiscales antes de la emisión | Entrevista (Página 4-5) |
| UR-55 | Superadministrador / Administrador | Configurar umbrales de facturación para aprobaciones extraordinarias y autorizar o rechazar facturas o rectificativas que superen dicho umbral | Entrevista |

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
| FR-08 | El sistema debe ofrecer una pantalla de trabajo diario que muestre vencimientos, pagos pendientes de conciliación, problemas de entrega, aprobaciones pendientes, reactivación de pausas y revisiones | UR-01 |
| FR-09 | El sistema debe permitir al usuario saltar directamente desde la pantalla de trabajo diario al elemento afectado para resolverlo en pocos clics | UR-01 |
| FR-10 | El sistema debe ofrecer a los administradores un dashboard financiero y de eficiencia operativa con métricas semanales, mensuales y anuales (facturación, cobros, pendientes, vencidos, tiempo medio de cobro e ingresos recurrentes) | UR-04, UR-25 |
| FR-11 | Los informes financieros y operativos deben poder filtrarse por periodo, cliente, responsable, país, ubicación, sector, estado y tipo de factura | UR-04, UR-05 |
| FR-12 | El sistema debe permitir exportar los resultados de informes a formato CSV y PDF | UR-04 |
| FR-13 | Las exportaciones deben respetar rigurosamente los permisos de acceso del usuario | UR-04, UR-10 |
| FR-14 | El sistema debe proporcionar una búsqueda global por nombre comercial, razón social, NIF/CIF/VAT, persona de contacto, número de factura y correo | UR-05 |
| FR-15 | El sistema debe permitir guardar filtros y vistas frecuentes de trabajo | UR-05 |
| FR-16 | El sistema debe permitir importar clientes y contactos desde ficheros CSV con previsualización, mapeo de columnas y control de errores | UR-06 |
| FR-17 | El sistema debe alertar si detecta NIFs/CIFs duplicados durante la importación | UR-06 |
| FR-18 | La importación completa debe registrarse como operación con resumen de registros creados, actualizados y rechazados | UR-06 |
| FR-19 | El sistema debe permitir la importación administrativa de histórico de facturas, separada de la emisión ordinaria | UR-07 |
| FR-20 | Las facturas históricas importadas no deben disparar emails ni consumir numeración oficial, quedando marcadas como migradas | UR-07 |
| FR-21 | El acceso de usuarios internos debe realizarse mediante correo electrónico del dominio corporativo autorizado y contraseña | UR-08 |
| FR-22 | El sistema debe prohibir estrictamente el autorregistro de usuarios | UR-08 |
| FR-23 | El superadministrador o administrador con permisos debe poder crear o invitar usuarios internos | UR-08 |
| FR-24 | El sistema debe permitir desactivar cuentas de usuarios que abandonen la empresa preservando el rastro de sus acciones e invalidando su sesión | UR-08 |
| FR-25 | El sistema debe permitir la recuperación de contraseñas mediante enlaces temporales con caducidad | UR-09 |
| FR-26 | El sistema debe distinguir roles de superadministrador, administrador y usuario operativo / lector | UR-10 |
| FR-27 | El sistema debe implementar un modelo centralizado y coherente de autorización de permisos | UR-10 |
| FR-28 | El usuario operativo debe poder gestionar información operativa, crear facturas autorizadas y seguir cobros de sus clientes asignados | UR-10 |
| FR-29 | El usuario operativo / lector no debe poder autoasignarse clientes, modificar tarifas globales, crear series ni ver el dashboard financiero global | UR-10 |
| FR-30 | El administrador debe poder asignar, desasignar y reasignar clientes a los usuarios con aprobación o suplentes, heredando tareas pendientes e historial | UR-11 |
| FR-31 | El administrador debe poder delegar temporalmente los clientes de un usuario a un suplente durante un intervalo con caducidad automática | UR-12 |
| FR-32 | El sistema debe autoguardar borradores periódicos durante la redacción de facturas y detectar conflictos de edición concurrente | UR-13, UR-16, UR-54 |
| FR-33 | Las operaciones monetarias críticas, numeración y conciliación deben mantener consistencia ante accesos concurrentes | UR-13 |
| FR-34 | El sistema debe registrar un log de auditoría de negocio detallado para operaciones clave (creación de clientes, cambios fiscales, emisión, descuentos, reasignaciones, disputas, conciliaciones) sin que sea editable por usuarios normales | UR-14 |
| FR-35 | El superadministrador debe poder consultar y filtrar la auditoría sin poder reescribirla | UR-14 |
| FR-36 | El sistema debe realizar copias de seguridad automáticas de datos y documentos con política definida y permitir su restauración comprobada | UR-15 |
| FR-37 | Las facturas, datos fiscales y contactos no deben ser accesibles mediante URLs públicas adivinables y se debe verificar permisos en cada acceso directo | UR-08, UR-16 |
| FR-38 | Un usuario autenticado solo debe poder descargar documentos autorizados mediante enlaces temporales | UR-16 |
| FR-39 | El sistema debe permitir la creación, almacenamiento y envío de facturas en PDF por correo electrónico o WhatsApp (con consentimiento) utilizando plantillas configurables con variables dinámicas | UR-17, UR-22, UR-48 |
| FR-40 | El sistema debe permitir programar a fecha futura y enviar recordatorios previos y avisos de impago ajustando la cadencia y recurrencia | UR-17, UR-39 |
| FR-41 | El sistema debe registrar y mostrar las transiciones de estado de cobro de las facturas (pendiente, vencida, pagada, parcialmente conciliada o disputada), asociadas al NIF, tipo de cobro y fecha de vencimiento | UR-18, UR-22, UR-32 |
| FR-42 | El sistema debe mantener un historial de versiones para los registros, contactos y documentos modificados | UR-18, UR-19 |
| FR-43 | El sistema debe permitir la apertura, seguimiento y gestión de incidencias e interrupciones en procesos de cobro asociadas a clientes | UR-19, UR-44 |
| FR-44 | El sistema debe incluir una funcionalidad integrada de búsqueda de direcciones | UR-19 |
| FR-45 | El sistema debe permitir la integración con Zoom (ampliación de pantalla) | UR-21 |
| FR-46 | El sistema debe generar informes específicos de la aplicación con detalle de facturas que fallaron en meses anteriores, así como resúmenes periódicos semanales y mensuales | UR-20 |
| FR-47 | El sistema deberá permitir la creación, gestión, envío y conversión de presupuestos aceptados a factura reutilizando líneas (opcional) | UR-23 |
| FR-48 | El sistema no deberá permitir la modificación directa de facturas emitidas; toda corrección requiere una factura rectificativa vinculada que recalcule el saldo | UR-24 |
| FR-49 | Si el importe de una rectificativa o factura excepcional supera los umbrales configurados, esta deberá ser aprobada por un perfil autorizado antes de emitirse | UR-24, UR-55 |
| FR-50 | El sistema deberá gestionar la campaña anual de revisión de facturación de clientes, calculando la propuesta de rango según la facturación verificada y aplicando nuevos precios tras validación humana sin alterar facturas pasadas | UR-26 |
| FR-51 | En caso de correcciones en revisiones anuales, se calculará el impacto potencial exigiendo aprobación administrativa para cualquier regularización retroactiva | UR-26 |
| FR-52 | El sistema deberá ofrecer una pantalla de monitoreo con la cola de emails pendientes, errores de integración, último backup y estado de ejecuciones recurrentes | UR-27 |
| FR-53 | El sistema deberá mostrar el historial completo de la relación comercial de cada cliente (alta, condiciones, responsables, tarifas, facturas, cobros, incidencias, pausas, bajas y reactivaciones) | UR-28 |
| FR-54 | El sistema deberá cerrar sesión automáticamente tras 30 minutos de inactividad | UR-08 |
| FR-55 | El sistema deberá exponer una API rate-limited para consulta externa por identificador de cliente (deuda, estado y solicitudes controladas) aislando clientes con errores sin detener el flujo general | UR-29 |
| FR-56 | El sistema deberá registrar los errores en logs técnicos asociándolos a un código de incidencia, mostrando al usuario únicamente un mensaje comprensible sin información técnica | UR-30, UR-31 |
| FR-57 | Al dar de alta o reingresar un cliente, el sistema registrará los campos fiscales y operativos internacionales (país, NIF/CIF/VAT, moneda, dirección), validará email e identificador fiscal y buscará coincidencias para permitir reactivar expedientes históricos | UR-32 |
| FR-58 | El sistema deberá bloquear la emisión de facturas si falta un dato fiscal imprescindible e impedir eliminar o inactivar el único contacto de facturación de un cliente activo | UR-32 |
| FR-59 | El sistema deberá permitir gestionar los datos fiscales de una o varias entidades emisoras con sus correspondientes series de numeración oficiales (opcional) | UR-33, UR-34 |
| FR-60 | El sistema deberá permitir adjuntar documentos a clientes y facturas limitando los formatos a listas seguras (PDF, JPG/PNG, DOCX, XLSX, CSV hasta 10 MB) y rechazando ejecutables | UR-35 |
| FR-61 | El sistema deberá permitir marcar clientes como favoritos, mostrar los consultados recientemente y listar los pendientes de activación con fecha futura | UR-28, UR-36 |
| FR-62 | Disponibilidad de una bandeja de solicitudes y excepciones económicas (descuentos, cambios de precio) con comentarios del aprobador e impedimento estricto de autoaprobación para el solicitante | UR-45, UR-55 |
| FR-63 | Permitir el cierre administrativo de periodos contables (mes/trimestre) bloqueando modificaciones, con opción de reopening reservada al superadministrador previa justificación obligatoria | UR-46 |
| FR-64 | Recopilación y empaquetado automático en ZIP/CSV de la documentación contable del periodo para la gestoría, registrando trazabilidad y control de versiones | UR-47 |
| FR-65 | Almacenamiento del idioma, canal preferido y gestión de consentimiento explícito individual para notificaciones de cada contacto | UR-48 |
| FR-66 | Registro automático en auditoría de exportaciones masivas e incrustación de metadatos de trazabilidad en los archivos descargados | UR-49 |
| FR-67 | Emisión configurable de alertas operativas por facturas excesivamente vencidas, exceso de saldo de deuda, fallos repetidos de envío o revisiones/incidencias estancadas | UR-50 |
| FR-68 | Clasificación opcional de facturas por proyecto o línea de negocio manteniendo el histórico tras renombrados, con administración de un catálogo ligero de conceptos reutilizables | UR-20 |
| FR-69 | Control de objetivos mensual/anual de facturación y cobro con histórico de cambios | UR-38 |
| FR-70 | Desplazamiento automático de comunicaciones programadas en fin de semana o festivo al siguiente día laborable según calendario laboral | UR-39 |
| FR-71 | Gestión de facturas en moneda específica, conservando el importe original y registrando el tipo de cambio para la moneda base de informes | UR-40, UR-43 |
| FR-72 | Ejecución de tareas pesadas en segundo plano con seguimiento de estado independiente del cierre de pestaña | UR-27 |
| FR-73 | Prevención de duplicados por reintento o doble clic en emisión, envío y conciliación, asignando número correlativo definitivo únicamente al emitir | UR-16, UR-29 |
| FR-74 | Visualización del estado detallado de cada mensaje (en cola, enviado, entregado, fallido, reintentado) | UR-44 |
| FR-75 | Diferenciación estricta entre comunicaciones operativas de facturación y campañas comerciales, prohibiendo la reutilización de datos para marketing | UR-48 |
| FR-76 | Soporte para notas internas con nivel de visibilidad restringido exclusivamente a administradores | UR-37 |
| FR-77 | Carga opcional de datos de prueba para demos sin interferencia con producción | UR-41 |
| FR-78 | El sistema generará automáticamente las facturas de suscripciones recurrentes el primer día de cada mes calculando el prorrateo proporcional en altas del mes en curso, o aplicando la excepción explícita de aplazamiento | UR-02, UR-39, UR-54 |
| FR-79 | El sistema deberá permitir deshacer acciones reversibles y requerir confirmación explícita con aviso de irreversibilidad antes de ejecutar borrados o envíos a Hacienda | UR-16 |
| FR-80 | Registrar solicitudes de baja comprobando deudas: detendrá la generación de facturas recurrentes futuras pero mantendrá activo el flujo de recobro sobre deudas pendientes | UR-29, UR-53 |
| FR-81 | El sistema deberá eliminar del servidor los archivos exportados temporalmente una vez expirado el tiempo de retención configurado por el Superadministrador | UR-51 |
| FR-82 | El sistema recopilará de forma anónima métricas de rendimiento (tiempo invertido, errores devueltos y conteo de clics) | UR-16 |
| FR-83 | El cálculo financiero se ejecutará mediante programación determinista tradicional sin usar IA, con opción de desactivar las funciones de apoyo basadas en IA (opcional) | UR-21 |
| FR-84 | Permitir pausar temporalmente una suscripción indicando motivo y fechas, congelando la generación de mensualidades sin afectar a facturas impagadas, y notificando la reactivación al alcanzar la fecha | UR-01, UR-52 |
| FR-85 | Permitir marcar una factura como "en disputa" con motivo y fecha de revisión para suspender temporalmente el envío de recordatorios automáticos | UR-22 |
| FR-86 | Simular la recepción de eventos de pasarela/banco (Stripe), vinculando cobros automáticamente por coincidencia clara o derivando a bandeja de revisión manual con traza histórica si se deshace | UR-25 |
| FR-87 | Dar de baja contable una deuda clasificándola como "anulada" o "incobrable" tras la correspondiente aprobación administrativa | UR-24 |




### 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
| :---- | :---- | :---- | :---- |
| NFR-01 | Independencia / Disponibilidad | El sistema deberá operar como herramienta independiente respecto al producto principal (Brain), asegurando que los flujos administrativos y operativos puedan completarse sin depender de su interfaz o disponibilidad | Operatividad administrativa garantizada ante caídas o indisponibilidad de Brain |
| NFR-02 | Seguridad / Autenticación | Las contraseñas se almacenarán mediante hashing seguro (bcrypt/argon2) y la arquitectura estará preparada para la incorporación futura de doble factor de autenticación (2FA) | Almacenamiento no expuesto en texto plano y extensible a 2FA |
| NFR-03 | Seguridad / Cifrado | Uso obligatorio de protocolo HTTPS/TLS en todo el tráfico web para garantizar comunicaciones cifradas | Cifrado punto a punto en toda la aplicación web |
| NFR-04 | Seguridad / Secretos | Los secretos y credenciales del entorno o de servicios simulados (Stripe) no se almacenarán en el repositorio de código | Carga exclusiva desde variables de entorno externas |
| NFR-05 | Mantenibilidad / Arquitectura | Los permisos, políticas de autorización y reglas de negocio/facturación estarán centralizados de forma modular (constantes o servicios), evitando condicionales dispersos y facilitando la mantenibilidad mediante migraciones y tests | Modelo coherente de control de acceso y variaciones parametrizables sin reescritura de código |
| NFR-06 | Seguridad / Permisos y Acceso | El sistema restringirá el acceso a la información y descargas de adjuntos (límite 10 MB, sin ejecutables) según el rol asignado (p. ej., un usuario con rol Lector solo operará en sus clientes explícitamente asignados) | Aislamiento estricto de datos y documentos con rechazo de acceso no autorizado o archivos ejecutables |
| NFR-07 | Fiabilidad / Copias de Seguridad | Los sistemas de backup deben estar diseñados, probados y demostrados mediante procedimientos documentados de restauración periódica | Mecanismo verificado de almacenamiento, recuperación y procedimiento de prueba funcional |
| NFR-08 | Privacidad / Cumplimiento / RGPD | Anonimización de datos personales según normativa sin destruir la trazabilidad de auditoría o los ID históricos, aplicando minimización de datos, respetando plazos legales de conservación y prohibiendo el uso de datos reales en repositorios o demos | Cumplimiento RGPD en entornos de desarrollo y producción preservando la integridad de logs y registros fiscales |
| NFR-09 | Rendimiento / Eficiencia | Las búsquedas, filtrados y consultas del catálogo de clientes devolverán respuesta en menos de 3 segundos; la selección e inserción de conceptos frecuentes se realizará en menos de 3 clics y la generación masiva de facturas se ejecutará en segundo plano con progreso visible | Tiempos de respuesta reducidos, fluidez en UI y superación de tests de estrés sin bloqueo de interfaz |
| NFR-10 | Escalabilidad | El sistema debe soportar el crecimiento operativo hasta centenares de usuarios internos y 2.500 clientes simultáneos sin degradar la latencia por encima de 5 segundos, permitiendo consultar el estado global sin abrir ficha por ficha | Arquitectura modular con capacidad de visualización macro de la cartera |
| NFR-11 | Fiabilidad / Integridad / Idempotencia | Procesamiento de tareas automáticas con aislamiento de registros corruptos en colas de excepciones; reintentos de notificaciones sin duplicidad de documentos o cobros; UI con claves de idempotencia (bloqueo tras primer clic) y cálculos numéricos deterministas con precisión decimal exacta (sin IA) | Tolerancia a fallos de red, prevención de doble cobro y cuadre financiero exacto con los PDF emitidos |
| NFR-12 | Internacionalización | Soporte completo multilingüe (español e inglés) para la interfaz y las comunicaciones del sistema, permitiendo cambiar el idioma dinámicamente | Visualización y envío de documentos adaptados al idioma seleccionado por el usuario o contacto |
| NFR-13 | Internacionalización / Cobertura Fiscal | Registro y soporte operativo para empresas internacionales sin imponer formatos exclusivos de España (NIF/CIF/VAT internacional) | Alta y facturación fluida de clientes con estructuras fiscales de cualquier país |
| NFR-14 | Configuración Regional | Operación, registro de marcas de tiempo y cálculo de vencimientos ajustados estrictamente a la zona horaria oficial de España | Auditoría y registros temporales unificados bajo la hora oficial de España |
| NFR-15 | Portabilidad / Usabilidad / Consistencia | Aplicación totalmente responsiva adaptable a escritorio, tabletas y teléfonos móviles, con una ubicación estandarizada e idéntica para los botones principales de guardado y navegación | Operatividad móvil completa y consistencia de UI en cualquier dispositivo |
| NFR-16 | Usabilidad / Eficiencia y Aprendizaje | Proceso optimizado que permita que al menos el 90% de usuarios sin experiencia completen un alta al primer intento y que la creación/emisión de una factura puntual o alta estándar requiera menos de 5 clics | Mínima carga cognitiva e interacciones optimizadas |
| NFR-17 | Compatibilidad | Funcionamiento garantizado en las versiones actuales de navegadores web de escritorio y móvil (Chrome, Firefox, Edge, Safari, Android e iOS) | Compatibilidad multiplataforma en navegadores modernos |
| NFR-18 | Interoperabilidad | Apertura estándar de archivos PDF y exportación de CSV preservando la codificación de caracteres (tildes y caracteres extranjeros) | Lectura transparente de PDF y CSV sin pérdida ni corrupción de caracteres |
| NFR-19 | Restricción Tecnológica | Uso exclusivo de herramientas, dependencias y bibliotecas principales bajo licencias de software libre | Garantía de independencia tecnológica mediante open-source |
| NFR-20 | Documentación | Disponibilidad de documentación corta de usuario, documentación técnica completa (despliegue, modelo de datos, API, restauración) y registro de decisiones de arquitectura | Entregables documentales operativos y técnicos para el equipo de mantenimiento |
| NFR-21 | Mantenibilidad / Testabilidad | Expresión de cada regla de negocio en tests unitarios/integración o escenarios legibles comprensibles por la administración | Cobertura de pruebas sobre las reglas operativas del negocio |
| NFR-22 | Mantenibilidad / Extensibilidad | La sustitución o modificación del proveedor de pagos (p. ej. Stripe simulado) no requerirá alterar las facturas ni datos almacenados previamente | Desacoplamiento entre la pasarela de pagos y el histórico de facturación |
| NFR-23 | Despliegue | Procedimiento de despliegue automatizado, reproducible y documentado para entorno de pruebas y producción desde cero | Puesta en marcha consistente mediante scripts y guías de infraestructura |
| NFR-24 | Integridad y Legalidad / Inmutabilidad | Trazabilidad completa de cambios económicos (quién, cuándo, valores anteriores y nuevos) y bloqueo técnico de facturas en PDF contra borrados o modificaciones directas en base de datos durante el plazo legal | Inmutabilidad garantizada e irreversibilidad legal de facturas emitidas |

## 5\. Reglas de negocio

| ID | Regla |
| :---- | :---- |
| RB-01 | Asignación de Numeración Oficial | Una factura en estado borrador no consume numeración oficial definitiva ni ID único, los cuales se asignan de forma concurrente, correlativa y única únicamente en el momento exacto de la emisión |
| RB-02 | Emisión Recurrente y Prorrateo | Las facturas recurrentes se emitirán automáticamente el día 1 de cada mes desde el inicio de la relación comercial, calculando el prorrateo de altas a mitad de mes dividiendo la cuota entre los días reales del mes y multiplicando por los días de servicio |
| RB-03 | Inmutabilidad Legal y Retención Contable | Los datos de empresas y facturas emitidas (incluyendo su representación en PDF) son inalterables y no se podrán modificar silenciosamente ni eliminar definitivamente hasta transcurrido el plazo legal exigido |
| RB-04 | Trazabilidad de Correcciones Legales | Una factura emitida no puede editarse ni borrarse; cualquier corrección requerirá trazabilidad explícita o la emisión de una factura rectificativa vinculada |
| RB-05 | Independencia de la Relación Comercial | La relación comercial (suscripciones, contratos, tarifas) es independiente del histórico de facturación; modificar un precio o regla futura nunca reescribirá ni afectará a las facturas pasadas |
| RB-06 | Independencia entre Presupuesto y Factura | Un presupuesto aceptado y la factura generada a partir de sus líneas conservan identidades, estados e históricos independientes |
| RB-07 | Control de Excepciones y Aprobaciones | Toda excepción comercial, descuento extraordinario o modificación manual requerirá la aprobación explícita de un usuario con rol Administrador o Superadministrador |
| RB-08 | Independencia de la Baja y Cobros Pendientes | La baja comercial de un cliente o la pausa de su suscripción detiene la generación de cuotas futuras recurrentes, pero mantiene activo e inalterado el flujo de cobro sobre las facturas emitidas impagadas |
| RB-09 | Protección de Cambios en Catálogo | Las modificaciones en las tarifas o impuestos por defecto de los conceptos del catálogo de productos no afectarán de forma retroactiva a las facturas ni suscripciones anteriormente emitidas |
| RB-10 | Gestión de Deudas Incobrables o Anuladas | Una deuda perdonada o dada de baja no podrá clasificarse ni contabilizarse como "pagada", debiendo pasar explícitamente al estado "anulada" o "incobrable" tras la aprobación correspondiente |
| RB-11 | Conciliación de Saldo vs Facturación | El saldo pendiente de pago de un cliente y su facturación total acumulada son métricas financieras independientes y reconciliables |
| RB-12 | Requisito de Validación para Cambio de Estado de Pago | Una factura no podrá considerarse saldada mientras el sistema refleje un impago, requiriendo validación manual o confirmación de cobro por pasarela/banco para pasar a estado pagado |
| RB-13 | Control de Acceso por Asignación de Cartera | El acceso a los datos, documentos y carteras de clientes estará estrictamente limitado al empleado responsable asignado, salvo para roles de administración global |
| RB-14 | Validación de Variables en Plantillas de Envío | Las plantillas de comunicación requerirán obligatoriamente la presencia de las variables dinámicas clave (empresa, número de factura, importe y vencimiento) antes de permitir su envío |



## 6\. Suposiciones y decisiones de análisis

| ID | Suposición o decisión | Justificación | Requisitos afectados |
| :---- | :---- | :---- | :---- |
| A-01 | El tamaño y formatos permitidos para archivos adjuntos están limitados (PDF, JPG/PNG, DOCX, XLSX, CSV hasta 10 MB) | Petición de control de seguridad, prevención de ejecutables y definición del límite "razonable" | FR-91, FR-92, NFR-21 |
| A-02 | La sesión expira tras 30 minutos de inactividad y se invalidan sesiones de usuarios desactivados | Necesidad de seguridad básica en equipos compartidos definiendo un tiempo de inactividad razonable | FR-73, FR-88 |
| A-03 | Se implementa bloqueo temporal de 15 minutos tras 5 intentos fallidos de login consecutivos | Protección contra ataques de fuerza bruta sin un bloqueo excesivo para el usuario | FR-87 |
| A-04 | La regularización retroactiva requiere acción explícita y aprobación administrativa | Evitar emisión automática de facturas retroactivas imprevistas definiendo el rol aprobador | FR-94, RB-04 |
| A-05 | La detección de duplicados de clientes se basa en coincidencias de NIF/CIF, razón social, email o teléfono | Prevención de duplicidades en importaciones y altas mediante criterios unificados | FR-19, FR-84 |
| A-06 | Se adopta integración simulada para Stripe, WhatsApp y correo electrónico | Cumplir objetivos funcionales sin dependencia de contratos con proveedores reales de pago o mensajería | FR-50, FR-51, NFR-22 |
| A-07 | La integración de Zoom se usará para poder acceder con mayor visión a gráficas, datos o informes (ampliación de pantalla) | Derivado de la nota explícita sobre la app Zoom | FR-53 |
| A-08 | La búsqueda de direcciones se resolverá mediante un componente de autocompletado estándar o servicio de mapas integrado | Derivado de la nota "búsqueda de dirección" | FR-52 |
| A-09 | El teléfono del contacto es el dato "conveniente" que puede faltar para guardar un cliente | Es el único ejemplo citado de dato no imprescindible para permitir guardado excepcional | FR-95 |
| A-10 | Los límites de uso del ritmo de solicitudes (rate limiting) de la API quedan pendientes de concretar | El cliente requirió límites "razonables" para proteger el servicio | FR-78 |
| A-11 | Los requisitos marcados como opcionales (presupuestos, varias entidades emisoras) constituyen ampliaciones | El cliente los presentó como funcionalidades secundarias fuera del núcleo del primer despliegue | FR-56, FR-57, FR-58, FR-89, FR-90 |




## 7\. Dudas, ambigüedades y cuestiones pendientes

| ID | Cuestión | Origen | Impacto | Estado / resolución |
| :---- | :---- | :---- | :---- | :---- |
| Q-01 | Criterio exacto de umbrales económicos para aprobación de descuentos por el superadministrador | Transcripción ampliada | Configuración de flujos de aprobación | Pendiente de definición parametrizable |
| Q-02 | Calendario de festivos y días laborables exacto para el cálculo de vencimientos en diferentes países | Transcripción ampliada | Automatización de recordatorios | Resuelta: configuración basada en calendario configurable de España para fase inicial |
| Q-03 | ¿Cómo debe actuar exactamente el sistema ante un fallo en el envío masivo de correos de facturas de meses anteriores? ¿Debe reintentar de forma autónoma o registrar una alerta crítica en el informe? | Notas de notas de la app / informe de fallos | Alto para la fiabilidad de envíos | Pendiente |
| Q-04 | ¿Qué permisos específicos tendrán los empleados suplentes sobre los clientes asignados a compañeros ausentes? | Decisiones de equipo | Medio para la gestión de incidencias | Pendiente |


## 8\. Trazabilidad

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
| :---- | :---- | :---- |
| BR-01 | UR-01, UR-04, UR-17, UR-22, UR-25, UR-27, UR-52, UR-54 | FR-08, FR-09, FR-10, FR-39, FR-40, FR-41, FR-47, FR-48, FR-68, FR-69, FR-78, FR-84, FR-85, NFR-09, NFR-11, NFR-14 |
| BR-02 | UR-10, UR-29, UR-53 | FR-28, FR-29, FR-31, FR-55, FR-57, FR-73, FR-75, FR-80, NFR-01, NFR-05, NFR-22 |
| BR-03 | UR-07, UR-14, UR-15, UR-24, UR-30, UR-33, UR-34, UR-42, UR-46, UR-47, UR-49, UR-55 | FR-19, FR-20, FR-34, FR-35, FR-36, FR-41, FR-42, FR-48, FR-49, FR-59, FR-60, FR-63, FR-64, FR-66, FR-79, FR-87, NFR-06, NFR-07, NFR-08, NFR-21, NFR-24 |
| BR-04 | UR-01, UR-02, UR-04, UR-18, UR-22, UR-25, UR-26, UR-28, UR-32, UR-35, UR-43, UR-50 | FR-01, FR-02, FR-03, FR-04, FR-05, FR-06, FR-07, FR-10, FR-11, FR-12, FR-13, FR-41, FR-50, FR-51, FR-52, FR-53, FR-57, FR-58, FR-61, FR-67, FR-71, FR-86, NFR-08, NFR-09, NFR-10, NFR-13 |
| BR-05 | UR-01, UR-03, UR-05, UR-06, UR-08, UR-09, UR-11, UR-12, UR-13, UR-16, UR-19, UR-20, UR-21, UR-23, UR-31, UR-36, UR-37, UR-38, UR-39, UR-40, UR-41, UR-44, UR-45, UR-48, UR-51 | FR-08, FR-09, FR-14, FR-15, FR-16, FR-17, FR-18, FR-21, FR-22, FR-23, FR-24, FR-25, FR-26, FR-27, FR-30, FR-32, FR-33, FR-37, FR-38, FR-43, FR-44, FR-45, FR-46, FR-54, FR-56, FR-62, FR-65, FR-70, FR-72, FR-74, FR-76, FR-77, FR-81, FR-82, FR-83, NFR-02, NFR-03, NFR-04, NFR-12, NFR-15, NFR-16, NFR-17, NFR-18, NFR-19, NFR-20, NFR-23 |
| BR-06 | UR-08, UR-10, UR-16, UR-42, UR-49 | FR-13, FR-24, FR-37, FR-38, FR-60, FR-66, NFR-02, NFR-06, NFR-08, NFR-20 |
| BR-07 | UR-48 | FR-75 |
| BR-08 | UR-29, UR-53 | FR-55, FR-80, RB-08 |

## 9\. Glosario

| Término | Definición |
| :---- | :---- |
| Factura emitida | Factura validada y emitida oficialmente con numeración única que no puede ser editada silenciosamente ni modificada |
| Factura rectificativa | Documento legal vinculado a una factura original para corregir errores o importes y ajustar el saldo del cliente |
| Borrador de factura | Estado previo a la emisión en el que la factura es editable o eliminable sin consumir numeración oficial |
| Presupuesto | Documento comercial previo a una factura que puede ser aceptado o rechazado y reutilizar sus líneas para generar la factura |
| Saldo | Importe pendiente de cobro de un cliente, considerando facturas emitidas, rectificativas y pagos registrados |
| Facturación | Importe total facturado a un cliente en un periodo determinado |
| Campaña de revisión | Proceso anual que lista los clientes cuya facturación anual y tarifas deben revisarse |
| Rango de plan | Tramo de facturación anual al que corresponde una tarifa específica configurada |
| Solicitud controlada | Petición externa vía API que requiere validación o aprobación antes de afectar a los datos del sistema |
| Entidad emisora | Sociedad jurídica desde la cual se emiten facturas, con sus respectivas series de numeración |
| Prorrateo | Cálculo proporcional de la cuota mensual cuando un servicio inicia en un día distinto al día 1 del mes |
| Conciliación | Proceso de asociar y verificar un movimiento o evento de cobro (Stripe, Revolut o banco) con su factura correspondiente, ya sea de forma automática, propuesta por el sistema o resuelta manualmente |
| NIF | Número de Identificación Fiscal utilizado para identificar unívocamente a los clientes y empresas |
| Plantilla de comunicación | Formato de correo predefinido que incluye campos dinámicos para automatizar la relación con el cliente |
| Incidencia | Registro o reporte de anomalía operativa, duda o problema técnico asociado a un cliente o factura |
| Estado de factura | Condición actual de la factura que determina si se encuentra en situación de pago o de impago |
| Imputación | Asignación o clasificación del importe de una factura puntual a un proyecto interno, centro de coste o línea de negocio específica para su posterior análisis en informes |
| Prospecto importado | Estado inicial o posible situación de la ficha de un cliente potencial traído al sistema mediante importación de datos antes de su activación formal |
| Dashboard | Panel de control visual dirigido a administradores que muestra métricas e indicadores financieros clave (facturado, cobrado, pendiente, vencido, previsión) con desglose al detalle |
| API | Interfaz de comunicación que permite a la aplicación interactuar de forma controlada y segura con sistemas externos (como Brain u otros agentes) para consultar datos y registrar solicitudes bajo reglas de negocio unificadas |
| Reporting | Proceso de consolidación y generación de informes financieros donde los importes en moneda extranjera se convierten a una moneda base utilizando un tipo de cambio registrado |
| Aprobador | Usuario (administrador o superadministrador) encargado de revisar, autorizar o rechazar solicitudes de operaciones económicas sensibles a través de una bandeja de entrada |
| Claves de idempotencia | Mecanismo técnico y de interfaz utilizado en operaciones críticas para evitar la duplicación de procesos ante reintentos o doble clic |
