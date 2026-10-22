# Especificación de Casos de Uso

---

## CU-46 — Consultar y filtrar auditoría del sistema

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-46 |
| **Nombre** | Consultar y filtrar auditoría del sistema |
| **Objetivo** | Permitir al Superadministrador auditar de forma inmutable los registros de actividad para conocer quién realizó cada acción, cuándo y por qué. |
| **Actores participantes** | Superadministrador (principal) |
| **Requisito asociado** | UR-46 (FR-92, BR-02) |

---

### 2. Precondiciones

- PRE-1. El Superadministrador ha iniciado sesión y se encuentra autenticado.
- PRE-2. El sistema dispone de registros de auditoría generados previamente.

---

### 3. Flujo principal

1. **Actor:** Accede al panel de auditoría general del sistema.
2. **Sistema:** Muestra el listado de registros de auditoría en orden cronológico inverso, incluyendo campos de usuario, acción realizada, fecha/hora y motivo/justificación.
3. **Actor:** Aplica uno o varios filtros de búsqueda (rango de fechas, tipo de acción, usuario o término clave).
4. **Sistema:** Filtra y presenta los registros que coinciden con los criterios establecidos.
5. **Actor:** Selecciona un registro específico para examinar el detalle completo de la traza de auditoría.
6. **Sistema:** Muestra la vista detallada e inmutable de la traza seleccionada.

---

### 4. Flujos alternativos

#### FA-1 — Exportación de trazas de auditoría

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El Superadministrador solicita descargar los registros filtrados.

1. El Superadministrador hace clic en la opción de exportar informe de auditoría.
2. El sistema genera el archivo correspondiente incluyendo la marca de agua y metadatos de trazabilidad de la consulta.
3. El sistema entrega el archivo para su descarga.

**Continuación:** El caso de uso finaliza.

---

### 5. Flujos de excepción

#### FE-1 — No existen registros para los filtros seleccionados

**Se produce en:** paso 4 del flujo principal.  
**Condición:** Los filtros aplicados no retornan ninguna coincidencia.

1. El sistema muestra un mensaje indicando que no se han encontrado registros de auditoría con los criterios especificados.
2. El sistema mantiene los filtros activos para que el usuario pueda modificarlos.

**Resultado:** El Superadministrador puede ajustar los parámetros y volver al paso 3.

---

### 6. Postcondiciones

- POST-1. La consulta queda registrada en la propia auditoría del sistema.
- POST-2. El histórico de auditoría permanece completamente inalterado e inmutable.

---

## CU-69 — Gestionar comentarios e insertar notas restringidas

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-69 |
| **Nombre** | Gestionar comentarios e insertar notas restringidas |
| **Objetivo** | Permitir registrar comentarios internos en clientes, facturas o incidencias, soportando un nivel de visibilidad restringido exclusivo para administradores. |
| **Actores participantes** | Lector, Administrador (principales) |
| **Requisito asociado** | UR-69 (FR-194) |

---

### 2. Precondiciones

- PRE-1. El usuario está autenticado y se encuentra en la vista detallada de una entidad (cliente, factura o incidencia).

---

### 3. Flujo principal

1. **Actor:** Accede a la sección de comentarios de la entidad seleccionada.
2. **Sistema:** Muestra el hilo de comentarios existentes según la visibilidad del rol del usuario.
3. **Actor:** Redacta un nuevo comentario.
4. **Actor (Administrador):** Selecciona el nivel de visibilidad de la nota ("Ordinaria" o "Restringida a Administradores").
5. **Actor:** Confirma la publicación del comentario.
6. **Sistema:** Guarda el comentario asociando el usuario, fecha/hora y nivel de visibilidad seleccionado.
7. **Sistema:** Muestra el comentario publicado en el hilo correspondiente.

---

### 4. Flujos alternativos

#### FA-1 — Publicación de comentario por rol Lector

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El usuario actual tiene el rol Lector.

1. El sistema no muestra la opción de marcar la nota como restringida.
2. El comentario se publica por defecto con nivel de visibilidad "Ordinario".

**Continuación:** El caso de uso continúa en el paso 5 del flujo principal.

---

### 5. Flujos de excepción

#### FE-1 — Intento de acceso a nota restringida por usuario no autorizado

**Se produce en:** paso 2 del flujo principal.  
**Condición:** Existe una nota restringida y el usuario tiene rol Lector.

1. El sistema filtra y oculta de la interfaz las notas clasificadas como "Restringidas".
2. El usuario Lector solo visualiza las notas ordinarias.

**Resultado:** Se preserva la privacidad de las notas administrativas sin interrumpir el flujo.

---

### 6. Postcondiciones

- POST-1. El comentario queda almacenado en la entidad correspondiente con su nivel de visibilidad asignado.

---

## CU-71 — Programar informes periódicos y fijar objetivos de facturación y cobro

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-71 |
| **Nombre** | Programar informes periódicos y fijar objetivos de facturación y cobro |
| **Objetivo** | Configurar el envío automático de informes periódicos y establecer metas mensuales o anuales con trazabilidad de cambios. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-71 (FR-186) |

---

### 2. Precondiciones

- PRE-1. El Administrador dispone de permisos para gestionar la planificación estratégica e informes.

---

### 3. Flujo principal

1. **Actor:** Accede al módulo de programación de informes y gestión de objetivos.
2. **Actor:** Define los parámetros de los informes periódicos (frecuencia, destinatarios y tipo de reporte).
3. **Actor:** Introduce o actualiza los objetivos económicos (mensuales o anuales) de facturación y cobro.
4. **Sistema:** Valida los datos introducidos y registra la versión actual de los objetivos, conservando el histórico anterior para comparativas.
5. **Sistema:** Confirma la correcta programación de los informes y el almacenamiento de los objetivos.

---

### 4. Flujos alternativos

#### FA-1 — Consulta de histórico de cambios de objetivos

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El Administrador solicita ver las modificaciones históricas de los objetivos.

1. El Administrador selecciona la opción "Ver histórico de objetivos".
2. El sistema muestra los valores previos fijados en ejercicios o periodos pasados.

**Continuación:** El caso de uso regresa al paso 3 del flujo principal.

---

### 5. Flujos de excepción

#### FE-1 — Incongruencia en los parámetros del periodo de informe

**Se produce en:** paso 4 del flujo principal.  
**Condición:** Las fechas o la frecuencia programada contienen incoherencias.

1. El sistema detecta el fallo en la definición del periodo.
2. El sistema notifica el error especificando el campo incorrecto.
3. El Administrador corrige los parámetros.

**Resultado:** El flujo se retoma en el paso 4 del flujo principal.

---

### 6. Postcondiciones

- POST-1. Queda programada la ejecución y distribución automatizada de los informes.
- POST-2. Los objetivos económicos quedan registrados con trazabilidad de cambios para no falsear datos históricos.

---

## CU-72 — Configurar sistema de plazos, recordatorios y calendario laboral

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-72 |
| **Nombre** | Configurar sistema de plazos, recordatorios y calendario laboral |
| **Objetivo** | Definir reglas globales de plazos de pago, frecuencia de recordatorios y gestionar el calendario de días laborables para el desplazamiento de comunicaciones. |
| **Actores participantes** | Superadministrador (principal) |
| **Requisito asociado** | UR-72 (FR-187) |

---

### 2. Precondiciones

- PRE-1. El Superadministrador está en el panel de configuración global del sistema.

---

### 3. Flujo principal

1. **Actor:** Accede a la configuración del sistema de plazos y calendario.
2. **Actor:** Ajusta los valores de plazos de pago estándar y cadencias de recordatorios.
3. **Actor:** Configura el calendario laboral registrando los días festivos o no lectivos.
4. **Actor:** Activa la regla de desplazamiento automático de avisos al siguiente día laborable cuando la fecha programada coincida con fin de semana o festivo.
5. **Sistema:** Guarda la nueva configuración global.

---

### 4. Flujos alternativos

#### FA-1 — Importación masiva de festivos nacionales/locales

**Se produce en:** paso 3 del flujo principal.  
**Condición:** El Superadministrador carga un calendario externo (ej. archivo ICS o CSV).

1. El Superadministrador selecciona el archivo con la lista de días festivos.
2. El sistema valida e incorpora las fechas al calendario del sistema.

**Continuación:** El caso de uso continúa en el paso 4 del flujo principal.

---

### 5. Flujos de excepción

#### FE-1 — Formato de fecha o calendario no válido

**Se produce en:** paso 5 del flujo principal.  
**Condición:** Se detecta un conflicto en las fechas asignadas.

1. El sistema cancela la grabación de la configuración.
2. Muestra un mensaje detallando la incoherencia en las fechas introducidas.

**Resultado:** El Superadministrador corrige los datos e intenta guardar de nuevo.

---

### 6. Postcondiciones

- POST-1. Las notificaciones futuras se recalcularán automáticamente considerando los días laborables configurados.

---

## CU-75 — Localizar y anonimizar datos personales de contactos

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-75 |
| **Nombre** | Localizar y anonimizar datos personales de contactos |
| **Objetivo** | Permitir encontrar los datos personales de un contacto y ejecutar su anonimización cuando legalmente proceda, protegiendo el histórico contable. |
| **Actores participantes** | Administrador, Superadministrador (principales) |
| **Requisito asociado** | UR-75 (FR-207, BR-05) |

---

### 2. Precondiciones

- PRE-1. El usuario tiene privilegios para la gestión de privacidad y protección de datos.
- PRE-2. El contacto a gestionar está registrado en el sistema.

---

### 3. Flujo principal

1. **Actor:** Busca el contacto mediante su identificador o datos personales en el módulo de privacidad.
2. **Sistema:** Presenta la localización completa de los datos personales almacenados en la plataforma.
3. **Actor:** Solicita la anonimización de los datos de contacto con fines comerciales o de marketing.
4. **Sistema:** Desvincula o sustituye los datos identificativos del contacto por cadenas anonimizadas en el módulo de marketing.
5. **Sistema:** Conserva intacta la información legal e id de facturación asociada en las facturas e histórico contable emitido.
6. **Sistema:** Notifica la finalización exitosa del proceso de anonimización.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Cancelación de solicitud por incoherencia jurídica

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El contacto posee operaciones en trámite que impiden legalmente la anonimización.

1. El sistema bloquea el proceso.
2. Muestra un mensaje informando de que existen expedientes abiertos que impiden el borrado inmediato.

**Resultado:** Se aborta la operación manteniendo los datos sin modificar.

---

### 6. Postcondiciones

- POST-1. Los datos personales del contacto quedan anonimizados en la capa comercial/marketing.
- POST-2. El histórico contable y legal permanece inalterado.

---

## CU-76 — Consultar tipos de cambio y reglas de conversión de divisa

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-76 |
| **Nombre** | Consultar tipos de cambio y reglas de conversión de divisa |
| **Objetivo** | Permitir al Administrador visualizar las tasas de cambio de moneda base y las reglas de conversión aplicadas a la consolidación de reportes. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-76 (FR-189) |

---

### 2. Precondiciones

- PRE-1. El sistema opera con múltiples monedas e importes internacionales.

---

### 3. Flujo principal

1. **Actor:** Solicita acceso a la consulta de tipos de cambio y reglas de conversión.
2. **Sistema:** Muestra el listado de monedas configuradas, el tipo de cambio oficial aplicado con su fecha de registro y la moneda base de consolidación.
3. **Actor:** Selecciona un registro de divisa para auditar su histórico de conversión.
4. **Sistema:** Muestra la evolución del tipo de cambio sin alterar los totales legales de las facturas originales en sus divisas de origen.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Falta de tipo de cambio registrado para una fecha dada

**Se produce en:** paso 2 del flujo principal.  
**Condición:** No se encuentra una tasa de cambio asignada a un día específico.

1. El sistema emite un aviso alertando de la discrepancia.
2. Aplica la última tasa de cambio válida registrada en el sistema e informa de ello.

**Resultado:** El reporte se genera mostrando la advertencia correspondiente.

---

### 6. Postcondiciones

- POST-1. Los reportes financieros consolidados se muestran en la moneda base manteniendo el importe legal de las facturas intacto.

---

## CU-77 — Consultar trazabilidad y estado de entrega de mensajes

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-77 |
| **Nombre** | Consultar trazabilidad y estado de entrega de mensajes |
| **Objetivo** | Ofrecer visibilidad detallada sobre el estado individual de envío y entrega de cada comunicación emitida por el sistema. |
| **Actores participantes** | Lector, Administrador (principales) |
| **Requisito asociado** | UR-77 (FR-192) |

---

### 2. Precondiciones

- PRE-1. Existen mensajes o comunicaciones asociadas a envíos en la plataforma.

---

### 3. Flujo principal

1. **Actor:** Accede al registro de envíos y comunicaciones de una factura o cliente.
2. **Sistema:** Lista todos los mensajes relacionados con sus respectivos identificadores.
3. **Actor:** Selecciona un mensaje en particular.
4. **Sistema:** Muestra el detalle del estado de trazabilidad (en cola, enviado, entregado, fallido o reintentado) basándose en las confirmaciones recibidas del proveedor.

---

### 4. Flujos alternativos

#### FA-1 — Reintento manual de envío de un mensaje fallido

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El mensaje seleccionado está en estado "fallido" y el usuario es Administrador.

1. El Administrador solicita reintentar el envío.
2. El sistema vuelve a poner en cola el mensaje e incrementa el contador de reintentos.

**Continuación:** El caso de uso regresa al paso 2 del flujo principal.

---

### 5. Flujos de excepción

#### FE-1 — Proveedor externo no responde sobre el estado de la entrega

**Se produce en:** paso 4 del flujo principal.  
**Condición:** El conector externo de mensajería no devuelve la confirmación de recepción.

1. El sistema marca el estado del mensaje como "Enviado (sin confirmación de entrega)".
2. Informa al usuario de la ausencia de telemetría detallada por parte del proveedor.

**Resultado:** Se muestra el último estado conocido del mensaje.

---

### 6. Postcondiciones

- POST-1. La trazabilidad de la consulta se refleja en el visor de notificaciones.

---

## CU-78 — Consultar estado de solicitudes económicas en bandeja de entrada

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-78 |
| **Nombre** | Consultar estado de solicitudes económicas en bandeja de entrada |
| **Objetivo** | Proporcionar una bandeja donde el usuario revise la situación de sus solicitudes de operaciones económicas (aprobadas, rechazadas o pendientes). |
| **Actores participantes** | Administrador, Superadministrador (principales) |
| **Requisito asociado** | UR-78 (FR-167) |

---

### 2. Precondiciones

- PRE-1. El usuario ha realizado previamente al menos una solicitud económica en el sistema.

---

### 3. Flujo principal

1. **Actor:** Accede a la bandeja de entrada de solicitudes económicas.
2. **Sistema:** Recupera y presenta el listado de las solicitudes realizadas por el usuario, agrupadas o filtrables por estado: Pendiente, Aprobada o Rechazada.
3. **Actor:** Selecciona una solicitud específica para ver sus detalles.
4. **Sistema:** Muestra el desglose de la solicitud, incluyendo la fecha de petición, importe/operación solicitada y el estado actual.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Sin registros de solicitudes

**Se produce en:** paso 2 del flujo principal.  
**Condición:** El usuario no ha generado ninguna petición económica.

1. El sistema muestra la bandeja vacía indicando la ausencia de registros de solicitudes.

**Resultado:** El actor puede salir o navegar a otra sección.

---

### 6. Postcondiciones

- POST-1. El usuario obtiene una visión actualizada del estado de sus peticiones económicas.

---

## CU-79 — Consultar comentarios explicativos del aprobador

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-79 |
| **Nombre** | Consultar comentarios explicativos del aprobador |
| **Objetivo** | Mostrar la justificación textual introducida por el aprobador al autorizar o denegar una solicitud económica. |
| **Actores participantes** | Administrador, Superadministrador (principales) |
| **Requisito asociado** | UR-79 (FR-168) |

---

### 2. Precondiciones

- PRE-1. La solicitud económica examinada ha sido procesada previamente por un aprobador.

---

### 3. Flujo principal

1. **Actor:** Selecciona dentro de su bandeja de entrada una solicitud resuelta (aprobada o rechazada).
2. **Sistema:** Despliega el resumen de la resolución.
3. **Sistema:** Muestra de forma explícita el bloque de comentarios registrado por el aprobador, especificando el motivo de la decisión.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Ausencia no planificada de comentario explicativo

**Se produce en:** paso 3 del flujo principal.  
**Condición:** La solicitud fue procesada mediante un evento del sistema sin comentario registrado.

1. El sistema muestra la etiqueta "Sin comentarios adicionales por parte del aprobador".

**Resultado:** El usuario comprende el estado formal aunque no exista texto explicativo opcional.

---

### 6. Postcondiciones

- POST-1. Se garantiza la transparencia en la toma de decisiones sobre operaciones económicas.

---

## CU-80 — Validar segregación de funciones en aprobación de solicitudes

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-80 |
| **Nombre** | Validar segregación de funciones en aprobación de solicitudes |
| **Objetivo** | Garantizar la separación de funciones impidiendo que un usuario pueda autoaprobar sus propias solicitudes de operaciones económicas sensibles. |
| **Actores participantes** | Administrador, Superadministrador (principales) |
| **Requisito asociado** | UR-80 (FR-169) |

---

### 2. Precondiciones

- PRE-1. El usuario tiene rol de aprobador (Administrador/Superadministrador).
- PRE-2. Existe una solicitud económica pendiente en el sistema originada por este mismo usuario.

---

### 3. Flujo principal

1. **Actor:** Accede al listado general de solicitudes pendientes de aprobación.
2. **Actor:** Intenta seleccionar o ejecutar la acción de aprobación sobre una solicitud propia.
3. **Sistema:** Intercepta la acción y verifica la coincidencia entre la identidad del solicitante y la del aprobador.
4. **Sistema:** Deshabilita y bloquea la posibilidad de aprobar el registro por parte del propio autor.
5. **Sistema:** Informa al usuario de que la normativa exige que la aprobación sea realizada por un usuario diferente.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. La solicitud permanece en estado pendiente hasta que sea gestionada por un aprobador distinto.

---

## CU-81 — Ejecutar cierre formal de periodo contable

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-81 |
| **Nombre** | Ejecutar cierre formal de periodo contable |
| **Objetivo** | Permitir al Administrador dar por finalizado un mes o trimestre contable para congelar sus registros económicos. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-81 (FR-170) |

---

### 2. Precondiciones

- PRE-1. El periodo contable objetivo no ha sido cerrado previamente.
- PRE-2. No existen facturas ni borradores pendientes de emisión en dicho periodo.

---

### 3. Flujo principal

1. **Actor:** Selecciona el periodo contable a cerrar (mes o trimestre) en el panel contable.
2. **Sistema:** Realiza una verificación de integridad sobre las operaciones del periodo.
3. **Sistema:** Solicita confirmación explícita para la ejecución del cierre contable.
4. **Actor:** Confirma el cierre del periodo.
5. **Sistema:** Cambia el estado del periodo a "Cerrado" y bloquea las operaciones ordinarias de modificación.
6. **Sistema:** Emite una notificación de cierre exitoso.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Transacciones pendientes de conciliación o emisión

**Se produce en:** paso 2 del flujo principal.  
**Condición:** El sistema detecta elementos económicos huérfanos o borradores sin emitir en el periodo.

1. El sistema aborta el cierre del periodo.
2. Muestra la lista de transacciones o documentos pendientes que requieren resolución previa.

**Resultado:** El periodo se mantiene en estado abierto.

---

### 6. Postcondiciones

- POST-1. El periodo contable pasa a estado "Cerrado", inmovilizando los registros contenidos.

---

## CU-82 — Bloquear modificaciones en periodos contables cerrados

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-82 |
| **Nombre** | Bloquear modificaciones en periodos contables cerrados |
| **Objetivo** | Impedir que el sistema permita crear, alterar o borrar por error facturas o cobros de un periodo con cierre administrativo. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-82 (FR-171) |

---

### 2. Precondiciones

- PRE-1. El periodo contable correspondiente a la fecha de la operación pretendida está "Cerrado".

---

### 3. Flujo principal

1. **Actor:** Intenta crear, modificar o eliminar una factura o cobro con fecha perteneciente a un periodo cerrado.
2. **Sistema:** Verifica la fecha del documento e identifica que el periodo asociado se encuentra bloqueado por cierre.
3. **Sistema:** Detiene la ejecución de la acción de edición/creación/borrado.
4. **Sistema:** Muestra un aviso notificando que el periodo está cerrado y que la operación ha sido rechazada por seguridad contable.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. Los registros contables del periodo cerrado permanecen sin alteración alguna.

---

## CU-83 — Reabrir periodos contables cerrados

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-83 |
| **Nombre** | Reabrir periodos contables cerrados |
| **Objetivo** | Permitir la reapertura excepcional de un periodo contable cerrado requiriendo privilegios de Superadministrador y la justificación de un motivo obligatorio. |
| **Actores participantes** | Superadministrador (principal) |
| **Requisito asociado** | UR-83 (FR-172, BR-02) |

---

### 2. Precondiciones

- PRE-1. El usuario tiene el rol de Superadministrador.
- PRE-2. El periodo contable seleccionado se encuentra en estado "Cerrado".

---

### 3. Flujo principal

1. **Actor:** Solicita la reapertura de un periodo contable cerrado.
2. **Sistema:** Muestra una ventana emergente exigiendo la introducción obligatoria de un motivo justificado para la reapertura.
3. **Actor:** Escribe el motivo formal de la reapertura.
4. **Actor:** Confirma la acción de reapertura.
5. **Sistema:** Valida que el texto de la justificación no esté vacío.
6. **Sistema:** Cambia el estado del periodo a "Abierto" y registra en la auditoría inmutable el usuario, la hora y el motivo introducido.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Motivo de reapertura no cumplimentado

**Se produce en:** paso 5 del flujo principal.  
**Condición:** El usuario intenta confirmar el desbloqueo sin rellenar el campo de justificación.

1. El sistema rechaza la solicitud de reapertura.
2. Muestra un aviso de error indicando que el motivo es obligatorio.

**Resultado:** El periodo sigue cerrado hasta proporcionar el motivo exigido.

---

### 6. Postcondiciones

- POST-1. El periodo pasa a estado "Abierto".
- POST-2. La reapertura con su motivo queda reflejada inalterablemente en el log de auditoría.

---

## CU-84 — Generar y descargar paquete contable completo

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-84 |
| **Nombre** | Generar y descargar paquete contable completo |
| **Objetivo** | Recopilar y empaquetar en un único archivo comprimido (ZIP/CSV) toda la información y documentos PDF contables del periodo seleccionado. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-84 (FR-173, NFR-30) |

---

### 2. Precondiciones

- PRE-1. El Administrador ha seleccionado un periodo contable para la generación del paquete.

---

### 3. Flujo principal

1. **Actor:** Solicita la generación del paquete contable del periodo seleccionado.
2. **Sistema:** Inicia en segundo plano la recopilación de facturas emitidas, rectificativas, cobros y la generación de sus archivos PDF correspondientes.
3. **Sistema:** Embala los archivos en una estructura comprimida (ZIP/CSV).
4. **Sistema:** Informa mediante una notificación en la interfaz de que el paquete se encuentra listo para su descarga.
5. **Actor:** Procede a la descarga del archivo ZIP/CSV.

---

### 4. Flujos alternativos

#### FA-1 — Proceso de larga duración (Tarea pesada)

**Se produce en:** paso 2 del flujo principal.  
**Condición:** El volumen de facturas es muy elevado (cumple NFR-30).

1. El sistema notifica al usuario que el proceso se ejecutará en segundo plano.
2. La interfaz permanece totalmente operativa para que el Administrador continúe con otras tareas.
3. Al finalizar, el sistema emite una alerta visual notificando la disponibilidad del archivo.

**Continuación:** El caso de uso continúa en el paso 5 del flujo principal.

---

### 5. Flujos de excepción

#### FE-1 — Fallo en el empaquetado de archivos

**Se produce en:** paso 3 del flujo principal.  
**Condición:** Ocurre un error de lectura de algún documento PDF o exportación CSV.

1. El sistema detiene la preparación del lote.
2. Notifica al Administrador del error puntual ofreciendo la opción de reintentar.

**Resultado:** No se entrega un paquete incompleto.

---

### 6. Postcondiciones

- POST-1. El usuario descarga un archivo comprimido único con el lote completo de documentos del periodo.

---

## CU-85 — Consultar autoría y fecha de generación del paquete contable

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-85 |
| **Nombre** | Consultar autoría y fecha de generación del paquete contable |
| **Objetivo** | Registrar y mostrar la trazabilidad (usuario, fecha y hora) de la última exportación del paquete contable para confirmar su envío a gestoría. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-85 (FR-174) |

---

### 2. Precondiciones

- PRE-1. Se ha generado al menos un paquete contable para el periodo consultado.

---

### 3. Flujo principal

1. **Actor:** Accede al historial de paquetes contables del periodo.
2. **Sistema:** Recupera el registro de trazabilidad de las entregas generadas.
3. **Sistema:** Muestra de forma visible la fecha exactas, la hora y el nombre del Administrador que generó el último paquete contable.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. El Administrador verifica fehacientemente si el lote de datos fue generado previamente y quién fue responsable.

---

## CU-86 — Versionar paquetes contables de un mismo periodo

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-86 |
| **Nombre** | Versionar paquetes contables de un mismo periodo |
| **Objetivo** | Asignar e identificar una versión secuencial distinta cada vez que se regenere el paquete contable de un mismo periodo para evitar duplicidades. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-86 (FR-175) |

---

### 2. Precondiciones

- PRE-1. Existe previamente un paquete contable (Versión 1) generado para el periodo actual.

---

### 3. Flujo principal

1. **Actor:** Solicita la regeneración del paquete contable de un periodo que ya contaba con una exportación previa.
2. **Sistema:** Detecta la presencia de archivos anteriores de ese mismo periodo.
3. **Sistema:** Incrementa la numeración de la versión (ej. V1 -> V2).
4. **Sistema:** Genera el nuevo archivo identificándolo explícitamente con el nuevo número de versión en su nombre y metadatos.
5. **Sistema:** Muestra el listado de versiones disponibles para dicho periodo destacando la versión más reciente.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. El sistema conserva el histórico de versiones de los paquetes contables sin sobrescribir o confundir los envíos previos.

---

## CU-87 — Registrar idioma preferido de comunicación

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-87 |
| **Nombre** | Registrar idioma preferido de comunicación |
| **Objetivo** | Almacenar y gestionar la preferencia de idioma de los contactos para la emisión de notificaciones e impresos. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-87 (FR-176) |

---

### 2. Precondiciones

- PRE-1. El Administrador está editando o creando la ficha de un contacto.

---

### 3. Flujo principal

1. **Actor:** Selecciona el contacto a configurar.
2. **Actor:** Accede a las opciones de preferencias de comunicación.
3. **Actor:** Selecciona el idioma preferido dentro del catálogo de idiomas soportados.
4. **Actor:** Guarda los cambios.
5. **Sistema:** Almacena la preferencia de idioma asociada al contacto para futuras comunicaciones.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. Las comunicaciones automáticas generadas para este contacto se emitirán en el idioma configurado.

---

## CU-88 — Registrar canal preferido de notificaciones

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-88 |
| **Nombre** | Registrar canal preferido de notificaciones |
| **Objetivo** | Establecer el canal prioritario (Email, WhatsApp, Correo postal) para el envío de avisos e impresos de un contacto. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-88 (FR-177) |

---

### 2. Precondiciones

- PRE-1. El contacto dispone de los datos requeridos para los distintos canales (email, teléfono, dirección).

---

### 3. Flujo principal

1. **Actor:** Accede al apartado de configuración de canales del contacto.
2. **Actor:** Elige el canal preferido de entrega de notificaciones (ej. Correo Electrónico).
3. **Actor:** Asigna opcionalmente canales alternativos de respaldo.
4. **Sistema:** Guarda la preferencia del canal asignado.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. El sistema priorizará el canal seleccionado al despachar avisos automáticos al contacto.

---

## CU-89 — Gestionar permisos de envío y consentimiento por canal

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-89 |
| **Nombre** | Gestionar permisos de envío y consentimiento por canal |
| **Objetivo** | Administrar el consentimiento explícito e independiente para cada canal de comunicación acorde a las leyes de protección de datos. |
| **Actores participantes** | Administrador (principal) |
| **Requisito asociado** | UR-89 (FR-178, BR-05) |

---

### 2. Precondiciones

- PRE-1. Se dispone del registro o evidencia de consentimiento prestado por el cliente o contacto.

---

### 3. Flujo principal

1. **Actor:** Entra al módulo de gestión de GDPR/RGPD del contacto.
2. **Sistema:** Despliega los canales disponibles (Email, SMS, WhatsApp) con sus estados de consentimiento actuales.
3. **Actor:** Modifica el estado de permiso (Concedido/Denegado) para cada canal de forma independiente.
4. **Sistema:** Registra la fecha, usuario y cambio de estado de cada consentimiento prestado.
5. **Sistema:** Verifica automáticamente las autorizaciones antes de realizar cualquier envío por dichos canales.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Intento de envío a canal sin consentimiento activo

**Se produce en:** paso 5 del flujo principal.  
**Condición:** Se intenta despachar una comunicación por un canal que tiene el consentimiento denegado.

1. El sistema bloquea automáticamente el envío.
2. Registra en la trazabilidad que la comunicación fue omitida por falta de permiso explícito.

**Resultado:** Se garantiza el cumplimiento normativo impidiendo el mensaje.

---

### 6. Postcondiciones

- POST-1. Los consentimientos por canal quedan actualizados y registrados con fecha y hora.

---

## CU-90 — Auditar exportaciones masivas de datos

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-90 |
| **Nombre** | Auditar exportaciones masivas de datos |
| **Objetivo** | Registrar automáticamente en la auditoría del sistema cualquier descarga masiva realizada, identificando el usuario, fecha y filtros utilizados. |
| **Actores participantes** | Superadministrador (principal) |
| **Requisito asociado** | UR-90 (FR-179, BR-02, BR-05) |

---

### 2. Precondiciones

- PRE-1. Un usuario del sistema realiza una consulta que culmina en una exportación masiva de datos.

---

### 3. Flujo principal

1. **Actor (Superadministrador):** Accede al filtro especializado de eventos de auditoría sobre datos y seguridad.
2. **Sistema:** Presenta las entradas del log que corresponden exclusivamente a eventos de "Exportación Masiva de Datos".
3. **Actor:** Inspecciona una línea de auditoría.
4. **Sistema:** Muestra el detalle del usuario ejecutor, la fecha/hora exacta, el volumen de filas exportadas y la lista explícita de filtros de búsqueda que se usaron en la consulta.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. La actividad de exportación masiva queda registrada de forma indeleble.

---

## CU-91 — Incrustar metadatos de trazabilidad en ficheros exportados

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-91 |
| **Nombre** | Incrustar metadatos de trazabilidad en ficheros exportados |
| **Objetivo** | Añadir marcas de agua o metadatos de identificación en los archivos exportados para disuadir e identificar posibles fugas de información. |
| **Actores participantes** | Superadministrador (beneficiario / auditor) |
| **Requisito asociado** | UR-91 (FR-180, BR-05) |

---

### 2. Precondiciones

- PRE-1. Un usuario autorizado desencadena la descarga o exportación de un conjunto de datos en formato Excel, CSV o PDF.

---

### 3. Flujo principal

1. **Sistema:** Recibe la orden de generación de la exportación de información.
2. **Sistema:** Recupera el ID del usuario actual, la marca de tiempo exacta y los parámetros del filtro ejecutado.
3. **Sistema:** Incrusta de forma automatizada estos datos en las propiedades del archivo (metadatos) y/o como pie de página/marca de agua visible.
4. **Sistema:** Entrega el archivo procesado con los metadatos integrados al usuario descargador.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. El fichero distribuido incluye dentro de su estructura la huella digital del usuario y la fecha de descarga.

---

## CU-92 — Emitir alerta por factura en estado vencido

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-92 |
| **Nombre** | Emitir alerta por factura en estado vencido |
| **Objetivo** | Generar una alerta en el sistema cuando una factura permanezca impagada superando el umbral parametrizable de días vencidos. |
| **Actores participantes** | Lector, Administrador (principales) |
| **Requisito asociado** | UR-92 (FR-181) |

---

### 2. Precondiciones

- PRE-1. El sistema tiene configurado el parámetro de días máximos tolerables de vencimiento.
- PRE-2. Existen facturas emitidas pendientes de cobro cuya fecha de vencimiento ha caducado.

---

### 3. Flujo principal

1. **Sistema:** Ejecuta la rutina periódica de revisión del estado de cobros de facturas.
2. **Sistema:** Detecta facturas impagadas que sobrepasan el límite de días vencidos definido.
3. **Sistema:** Genera automáticamente una alerta de facturación vencida vinculada al cliente y factura.
4. **Actor:** Accede al panel de avisos/alertas y visualiza la alerta emitida.
5. **Actor:** Hace clic en la alerta para navegar directamente a la factura afectada.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. La alerta queda visible en la bandeja de notificaciones hasta que la factura sea cobrada o gestionada.

---

## CU-93 — Emitir alerta por exceso de límite de deuda de cliente

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-93 |
| **Nombre** | Emitir alerta por exceso de límite de deuda de cliente |
| **Objetivo** | Notificar al usuario cuando el saldo acumulado de deuda de un cliente supere el umbral máximo económico permitido. |
| **Actores participantes** | Lector, Administrador (principales) |
| **Requisito asociado** | UR-93 (FR-182) |

---

### 2. Precondiciones

- PRE-1. El cliente posee un límite de crédito o deuda máxima configurado en su ficha.

---

### 3. Flujo principal

1. **Sistema:** Evalúa el saldo total adeudado por el cliente tras una nueva emisión de factura o actualización de estado.
2. **Sistema:** Constata que el saldo de deuda supera el valor máximo fijado.
3. **Sistema:** Emite una alerta de riesgo financiero sobre la ficha del cliente.
4. **Sistema:** Opcionalmente bloquea la generación automática de nuevas acciones comerciales hacia el cliente.
5. **Actor:** Revisa la notificación recibida en el centro de alertas.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. La ficha del cliente muestra un indicador visual de riesgo por exceso de deuda acumulada.

---

## CU-94 — Notificar acumulación de fallos en envíos a un contacto

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-94 |
| **Nombre** | Notificar acumulación de fallos en envíos a un contacto |
| **Objetivo** | Alertar al usuario sobre la detección de más de 3 fallos reiterados en las entregas de comunicaciones a un contacto determinado. |
| **Actores participantes** | Lector, Administrador (principales) |
| **Requisito asociado** | UR-94 (FR-183) |

---

### 2. Precondiciones

- PRE-1. El sistema registra las respuestas o errores de despacho de comunicaciones por parte de las pasarelas externas.

---

### 3. Flujo principal

1. **Sistema:** Registra un nuevo fallo de entrega en el envío hacia un contacto.
2. **Sistema:** Contabiliza el número total de errores consecutivos cometidos hacia dicha dirección/canal.
3. **Sistema:** Detecta que se han superado los 3 fallos de comunicación consecutivos.
4. **Sistema:** Emite una alerta preventiva indicando la posible invalidez o desactualización del email/teléfono del contacto.
5. **Actor:** Recibe la alerta y accede a la ficha del contacto para subsanar los datos de entrega.

---

### 4. Flujos alternativos

#### FA-1 — Corrección directa de los datos de contacto

**Se produce en:** paso 5 del flujo principal.  
**Condición:** El usuario modifica y guarda la nueva dirección de correo/teléfono.

1. El usuario introduce los nuevos datos validados.
2. El sistema reinicia a cero el contador de fallos de envío consecutivos para dicho contacto.

**Continuación:** El caso de uso finaliza.

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. La alerta se mantiene activa indicando la avería en la vía de comunicación hasta su resolución.

---

## CU-95 — Alertar sobre revisiones e incidencias estancadas

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-95 |
| **Nombre** | Alertar sobre revisiones e incidencias estancadas |
| **Objetivo** | Emitir una notificación al detectar que una revisión o incidencia anual permanece sin resolver tras transcurrir más de 7 días. |
| **Actores participantes** | Lector, Administrador (principales) |
| **Requisito asociado** | UR-95 (FR-184) |

---

### 2. Precondiciones

- PRE-1. Existen revisiones o incidencias en estado "Pendiente" o "En Proceso" en el sistema.

---

### 3. Flujo principal

1. **Sistema:** Ejecuta la rutina diaria de supervisión de antigüedad de incidencias no resueltas.
2. **Sistema:** Localiza expedientes o revisiones cuya fecha de apertura sea superior a 7 días sin haber cambiado de estado.
3. **Sistema:** Genera una alerta por estancamiento de incidencia/revisión.
4. **Actor:** Visualiza la alerta en el cuadro de mando.
5. **Actor:** Accede directamente a la incidencia demorada para proceder a su gestión o reasignación.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. Se impulsa la resolución de expedientes demorados en el sistema mediante notificaciones escaladas.

---

## CU-107 — Clasificar y etiquetar clientes por proyectos o categorías

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-107 |
| **Nombre** | Clasificar y etiquetar clientes por proyectos o categorías |
| **Objetivo** | Clasificar clientes y facturas de forma flexible mediante etiquetas o líneas de negocio preservando el histórico. |
| **Actores participantes** | Lector, Administrador (principales) |
| **Requisito asociado** | UR-107 (FR-185) |

---

### 2. Precondiciones

- PRE-1. El catálogo de etiquetas o proyectos está disponible en el sistema.

---

### 3. Flujo principal

1. **Actor:** Accede a la ficha de un cliente o factura.
2. **Actor:** Selecciona la opción de añadir o gestionar etiquetas/proyectos.
3. **Actor:** Selecciona o crea una etiqueta/categoría (ej. "Línea de Negocio A").
4. **Sistema:** Asocia la etiqueta al registro seleccionado.
5. **Actor (Administrador):** Modifica el nombre de una categoría global administrable.
6. **Sistema:** Actualiza el nombre visual de la categoría conservando las claves e identificadores internos del histórico intactos.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

*No se identifican flujos de excepción.*

---

### 6. Postcondiciones

- POST-1. Los clientes/facturas quedan etiquetados para su posterior filtrado sin distorsionar el historial previo.

---

## CU-109 — Segregar comunicaciones comerciales de datos de facturación

### 1. Identificación

| Campo | Descripción |
|---|---|
| **Identificador** | CU-109 |
| **Nombre** | Segregar comunicaciones comerciales de datos de facturación |
| **Objetivo** | Asegurar que los datos de facturación no sean reutilizados automáticamente en campañas de marketing o envíos comerciales. |
| **Actores participantes** | Administrador, Superadministrador (principales) |
| **Requisito asociado** | UR-109 (FR-193, BR-05) |

---

### 2. Precondiciones

- PRE-1. Existen contactos agregados estrictamente a efectos de emisión e imposición de facturas.

---

### 3. Flujo principal

1. **Actor:** Prepara la creación de una campaña o envío de comunicaciones de índole comercial/marketing.
2. **Sistema:** Carga el universo de contactos disponibles en la plataforma.
3. **Sistema:** Aplica el filtro estricto de segregación, excluyendo de la lista a todos aquellos contactos provenientes de facturación que no cuenten con un consentimiento comercial explícito.
4. **Sistema:** Presenta la lista final de destinatarios protegida.
5. **Actor:** Revisa y confirma el envío del mensaje únicamente a los contactos autorizados.

---

### 4. Flujos alternativos

*No se identifican flujos alternativos.*

---

### 5. Flujos de excepción

#### FE-1 — Ausencia de contactos con consentimiento comercial

**Se produce en:** paso 3 del flujo principal.  
**Condición:** Ninguno de los contactos de facturación tiene permiso comercial activo.

1. El sistema indica que no hay destinatarios válidos para la campaña comercial.
2. Impide la emisión del mensaje masivo.

**Resultado:** Se previene cualquier infracción en materia de protección de datos.

---

### 6. Postcondiciones

- POST-1. Se mantiene la independencia total entre la información de facturación obligatoria y la actividad publicitaria o comercial.