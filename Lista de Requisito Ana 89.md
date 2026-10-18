# Requisitos

## 1. Contexto y alcance

### 1.1. Objetivo del sistema
Desarrollar una aplicación de gestión administrativa, facturación y control de cobros que permita centralizar y automatizar el flujo de trabajo de la organización. El sistema busca optimizar el envío de facturas por correo electrónico mediante plantillas personalizables, el seguimiento de vencimientos y estados de pago, la asignación de clientes a empleados, el registro de incidencias y la generación de informes y resúmenes periódicos.

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
|---|---|---|
| Personal administrativo | Personal encargado de generar facturas, enviar correos, gestionar plantillas y realizar seguimiento de cobros | Reducir la carga manual, asegurar el control de vencimientos y disponer de información actualizada de los estados de pago |
| Empleado / Gestor | Personal que interactúa con los clientes asignados, abre incidencias y consulta el estado de las cuentas | Acceder fácilmente a los clientes asignados, registrar incidencias y consultar datos de forma rápida desde dispositivos móviles o de escritorio |
| Administrador | Usuario con privilegios elevados sobre la configuración general del sistema, usuarios y permisos | Controlar la correcta asignación de carteras, revisar los informes periódicos y asegurar el funcionamiento del sistema |
| Cliente final | Empresa o destinatario que recibe las facturas, recordatorios y comunicaciones de pago | Recibir de forma puntual, clara y correcta sus facturas y comunicaciones asociadas |


## 2. Requisitos de negocio

| ID | Requisito | Fuente |
|---|---|---|
| BR-01 | Reducir drásticamente el trabajo manual asociado al envío de facturas, recordatorios previos y comunicaciones mediante el uso de plantillas estandarizadas | Notas de requisitos / sesión de análisis |
| BR-02 | Mejorar el control financiero y la trazabilidad de la cartera mediante el seguimiento riguroso de vencimientos, estados de pago/impago y control de NIF | Notas de requisitos / sesión de análisis |
| BR-03 | Potenciar la eficiencia operativa y la coordinación interna permitiendo la asignación de clientes a empleados, la gestión de incidencias y el acceso multiplataforma y multilingüe | Notas de requisitos / sesión de análisis |


## 3. Requisitos de usuario

| ID | Actor | Requisito | Fuente |
|---|---|---|---|
| UR-01 | Personal administrativo | Poder redactar y enviar facturas y recordatorios previos por correo electrónico utilizando plantillas que completen automáticamente variables clave (nombre de empresa, número de factura, importe y vencimiento) | Notas de requisitos |
| UR-02 | Personal administrativo / Empleado | Poder consultar de forma clara los estados de las facturas (pago e impago), el NIF del cliente, las fechas de vencimiento y el historial de versiones de los registros | Notas de requisitos |
| UR-03 | Empleado / Administrador | Poder asociar clientes específicos a empleados, utilizar herramientas de búsqueda de direcciones y abrir incidencias cuando sea necesario | Notas de requisitos |
| UR-04 | Usuario del sistema | Poder consultar informes detallados de la aplicación (incluyendo facturas que fallaron en meses anteriores) así como resúmenes semanales y mensuales | Notas de requisitos |
| UR-05 | Administrador / Usuario | Poder utilizar la aplicación desde diferentes dispositivos (ordenador, tablet y móvil), en idioma español o inglés, adaptada a la zona horaria de España e integrada con la aplicación Zoom | Notas de requisitos |


## 4. Requisitos del sistema

### 4.1. Requisitos funcionales

| ID | Requisito | Relacionado con |
|---|---|---|
| FR-01 | El sistema deberá permitir la creación, almacenamiento y envío de facturas por correo electrónico | UR-01 |
| FR-02 | El sistema deberá ofrecer plantillas de comunicación configurables que integren de forma dinámica las variables: nombre de empresa, número de factura, importe y fecha de vencimiento | UR-01 |
| FR-03 | El sistema deberá permitir programar y enviar recordatorios previos a los vencimientos de las facturas | UR-01 |
| FR-04 | El sistema deberá registrar y mostrar el estado de las facturas diferenciando entre pago e impago, asociadas al NIF y a la fecha de vencimiento correspondiente | UR-02 |
| FR-05 | El sistema deberá mantener un historial de versiones para los registros y documentos modificados | UR-02 |
| FR-06 | El sistema deberá permitir asignar clientes específicos a los empleados encargados de su gestión | UR-03 |
| FR-07 | El sistema deberá permitir la apertura, seguimiento y gestión de incidencias asociadas a los clientes | UR-03 |
| FR-08 | El sistema deberá incluir una funcionalidad integrada de búsqueda de direcciones | UR-03 |
| FR-09 | El sistema deberá permitir la integración con zoom (ampliaccion de pantalla)| UR-05 |
| FR-10 | El sistema deberá generar informes específicos de la aplicación (con detalle de facturas que fallaron en meses anteriores) y resúmenes periódicos semanales y mensuales | UR-04 |

### 4.2. Requisitos no funcionales

| ID | Categoría | Requisito | Criterio verificable |
|---|---|---|---|
| NFR-01 | Internacionalización | La interfaz y las comunicaciones del sistema deberán soportar los idiomas español e inglés | El usuario podrá cambiar el idioma en la interfaz y todos los textos del sistema se mostrarán correctamente en el idioma seleccionado |
| NFR-02 | Configuración Regional | El sistema deberá operar, registrar fechas y calcular vencimientos ajustados a la zona horaria oficial de España | Las marcas de tiempo y los registros de actividad reflejarán de manera precisa la hora oficial en España |
| NFR-03 | Portabilidad / Usabilidad | La aplicación deberá ser plenamente funcional y accesible desde ordenadores, tabletas y teléfonos móviles | Las interfaces se adaptarán correctamente a los diferentes tamaños de pantalla de escritorio, tablet y smartphone manteniendo la operabilidad completa |


## 5. Reglas de negocio

| ID | Regla |
|---|---|
| RB-01 | Una factura no podrá considerarse saldada si su estado reflejado en el sistema es de impago, requiriendo validación manual o de cobro para cambiar a estado de pago. |
| RB-02 | El acceso a los datos y carteras de los clientes estará restringido al empleado que los tenga asignados, salvo para los perfiles de administración. |
| RB-03 | Las plantillas de comunicación requerirán obligatoriamente la presencia de las variables de empresa, número de factura, importe y vencimiento antes de permitir su envío masivo o individual. |


## 6. Suposiciones y decisiones de análisis

| ID | Suposición o decisión | Justificación | Requisitos afectados |
|---|---|---|---|
| A-01 | La integración de zoom se usará para poder acceder con mayor vision a graficas, datos o informes| Derivado de la nota explícita sobre la app Zoom. | FR-09 |
| A-02 | La búsqueda de direcciones se resolverá mediante un componente de autocompletado estándar o servicio de mapas integrado. | Derivado de la nota "búsqueda de dirección". | FR-08 |


## 7. Dudas, ambigüedades y cuestiones pendientes

| ID | Cuestión | Origen | Impacto | Estado / resolución |
|---|---|---|---|---|
| Q-01 | ¿Cómo debe actuar exactamente el sistema ante un fallo en el envío masivo de correos de facturas de meses anteriores? ¿Debe reintentar de forma autónoma o registrar una alerta crítica en el informe? | Notas de notas de la app / informe de fallos | Alto para la fiabilidad de envíos | Pendiente |
| Q-02 | ¿Qué permisos específicos tendrán los empleados suplentes sobre los clientes asignados a compañeros ausentes? | Decisiones de equipo | Medio para la gestión de incidencias | Pendiente |


## 8. Trazabilidad

| Requisito de negocio | Requisito de usuario | Requisito funcional / no funcional |
|---|---|---|
| BR-01 | UR-01 | FR-01, FR-02, FR-03 |
| BR-02 | UR-02, UR-04 | FR-04, FR-05, FR-10, NFR-02 |
| BR-03 | UR-03, UR-05 | FR-06, FR-07, FR-08, FR-09, NFR-01, NFR-03 |


## 9. Glosario

| Término | Definición |
|---|---|
| NIF | Número de Identificación Fiscal utilizado para identificar unívocamente a los clientes y empresas. |
| Plantilla de comunicación | Formato de correo predefinido que incluye campos dinámicos para automatizar la relación con el cliente. |
| Incidencia | Registro o reporte de anomalía operativa, duda o problema técnico asociado a un cliente o factura. |
| Estado de factura | Condición actual de la factura que determina si se encuentra en situación de pago o de impago. |