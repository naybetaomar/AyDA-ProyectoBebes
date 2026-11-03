# Especificación de casos de uso — Aplicación de facturación y cobros de Turbine
## Introducción

Este documento recoge la especificación textual de los 58 casos de uso representados en los diagramas de casos de uso unificados. Cada caso de uso se corresponde con un objetivo completo de un actor; los pasos intermedios (validar, previsualizar, generar el PDF, registrar la auditoría…) forman parte de su flujo y no son casos de uso aparte.

**Trazabilidad.** Bajo el título de cada caso de uso figuran los requisitos de usuario (UR) y funcionales (FR) que cubre, tal como se definen en `Especificacion Requisitos.md`. Las reglas de negocio (RB), los supuestos (A) y las preguntas abiertas (Q) de ese documento se citan donde intervienen.

**Actores.** Lector, Administrador y Superadministrador son jerárquicos (A-19): el Administrador puede hacer todo lo que hace el Lector, y el Superadministrador todo lo que hace el Administrador, salvo aprobar sus propias solicitudes sensibles. Además intervienen el Sistema externo, que consume la API; la Pasarela de pagos, un servicio de cobros simulado con Stripe; y el Planificador, que dispara los procesos sin intervención humana: generación mensual, recordatorios, campaña anual, caducidad de delegaciones, copias de seguridad y alertas. Salvo CU-48 (Acceder al sistema), los casos de uso iniciados por el Planificador (CU-29) o por la Pasarela de pagos (CU-34) y los de la API externa (CU-57, CU-58), todos requieren que el usuario haya iniciado sesión, lo que se recoge como primera precondición de cada uno. Los actores son los definidos en la sección 1.3 de `Especificacion Requisitos.md`.

**Requisitos transversales sin caso de uso propio.** UR-52 (dispositivos, idioma y zona horaria; NFR-17 y FR-49); UR-97 (deshacer modificaciones accidentales; flujo alternativo en CU-01, CU-10, CU-16 y en la conciliación, CU-35); UR-102 (recuperación tras una caída; flujo de excepción de CU-17, con apoyo de NFR-15); UR-45 y UR-70 (edición concurrente y duplicados por doble clic; flujos de excepción en CU-01 y CU-15); y UR-110 (cálculo determinista sin IA: FR-97 es una regla que ningún caso de uso puede incumplir, y la desactivación opcional está en CU-54).

## Índice de casos de uso

| CU | Nombre | Actor principal | UR | FR |
|---|---|---|---|---|
| [CU-01](#cu-01--registrar-cliente) | Registrar cliente | Lector | 01, 45, 64, 97, 105, 108 | 01, 42, 48, 64, 70, 92, 106 |
| [CU-02](#cu-02--consultar-cliente-e-historial) | Consultar cliente e historial | Lector | 02, 59, 68 | 01, 57, 71 |
| [CU-03](#cu-03--gestionar-contactos-y-preferencias-de-comunicación) | Gestionar contactos y preferencias de comunicación | Lector | 03, 87, 88, 89 | 02, 78 |
| [CU-04](#cu-04--adjuntar-documentos-a-cliente-o-factura) | Adjuntar documentos a cliente o factura | Lector | 67 | 67 |
| [CU-05](#cu-05--importar-clientes-desde-csv) | Importar clientes desde CSV | Lector | 38 | 34 |
| [CU-06](#cu-06--importar-histórico-de-facturas) | Importar histórico de facturas | Administrador | 39 | 35 |
| [CU-07](#cu-07--ejecutar-acción-masiva-sobre-clientes) | Ejecutar acción masiva sobre clientes | Lector | 106 | 107 |
| [CU-08](#cu-08--etiquetar-clientes-y-clasificar-facturas-opcional) | Etiquetar clientes y clasificar facturas (opcional) | Lector | 107 | 81, 108 |
| [CU-09](#cu-09--gestionar-privacidad-de-datos-personales) | Gestionar privacidad de datos personales | Administrador | 75, 109 | 89, 99 |
| [CU-10](#cu-10--gestionar-relación-comercial) | Gestionar relación comercial | Lector | 04, 19, 97 | 03, 07, 92 |
| [CU-11](#cu-11--pausar-y-reactivar-suscripción) | Pausar y reactivar suscripción | Lector | 20, 21 | 15 |
| [CU-12](#cu-12--dar-de-baja-a-un-cliente) | Dar de baja a un cliente | Lector | 22 | 16 |
| [CU-13](#cu-13--revisar-anualmente-el-plan-de-un-cliente) | Revisar anualmente el plan de un cliente | Administrador | 57 | 54, 55, 69 |
| [CU-14](#cu-14--configurar-tarifas-globales) | Configurar tarifas globales | Superadministrador | 10 | 10 |
| [CU-15](#cu-15--emitir-factura-puntual) | Emitir factura puntual | Lector | 05, 11, 17, 23, 24, 29, 53, 66, 70, 98 | 04, 17, 18, 19, 66, 68, 87, 93 |
| [CU-16](#cu-16--gestionar-borradores-de-factura) | Gestionar borradores de factura | Lector | 05, 08, 96, 97 | 14, 92 |
| [CU-17](#cu-17--configurar-facturación-recurrente) | Configurar facturación recurrente | Lector | 05, 06, 17, 102 | 05, 06, 100 |
| [CU-18](#cu-18--programar-emisión-futura) | Programar emisión futura | Lector | 09 | 08 |
| [CU-19](#cu-19--emitir-factura-rectificativa) | Emitir factura rectificativa | Administrador | 55 | 52 |
| [CU-20](#cu-20--gestionar-presupuestos-opcional) | Gestionar presupuestos (opcional) | Lector | 54 | 51 |
| [CU-21](#cu-21--configurar-serie-y-numeración) | Configurar serie y numeración | Superadministrador | 16 | 13 |
| [CU-22](#cu-22--proponer-excepción-o-factura-para-revisión) | Proponer excepción o factura para revisión | Lector | 12 | 11 |
| [CU-23](#cu-23--resolver-propuesta-o-autorizar-sobre-el-umbral) | Resolver propuesta o autorizar sobre el umbral | Administrador | 13, 15, 80 | 11, 74 |
| [CU-24](#cu-24--consultar-mis-solicitudes-económicas) | Consultar mis solicitudes económicas | Lector | 78, 79 | 73 |
| [CU-25](#cu-25--cerrar-un-periodo-contable) | Cerrar un periodo contable | Administrador | 81, 82 | 75 |
| [CU-26](#cu-26--reabrir-un-periodo-cerrado) | Reabrir un periodo cerrado | Superadministrador | 83 | 76 |
| [CU-27](#cu-27--enviar-factura-al-cliente) | Enviar factura al cliente | Lector | 30, 53 | 20, 68 |
| [CU-28](#cu-28--gestionar-fallo-de-envío-de-una-factura) | Gestionar fallo de envío de una factura | Lector | 25 | 21 |
| [CU-29](#cu-29--enviar-recordatorios-de-pago-automáticos) | Enviar recordatorios de pago automáticos | Planificador | 31, 49 | 22, 46 |
| [CU-30](#cu-30--configurar-recordatorios-y-plantillas) | Configurar recordatorios y plantillas | Superadministrador | 31, 49, 104 | 22, 46, 105 |
| [CU-31](#cu-31--marcar-factura-en-disputa) | Marcar factura en disputa | Administrador | 26 | 23 |
| [CU-32](#cu-32--consultar-estado-de-entrega-de-mensajes) | Consultar estado de entrega de mensajes | Lector | 77 | 88 |
| [CU-33](#cu-33--consultar-estado-de-cobro-y-saldo) | Consultar estado de cobro y saldo | Lector | 07, 18, 56 | 09, 47, 53 |
| [CU-34](#cu-34--registrar-cobro-notificado-por-la-pasarela) | Registrar cobro notificado por la pasarela | Pasarela de pagos | 32 | 25 |
| [CU-35](#cu-35--conciliar-cobros) | Conciliar cobros | Lector | 28 | 26, 27 |
| [CU-36](#cu-36--dar-de-baja-contable-una-deuda) | Dar de baja contable una deuda | Administrador | 27 | 24 |
| [CU-37](#cu-37--consultar-pantalla-de-trabajo-notificaciones-y-alertas) | Consultar pantalla de trabajo, notificaciones y alertas | Lector | 33, 34, 92, 93, 94, 95 | 28, 30, 80 |
| [CU-38](#cu-38--configurar-notificaciones-y-alertas) | Configurar notificaciones y alertas | Superadministrador | 35, 92, 93, 94, 95 | 29, 80 |
| [CU-39](#cu-39--buscar-clientes-y-facturas) | Buscar clientes y facturas | Lector | 37 | 33 |
| [CU-40](#cu-40--gestionar-incidencias-de-facturación-y-de-cobro) | Gestionar incidencias de facturación y de cobro | Lector | 50, 99 | 25, 94, 109 |
| [CU-41](#cu-41--comentar-internamente) | Comentar internamente | Lector | 69 | 90 |
| [CU-42](#cu-42--consultar-dashboard-financiero) | Consultar dashboard financiero | Administrador | 36 | 31 |
| [CU-43](#cu-43--generar-y-exportar-informes) | Generar y exportar informes | Lector | 36, 51, 76, 100 | 32, 50, 85, 95 |
| [CU-44](#cu-44--programar-informes-periódicos-opcional) | Programar informes periódicos (opcional) | Administrador | 111 | 102 |
| [CU-45](#cu-45--fijar-objetivos-de-facturación-y-cobro) | Fijar objetivos de facturación y cobro | Administrador | 71 | 82 |
| [CU-46](#cu-46--generar-paquete-contable-del-periodo) | Generar paquete contable del periodo | Administrador | 84, 85, 86 | 77 |
| [CU-47](#cu-47--consultar-eficiencia-operativa) | Consultar eficiencia operativa | Superadministrador | 101 | 96 |
| [CU-48](#cu-48--acceder-al-sistema) | Acceder al sistema | Lector | 40, 41, 60 | 36, 38, 58, 72 |
| [CU-49](#cu-49--gestionar-usuarios) | Gestionar usuarios | Administrador | 40 | 37, 39 |
| [CU-50](#cu-50--asignar-y-delegar-clientes) | Asignar y delegar clientes | Administrador | 42, 43, 44 | 39, 40, 41 |
| [CU-51](#cu-51--descargar-documentos-autorizados) | Descargar documentos autorizados | Lector | 48 | 45 |
| [CU-52](#cu-52--consultar-auditoría-de-negocio-y-exportaciones) | Consultar auditoría de negocio y exportaciones | Superadministrador | 46, 90, 91 | 43, 79 |
| [CU-53](#cu-53--gestionar-copias-de-seguridad) | Gestionar copias de seguridad | Superadministrador | 47 | 44 |
| [CU-54](#cu-54--gestionar-configuración-global) | Gestionar configuración global | Superadministrador | 14, 65, 66, 72, 73, 103, 110 | 12, 65, 66, 83, 84, 98, 103, 104 |
| [CU-55](#cu-55--cargar-datos-de-demostración-opcional) | Cargar datos de demostración (opcional) | Superadministrador | 74 | 91 |
| [CU-56](#cu-56--consultar-estado-del-sistema-y-errores) | Consultar estado del sistema y errores | Administrador | 58, 62, 63 | 56, 62, 63, 86, 101 |
| [CU-57](#cu-57--consultar-datos-mediante-la-api) | Consultar datos mediante la API | Sistema externo | 61 | 59, 61 |
| [CU-58](#cu-58--enviar-solicitud-mediante-la-api) | Enviar solicitud mediante la API | Sistema externo | 61 | 60 |

---

# Área 1 — Clientes y contactos

![Diagrama de casos de uso — Clientes y contactos](<casos de uso/diagramas/diagrama_CU_area01_clientes_y_contactos.png>)
## CU-01 — Registrar cliente

> UR: UR-01, UR-45, UR-64, UR-97, UR-105, UR-108 · FR: FR-01, FR-42, FR-48, FR-64, FR-70, FR-92, FR-106

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-01 |
| **Nombre** | Registrar cliente |
| **Objetivo** | Dar de alta una empresa cliente con sus datos fiscales y operativos correctos y sin duplicados, y saber qué datos faltan para poder facturarle. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario tiene permiso para dar de alta clientes.

---

### 3. Flujo principal

1. **Lector:** solicita dar de alta un cliente.
2. **Sistema:** muestra el formulario con valores por defecto propuestos para las altas frecuentes (país, moneda, condiciones de pago).
3. **Lector:** introduce país, identificación fiscal, moneda y demás datos; puede usar la búsqueda de direcciones.
4. **Sistema:** valida los datos y comprueba posibles duplicados (nombre o razón social, identificador fiscal, email y teléfono, A-10).
5. **Sistema:** muestra un resumen del alta con los datos que faltan para poder facturar.
6. **Lector:** revisa el resumen y confirma.
7. **Sistema:** registra el cliente y lo asigna al responsable.

---

### 4. Flujos alternativos

#### FA-1 — Guardar con datos no imprescindibles pendientes

**Se produce en:** paso 5 del flujo principal.  
**Condición:** Faltan datos no imprescindibles (por ejemplo, el teléfono del contacto, A-11) o el país es desconocido.

1. El sistema permite guardar el cliente como excepción controlada.
2. Si el país se desconoce, la validación del identificador fiscal queda pendiente.
3. El sistema deja marcado qué datos faltan.

**Continuación:** el caso de uso termina en el paso 7; los datos pendientes bloquean la facturación hasta completarse.

#### FA-2 — Reutilizar un cliente existente

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El sistema detecta un posible duplicado y el usuario decide que es el mismo cliente.

1. El sistema muestra el cliente coincidente.
2. El usuario abandona el alta o reactiva el expediente existente.

**Continuación:** termina sin crear un cliente nuevo.

#### FA-3 — Deshacer una modificación accidental

**Se produce en:** posterior al paso final del flujo principal.  
**Condición:** El usuario detecta que ha modificado un dato por error.

1. El usuario solicita deshacer la última modificación.
2. El sistema comprueba que no es legalmente irreversible y restaura el estado anterior, registrando la acción.
3. Si es irreversible (RB-11), el sistema rechaza la operación e informa al usuario.

**Continuación:** el caso de uso termina.

---

### 5. Flujos de excepción

#### FE-1 — Datos inválidos

**Se produce en:** paso 4.  
**Condición:** El identificador fiscal o algún dato imprescindible no supera la validación.

1. El sistema indica qué campos son incorrectos.
2. No se registra el cliente.

**Resultado:** el usuario corrige y regresa al paso 3.

#### FE-2 — Conflicto de edición concurrente

**Se produce en:** paso 7.  
**Condición:** Otro usuario ha modificado el mismo registro entretanto (UR-45).

1. El sistema detecta el conflicto y no sobrescribe los cambios del otro usuario.
2. Muestra las diferencias y pide al usuario que decida.

**Resultado:** el usuario revisa y reintenta desde el paso 5.

---

### 6. Postcondiciones

- POST-1. El cliente queda registrado y asignado a un responsable.
- POST-2. Los datos pendientes, si los hay, quedan marcados.
- POST-3. La operación queda auditada.

---

## CU-02 — Consultar cliente e historial

> UR: UR-02, UR-59, UR-68 · FR: FR-01, FR-57, FR-71

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-02 |
| **Nombre** | Consultar cliente e historial |
| **Objetivo** | Consultar la información registrada de un cliente y su historial, y acceder con rapidez a los clientes habituales. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El cliente está asignado al usuario (RB-15) o el usuario es Administrador/Superadministrador.

---

### 3. Flujo principal

1. **Lector:** accede a la lista de clientes, a sus favoritos o a los consultados recientemente.
2. **Sistema:** muestra los clientes a los que el usuario tiene acceso.
3. **Lector:** selecciona un cliente.
4. **Sistema:** muestra sus datos fiscales y operativos, su relación comercial y su historial (el historial completo lo ve el Administrador, UR-59).
5. **Lector:** opcionalmente marca el cliente como favorito.
6. **Sistema:** registra el favorito.

---

### 4. Flujos alternativos

#### FA-1 — Consultar el historial del cliente

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El usuario es Administrador y solicita el historial.

1. El sistema muestra cambios, facturas, cobros y comunicaciones en orden cronológico.

**Continuación:** termina al cerrar la consulta.

---

### 5. Flujos de excepción

#### FE-1 — Cliente no asignado

**Se produce en:** paso 3.  
**Condición:** Un Lector intenta acceder a un cliente que no tiene asignado.

1. El sistema deniega el acceso sin revelar datos del cliente.

**Resultado:** el caso de uso termina sin mostrar datos.

---

### 6. Postcondiciones

- POST-1. Ninguna modificación de datos; el favorito, si se marcó, queda guardado.

---

## CU-03 — Gestionar contactos y preferencias de comunicación

> UR: UR-03, UR-87, UR-88, UR-89 · FR: FR-02, FR-78

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-03 |
| **Nombre** | Gestionar contactos y preferencias de comunicación |
| **Objetivo** | Mantener los contactos de una empresa cliente con su idioma, canal preferido y permiso de envío por canal. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión y tiene acceso al cliente.

---

### 3. Flujo principal

1. **Lector:** abre los contactos del cliente y elige crear, editar o eliminar un contacto.
2. **Sistema:** muestra el formulario del contacto.
3. **Lector:** introduce los datos del contacto, su idioma preferido y su canal preferido.
4. **Lector:** indica por separado el consentimiento de envío de cada canal.
5. **Sistema:** valida y guarda el contacto.

---

### 4. Flujos alternativos

#### FA-1 — Designar contacto de facturación

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El contacto va a recibir las facturas.

1. El usuario marca el contacto como de facturación.
2. El sistema comprueba que el cliente conserva al menos un contacto de facturación (RB-27).

**Continuación:** continúa en el paso 5.

---

### 5. Flujos de excepción

#### FE-1 — Eliminar el único contacto de facturación

**Se produce en:** paso 1.  
**Condición:** Un cliente activo se queda sin contacto de facturación.

1. El sistema rechaza la operación e informa de que debe designarse otro contacto antes (RB-27).

**Resultado:** el contacto no se elimina.

---

### 6. Postcondiciones

- POST-1. El contacto queda guardado con idioma, canal y consentimientos.
- POST-2. Las comunicaciones futuras respetan idioma, canal y consentimiento (RB-28).

---

## CU-04 — Adjuntar documentos a cliente o factura

> UR: UR-67 · FR: FR-67

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-04 |
| **Nombre** | Adjuntar documentos a cliente o factura |
| **Objetivo** | Adjuntar de forma segura los documentos que justifican un cliente o una factura (pedido, presupuesto aceptado, justificante). |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión y tiene acceso al cliente o a la factura.

---

### 3. Flujo principal

1. **Lector:** elige el cliente o la factura y selecciona adjuntar documento.
2. **Sistema:** solicita el fichero.
3. **Lector:** selecciona el fichero.
4. **Sistema:** comprueba el tipo y formato permitidos y lo almacena de forma segura.
5. **Sistema:** lo muestra asociado al cliente o factura.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Tipo o formato no permitido

**Se produce en:** paso 4.  
**Condición:** El fichero no cumple los tipos o formatos permitidos.

1. El sistema rechaza el fichero e indica los formatos admitidos.

**Resultado:** el usuario puede elegir otro fichero y volver al paso 3.

---

### 6. Postcondiciones

- POST-1. El documento queda asociado al cliente o factura y solo es accesible a usuarios autorizados.

---

## CU-05 — Importar clientes desde CSV

> UR: UR-38 · FR: FR-34

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-05 |
| **Nombre** | Importar clientes desde CSV |
| **Objetivo** | Cargar clientes desde un fichero CSV con previsualización, mapeo de columnas y control de duplicados por NIF. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión y dispone de un fichero CSV.

---

### 3. Flujo principal

1. **Lector:** selecciona el fichero CSV.
2. **Sistema:** muestra una previsualización de las filas.
3. **Lector:** asigna cada columna del fichero a un campo del cliente.
4. **Sistema:** valida las filas y detecta duplicados por NIF.
5. **Lector:** revisa el resultado y confirma la importación.
6. **Sistema:** crea los clientes válidos y muestra un resumen.

---

### 4. Flujos alternativos

#### FA-1 — Omitir o fusionar duplicados

**Se produce en:** paso 5 del flujo principal.  
**Condición:** Hay filas con NIF ya existente.

1. El usuario elige omitirlas o actualizar el cliente existente.

**Continuación:** continúa en el paso 6.

---

### 5. Flujos de excepción

#### FE-1 — Filas inválidas

**Se produce en:** paso 4.  
**Condición:** Algunas filas no superan la validación.

1. El sistema las excluye y las lista con su motivo.

**Resultado:** el usuario decide importar solo las válidas (paso 5) o cancelar.

---

### 6. Postcondiciones

- POST-1. Los clientes importados quedan registrados.
- POST-2. El resumen de la importación queda auditado.

---

## CU-06 — Importar histórico de facturas

> UR: UR-39 · FR: FR-35

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-06 |
| **Nombre** | Importar histórico de facturas |
| **Objetivo** | Migrar facturas históricas sin enviar emails ni consumir la numeración oficial. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador.
- PRE-3. Los clientes afectados existen en el sistema.

### 3. Flujo principal

1. **Administrador:** selecciona el fichero con el histórico y el modo migración.
2. **Sistema:** valida el formato y los clientes referenciados.
3. **Administrador:** confirma la importación.
4. **Sistema:** crea las facturas marcadas como migradas, sin enviar comunicaciones y sin consumir numeración oficial.
5. **Sistema:** muestra el resumen.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Cliente inexistente o datos incoherentes

**Se produce en:** paso 2.  
**Condición:** Una factura referencia un cliente que no existe o tiene importes incoherentes.

1. El sistema excluye la factura y la lista con su motivo.

**Resultado:** el Administrador puede corregir el fichero y repetir.

---

### 6. Postcondiciones

- POST-1. Las facturas históricas quedan marcadas como migradas.
- POST-2. No se ha enviado ningún email ni se ha consumido numeración.

---

## CU-07 — Ejecutar acción masiva sobre clientes

> UR: UR-106 · FR: FR-107

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-07 |
| **Nombre** | Ejecutar acción masiva sobre clientes |
| **Objetivo** | Aplicar una misma acción a un conjunto de clientes controlando el alcance y el resultado. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión y tiene permiso para la acción.

---

### 3. Flujo principal

1. **Lector:** selecciona un conjunto de clientes y la acción a aplicar.
2. **Sistema:** muestra el alcance (cuántos clientes y cuáles) y pide confirmación.
3. **Lector:** confirma.
4. **Sistema:** ejecuta la acción cliente a cliente y registra el resultado de cada uno.
5. **Sistema:** muestra un resumen con éxitos y fallos.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Acción no permitida en masa

**Se produce en:** paso 2.  
**Condición:** La acción es marcar facturas como pagadas (RB-23).

1. El sistema rechaza la acción.

**Resultado:** el caso de uso termina sin cambios.

#### FE-2 — Fallo parcial

**Se produce en:** paso 4.  
**Condición:** La acción falla para algunos clientes.

1. El sistema continúa con el resto y lista los fallos.

**Resultado:** el usuario puede reintentar solo los fallidos.

---

### 6. Postcondiciones

- POST-1. Los clientes afectados quedan actualizados y la acción auditada.

---

## CU-08 — Etiquetar clientes y clasificar facturas (opcional)

> UR: UR-107 · FR: FR-81, FR-108
> Opcional (A-14, A-16): no se implementa en el primer despliegue.

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-08 |
| **Nombre** | Etiquetar clientes y clasificar facturas (opcional) |
| **Objetivo** | Organizar clientes con etiquetas y clasificar facturas por proyecto o línea de negocio para analizarlas. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. Las categorías están definidas por un administrador.

---

### 3. Flujo principal

1. **Lector:** selecciona un cliente o una factura.
2. **Lector:** asigna etiquetas o la categoría de proyecto o línea de negocio.
3. **Sistema:** guarda la clasificación.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. La clasificación queda asociada al cliente o factura. Las etiquetas manuales no sustituyen estados derivados como «impagado» (RB-34).

---

## CU-09 — Gestionar privacidad de datos personales

> UR: UR-75, UR-109 · FR: FR-89, FR-99

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-09 |
| **Nombre** | Gestionar privacidad de datos personales |
| **Objetivo** | Localizar los datos personales de un contacto y anonimizarlos cuando legalmente proceda, sin invalidar el histórico contable, y garantizar que no se usan para campañas comerciales. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador o Superadministrador.

### 3. Flujo principal

1. **Administrador:** busca un contacto y solicita localizar sus datos personales.
2. **Sistema:** muestra todos los datos personales (registros activos, históricos y copias según la política definida, RB-18).
3. **Administrador:** solicita anonimizar.
4. **Sistema:** comprueba qué datos pueden anonimizarse y cuáles deben conservarse por obligación contable (RB-17).
5. **Administrador:** confirma.
6. **Sistema:** anonimiza los datos permitidos conservando la integridad del histórico.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Datos que deben conservarse

**Se produce en:** paso 4.  
**Condición:** Parte de los datos está sujeta a conservación legal.

1. El sistema anonimiza solo lo permitido e informa de lo que se mantiene y por qué.

**Resultado:** termina con anonimización parcial.

---

### 6. Postcondiciones

- POST-1. Los datos personales permitidos quedan anonimizados.
- POST-2. Las facturas emitidas siguen siendo íntegras.
- POST-3. Los datos de facturación no se reutilizan automáticamente para campañas comerciales (FR-89).

---


# Área 2 — Relación comercial y suscripciones

![Diagrama de casos de uso — Relación comercial y suscripciones](<casos de uso/diagramas/diagrama_CU_area02_relacion_comercial_y_suscripciones.png>)
## CU-10 — Gestionar relación comercial

> UR: UR-04, UR-19, UR-97 · FR: FR-03, FR-07, FR-92

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-10 |
| **Nombre** | Gestionar relación comercial |
| **Objetivo** | Registrar y consultar la relación comercial de un cliente (inicio, plan, tarifa, condiciones de pago, responsable) y gestionar los clientes con fecha de inicio futura. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión y tiene acceso al cliente.

---

### 3. Flujo principal

1. **Lector:** abre la relación comercial del cliente.
2. **Sistema:** muestra fecha de inicio, plan, tarifa, condiciones de pago, responsable e historial.
3. **Lector:** crea o modifica la relación e indica la fecha de inicio.
4. **Sistema:** valida los datos y guarda la relación.
5. **Sistema:** si la fecha de inicio es futura, marca al cliente como pendiente de activación.

---

### 4. Flujos alternativos

#### FA-1 — Consultar pendientes de activación

**Se produce en:** paso 1 del flujo principal.  
**Condición:** El usuario quiere ver los clientes con inicio futuro.

1. El sistema lista los clientes pendientes de activación con su fecha.

**Continuación:** termina al cerrar la consulta.

#### FA-2 — Deshacer una modificación accidental

**Se produce en:** posterior al paso final del flujo principal.  
**Condición:** El usuario detecta que ha modificado un dato por error.

1. El usuario solicita deshacer la última modificación.
2. El sistema comprueba que no es legalmente irreversible y restaura el estado anterior, registrando la acción.
3. Si es irreversible (RB-11), el sistema rechaza la operación e informa al usuario.

**Continuación:** el caso de uso termina.

---

### 5. Flujos de excepción

#### FE-1 — Facturar antes de la fecha de inicio

**Se produce en:** paso 4.  
**Condición:** Se intenta generar facturas o recordatorios antes de la fecha de inicio (RB-30).

1. El sistema lo impide.

**Resultado:** no se genera nada.

---

### 6. Postcondiciones

- POST-1. La relación comercial queda registrada, independiente de las facturas ya generadas (RB-12).
- POST-2. Al llegar la fecha de inicio, el cliente entra en la facturación recurrente.

---

## CU-11 — Pausar y reactivar suscripción

> UR: UR-20, UR-21 · FR: FR-15

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-11 |
| **Nombre** | Pausar y reactivar suscripción |
| **Objetivo** | Pausar temporalmente una suscripción congelando nuevas mensualidades, y confirmar su reanudación cuando llegue la fecha prevista. |
| **Actores participantes** | Lector (principal), Planificador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. La suscripción del cliente está activa.
- PRE-3. El usuario tiene acceso al cliente.

### 3. Flujo principal

1. **Lector:** solicita pausar la suscripción e indica motivo, fecha de inicio y fecha prevista de reactivación.
2. **Sistema:** registra la pausa y detiene la generación de nuevas mensualidades (RB-05).
3. **Sistema:** mantiene sin cambios las facturas ya emitidas e impagadas.
4. **Planificador:** al llegar la fecha prevista de reactivación, avisa al responsable asignado.
5. **Lector:** confirma la reanudación del cobro.
6. **Sistema:** reactiva la generación de mensualidades.

---

### 4. Flujos alternativos

#### FA-1 — Mantener la pausa

**Se produce en:** paso 5 del flujo principal.  
**Condición:** El responsable no confirma la reanudación.

1. El sistema mantiene la suscripción pausada (RB-29).

**Continuación:** la facturación no se reanuda sin confirmación explícita.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Mientras dura la pausa no se generan mensualidades.
- POST-2. Las facturas impagadas anteriores siguen en recobro.

---

## CU-12 — Dar de baja a un cliente

> UR: UR-22 · FR: FR-16

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-12 |
| **Nombre** | Dar de baja a un cliente |
| **Objetivo** | Registrar la baja comercial de un cliente deteniendo cobros futuros pero manteniendo el recobro de deudas pendientes. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El cliente está activo.
- PRE-3. El usuario tiene acceso al cliente.

### 3. Flujo principal

1. **Lector:** solicita la baja del cliente e indica motivo y fecha.
2. **Sistema:** pide confirmación.
3. **Lector:** confirma.
4. **Sistema:** detiene la generación de nuevas cuotas recurrentes (RB-13).
5. **Sistema:** mantiene activo el flujo de recobro de deudas anteriores.
6. **Sistema:** conserva los datos exigidos por obligaciones contables (RB-17).

---

### 4. Flujos alternativos

#### FA-1 — Baja solicitada por sistema externo

**Se produce en:** paso 1 del flujo principal.  
**Condición:** La solicitud llega por la API (CU-58).

1. El sistema la trata como solicitud controlada sujeta a validación o aprobación (RB-31).

**Continuación:** continúa en el paso 2 tras la validación.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. El cliente queda de baja sin nuevas cuotas.
- POST-2. Las deudas pendientes siguen en recobro.
- POST-3. Ningún dato de conservación obligatoria se elimina.

---

## CU-13 — Revisar anualmente el plan de un cliente

> UR: UR-57 · FR: FR-54, FR-55, FR-69

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-13 |
| **Nombre** | Revisar anualmente el plan de un cliente |
| **Objetivo** | Revisar cada año si un cliente sigue en el plan que le corresponde y decidir el cambio sin alterar las facturas pasadas. |
| **Actores participantes** | Administrador (principal), Superadministrador, Planificador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador.
- PRE-3. El Planificador ha lanzado la campaña anual de revisión.

### 3. Flujo principal

1. **Planificador:** al iniciarse la campaña anual, prepara la lista de clientes a revisar.
2. **Administrador:** abre la campaña anual y consulta la lista de clientes a revisar.
3. **Sistema:** obtiene la facturación anual verificada de cada cliente.
4. **Sistema:** propone el rango de facturación que le corresponde.
5. **Administrador:** revisa la propuesta y decide aplicar o mantener el plan.
6. **Sistema:** aplica el cambio hacia delante sin alterar facturas pasadas (RB-06).
7. **Sistema:** registra aprobador, fecha, plan anterior y plan nuevo.

---

### 4. Flujos alternativos

#### FA-1 — Corregir datos de la revisión

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El Administrador detecta un dato de facturación erróneo.

1. El sistema permite corregirlo, recalcula el impacto y exige aprobación.

**Continuación:** continúa en el paso 3 con los datos corregidos.

---

### 5. Flujos de excepción

#### FE-1 — Aprobación propia

**Se produce en:** paso 4.  
**Condición:** El usuario que corrige es el mismo que aprobaría el cambio.

1. El sistema exige que apruebe otro usuario (FR-74).

**Resultado:** el cambio queda pendiente de otro aprobador.

---

### 6. Postcondiciones

- POST-1. El plan queda actualizado o mantenido y la decisión auditada.

---

## CU-14 — Configurar tarifas globales

> UR: UR-10 · FR: FR-10

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-14 |
| **Nombre** | Configurar tarifas globales |
| **Objetivo** | Configurar los rangos de facturación anual y las tarifas sin modificar el código. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.

### 3. Flujo principal

1. **Superadministrador:** abre la configuración de tarifas.
2. **Sistema:** muestra los rangos y precios vigentes.
3. **Superadministrador:** crea o modifica rangos y precios.
4. **Sistema:** valida la coherencia de los rangos (sin solapes ni huecos).
5. **Sistema:** guarda y audita el cambio.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Rangos incoherentes

**Se produce en:** paso 4.  
**Condición:** Los rangos se solapan o dejan huecos.

1. El sistema rechaza el cambio e indica el problema.

**Resultado:** el usuario corrige y vuelve al paso 3.

---

### 6. Postcondiciones

- POST-1. Las nuevas tarifas se aplican hacia delante; las facturas emitidas no cambian (RB-06, RB-12).

---


# Área 3 — Emisión de facturas

![Diagrama de casos de uso — Emisión de facturas](<casos de uso/diagramas/diagrama_CU_area03_emision_de_facturas.png>)
## CU-15 — Emitir factura puntual

> UR: UR-05, UR-11, UR-17, UR-23, UR-24, UR-29, UR-53, UR-66, UR-70, UR-98 · FR: FR-04, FR-17, FR-18, FR-19, FR-66, FR-68, FR-87, FR-93

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-15 |
| **Nombre** | Emitir factura puntual |
| **Objetivo** | Preparar y emitir una factura puntual con varias líneas e impuestos, obteniendo su PDF inalterable. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión y tiene acceso al cliente.
- PRE-2. El cliente tiene los datos fiscales completos.
- PRE-3. Existe una serie de facturación configurada.

---

### 3. Flujo principal

1. **Lector:** solicita crear una factura puntual para un cliente.
2. **Sistema:** crea un borrador y muestra el formulario.
3. **Lector:** añade líneas, usando si quiere conceptos del catálogo, y selecciona los impuestos aplicables.
4. **Sistema:** valida los datos y bloquea la emisión si faltan datos fiscales (UR-24).
5. **Lector:** solicita la previsualización.
6. **Sistema:** muestra la previsualización, con aviso si el importe es atípico respecto a la media del cliente (no bloquea, FR-18).
7. **Lector:** confirma la emisión tras ver el nivel de irreversibilidad de la acción (UR-98).
8. **Sistema:** asigna número de la serie, genera el PDF inalterable (RB-07) y marca la factura como emitida.

---

### 4. Flujos alternativos

#### FA-1 — Modificar impuestos

**Se produce en:** paso 3 del flujo principal.  
**Condición:** Hay que cambiar los impuestos por defecto.

1. El usuario modifica los impuestos aplicables.
2. El sistema recalcula los importes.

**Continuación:** continúa en el paso 4.

#### FA-2 — Guardar como borrador

**Se produce en:** paso 5 del flujo principal.  
**Condición:** El usuario no quiere emitir todavía.

1. El usuario guarda el borrador (CU-16).

**Continuación:** termina sin emitir.

#### FA-3 — Pasar a aprobación

**Se produce en:** paso 7 del flujo principal.  
**Condición:** La factura incluye una modificación manual o supera el umbral (RB-25).

1. La factura queda pendiente de aprobación (CU-23).

**Continuación:** se emite tras la aprobación.

#### FA-4 — Elegir la sociedad emisora (opcional)

**Se produce en:** paso 3 del flujo principal.  
**Condición:** Turbine factura desde varias sociedades (UR-66).

1. El usuario elige, entre las configuradas (CU-54), la sociedad con la que se emite la factura.

**Continuación:** continúa en el paso 4.

---

### 5. Flujos de excepción

#### FE-1 — Doble clic o reintento

**Se produce en:** paso 7.  
**Condición:** El usuario pulsa dos veces o repite la petición.

1. El sistema detecta el duplicado y emite una sola factura (FR-87).

**Resultado:** termina con una única factura.

#### FE-2 — Fallo al crear la factura

**Se produce en:** paso 8.  
**Condición:** Un error impide crear la factura.

1. El sistema informa de que la factura no se pudo crear, distinguiéndolo de un fallo de envío (UR-53).
2. No se consume numeración.

**Resultado:** el usuario puede reintentar desde el paso 7.

#### FE-3 — Falta algún dato fiscal

**Se produce en:** paso 4.  
**Condición:** Faltan datos fiscales imprescindibles.

1. El sistema bloquea la emisión e indica qué falta.

**Resultado:** el usuario completa el cliente (CU-01) y vuelve al paso 5.

---

### 6. Postcondiciones

- POST-1. La factura queda emitida con ID único (RB-01), con PDF inalterable y sin posibilidad de edición silenciosa (RB-11).
- POST-2. La emisión queda auditada.

---

## CU-16 — Gestionar borradores de factura

> UR: UR-05, UR-08, UR-96, UR-97 · FR: FR-14, FR-92

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-16 |
| **Nombre** | Gestionar borradores de factura |
| **Objetivo** | Guardar, recuperar y borrar borradores de factura sin perder el trabajo. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.

---

### 3. Flujo principal

1. **Lector:** abre su lista de borradores.
2. **Sistema:** muestra los borradores con su fecha de modificación.
3. **Lector:** selecciona uno y continúa editándolo, o solicita borrarlo.
4. **Sistema:** guarda automáticamente los cambios durante la edición.
5. **Sistema:** si se solicitó borrar, pide confirmación y elimina el borrador.

---

### 4. Flujos alternativos

#### FA-1 — Recuperar tras interrupción

**Se produce en:** paso 1 del flujo principal.  
**Condición:** La edición se interrumpió accidentalmente.

1. El sistema restaura el último borrador guardado automáticamente.

**Continuación:** continúa en el paso 3.

#### FA-2 — Deshacer una modificación accidental

**Se produce en:** posterior al paso final del flujo principal.  
**Condición:** El usuario detecta que ha modificado un dato por error.

1. El usuario solicita deshacer la última modificación.
2. El sistema restaura el estado anterior del borrador, que al no estar emitido no tiene efectos legales, y registra la acción.

**Continuación:** el caso de uso termina.

---

### 5. Flujos de excepción

#### FE-1 — Borrar una factura emitida

**Se produce en:** paso 3.  
**Condición:** El usuario intenta borrar una factura ya emitida.

1. El sistema lo impide (RB-11).

**Resultado:** solo puede corregirse con rectificativa (CU-19).

---

### 6. Postcondiciones

- POST-1. Los borradores conservan el trabajo del usuario; los borrados dejan de existir.

---

## CU-17 — Configurar facturación recurrente

> UR: UR-05, UR-06, UR-17, UR-102 · FR: FR-05, FR-06, FR-100

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-17 |
| **Nombre** | Configurar facturación recurrente |
| **Objetivo** | Configurar la facturación mensual de una relación comercial y revisar el prorrateo del primer mes. |
| **Actores participantes** | Lector (principal), Planificador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. La relación comercial está aprobada y su fecha de inicio es válida.

### 3. Flujo principal

1. **Lector:** abre la configuración de facturación recurrente de la relación comercial.
2. **Lector:** indica el importe o plan a facturar mensualmente.
3. **Sistema:** calcula el prorrateo de la primera factura según la fecha de inicio (RB-02).
4. **Lector:** revisa el cálculo prorrateado antes de su emisión.
5. **Lector:** confirma.
6. **Sistema:** activa la generación automática de facturas recurrentes.
7. **Planificador:** el día 1 de cada mes, genera la factura recurrente del mes.

---

### 4. Flujos alternativos

#### FA-1 — Excepción al prorrateo

**Se produce en:** paso 3 del flujo principal.  
**Condición:** Existe una excepción comercial aprobada.

1. El sistema aplica la excepción aprobada en lugar del prorrateo.

**Continuación:** continúa en el paso 4.

---

### 5. Flujos de excepción

#### FE-1 — Relación sin aprobar

**Se produce en:** paso 1.  
**Condición:** La relación comercial no está aprobada.

1. El sistema impide activar la facturación recurrente.

**Resultado:** termina sin activar.

#### FE-2 — Caída del sistema durante la generación mensual

**Se produce en:** paso 7.  
**Condición:** Una caída breve interrumpe la generación de las facturas recurrentes.

1. Al recuperarse, el Planificador detecta las facturas recurrentes no generadas.
2. Genera solo las pendientes, sin duplicar las ya generadas (FR-100, NFR-15).
3. El Administrador puede comprobar el resultado en el estado del sistema (CU-56).

**Resultado:** el caso de uso continúa con normalidad.

---

### 6. Postcondiciones

- POST-1. La facturación recurrente queda activa y genera una factura cada mes (ver FE-2).

---

## CU-18 — Programar emisión futura

> UR: UR-09 · FR: FR-08

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-18 |
| **Nombre** | Programar emisión futura |
| **Objetivo** | Programar la emisión automática de una factura para una fecha futura. |
| **Actores participantes** | Lector (principal), Planificador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El borrador de factura existe y es válido.

### 3. Flujo principal

1. **Lector:** selecciona un borrador y elige programar la emisión.
2. **Lector:** indica la fecha futura.
3. **Sistema:** valida la fecha y deja la factura programada.
4. **Planificador:** en la fecha indicada, emite la factura automáticamente.

---

### 4. Flujos alternativos

#### FA-1 — Cancelar o cambiar la programación

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El usuario cambia de idea antes de la fecha.

1. El usuario cancela o modifica la fecha.

**Continuación:** termina sin emitir o con la nueva fecha.

---

### 5. Flujos de excepción

#### FE-1 — Fallo en la emisión programada

**Se produce en:** paso 4.  
**Condición:** Al llegar la fecha falla la emisión.

1. El sistema notifica el fallo al responsable (CU-40) y no duplica la emisión.

**Resultado:** el usuario puede reintentar.

---

### 6. Postcondiciones

- POST-1. La factura se emite en la fecha programada, una sola vez.

---

## CU-19 — Emitir factura rectificativa

> UR: UR-55 · FR: FR-52

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-19 |
| **Nombre** | Emitir factura rectificativa |
| **Objetivo** | Corregir un error de una factura ya emitida sin alterarla, de modo que el saldo del cliente refleje la corrección. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. La factura original está emitida.
- PRE-3. El usuario es Administrador o Superadministrador (RB-21).

### 3. Flujo principal

1. **Administrador:** selecciona la factura original y solicita rectificarla.
2. **Sistema:** muestra la factura y pide los importes o conceptos corregidos y el motivo.
3. **Administrador:** introduce la corrección.
4. **Sistema:** genera una rectificativa vinculada a la original sin modificarla.
5. **Sistema:** recalcula el saldo del cliente.

---

### 4. Flujos alternativos

#### FA-1 — Rectificativa sobre el umbral

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El importe supera el umbral configurado (RB-24).

1. La rectificativa queda pendiente de aprobación (CU-23) antes de emitirse.

**Continuación:** se emite tras aprobarse.

---

### 5. Flujos de excepción

#### FE-1 — Usuario sin permiso

**Se produce en:** paso 1.  
**Condición:** Un Lector intenta rectificar.

1. El sistema deniega la acción (RB-21).

**Resultado:** el caso de uso termina.

---

### 6. Postcondiciones

- POST-1. La factura original permanece inalterada y la rectificativa queda vinculada.
- POST-2. El saldo del cliente refleja la corrección.

---

## CU-20 — Gestionar presupuestos (opcional)

> UR: UR-54 · FR: FR-51
> Opcional (A-13).

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-20 |
| **Nombre** | Gestionar presupuestos (opcional) |
| **Objetivo** | Preparar un presupuesto, enviarlo, registrar su aceptación o rechazo y convertirlo en factura sin reintroducir los datos. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El cliente existe y tiene un contacto de facturación.

### 3. Flujo principal

1. **Lector:** prepara un presupuesto para un cliente.
2. **Lector:** lo envía al cliente.
3. **Lector:** registra la respuesta del cliente (acepta o rechaza).
4. **Sistema:** si lo acepta, genera una factura reutilizando las líneas del presupuesto.

---

### 4. Flujos alternativos

#### FA-1 — Presupuesto rechazado

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El cliente lo rechaza.

1. El sistema marca el presupuesto como rechazado.

**Continuación:** termina sin factura.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. El presupuesto y la factura conservan identidades e históricos independientes (RB-09).

---

## CU-21 — Configurar serie y numeración

> UR: UR-16 · FR: FR-13

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-21 |
| **Nombre** | Configurar serie y numeración |
| **Objetivo** | Configurar las series de facturación y la numeración correlativa única. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.

### 3. Flujo principal

1. **Superadministrador:** abre la configuración de series.
2. **Superadministrador:** crea o modifica una serie y su numeración inicial.
3. **Sistema:** valida que la numeración sea correlativa y única.
4. **Sistema:** guarda y audita el cambio.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Numeración conflictiva

**Se produce en:** paso 3.  
**Condición:** El número inicial entra en conflicto con facturas ya emitidas.

1. El sistema rechaza el cambio.

**Resultado:** el usuario corrige y repite.

---

### 6. Postcondiciones

- POST-1. Cada factura nueva recibe un número correlativo único de su serie.

---


# Área 4 — Aprobaciones y cierre contable

![Diagrama de casos de uso — Aprobaciones y cierre contable](<casos de uso/diagramas/diagrama_CU_area04_aprobaciones_y_cierre_contable.png>)
## CU-22 — Proponer excepción o factura para revisión

> UR: UR-12 · FR: FR-11

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-22 |
| **Nombre** | Proponer excepción o factura para revisión |
| **Objetivo** | Proponer facturas nuevas o modificadas o excepciones comerciales que requieren revisión. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.

---

### 3. Flujo principal

1. **Lector:** prepara una factura o una excepción con modificación manual de importe, descuento o fecha excepcional.
2. **Lector:** indica el motivo y la envía a revisión.
3. **Sistema:** guarda la propuesta como pendiente, sin emitirse (RB-25).
4. **Sistema:** notifica al aprobador correspondiente.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. La propuesta queda pendiente de aprobación y visible en la bandeja del solicitante (CU-24).

---

## CU-23 — Resolver propuesta o autorizar sobre el umbral

> UR: UR-13, UR-15, UR-80 · FR: FR-11, FR-74

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-23 |
| **Nombre** | Resolver propuesta o autorizar sobre el umbral |
| **Objetivo** | Aprobar o rechazar propuestas de factura o excepción, autorizando como Superadministrador las que superan el umbral. |
| **Actores participantes** | Administrador (principal), Superadministrador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. Existe una propuesta pendiente.
- PRE-3. El usuario es Administrador o Superadministrador y no es el solicitante (FR-74).

### 3. Flujo principal

1. **Administrador:** abre la bandeja de propuestas pendientes.
2. **Sistema:** muestra cada propuesta con su importe y el umbral configurado.
3. **Administrador:** revisa y decide aprobar o rechazar, indicando un comentario.
4. **Sistema:** registra la decisión, el comentario, el usuario y la fecha.
5. **Sistema:** si se aprueba, emite o aplica lo propuesto.

---

### 4. Flujos alternativos

#### FA-1 — Supera el umbral

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El importe supera el umbral configurado.

1. El sistema exige la autorización de un Superadministrador (RB-04).

**Continuación:** continúa en el paso 4 con el Superadministrador.

---

### 5. Flujos de excepción

#### FE-1 — Autoaprobación

**Se produce en:** paso 3.  
**Condición:** El usuario intenta aprobar su propia solicitud.

1. El sistema lo impide (FR-74).

**Resultado:** otro usuario debe resolver; si solo hay un Superadministrador queda pendiente (Q-11).

---

### 6. Postcondiciones

- POST-1. La propuesta queda aprobada o rechazada con su motivo.

---

## CU-24 — Consultar mis solicitudes económicas

> UR: UR-78, UR-79 · FR: FR-73

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-24 |
| **Nombre** | Consultar mis solicitudes económicas |
| **Objetivo** | Consultar el estado de las solicitudes económicas propias y el comentario del aprobador. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario ha realizado alguna solicitud económica.

### 3. Flujo principal

1. **Lector:** abre su bandeja de solicitudes.
2. **Sistema:** muestra cada solicitud como aprobada, rechazada o pendiente.
3. **Lector:** abre una solicitud.
4. **Sistema:** muestra el comentario explicativo del aprobador.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Ninguna modificación; el usuario conoce el motivo de cada decisión.

---

## CU-25 — Cerrar un periodo contable

> UR: UR-81, UR-82 · FR: FR-75

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-25 |
| **Nombre** | Cerrar un periodo contable |
| **Objetivo** | Cerrar formalmente un mes o trimestre y bloquear la modificación ordinaria de lo económico en ese periodo. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El periodo ha finalizado.
- PRE-3. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** selecciona el periodo y solicita cerrarlo.
2. **Sistema:** comprueba que no quedan operaciones pendientes del periodo.
3. **Administrador:** confirma.
4. **Sistema:** cierra el periodo y bloquea facturas y cobros del periodo.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Modificar un periodo cerrado

**Se produce en:** posterior al cierre.  
**Condición:** Se intenta modificar una factura o cobro de un periodo cerrado.

1. El sistema lo impide e indica que el periodo está cerrado.

**Resultado:** solo es posible tras reabrirlo (CU-26).

#### FE-2 — Operaciones pendientes

**Se produce en:** paso 2.  
**Condición:** Hay operaciones sin resolver en el periodo.

1. El sistema las lista.

**Resultado:** el Administrador las resuelve y reintenta.

---

### 6. Postcondiciones

- POST-1. El periodo queda cerrado y las modificaciones ordinarias bloqueadas.

---

## CU-26 — Reabrir un periodo cerrado

> UR: UR-83 · FR: FR-76

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-26 |
| **Nombre** | Reabrir un periodo cerrado |
| **Objetivo** | Reabrir un periodo cerrado indicando un motivo obligatorio que quede registrado. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El periodo está cerrado.
- PRE-3. El usuario es Superadministrador.

### 3. Flujo principal

1. **Superadministrador:** selecciona el periodo cerrado y solicita reabrirlo.
2. **Sistema:** exige un motivo.
3. **Superadministrador:** introduce el motivo y confirma.
4. **Sistema:** reabre el periodo y registra usuario, fecha y motivo.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Sin motivo

**Se produce en:** paso 3.  
**Condición:** No se indica motivo.

1. El sistema no reabre el periodo.

**Resultado:** el usuario introduce el motivo (paso 3).

#### FE-2 — Usuario no autorizado

**Se produce en:** paso 1.  
**Condición:** Quien lo intenta no es Superadministrador.

1. El sistema deniega la acción.

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. El periodo queda reabierto y la reapertura auditada con su motivo.

---


# Área 5 — Envío y comunicaciones

![Diagrama de casos de uso — Envío y comunicaciones](<casos de uso/diagramas/diagrama_CU_area05_envio_y_comunicaciones.png>)
## CU-27 — Enviar factura al cliente

> UR: UR-30, UR-53 · FR: FR-20, FR-68

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-27 |
| **Nombre** | Enviar factura al cliente |
| **Objetivo** | Enviar la factura emitida al contacto de facturación por correo electrónico o, de forma simulada, por WhatsApp. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. La factura está emitida y tiene PDF.
- PRE-3. El cliente tiene contacto de facturación.

### 3. Flujo principal

1. **Lector:** solicita enviar la factura.
2. **Sistema:** selecciona el canal preferido del contacto y la plantilla con las variables de la factura (RB-16).
3. **Sistema:** envía la factura y registra la plantilla usada (RB-35), el destinatario y la fecha.
4. **Sistema:** marca el estado de envío de la factura.

---

### 4. Flujos alternativos

#### FA-1 — Envío por WhatsApp (simulado)

**Se produce en:** paso 2 del flujo principal.  
**Condición:** El contacto prefiere WhatsApp.

1. El sistema comprueba número válido y consentimiento (RB-28).
2. Simula el envío.

**Continuación:** continúa en el paso 3.

---

### 5. Flujos de excepción

#### FE-1 — Fallo de envío

**Se produce en:** paso 3.  
**Condición:** El envío falla o rebota.

1. El sistema marca el envío como fallido y genera una incidencia de entrega, sin deshacer la factura.
2. Se muestra que la factura existe pero no se envió (UR-53).

**Resultado:** continúa en CU-28.

---

### 6. Postcondiciones

- POST-1. La factura queda enviada o con incidencia de entrega registrada.

---

## CU-28 — Gestionar fallo de envío de una factura

> UR: UR-25 · FR: FR-21

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-28 |
| **Nombre** | Gestionar fallo de envío de una factura |
| **Objetivo** | Corregir los datos de contacto tras un fallo y reintentar el envío sin duplicar la factura. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. Existe una incidencia de envío fallido.

### 3. Flujo principal

1. **Lector:** abre la incidencia de envío.
2. **Sistema:** muestra el motivo del fallo y el contacto afectado.
3. **Lector:** corrige los datos de contacto.
4. **Lector:** solicita reintentar.
5. **Sistema:** reenvía la misma factura sin generar una nueva ni consumir numeración.
6. **Sistema:** cierra la incidencia.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Fallos repetidos

**Se produce en:** paso 5.  
**Condición:** Se acumulan tres fallos consecutivos (ejemplo del cliente).

1. El sistema avisa para corregir los datos de entrega (CU-37).

**Resultado:** el usuario corrige y reintenta.

---

### 6. Postcondiciones

- POST-1. La factura se envía una sola vez, sin duplicados, y la incidencia queda resuelta.

---

## CU-29 — Enviar recordatorios de pago automáticos

> UR: UR-31, UR-49 · FR: FR-22, FR-46

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-29 |
| **Nombre** | Enviar recordatorios de pago automáticos |
| **Objetivo** | Enviar recordatorios de cobro automáticos según la cadencia configurada y respetando el vencimiento acordado con cada cliente. |
| **Actores participantes** | Planificador (principal), Lector |

---

### 2. Precondiciones

- PRE-1. Existen facturas pendientes con vencimiento.
- PRE-2. La cadencia de recordatorios está configurada (CU-30).

---

### 3. Flujo principal

1. **Planificador:** en cada ciclo de la cadencia, selecciona las facturas que requieren recordatorio.
2. **Sistema:** excluye las facturas en disputa y las de relaciones no iniciadas (RB-30).
3. **Sistema:** genera el mensaje con la plantilla y el idioma del contacto.
4. **Sistema:** lo envía por el canal preferido y registra el envío.
5. **Lector:** como responsable del cliente, consulta el resultado y atiende las incidencias de envío que se generen.

---

### 4. Flujos alternativos

#### FA-1 — Factura en disputa

**Se produce en:** paso 2 del flujo principal.  
**Condición:** La factura está marcada en disputa (CU-31).

1. El sistema omite el recordatorio mientras dure la disputa.

**Continuación:** continúa con la siguiente factura.

---

### 5. Flujos de excepción

#### FE-1 — Envío fallido

**Se produce en:** paso 4.  
**Condición:** El envío falla.

1. El sistema registra el fallo y lo gestiona como incidencia (CU-28).

**Resultado:** continúa con la siguiente factura.

---

### 6. Postcondiciones

- POST-1. Cada recordatorio enviado queda registrado con fecha y plantilla.

---

## CU-30 — Configurar recordatorios y plantillas

> UR: UR-31, UR-49, UR-104 · FR: FR-22, FR-46, FR-105

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-30 |
| **Nombre** | Configurar recordatorios y plantillas |
| **Objetivo** | Configurar la cadencia de recordatorios y las plantillas de comunicación, y probar los cambios antes de activarlos. |
| **Actores participantes** | Superadministrador (principal), Administrador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador (cadencia) o Administrador (plantillas y pruebas).

### 3. Flujo principal

1. **Superadministrador:** configura la cadencia de recordatorios respetando el vencimiento acordado.
2. **Administrador:** edita las plantillas de factura y de recordatorio con las variables obligatorias (RB-16).
3. **Administrador:** prueba los cambios con una simulación o previsualización.
4. **Sistema:** muestra el resultado de la prueba.
5. **Superadministrador:** activa el cambio.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Plantilla sin variables obligatorias

**Se produce en:** paso 2.  
**Condición:** Faltan empresa, número de factura, importe o vencimiento.

1. El sistema rechaza la plantilla.

**Resultado:** el usuario corrige.

---

### 6. Postcondiciones

- POST-1. Los cambios probados quedan activos y auditados.

---

## CU-31 — Marcar factura en disputa

> UR: UR-26 · FR: FR-23

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-31 |
| **Nombre** | Marcar factura en disputa |
| **Objetivo** | Pausar los recordatorios de una factura mientras se investiga una disconformidad. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. La factura está emitida y pendiente de cobro.
- PRE-3. El usuario es Administrador o Superadministrador (RB-22).

### 3. Flujo principal

1. **Administrador:** marca la factura como «en disputa».
2. **Sistema:** solicita el motivo y una fecha de revisión.
3. **Administrador:** los introduce.
4. **Sistema:** registra la disputa sin cambiar el estado de cobro y suspende sus recordatorios.

---

### 4. Flujos alternativos

#### FA-1 — Resolver la disputa

**Se produce en:** posterior del flujo principal.  
**Condición:** Se cierra la disconformidad.

1. El administrador levanta la disputa.
2. El sistema reanuda los recordatorios.

**Continuación:** termina.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. La factura sigue pendiente de cobro con los recordatorios suspendidos.

---

## CU-32 — Consultar estado de entrega de mensajes

> UR: UR-77 · FR: FR-88

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-32 |
| **Nombre** | Consultar estado de entrega de mensajes |
| **Objetivo** | Consultar la trazabilidad y el estado detallado de entrega de cada mensaje enviado. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. Se ha enviado al menos un mensaje.

### 3. Flujo principal

1. **Lector:** abre el historial de comunicaciones de un cliente o factura.
2. **Sistema:** muestra cada mensaje con su canal, fecha, plantilla y estado de entrega.
3. **Lector:** abre un mensaje concreto.
4. **Sistema:** muestra el detalle de la entrega.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Ninguna modificación.

---


# Área 6 — Cobros, conciliación y saldo

![Diagrama de casos de uso — Cobros, conciliación y saldo](<casos de uso/diagramas/diagrama_CU_area06_cobros_conciliacion_y_saldo.png>)
## CU-33 — Consultar estado de cobro y saldo

> UR: UR-07, UR-18, UR-56 · FR: FR-09, FR-47, FR-53

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-33 |
| **Nombre** | Consultar estado de cobro y saldo |
| **Objetivo** | Conocer de un vistazo el saldo, las facturas pendientes y pagadas de los clientes asignados y su trazabilidad, y hacer el seguimiento de cobros. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario tiene clientes asignados.

### 3. Flujo principal

1. **Lector:** abre el dashboard de saldo o la lista de facturas.
2. **Sistema:** muestra el saldo, las facturas pendientes y las pagadas de los clientes asignados.
3. **Lector:** filtra por estado de cobro.
4. **Lector:** abre una factura.
5. **Sistema:** muestra su historial, transiciones de estado y de dónde sale cada cifra.

---

### 4. Flujos alternativos

#### FA-1 — Enviar recordatorio manual

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El usuario quiere reclamar una factura.

1. El usuario envía un recordatorio de pago.

**Continuación:** termina.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Ninguna modificación; el saldo pendiente y la facturación acumulada se mantienen como conceptos distintos (RB-10).

---

## CU-34 — Registrar cobro notificado por la pasarela

> UR: UR-32 · FR: FR-25

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-34 |
| **Nombre** | Registrar cobro notificado por la pasarela |
| **Objetivo** | Recibir los eventos de pago de la pasarela, sin contabilizar dos veces un mismo evento, y permitir su consulta. |
| **Actores participantes** | Pasarela de pagos (principal), Lector |

---

### 2. Precondiciones

- PRE-1. Existe una factura pendiente con referencia de pago.

---

### 3. Flujo principal

1. **Pasarela de pagos:** notifica un evento de pago.
2. **Sistema:** comprueba que el evento no se ha procesado antes.
3. **Sistema:** registra la transacción y sus datos de confirmación.
4. **Sistema:** intenta conciliar con la factura (CU-35).
5. **Lector:** consulta los cobros notificados.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Evento repetido

**Se produce en:** paso 2.  
**Condición:** El evento ya fue procesado.

1. El sistema lo ignora y no lo contabiliza otra vez.

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. La transacción queda registrada una sola vez.
- POST-2. Al pasar la factura a pagada se guardan los datos de confirmación de la pasarela.

---

## CU-35 — Conciliar cobros

> UR: UR-28 · FR: FR-26, FR-27

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-35 |
| **Nombre** | Conciliar cobros |
| **Objetivo** | Revisar y conciliar los movimientos bancarios o de pasarela no conciliados automáticamente, o con importes parciales o excesivos. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. Existen cobros registrados.

### 3. Flujo principal

1. **Lector:** abre la bandeja de conciliación.
2. **Sistema:** muestra los movimientos sin conciliar o con importes parciales o excesivos.
3. **Lector:** asocia el movimiento con la factura correcta.
4. **Sistema:** registra la conciliación y actualiza el estado y el saldo.

---

### 4. Flujos alternativos

#### FA-1 — Deshacer una conciliación

**Se produce en:** paso 4 del flujo principal.  
**Condición:** Se asoció por error.

1. El usuario deshace la conciliación.
2. El sistema conserva la traza.

**Continuación:** vuelve al paso 3.

#### FA-2 — Importe parcial o excesivo

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El cobro no coincide con el total.

1. El sistema registra el pago parcial o deja el excedente pendiente (Q-12).

**Continuación:** continúa en el paso 4.

---

### 5. Flujos de excepción

#### FE-1 — Referencia ambigua

**Se produce en:** paso 2.  
**Condición:** La referencia no identifica una única factura.

1. El sistema deriva el movimiento a revisión manual.

**Resultado:** el usuario decide.

---

### 6. Postcondiciones

- POST-1. Cobros y facturas quedan conciliados con traza.

---

## CU-36 — Dar de baja contable una deuda

> UR: UR-27 · FR: FR-24

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-36 |
| **Nombre** | Dar de baja contable una deuda |
| **Objetivo** | Clasificar una deuda como «anulada» o «incobrable» con aprobación y motivo. |
| **Actores participantes** | Administrador (principal), Superadministrador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. La factura tiene deuda pendiente.
- PRE-3. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** solicita la baja contable e indica motivo y tipo.
2. **Sistema:** envía la solicitud a aprobación.
3. **Superadministrador:** aprueba la solicitud.
4. **Sistema:** registra la baja y excluye la deuda de los recordatorios.

---

### 4. Flujos alternativos

#### FA-1 — Rechazo

**Se produce en:** paso 3 del flujo principal.  
**Condición:** Se rechaza la solicitud.

1. La deuda permanece sin cambios.

**Continuación:** termina.

---

### 5. Flujos de excepción

#### FE-1 — Marcar como pagada

**Se produce en:** paso 1.  
**Condición:** Se intenta clasificarla como «pagada».

1. El sistema lo impide (RB-08).

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. La deuda queda anulada o incobrable, nunca como pagada.

---


# Área 7 — Notificaciones y colaboración

![Diagrama de casos de uso — Notificaciones y colaboración](<casos de uso/diagramas/diagrama_CU_area07_notificaciones_y_colaboracion.png>)
## CU-37 — Consultar pantalla de trabajo, notificaciones y alertas

> UR: UR-33, UR-34, UR-92, UR-93, UR-94, UR-95 · FR: FR-28, FR-30, FR-80

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-37 |
| **Nombre** | Consultar pantalla de trabajo, notificaciones y alertas |
| **Objetivo** | Disponer de una pantalla de trabajo diaria con las tareas, notificaciones y alertas pendientes, atenderlas con pocos clics y distinguir las leídas de las resueltas. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.

---

### 3. Flujo principal

1. **Lector:** abre la pantalla de trabajo.
2. **Sistema:** muestra las tareas, notificaciones y alertas pendientes de sus clientes, con prioridad.
3. **Lector:** accede directamente al elemento afectado y lo atiende.
4. **Lector:** marca la notificación como leída o resuelta.
5. **Sistema:** actualiza el estado.

---

### 4. Flujos alternativos

#### FA-1 — Alerta de deuda sobre el límite

**Se produce en:** paso 3 del flujo principal.  
**Condición:** La alerta indica que la deuda de un cliente supera el límite económico permitido.

1. El sistema bloquea nuevas acciones sobre ese cliente hasta que se regularice la deuda.

**Continuación:** continúa en el paso 4.

#### FA-2 — Fallos repetidos de envío

**Se produce en:** paso 3 del flujo principal.  
**Condición:** La alerta indica fallos repetidos de envío hacia un contacto (a partir de 3 fallos consecutivos).

1. El usuario corrige los datos de entrega del contacto (CU-28).

**Continuación:** continúa en el paso 4.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Las notificaciones y alertas reflejan su estado leída o resuelta.

---

## CU-38 — Configurar notificaciones y alertas

> UR: UR-35, UR-92, UR-93, UR-94, UR-95 · FR: FR-29, FR-80

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-38 |
| **Nombre** | Configurar notificaciones y alertas |
| **Objetivo** | Configurar los canales y preferencias de notificación y los umbrales de las alertas. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.

### 3. Flujo principal

1. **Superadministrador:** abre la configuración de notificaciones.
2. **Superadministrador:** elige canales (in-app, email, resumen diario).
3. **Superadministrador:** configura los umbrales de alerta (días de vencimiento, límite de deuda, fallos de envío, antigüedad de revisiones).
4. **Sistema:** valida y guarda.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Las notificaciones se emiten según la configuración.
- POST-2. La alerta por fallos de envío salta a partir de 3 fallos consecutivos.

---

## CU-39 — Buscar clientes y facturas

> UR: UR-37 · FR: FR-33

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-39 |
| **Nombre** | Buscar clientes y facturas |
| **Objetivo** | Realizar búsquedas globales rápidas y guardar vistas o filtros frecuentes. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.

---

### 3. Flujo principal

1. **Lector:** escribe un criterio en la búsqueda global.
2. **Sistema:** muestra clientes y facturas coincidentes a los que el usuario tiene acceso.
3. **Lector:** aplica filtros.
4. **Lector:** guarda la vista.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Sin resultados

**Se produce en:** paso 2.  
**Condición:** No hay coincidencias.

1. El sistema lo indica.

**Resultado:** el usuario ajusta el criterio.

---

### 6. Postcondiciones

- POST-1. La vista guardada queda disponible.

---

## CU-40 — Gestionar incidencias de facturación y de cobro

> UR: UR-50, UR-99 · FR: FR-25, FR-94, FR-109

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-40 |
| **Nombre** | Gestionar incidencias de facturación y de cobro |
| **Objetivo** | Abrir y seguir incidencias de facturación sobre un cliente, e identificar y resolver las incidencias técnicas de los procesos de cobro; el Administrador puede pausar recordatorios desde la incidencia. |
| **Actores participantes** | Lector (principal), Administrador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario tiene acceso al cliente.

### 3. Flujo principal

1. **Lector:** abre una incidencia sobre un cliente o factura.
2. **Sistema:** la registra con su estado.
3. **Lector:** la actualiza durante su seguimiento.
4. **Lector:** la cierra al resolverse.

---

### 4. Flujos alternativos

#### FA-1 — Pausar recordatorios

**Se produce en:** paso 3 del flujo principal.  
**Condición:** La incidencia afecta a facturas con recordatorios.

1. El Administrador pausa los recordatorios de las facturas afectadas (RB-22).

**Continuación:** continúa en el paso 3.

#### FA-2 — Incidencia generada por un fallo en un proceso de cobro

**Se produce en:** paso 1 del flujo principal.  
**Condición:** Un proceso de cobro falla para un cliente.

1. El sistema notifica el fallo al responsable y aísla al cliente con error sin detener el resto del proceso.
2. El sistema registra una incidencia asociada al cliente.

**Continuación:** continúa en el paso 3.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. La incidencia queda cerrada con su historial. Es un seguimiento interno, no un sistema de tickets para clientes (RB-20).
- POST-2. El resto de clientes se procesa con normalidad y el fallo queda registrado.

---

## CU-41 — Comentar internamente

> UR: UR-69 · FR: FR-90

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-41 |
| **Nombre** | Comentar internamente |
| **Objetivo** | Comentar internamente en clientes, facturas e incidencias, con notas restringidas cuando proceda. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario tiene acceso al elemento.

### 3. Flujo principal

1. **Lector:** escribe un comentario.
2. **Lector:** opcionalmente lo marca como restringido.
3. **Sistema:** lo guarda con autor y fecha.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Los comentarios no se envían al cliente y las notas restringidas solo las ven los administradores (RB-32).

---


# Área 8 — Informes y contabilidad

![Diagrama de casos de uso — Informes y contabilidad](<casos de uso/diagramas/diagrama_CU_area08_informes_y_contabilidad.png>)
## CU-42 — Consultar dashboard financiero

> UR: UR-36 · FR: FR-31

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-42 |
| **Nombre** | Consultar dashboard financiero |
| **Objetivo** | Consultar un dashboard con cifras reales de facturación y cobro. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** abre el dashboard.
2. **Sistema:** muestra facturación, cobros, impagos y comparativa con objetivos.
3. **Administrador:** aplica filtros de periodo.
4. **Sistema:** actualiza las cifras.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Ninguna modificación.

---

## CU-43 — Generar y exportar informes

> UR: UR-36, UR-51, UR-76, UR-100 · FR: FR-32, FR-50, FR-85, FR-95

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-43 |
| **Nombre** | Generar y exportar informes |
| **Objetivo** | Generar informes financieros y operativos filtrables y exportarlos a CSV y PDF, incluyendo resúmenes semanales o mensuales y facturas fallidas de meses anteriores. |
| **Actores participantes** | Lector (principal), Administrador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario tiene permiso para ver los datos del informe.

### 3. Flujo principal

1. **Lector:** elige el tipo de informe y los filtros.
2. **Sistema:** genera el informe con los datos a los que el usuario tiene acceso.
3. **Sistema:** aplica, si procede, el tipo de cambio registrado a la moneda base sin alterar el total legal.
4. **Lector:** exporta a CSV o PDF.
5. **Sistema:** genera el fichero temporal y registra la exportación.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Exportación masiva

**Se produce en:** paso 4.  
**Condición:** La exportación es masiva.

1. El sistema la audita e incrusta quién y cuándo la descargó (CU-52).

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. El fichero temporal se elimina al caducar el tiempo de retención configurado (RB-19).

---

## CU-44 — Programar informes periódicos (opcional)

> UR: UR-111 · FR: FR-102
> Opcional (A-16).

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-44 |
| **Nombre** | Programar informes periódicos (opcional) |
| **Objetivo** | Programar informes periódicos y su envío a las personas indicadas. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** elige un informe, su periodicidad y destinatarios.
2. **Sistema:** valida que los destinatarios tienen permiso.
3. **Sistema:** genera y envía el informe en cada periodo con un enlace autenticado (A-15).

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Destinatario sin permiso

**Se produce en:** paso 2.  
**Condición:** Un destinatario no puede ver el detalle de clientes (RB-33).

1. El sistema no permite incluirlo.

**Resultado:** el administrador elige otro.

---

### 6. Postcondiciones

- POST-1. El informe se envía periódicamente.

---

## CU-45 — Fijar objetivos de facturación y cobro

> UR: UR-71 · FR: FR-82

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-45 |
| **Nombre** | Fijar objetivos de facturación y cobro |
| **Objetivo** | Fijar objetivos mensuales y anuales de facturación y cobro. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** abre los objetivos.
2. **Administrador:** introduce o modifica objetivos mensuales o anuales.
3. **Sistema:** guarda el objetivo con histórico de cambios.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Los objetivos quedan registrados y alimentan el dashboard.

---

## CU-46 — Generar paquete contable del periodo

> UR: UR-84, UR-85, UR-86 · FR: FR-77

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-46 |
| **Nombre** | Generar paquete contable del periodo |
| **Objetivo** | Generar y descargar en un solo archivo toda la información y PDF contables del periodo, y consultar su autoría y versión. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El periodo está cerrado o finalizado.
- PRE-3. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** selecciona el periodo y solicita el paquete contable.
2. **Sistema:** genera un archivo ZIP/CSV con la información y PDF contables.
3. **Sistema:** registra fecha, autor, periodo y versión.
4. **Administrador:** descarga el paquete.
5. **Administrador:** puede consultar la fecha y autoría de la última generación para confirmar su envío a la gestoría.

---

### 4. Flujos alternativos

#### FA-1 — Regenerar

**Se produce en:** paso 1 del flujo principal.  
**Condición:** Ya existía un paquete del periodo.

1. El sistema genera una nueva versión, claramente distinta de la inicial.

**Continuación:** continúa en el paso 3.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. El paquete queda registrado con su versión.

---

## CU-47 — Consultar eficiencia operativa

> UR: UR-101 · FR: FR-96

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-47 |
| **Nombre** | Consultar eficiencia operativa |
| **Objetivo** | Evaluar la eficiencia operativa con un dashboard de métricas de uso. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.
- PRE-3. El sistema recopila de forma continua métricas de uso anónimas (FR-96).

### 3. Flujo principal

1. **Superadministrador:** abre el dashboard de eficiencia operativa.
2. **Sistema:** muestra las métricas de uso anónimas.
3. **Superadministrador:** filtra por periodo.
4. **Sistema:** actualiza las cifras.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Ninguna modificación; las métricas son anónimas.

---


# Área 9 — Usuarios, seguridad y auditoría

![Diagrama de casos de uso — Usuarios, seguridad y auditoría](<casos de uso/diagramas/diagrama_CU_area09_usuarios_seguridad_y_auditoria.png>)
## CU-48 — Acceder al sistema

> UR: UR-40, UR-41, UR-60 · FR: FR-36, FR-38, FR-58, FR-72

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-48 |
| **Nombre** | Acceder al sistema |
| **Objetivo** | Acceder con credenciales corporativas, recuperar la contraseña y mantener la sesión de forma segura. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario tiene una cuenta creada por un administrador (no hay autorregistro).

---

### 3. Flujo principal

1. **Lector:** introduce sus credenciales corporativas.
2. **Sistema:** autentica al usuario y abre la sesión.
3. **Sistema:** comprueba los permisos en cada acceso a cliente o factura.
4. **Lector:** usa el sistema.
5. **Sistema:** cierra la sesión tras la inactividad (30 minutos, A-06).

---

### 4. Flujos alternativos

#### FA-1 — Recuperar contraseña

**Se produce en:** paso 1 del flujo principal.  
**Condición:** El usuario olvidó la contraseña.

1. El usuario solicita recuperarla.
2. El sistema envía un enlace temporal.
3. El usuario fija una contraseña nueva.

**Continuación:** continúa en el paso 1.

---

### 5. Flujos de excepción

#### FE-1 — Intentos fallidos

**Se produce en:** paso 2.  
**Condición:** Cinco intentos fallidos consecutivos (A-07).

1. El sistema bloquea el acceso 15 minutos.

**Resultado:** el usuario espera o recupera la contraseña.

#### FE-2 — Enlace caducado

**Se produce en:** paso 2 de FA-1.  
**Condición:** El enlace tiene más de 24 horas (A-18).

1. El sistema rechaza el enlace.

**Resultado:** el usuario solicita otro.

---

### 6. Postcondiciones

- POST-1. El usuario accede solo a lo permitido por su rol.

---

## CU-49 — Gestionar usuarios

> UR: UR-40 · FR: FR-37, FR-39

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-49 |
| **Nombre** | Gestionar usuarios |
| **Objetivo** | Crear, invitar y desactivar usuarios internos conservando el rastro de sus acciones. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador o Superadministrador.

### 3. Flujo principal

1. **Administrador:** crea o invita a un usuario y le asigna su rol.
2. **Sistema:** envía la invitación.
3. **Administrador:** desactiva a un usuario que ya no debe acceder.
4. **Sistema:** bloquea su acceso conservando su histórico de auditoría.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Rol superior al propio

**Se produce en:** paso 1.  
**Condición:** El Administrador intenta crear un Superadministrador.

1. El sistema lo impide (A-19).

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. El usuario queda creado o desactivado y la acción auditada.

---

## CU-50 — Asignar y delegar clientes

> UR: UR-42, UR-43, UR-44 · FR: FR-39, FR-40, FR-41

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-50 |
| **Nombre** | Asignar y delegar clientes |
| **Objetivo** | Asignar, reasignar y delegar temporalmente clientes a usuarios, limitando al Lector a su cartera. |
| **Actores participantes** | Administrador (principal), Planificador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** selecciona clientes y un usuario responsable.
2. **Sistema:** asigna o reasigna, trasladando al nuevo responsable las tareas pendientes y el histórico.
3. **Administrador:** opcionalmente delega los clientes en un suplente indicando la fecha de fin.
4. **Sistema:** concede acceso temporal y lo revoca al caducar.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Delegación expirada

**Se produce en:** tras la fecha de fin.  
**Condición:** La delegación llega a su fecha de caducidad.

1. El Planificador revoca el acceso del suplente.

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. El Lector solo opera sobre los clientes que tiene asignados (RB-15).

---

## CU-51 — Descargar documentos autorizados

> UR: UR-48 · FR: FR-45

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-51 |
| **Nombre** | Descargar documentos autorizados |
| **Objetivo** | Descargar únicamente los documentos para los que el usuario tiene permisos válidos. |
| **Actores participantes** | Lector (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.

---

### 3. Flujo principal

1. **Lector:** solicita descargar un documento.
2. **Sistema:** comprueba el permiso del usuario sobre el cliente o la factura.
3. **Sistema:** genera un enlace temporal que caduca.
4. **Lector:** descarga el documento.
5. **Sistema:** registra quién, cuándo y qué se ha descargado.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Sin permiso

**Se produce en:** paso 2.  
**Condición:** El usuario no está autorizado.

1. El sistema deniega la descarga.

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. El documento solo lo ha descargado un usuario autorizado.
- POST-2. La descarga queda registrada.

---

## CU-52 — Consultar auditoría de negocio y exportaciones

> UR: UR-46, UR-90, UR-91 · FR: FR-43, FR-79

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-52 |
| **Nombre** | Consultar auditoría de negocio y exportaciones |
| **Objetivo** | Consultar y filtrar los registros de auditoría de negocio, incluidas las exportaciones masivas y las descargas de ficheros, sin poder alterar el pasado. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.

### 3. Flujo principal

1. **Superadministrador:** abre la auditoría.
2. **Sistema:** muestra las operaciones clave.
3. **Superadministrador:** filtra por usuario, fecha, tipo u objeto.
4. **Sistema:** muestra el detalle.

---

### 4. Flujos alternativos

#### FA-1 — Consultar exportaciones masivas y descargas

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El Superadministrador quiere saber quién exportó o descargó ficheros de datos.

1. El Superadministrador filtra por exportaciones masivas.
2. El sistema muestra qué usuario exportó, con qué criterios, y quién y cuándo descargó cada fichero.

**Continuación:** termina al cerrar la consulta.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. La auditoría es inalterable; solo se consulta.

---

## CU-53 — Gestionar copias de seguridad

> UR: UR-47 · FR: FR-44

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-53 |
| **Nombre** | Gestionar copias de seguridad |
| **Objetivo** | Disponer de copias de seguridad automáticas y restaurarlas de forma demostrable. |
| **Actores participantes** | Superadministrador (principal), Planificador |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.

### 3. Flujo principal

1. **Planificador:** periódicamente realiza copias automáticas de datos y documentos.
2. **Superadministrador:** consulta el estado de las copias.
3. **Superadministrador:** solicita restaurar una copia.
4. **Sistema:** restaura y confirma el resultado.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Restauración fallida

**Se produce en:** paso 4.  
**Condición:** La restauración falla.

1. El sistema informa del error sin alterar los datos actuales.

**Resultado:** el Superadministrador reintenta con otra copia.

---

### 6. Postcondiciones

- POST-1. Los datos quedan restaurados a la copia elegida y la restauración auditada.

---


# Área 10 — Configuración y sistema

![Diagrama de casos de uso — Configuración y sistema](<casos de uso/diagramas/diagrama_CU_area10_configuracion_y_sistema.png>)
## CU-54 — Gestionar configuración global

> UR: UR-14, UR-65, UR-66, UR-72, UR-73, UR-103, UR-110 · FR: FR-12, FR-65, FR-66, FR-83, FR-84, FR-98, FR-103, FR-104

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-54 |
| **Nombre** | Gestionar configuración global |
| **Objetivo** | Gestionar la configuración global del sistema con cambios validados y auditados: umbrales de aprobación, plazos, calendario y monedas, datos fiscales del emisor, logo y plantilla de facturas. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.

### 3. Flujo principal

1. **Superadministrador:** modifica un parámetro global.
2. **Sistema:** valida el cambio.
3. **Superadministrador:** confirma.
4. **Sistema:** aplica el cambio desde el momento de su validación (Q-07) y lo audita.

---

### 4. Flujos alternativos

#### FA-1 — Configurar los umbrales de aprobación

**Se produce en:** paso 1 del flujo principal.  
**Condición:** El parámetro es el umbral económico o el nivel de aprobación de las excepciones (UR-14).

1. El Superadministrador modifica los umbrales y los niveles de aprobación.
2. El sistema valida y guarda el cambio.

**Continuación:** continúa en el paso 4. Los nuevos umbrales se aplican a las propuestas posteriores (Q-01).

#### FA-2 — Configurar plazos, calendario y monedas

**Se produce en:** paso 1 del flujo principal.  
**Condición:** El parámetro es el plazo de pago, el calendario laboral o las monedas de emisión (UR-72, UR-73).

1. El Superadministrador define el plazo de pago, el calendario laboral y las monedas.
2. El sistema aplica el calendario trasladando al siguiente día laborable las comunicaciones que caigan en fin de semana o festivo.

**Continuación:** continúa en el paso 4. Las facturas nuevas se emiten en la moneda indicada conservando su importe original.

#### FA-3 — Configurar los datos fiscales del emisor y las sociedades

**Se produce en:** paso 1 del flujo principal.  
**Condición:** El parámetro son los datos fiscales del emisor, o las sociedades emisoras si Turbine factura desde varias (UR-65, UR-66, opcional).

1. El Superadministrador introduce los datos fiscales de cada sociedad emisora.
2. El sistema valida y guarda; las sociedades quedan disponibles para elegir al emitir una factura (CU-15).

**Continuación:** continúa en el paso 4.

#### FA-4 — Configurar logo y plantilla de las facturas

**Se produce en:** paso 1 del flujo principal.  
**Condición:** El parámetro es el logo o la plantilla de las facturas.

1. El Superadministrador sube el logo y edita la plantilla.
2. El sistema valida y guarda.

**Continuación:** continúa en el paso 4. Las facturas ya emitidas no cambian (RB-07).

#### FA-5 — Desactivar las funciones de apoyo con IA (opcional)

**Se produce en:** paso 1 del flujo principal.  
**Condición:** El Superadministrador quiere desactivar las funciones de apoyo basadas en IA.

1. El Superadministrador las desactiva.
2. El cálculo financiero sigue siendo determinista y nunca depende de IA.

**Continuación:** continúa en el paso 4.

---

### 5. Flujos de excepción

#### FE-1 — Cambio inválido

**Se produce en:** paso 2.  
**Condición:** El valor no supera la validación.

1. El sistema rechaza el cambio.

**Resultado:** el usuario corrige.

---

### 6. Postcondiciones

- POST-1. Lo ya emitido no se modifica (RB-12).

---

## CU-55 — Cargar datos de demostración (opcional)

> UR: UR-74 · FR: FR-91
> Opcional.

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-55 |
| **Nombre** | Cargar datos de demostración (opcional) |
| **Objetivo** | Cargar datos ficticios para demostraciones sin mezclarlos con los de producción. |
| **Actores participantes** | Superadministrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Superadministrador.

### 3. Flujo principal

1. **Superadministrador:** solicita cargar datos de demostración.
2. **Sistema:** los carga en un espacio separado.
3. **Superadministrador:** puede eliminarlos al terminar.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Los datos de demostración no se mezclan con los de producción.

---

## CU-56 — Consultar estado del sistema y errores

> UR: UR-58, UR-62, UR-63 · FR: FR-56, FR-62, FR-63, FR-86, FR-101

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-56 |
| **Nombre** | Consultar estado del sistema y errores |
| **Objetivo** | Conocer el estado del sistema y localizar la causa de un error a partir de su código de incidencia. |
| **Actores participantes** | Administrador (principal) |

---

### 2. Precondiciones

- PRE-1. El usuario ha iniciado sesión.
- PRE-2. El usuario es Administrador.

### 3. Flujo principal

1. **Administrador:** abre el estado del sistema.
2. **Sistema:** muestra emails pendientes, errores de integración, último backup y última generación recurrente.
3. **Administrador:** abre un error con su código de incidencia.
4. **Sistema:** muestra la correlación técnica.

---

### 4. Flujos alternativos

#### FA-1 — Error de un usuario

**Se produce en:** paso 3 del flujo principal.  
**Condición:** Un usuario ve un error.

1. El sistema le muestra un mensaje comprensible sin detalles técnicos y le da el código de incidencia.

**Continuación:** el administrador lo localiza.

---

### 5. Flujos de excepción

No se identifican flujos de excepción relevantes.

---

### 6. Postcondiciones

- POST-1. Los errores técnicos quedan registrados con su código.

---


# Área 11 — API externa

![Diagrama de casos de uso — API externa](<casos de uso/diagramas/diagrama_CU_area11_api_externa.png>)
## CU-57 — Consultar datos mediante la API

> UR: UR-61 · FR: FR-59, FR-61

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-57 |
| **Nombre** | Consultar datos mediante la API |
| **Objetivo** | Consultar clientes, estado de deuda, facturas y otros datos desde un sistema externo. |
| **Actores participantes** | Sistema externo (principal) |

---

### 2. Precondiciones

- PRE-1. El consumidor tiene credenciales de API válidas (NFR-50).

---

### 3. Flujo principal

1. **Sistema externo:** solicita datos.
2. **Sistema:** autentica al consumidor.
3. **Sistema:** comprueba los permisos y el límite de solicitudes.
4. **Sistema:** devuelve los datos y registra la llamada.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Límite superado

**Se produce en:** paso 3.  
**Condición:** El consumidor supera su límite.

1. El sistema rechaza la solicitud.

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. La llamada queda registrada.

---

## CU-58 — Enviar solicitud mediante la API

> UR: UR-61 · FR: FR-60

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-58 |
| **Nombre** | Enviar solicitud mediante la API |
| **Objetivo** | Enviar solicitudes controladas desde un sistema externo, como la baja de un cliente. |
| **Actores participantes** | Sistema externo (principal) |

---

### 2. Precondiciones

- PRE-1. El consumidor tiene credenciales de API válidas.

---

### 3. Flujo principal

1. **Sistema externo:** envía una solicitud.
2. **Sistema:** la valida y aplica las mismas reglas de negocio que la interfaz.
3. **Sistema:** la deja pendiente de validación o aprobación.
4. **Sistema:** informa del resultado.

---

### 4. Flujos alternativos

No se identifican flujos alternativos relevantes.

---

### 5. Flujos de excepción

#### FE-1 — Solicitud inválida

**Se produce en:** paso 2.  
**Condición:** No cumple las reglas de negocio.

1. El sistema la rechaza.

**Resultado:** termina.

---

### 6. Postcondiciones

- POST-1. La solicitud no modifica datos directamente (RB-31).

---


