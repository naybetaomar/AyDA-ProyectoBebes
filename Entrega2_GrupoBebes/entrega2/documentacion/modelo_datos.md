# Modelo físico de datos

## Alcance

Esta versión recoge el modelo de las **11 áreas**. Todas están en `script.sql`.

Fuentes: `diagramas/modelo_datos/er_area1.puml` a `er_area11.puml` y `script.sql` (PostgreSQL 16). Cada diagrama dibuja las tablas de su área y, en gris, las de otras áreas a las que apunta. Notación: entidad–relación física (patas de gallo) con tablas, PK, FK, tipos y cardinalidades; `*` indica NOT NULL.

Tablas del área 1: `cliente`, `contacto`, `consentimiento_canal`, `documento`, `etiqueta`, `cliente_etiqueta`, `categoria_factura` y `factura_categoria`.
Tablas del área 2: `relacion_comercial`, `pausa`, `rango_tarifa` y `revision_anual_plan`.
Tablas del área 3: `factura`, `linea_factura`, `historial_estado_factura`, `configuracion_recurrente`, `tramo_importe`, `periodo_pausa`, `serie_facturacion`, `entidad_emisora`, `impuesto` y `concepto_catalogo`.
Tablas del área 4: `solicitud_excepcion`, `periodo_contable` y `reapertura_periodo`.
Tablas del área 5: `plantilla_comunicacion`, `variable_plantilla`, `regla_recordatorio` y `mensaje`.
Tablas del área 6: `movimiento_cobro`, `conciliacion` y `baja_contable`.
Tablas del área 7: `notificacion`, `preferencia_notificacion`, `incidencia`, `comentario` y `tarea`.
Tablas del área 8: `objetivo_facturacion`, `paquete_contable`, `tipo_cambio`, `exportacion_masiva`, `informe_programado` y `destinatario_informe`.
Tablas del área 10: `configuracion_global`, `entrada_configuracion`, `tarea_programada`, `ejecucion_proceso`, `detalle_fallo`, `error_tecnico`, `calendario_laboral`, `dia_laborable_calendario` y `fecha_festiva`.
Tablas del área 11: `consumidor_api`, `llamada_api` y `solicitud_externa`.
Tablas del área 9: `usuario`, `sesion`, `token_recuperacion`, `asignacion_cliente`, `delegacion`, `registro_auditoria`, `descarga_fichero`, `copia_seguridad` y `restauracion_copia`.

Las clases de estas áreas están pendientes de la aprobación final del grupo, así que el modelo se cerrará cuando se aprueben. Las tablas van en el script en orden de dependencia: las de las áreas 1 y 4 que apuntan a `factura` (`documento`, `factura_categoria`, `solicitud_excepcion`) van después del área 3.

## Justificación del modelo

**Área 1**
- `CLIENTE (1)` — `CONTACTO (1..N)` y `CONTACTO (1)` — `CONSENTIMIENTO_CANAL (0..N)`: composiciones.
- `CLIENTE (0..N)` — `ETIQUETA (0..N)`: tabla intermedia `cliente_etiqueta`.
- `CATEGORIA_FACTURA (0..1)` — `FACTURA (0..N)`: tabla `factura_categoria` del área 1, para que `factura` (área 3) no dependa del área 1.
- `DOCUMENTO`: de un cliente o de una factura, exactamente uno (CU-04).

**Área 2**
- `CLIENTE (1)` — `RELACION_COMERCIAL (0..N)`; `RANGO_TARIFA (1)` — `RELACION_COMERCIAL (0..N)`: rango contratado.
- `RELACION_COMERCIAL (1)` — `PAUSA (0..N)`: composición.
- `RELACION_COMERCIAL (1)` — `REVISION_ANUAL_PLAN (0..N)`, con rango anterior (1), rango propuesto (0..1) y los usuarios que corrigen y aprueban.

**Área 3**
- `ENTIDAD_EMISORA (1)` — `SERIE_FACTURACION (0..N)`: cada serie pertenece a una entidad; una entidad puede tener varias.
- `ENTIDAD_EMISORA (1)` — `FACTURA (0..N)`: toda factura tiene entidad emisora (`NOT NULL`).
- `SERIE_FACTURACION (0..1)` — `FACTURA (0..N)`: un borrador todavía no tiene serie; una factura emitida sí (RB-01).
- `CLIENTE (1)` — `FACTURA (0..N)`.
- `PERIODO_CONTABLE (0..1)` — `FACTURA (0..N)`: se asigna al emitir.
- `FACTURA (1)` — `LINEA_FACTURA (1..N)`: composición; las líneas se borran junto con su borrador.
- `FACTURA (1)` — `HISTORIAL_ESTADO_FACTURA (0..N)`: composición; guarda los cambios de estado documental, de cobro y de envío.
- `FACTURA (0..1)` — `FACTURA (0..N)`, «rectifica»: una factura rectificativa apunta a la factura que rectifica.
- `CONFIGURACION_RECURRENTE (0..1)` — `FACTURA (0..N)`: las facturas recurrentes apuntan a su configuración.
- `RELACION_COMERCIAL (1)` — `CONFIGURACION_RECURRENTE (0..1)`.
- `CONFIGURACION_RECURRENTE (1)` — `TRAMO_IMPORTE (1..N)`: composición; cada cambio de importe añade un tramo con su fecha de inicio y los anteriores se conservan (RB-36).
- `CONFIGURACION_RECURRENTE (1)` — `PERIODO_PAUSA (0..N)`: composición; cada pausa es un intervalo `[desde, hasta)`, con `hasta` nulo mientras sigue en curso (CU-11).
- `IMPUESTO (1)` — `LINEA_FACTURA (0..N)` e `IMPUESTO (1)` — `CONCEPTO_CATALOGO (0..N)`; `CONCEPTO_CATALOGO (0..1)` — `LINEA_FACTURA (0..N)`: una línea puede venir del catálogo o ser libre.
- `USUARIO (0..1)` — `HISTORIAL_ESTADO_FACTURA (0..N)`, «realizado por»: nulo significa acción del Sistema.

**Área 6**
- `MOVIMIENTO_COBRO (1)` — `CONCILIACION (0..N)` y `FACTURA (1)` — `CONCILIACION (0..N)`: la conciliación es la tabla intermedia entre movimientos y facturas, con atributos propios (importe aplicado, fechas, usuarios).
- `FACTURA (1)` — `BAJA_CONTABLE (0..1)`: una factura tiene como máximo una baja.
- `SOLICITUD_EXCEPCION (1)` — `BAJA_CONTABLE (0..1)`: toda baja está aprobada mediante una solicitud.
- `USUARIO (0..1)` — `CONCILIACION (0..N)`: quién la realizó y quién la deshizo; nulo = conciliación automática.

**Área 4**
- `FACTURA (1)` — `SOLICITUD_EXCEPCION (0..N)`, con solicitante (1) y aprobador (0..1).
- `PERIODO_CONTABLE (1)` — `REAPERTURA_PERIODO (0..N)`; `PERIODO_CONTABLE (0..1)` — `FACTURA (0..N)`.

**Área 5**
- `PLANTILLA_COMUNICACION (1)` — `VARIABLE_PLANTILLA (0..N)`: la lista de variables obligatorias, normalizada.
- `PLANTILLA_COMUNICACION (1)` — `REGLA_RECORDATORIO (0..N)` y — `MENSAJE (0..N)`; `FACTURA (1)` y `CONTACTO (1)` — `MENSAJE (0..N)`.

**Área 7**
- `USUARIO`, `CLIENTE` y `FACTURA (0..1)` — `NOTIFICACION (0..N)`: destinatario (nulo = notificación general) y elemento sobre el que avisa.
- `CLIENTE (1)` — `INCIDENCIA (0..N)` y `CLIENTE (0..1)` — `TAREA (0..N)` (nulo = acción masiva sobre varios clientes, CU-07); `USUARIO (0..1)` como responsable de ambas (nulo = sin asignar).
- `COMENTARIO`: de un cliente, una factura o una incidencia, exactamente uno.
- Las FK a `factura` que no son composición pasan a nulo si se borra un borrador (`ON DELETE SET NULL`); los comentarios de un borrador se borran con él.

**Área 8**
- `PERIODO_CONTABLE (1)` — `PAQUETE_CONTABLE (0..N)`: una fila por versión; no se borra en cascada (RB-19).
- `INFORME_PROGRAMADO (1)` — `DESTINATARIO_INFORME (1..N)`: tabla intermedia con `usuario`.
- `OBJETIVO_FACTURACION` y `TIPO_CAMBIO` no tienen FK.

**Área 9**
- `USUARIO (1)` — `SESION`, `TOKEN_RECUPERACION`, `DELEGACION` (como origen y como suplente), `DESCARGA_FICHERO` y `RESTAURACION_COPIA (0..N)`; `USUARIO (0..1)` — `REGISTRO_AUDITORIA (0..N)` (nulo = Sistema).
- `USUARIO (1)` y `CLIENTE (1)` — `ASIGNACION_CLIENTE (0..N)`: un solo responsable vigente por cliente.
- `DESCARGA_FICHERO`: de un documento (área 1) o de una exportación (área 8), exactamente uno.

**Área 10**
- `CONFIGURACION_GLOBAL (1)` — `ENTRADA_CONFIGURACION (1..N)`, `EJECUCION_PROCESO (1)` — `DETALLE_FALLO (0..N)` y `CALENDARIO_LABORAL (1)` — `DIA_LABORABLE_CALENDARIO (1..N)` y `FECHA_FESTIVA (0..N)`: composiciones.
- `EJECUCION_PROCESO (0..1)` — `ERROR_TECNICO (0..N)`: un error técnico puede no venir de una ejecución (por ejemplo, de la API).
- `USUARIO (0..1)` — `ERROR_TECNICO (0..N)`: quién lo resolvió (`resuelto_por_id`).
- `TAREA_PROGRAMADA` no tiene FK: una fila por tipo de proceso.

**Área 11**
- `CONSUMIDOR_API (0..1)` — `LLAMADA_API (0..N)`: nulo cuando la credencial no es válida.
- `CONSUMIDOR_API (1)` y `CLIENTE (1)` — `SOLICITUD_EXTERNA (0..N)`; `SOLICITUD_EXTERNA (0..1)` — `TAREA (0..1)` (área 7).

**Decisiones de modelado**
- **Pausas guardadas dos veces, a propósito:** en `pausa` (área 2, con motivo y fecha prevista) y en `periodo_pausa` (área 3, solo el intervalo que no se factura). Así el área 3 no lee tablas del área 2. `ServicioRelacionComercial.pausar()` y `reactivar()` llaman a `ServicioFacturacion` en la misma transacción, de modo que las dos quedan siempre iguales.
- **Estado del cliente y rango vigente: no son columnas.** Se calculan desde la relación comercial más reciente y las revisiones aplicadas (área 2), así no hace falta una tarea diaria que los mantenga.
- **Herencia de `Factura` en una sola tabla**, con el discriminador `tipo` (PUNTUAL, RECURRENTE, RECTIFICATIVA). Las columnas propias de cada subtipo admiten nulos y un `CHECK` obliga a rellenarlas según el tipo. Evita uniones entre tablas para consultar facturas.
- **Tres estados independientes** de la factura: `estado_documental`, `estado_cobro` y `estado_envio`. Los dos últimos solo existen una vez emitida (A-23).
- **Importes guardados** (`base_imponible`, `impuestos`, `total`) aunque serían derivables: una factura emitida es inalterable (RB-07, RB-11) y no puede depender de recalcular.
- **Saldo pendiente: no es columna.** Lo calcula `ServicioCobros` como total menos conciliaciones no deshechas, menos baja contable, menos abonos emitidos (RB-10, A-27).
- **Estado del movimiento de cobro: no se guarda.** Se deriva de los importes y de `en_revision`.
- **Deshacer una conciliación no la borra:** se marca con `fecha_deshecho` y conserva su traza (FR-27). Un índice único parcial permite volver a conciliar la misma pareja después de deshacerla.
- **Abono sin estado de cobro:** una rectificativa con total negativo compensa la factura original y no tiene estado de cobro propio (A-27).
- **Cobro excesivo (A-28):** el importe que supera el saldo no se aplica a la factura; queda sin aplicar en el movimiento, que pasa a revisión (`en_revision`), y la factura se marca con `cobro_excesivo`.
- **Estado «vencida» guardado:** `VENCIDA` es un valor de `estado_cobro`; una tarea diaria del planificador marca las facturas sin ningún cobro cuyo vencimiento ha pasado (`ServicioCobros.actualizarVencimientos()`).
- **Importes y fechas:** `DECIMAL(12,2)` en importes y `DECIMAL(5,2)` en porcentajes (NFR-31); instantes en UTC con `TIMESTAMP` y fechas legales con `DATE` (NFR-42, NFR-43).
- **Trazabilidad (NFR-03):** todas las tablas llevan `creado_por`, `creado_en`, `modificado_por` y `modificado_en`, salvo las que son en sí un registro (`historial_estado_factura`, `sesion`, `token_recuperacion`, `registro_auditoria`, `descarga_fichero`, `llamada_api`, `ejecucion_proceso`, `detalle_fallo` y `error_tecnico`), que no las llevan, y las tablas cuyas filas solo se añaden y nunca se modifican (`tramo_importe`, `cliente_etiqueta`, `reapertura_periodo`, `variable_plantilla`, `dia_laborable_calendario`, `fecha_festiva`), que solo llevan `creado_por` y `creado_en`. Las dos FK a `usuario` admiten nulos (nulo = Sistema). No se dibujan en el diagrama.
- **Configuración con vigencia:** cada valor de `entrada_configuracion` tiene su intervalo de vigencia, y un cambio crea una fila nueva en lugar de sobrescribir la anterior. Así se sabe qué valor aplicaba en una fecha (Q-07).
- **Nombres:** tablas en singular y `snake_case`, PK `id`, FK `<tabla>_id` o por el rol cuando hay dos (`realizado_por_id`, `deshecho_por_id`).

## Reglas y restricciones

**Las garantiza la base de datos** (`script.sql`):

| Restricción | Tabla | Origen |
|---|---|---|
| `UNIQUE (serie_facturacion_id, numero_factura)` | `factura` | RB-01 |
| `UNIQUE (configuracion_recurrente_id, periodo_inicio)` | `factura` | FR-100, sin duplicar facturas recurrentes |
| `CHECK` de columnas propias por `tipo` (recurrente y rectificativa) | `factura` | Herencia en una tabla |
| `CHECK`: sin estado de cobro ni de envío hasta emitirse; sin estado de cobro en un abono | `factura` | A-23, A-27 |
| `CHECK`: una factura emitida tiene número, serie, periodo, fecha de emisión y estado de envío | `factura` | RB-01 |
| `CHECK (total = base_imponible + impuestos)` | `factura` | NFR-31 |
| Disparador `BEFORE DELETE`: solo se borran borradores | `factura` | RB-03, RB-11, CU-16 |
| Disparador `BEFORE UPDATE`: una factura emitida o rectificada no se modifica; solo pueden cambiar sus estados de cobro y envío, la disputa, el cobro excesivo, los campos de modificación y el paso de emitida a rectificada | `factura` | RB-07, RB-11 |
| Disparador: las líneas solo se crean, modifican o borran mientras la factura es un borrador (también quedan bloqueadas pendiente de aprobación, para que se apruebe lo que vio el aprobador) | `linea_factura` | RB-11, CU-22, CU-23 |
| FK compuesta `(serie_facturacion_id, entidad_emisora_id)` → `serie_facturacion (id, entidad_emisora_id)`: la serie es de la misma entidad emisora que la factura | `factura` | Coherencia serie–entidad |
| Borrado en cascada de líneas e historial | `linea_factura`, `historial_estado_factura` | Composición |
| `UNIQUE (entidad_emisora_id, prefijo)` | `serie_facturacion` | Propuesta: un prefijo no se repite en la misma entidad |
| `UNIQUE (relacion_comercial_id)` | `configuracion_recurrente` | Una configuración por relación comercial |
| `UNIQUE (configuracion_recurrente_id, desde)` | `tramo_importe` | RB-36: un solo importe por fecha de inicio |
| `EXCLUDE USING gist` sobre `daterange(desde, hasta)` por configuración (extensión `btree_gist`) | `periodo_pausa` | CU-11, RB-05: las pausas no se solapan y solo hay una en curso |
| `UNIQUE (origen, id_externo)` | `movimiento_cobro` | CU-34 FE-1, FR-25: el mismo evento no se cuenta dos veces |
| `CHECK`: `en_revision` exige `motivo_revision` | `movimiento_cobro` | A-28 |
| Índice único parcial `(movimiento_cobro_id, factura_id) WHERE fecha_deshecho IS NULL` | `conciliacion` | FR-87 |
| `CHECK`: `fecha_deshecho`, `motivo_deshacer` y `deshecho_por_id` van juntos | `conciliacion` | FR-27 |
| `UNIQUE (factura_id)` y `UNIQUE (solicitud_excepcion_id)` | `baja_contable` | Una baja por factura y por solicitud |
| `CHECK` de tipo: ANULADA o INCOBRABLE (nunca «pagada») | `baja_contable` | RB-08 |

| `UNIQUE (identificador_fiscal)` | `cliente` | CU-01 |
| Índice único parcial `(cliente_id) WHERE es_contacto_facturacion` | `contacto` | Un contacto de facturación por cliente |
| `UNIQUE (contacto_id, canal)` | `consentimiento_canal` | Un consentimiento por canal |
| `CHECK (num_nonnulls(cliente_id, factura_id) = 1)` | `documento` | CU-04 |
| `EXCLUDE USING gist` sobre `numrange(facturacion_desde, facturacion_hasta)` | `rango_tarifa` | CU-14 FE-1: rangos sin solapes |
| `EXCLUDE USING gist` sobre `daterange(fecha_inicio, fecha_baja)` por cliente e índice único parcial `(cliente_id) WHERE fecha_baja IS NULL` | `relacion_comercial` | RB-12, A-25: una relación nueva empieza el día de la baja de la anterior o después |
| `EXCLUDE USING gist` sobre `daterange(fecha_inicio, fecha_reactivacion)` por relación, índice único parcial `WHERE fecha_reactivacion IS NULL` y `CHECK (fecha_reactivacion > fecha_inicio)` | `pausa` | CU-11: pausas sin solapes y una sola en curso |
| `UNIQUE (relacion_comercial_id, anio)`; `CHECK` de dato, resolución y `aprobado_por_id ≠ corregido_por_id` | `revision_anual_plan` | CU-13, FA-2, FR-74 |
| `CHECK`: rechazada ⇒ comentario; pendiente ⇔ sin aprobador ni fecha de resolución; aprobador ≠ solicitante; motivo obligatorio salvo en FACTURA_SOBRE_UMBRAL; exactamente una de factura y configuración recurrente (esta, solo en la de prorrateo) | `solicitud_excepcion` | CU-22, CU-23, FR-74 |
| `EXCLUDE USING gist` sobre `daterange(inicio, fin)` por tipo | `periodo_contable` | Periodos del mismo tipo sin solapes |
| `UNIQUE (plantilla_comunicacion_id, nombre)` | `variable_plantilla` | Sin variables repetidas |
| Índice único parcial `(tipo, idioma) WHERE activa` | `plantilla_comunicacion` | Una plantilla activa por tipo e idioma (CU-29) |
| `CHECK`: enviado o entregado ⇒ `fecha_envio`; fallido ⇒ `motivo_fallo` | `mensaje` | CU-27, CU-28 |
| `CHECK`: las fechas van con el estado; las alertas llevan cliente | `notificacion` | CU-37 |
| Índice único parcial `NULLS NOT DISTINCT` sobre las alertas sin resolver | `notificacion` | No repetir una alerta abierta |
| `UNIQUE (usuario_id, canal)` | `preferencia_notificacion` | Una preferencia por canal |
| `CHECK`: cerrada ⇔ `fecha_cierre`, y `fecha_cierre ≥ fecha_apertura` | `incidencia` | CU-40 |
| `CHECK (num_nonnulls(cliente_id, factura_id, incidencia_id) = 1)` | `comentario` | CU-41 |
| `CHECK`: completada ⇔ `fecha_completada` | `tarea` | — |
| `UNIQUE NULLS NOT DISTINCT (tipo_periodo, anio, mes)` y `CHECK` del mes según el tipo | `objetivo_facturacion` | FR-82 |
| `UNIQUE (periodo_contable_id, version)` | `paquete_contable` | RB-19 |
| `UNIQUE (moneda, fecha)` y `valor > 0` | `tipo_cambio` | FR-85 |
| `UNIQUE (informe_programado_id, usuario_id)` | `destinatario_informe` | Sin destinatarios repetidos |
| Índice único sobre `lower(email)`; `CHECK` de rol (OPERATIVO, ADMINISTRADOR, SUPERADMINISTRADOR) | `usuario` | Matriz de permisos |
| `CHECK` del formato SHA-256 de `token_hash`, `caduca_en = emitido_en + 24 h` y uso dentro del plazo | `token_recuperacion` | Recuperación de contraseña |
| `EXCLUDE USING gist` sobre `daterange(desde, hasta)` por cliente | `asignacion_cliente` | Un responsable vigente por cliente |
| `CHECK`: `desde ≤ caducidad` y origen ≠ suplente | `delegacion` | — |
| Disparadores `BEFORE UPDATE OR DELETE` y `BEFORE TRUNCATE` | `registro_auditoria` | Auditoría inalterable |
| `CHECK (num_nonnulls(documento_id, exportacion_masiva_id) = 1)` | `descarga_fichero` | FR-79, FR-95 |
| `UNIQUE (credencial_hash)` | `consumidor_api` | Un consumidor por credencial |
| `CHECK`: sin consumidor solo si no autorizada; error ⇒ `codigo_incidencia` | `llamada_api` | FR-61 |
| `CHECK`: validada ⇔ con tarea; rechazada ⇔ con motivo | `solicitud_externa` | CU-58, RB-31 |
| `EXCLUDE USING gist` sobre `daterange(desde, hasta)` por clave | `entrada_configuracion` | Un solo valor vigente por clave y fecha (Q-07) |
| `UNIQUE (tipo)` | `tarea_programada` | Una programación por tipo de proceso |
| `CHECK`: en curso ⇔ sin `fecha_fin`; fallida o cancelada ⇒ `causa` | `ejecucion_proceso` | BR-04, CU-56 |
| `UNIQUE (codigo_incidencia)`; `CHECK`: resuelto ⇔ `fecha_resolucion`; sin resolver ⇒ sin `resuelto_por_id` | `error_tecnico` | FR-61, FR-62 |
| `UNIQUE (pais, anio)`; `UNIQUE` del día y del festivo por calendario | `calendario_laboral`, `dia_laborable_calendario`, `fecha_festiva` | FR-83, Q-02 |

**Las garantiza la aplicación** (cruzan tablas o dependen de cálculos). **La notación gráfica no las valida:**
- El tipo de la serie corresponde al de la factura: rectificativa para una rectificativa y ordinaria en otro caso. Se comprueba al emitir.
- El importe aplicado de una conciliación no supera el saldo pendiente de la factura, y la moneda del movimiento coincide con la de la factura (FR-84).
- La baja contable es de la misma factura que su solicitud de excepción.
- Un cliente activo tiene al menos un contacto de facturación (RB-27).
- Los rangos de tarifa no dejan huecos (CU-14 FE-1); los solapes sí los impide la base de datos.
- Una regla de recordatorio usa una plantilla de tipo RECORDATORIO.
- Un informe programado tiene al menos un destinatario con permiso para recibirlo (RB-33).
- La fecha de un festivo es del año de su calendario.

## Trazabilidad

| Requisitos/casos | Tablas/columnas | Observación |
|---|---|---|
| CU-15, CU-17, CU-19 (emitir facturas) | `factura`, `linea_factura`, `historial_estado_factura` | Una sola tabla para los tres tipos, con `tipo` como discriminador |
| CU-21 (series y numeración), RB-01 | `serie_facturacion.siguiente_numero`, `factura.numero_factura` | Número único por serie, asignado al emitir |
| CU-17, FR-100 | `configuracion_recurrente`, `factura.periodo_inicio`, `uq_factura_mes` | Evita duplicar la factura de un periodo |
| CU-11, CU-13, FR-100, RB-36 | `tramo_importe`, `periodo_pausa` | Al recuperar cuotas atrasadas, cada periodo sale con su importe y no se facturan los meses en pausa |
| CU-16, RB-03, RB-11, FR-93 | Disparador sobre `factura`; cascada en `linea_factura` e `historial_estado_factura` | Solo se borran borradores |
| CU-31 | `factura.en_disputa`, `motivo_disputa`, `fecha_revision_disputa` | La disputa guarda su motivo y su fecha de revisión; no cambia el estado de cobro |
| CU-22, CU-23, RB-25 | `factura.estado_documental` (PENDIENTE_APROBACION), `factura.modificacion_manual` | La solicitud (`solicitud_excepcion`) pertenece al área 4 |
| RB-06, FR-17 | `linea_factura.porcentaje_impuesto`, `concepto_catalogo`, `impuesto` | La línea copia el porcentaje: cambiar el impuesto del catálogo no altera facturas emitidas |
| RB-07, RB-11 | `factura.base_imponible`, `impuestos`, `total`, `ruta_pdf`, `hash_pdf`; disparadores sobre `factura` y `linea_factura` | Valores guardados, y la base de datos impide modificar una emitida y sus líneas |
| FR-84 | `factura.moneda`, `movimiento_cobro.moneda` | Moneda por factura y por movimiento |
| A-23, A-27 | `factura.estado_cobro`, `estado_envio`, `CHECK` | Sin estado de cobro en borradores ni en abonos |
| CU-34, FR-25, FR-87 | `movimiento_cobro` (`origen`, `id_externo`) | No contabilizar dos veces un mismo evento |
| CU-35, FR-26, FR-27, FR-87 | `conciliacion`, índice único parcial | Conciliar y deshacer conservando la traza |
| A-28 | `movimiento_cobro.en_revision`, `motivo_revision`; `factura.cobro_excesivo` | El sobrante queda sin aplicar en el movimiento |
| CU-36, RB-08 | `baja_contable` | Baja explícita (anulada o incobrable) aprobada mediante una solicitud |
| RB-10, A-27 | Sin columna: lo calcula `ServicioCobros` | Saldo pendiente ≠ facturación total |
| CU-56, BR-04 | `ejecucion_proceso`, `detalle_fallo`, `error_tecnico` | Cada ejecución del planificador queda registrada con sus fallos |
| FR-83, Q-02 | `calendario_laboral`, `dia_laborable_calendario`, `fecha_festiva` | Traslado de vencimientos y recordatorios al siguiente día laborable |
| NFR-03 | `creado_por`, `creado_en`, `modificado_por`, `modificado_en`; `historial_estado_factura` | Nulo = Sistema |
| NFR-31, NFR-42, NFR-43 | Tipos `DECIMAL` y `TIMESTAMP` en UTC | Sin coma flotante |

## Decisiones abiertas

- **Sumas de conciliaciones:** que las conciliaciones vigentes de un movimiento no superen su importe (A-28) se comprueba en la aplicación; no cabe en un `CHECK`.
- **Mínimo de una línea por factura:** el diagrama indica `1..N`; no se puede expresar con una restricción de columna y se comprueba al emitir.
- **Excepción sobre una configuración recurrente (aplicada el 25/11, pendiente de confirmar en la reunión):** la solicitud de excepción va sobre una factura o sobre una configuración recurrente (la de prorrateo, que se propone antes de que exista la factura). `factura_id` admite nulos, hay una columna `configuracion_recurrente_id` y un `CHECK` de «exactamente una».
- **Borrado de un borrador y solicitud de excepción:** el script usa `ON DELETE CASCADE`: si se borra un borrador, se borran sus solicitudes. No afecta a las de prorrateo, que van sobre la configuración.
- **Destino del sobrante cobrado (Q-12):** devolución o saldo a favor. El modelo deja el importe en el movimiento sin aplicar, sea cual sea el destino.
- **Aprobación de las clases de las áreas 3 y 6.** Mientras estén en «Propuesta», el modelo también lo está.
