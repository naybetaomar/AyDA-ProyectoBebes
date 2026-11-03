# Propuesta de entidades y clases — Entrega 2

Borrador de trabajo para que el equipo fije **una lista común de entidades y nombres** antes de repartir los diagramas (E-R físico, clases, secuencia y componentes). Se ha extraído de `Especificacion Requisitos.md` (FR, RB, glosario y estados) y de los 59 casos de uso. Está actualizada a la forma actual de la entrega (estados, permisos y CU-59). Es una propuesta, no una decisión: la sección 6 recoge lo que hay que decidir entre todos.

**Actualizada el 3/11/2026** para coincidir con `Catalogo_clases_referencia_E2_v2.11.md`. Si los dos documentos no coinciden, manda el catálogo.

**Convenciones propuestas**
- Nombres de entidad en español, singular, `PascalCase` (en el E-R físico: tabla en `snake_case`, p. ej. `RelacionComercial` → `relacion_comercial`).
- Importes: tipo decimal exacto, nunca coma flotante (NFR-31). Instantes en UTC y fecha de negocio aparte (NFR-42, NFR-43).
- Toda entidad con trazabilidad lleva `creadoPor`, `creadoEn`, `modificadoPor`, `modificadoEn` (NFR-03); no se repiten abajo. `creadoPor` y `modificadoPor` admiten nulo, que significa «Sistema»: una acción automática, no hecha por una persona (planificador o API externa).

---

## 1. Entidades principales (imprescindibles en E-R y en clases)

| # | Entidad | Atributos principales | Origen en los requisitos |
|---|---|---|---|
| 1 | **Cliente** | id, razonSocial, identificadorFiscal (NIF), pais, moneda, direccion, estadoCliente (pendiente de activación / activo / pausado / baja solicitada / baja efectiva, A-25), datosPendientes, anonimizado | FR-01, FR-64, FR-70, FR-99, RB-17, NFR-04 |
| 2 | **Contacto** | id, nombre, email, telefono, idioma, canalPreferido, esContactoFacturacion, anonimizado | FR-02, FR-78, RB-27 |
| 3 | **ConsentimientoCanal** | contacto, canal, otorgado, fecha | FR-78, RB-28 |
| 4 | **RelacionComercial** | id, fechaInicio, condicionesPago, fechaBaja (el estado no se repite aquí: vive en `Cliente.estadoCliente`) | FR-03, FR-07, FR-16, RB-12, RB-30 |
| 5 | **RangoTarifa** (plan) | id, facturacionDesde, facturacionHasta, precioMensual | FR-10, UR-10 |
| 6 | **Pausa** | relacionComercial, motivo, fechaInicio, fechaPrevistaReactivacion, reactivacionConfirmada | FR-15, RB-05, RB-29 |
| 7 | **Factura** | id (clave técnica, existe desde el borrador), numeroFactura [0..1] (único, solo al emitirse, RB-01), estadoDocumental (borrador / pendiente de aprobación / emitida / rectificada), estadoCobro [0..1] (nulo hasta emitirse, A-23), estadoEnvio [0..1] (nulo hasta emitirse), enDisputa, cobroExcesivo, modificacionManual, moneda, baseImponible, impuestos, total y saldoPendiente (derivados), fechaEmision [0..1], fechaEmisionProgramada [0..1], fechaVencimiento, rutaPdf [0..1], hashPdf [0..1], migrada. El tipo no es atributo: es la herencia `FacturaPuntual` / `FacturaRecurrente` / `FacturaRectificativa` (en el E-R, una columna `tipo`) | FR-04, FR-06, FR-09, FR-19, FR-23, RB-01, RB-07, RB-11 |
| 7b | **HistorialEstadoFactura** | id, tipoEstado (documental / cobro / envío), estadoAnterior [0..1], estadoNuevo, fecha, motivo [0..1], usuario [0..1] (nulo = transición del sistema) | FR-09, decisión 1 |
| 8 | **LineaFactura** | factura, concepto, cantidad, precioUnitario, descuento, porcentajeImpuesto (copia del impuesto al crear la línea, RB-06), importe (derivado) | FR-04, FR-17 |
| 9 | **SerieFacturacion** | id, prefijo, siguienteNumero, entidadEmisora | FR-13 |
| 10 | **ConceptoCatalogo** | id, descripcion, precioPorDefecto (el impuesto por defecto es una asociación a `Impuesto`) | FR-17, RB-06 |
| 11 | **Impuesto** | id, nombre, porcentaje, pais | FR-04 |
| 11b | **ConfiguracionRecurrente** (propuesta; acordar con el área 2) | id, importeMensual [0..1] (si es nulo se usa el `RangoTarifa`), excepcionSinProrrateo, activa, fechaActivacion [0..1] | FR-05, FR-06, FR-100 |
| 12 | **EntidadEmisora** | id, razonSocial, datosFiscales, logo, plantillaFactura | FR-65, FR-66 (opcional), FR-104 |
| 13 | **TransaccionPasarela** | id, idEventoExterno (único), importe, moneda, fechaEvento, estado | FR-25, FR-87, NFR-27 |
| 14 | **Conciliacion** | transaccion, factura, importeAplicado, fecha, deshecha | FR-26, FR-27, RB-14, RB-23 |
| 15 | **BajaContable** | factura, tipo (anulada / incobrable), importeDadoDeBaja (saldo pendiente, A-24), motivo, aprobador, fecha | FR-24, RB-08 |
| 16 | **SolicitudExcepcion** | id, tipo, importe, estado (pendiente / aprobada / rechazada), comentarioAprobador, fecha | FR-11, FR-73, FR-74, RB-04, RB-25 |
| 17 | **PeriodoContable** | id, tipo (mes / trimestre), inicio, fin, estado (abierto / cerrado) | FR-75, FR-76 |
| 18 | **ReaperturaPeriodo** | periodo, motivo, usuario, fecha | FR-76, UR-83 |
| 19 | **PaqueteContable** | periodo, version, generadoPor, fechaGeneracion | FR-77 |
| 20 | **Usuario** | id, nombre, email, rol (enumerado: lector / administrador / superadministrador), activo, credencial (hash) | FR-36, FR-37, FR-39, FR-110, NFR-07 |
| 21 | **AsignacionCliente** | usuario, cliente, desde, hasta | FR-40, RB-15 |
| 22 | **Delegacion** | usuarioOrigen, suplente, desde, caducidad | FR-41 |
| 23 | **RegistroAuditoria** | id, usuario [0..1] (nulo = Sistema), fecha, entidadAfectada, accion, valorAnterior, valorNuevo | FR-43, NFR-03 |

## 2. Entidades de apoyo (comunicaciones, avisos y colaboración)

| # | Entidad | Atributos principales | Origen |
|---|---|---|---|
| 24 | **PlantillaComunicacion** | id, tipo (factura / recordatorio), asunto, cuerpo, variablesObligatorias, activa | FR-46, FR-105, RB-16 |
| 25 | **ReglaRecordatorio** | cadencia, diasTrasVencimiento, activa | FR-22, UR-31 |
| 26 | **Mensaje** | factura, contacto, canal, plantilla, estadoEntrega, intentos, fechaEnvio | FR-20, FR-21, FR-88, RB-35 |
| 27 | **Notificacion** | usuarioDestino, cliente, tipo, prioridad, estado (nueva / leída / resuelta) | FR-28, FR-80 |
| 28 | **PreferenciaNotificacion** | usuario, canal (in-app / email / resumen diario) | FR-29 |
| 29 | **Incidencia** | id, cliente, factura (opcional), estado, responsable, pausaRecordatorios | FR-109, RB-20, RB-22 |
| 30 | **Comentario** | autor, texto, restringido, fecha, destino (Cliente, Factura o Incidencia) | FR-90, RB-32 |
| 31 | **Documento** | nombre, formato, tamano, ruta, destino (Cliente o Factura) | FR-67, NFR-25, NFR-26 |
| 32 | **RevisionAnualPlan** | cliente, anio, facturacionAnual, rangoPropuesto, fechaEfecto, aprobada | FR-54, FR-55, FR-69, RB-26, RB-36 |
| 33 | **Tarea** | id, tipo, cliente, responsable, estado, origen (p. ej. baja solicitada por la API), fecha | FR-28, FR-40, CU-11, CU-58 |
| 33b | **ObjetivoFacturacion** | tipoPeriodo (mensual / anual), periodo, importeObjetivoFacturado, importeObjetivoCobrado; el histórico de cambios queda en RegistroAuditoria | FR-82, CU-45 |

## 3. Entidades técnicas y de configuración

| # | Entidad | Para qué sirve | Origen |
|---|---|---|---|
| 34 | **ConfiguracionGlobal** | Pares clave–valor validados y auditados (umbral de aprobación, plazos, moneda base…) | FR-103, FR-12, UR-72 |
| 35 | **CalendarioLaboral** | Festivos y días laborables para vencimientos y avisos | FR-83, Q-02 |
| 36 | **TipoCambio** | Moneda, fecha, valor, para consolidar informes | FR-85 |
| 37 | **EjecucionProceso** | Cada ejecución automática: tipo, duración, procesados, fallos y causa | FR-86, FR-101, FR-94 |
| 38 | **ErrorTecnico** | codigoIncidencia, mensaje interno, fecha | FR-62, FR-63 |
| 39 | **CopiaSeguridad** | fecha, estado | FR-44, NFR-11 |
| 40 | **RestauracionCopia** | copia, usuario, fecha, resultado (la restauración es auditada) | FR-44, CU-59 |
| 41 | **ConsumidorAPI** | credencial, limiteSolicitudes, activo | FR-59 a FR-61, NFR-50 |
| 42 | **LlamadaAPI** | consumidor, fecha, operacion, resultado | FR-61 |
| 43 | **SolicitudExterna** | consumidor, tipo (p. ej. baja), estado de validación | FR-60, RB-31 |
| 44 | **ExportacionMasiva** | usuario, criterios, fecha, fichero, caducidad | FR-79, FR-95 |
| 45 | **DescargaFichero** | exportación, usuario, fecha | FR-79 (UR-91) |
| 46 | **Sesion** / **TokenRecuperacion** | Sesión autenticada y enlace de recuperación con caducidad | FR-38, FR-58, NFR-47, NFR-49 |

## 4. Entidades opcionales o de menor peso (decidir si entran)

`Presupuesto` y `LineaPresupuesto` (FR-51, RB-09), `Etiqueta` y `CategoriaFactura` (FR-81, FR-108), `InformeProgramado` (FR-102), `VistaGuardada` (FR-33), `ClienteFavorito` (FR-71) e `Importacion` (FR-34, FR-35). Los datos de demostración (FR-91, CU-55) ya no son opcionales, pero no son una entidad: ver la decisión 8. Están marcadas como opcionales en los requisitos (A-13, A-14, A-16), así que mi sugerencia es no dibujarlas en el E-R salvo que haya tiempo.

---

## 5. Relaciones y cardinalidades propuestas

| Origen | Relación | Destino | Cardinalidad |
|---|---|---|---|
| Cliente | tiene | Contacto | 1 — 1..* (un cliente activo siempre tiene contacto de facturación, RB-27) |
| Contacto | tiene | ConsentimientoCanal | 1 — 0..* |
| Cliente | tiene | RelacionComercial | 1 — 0..* (una activa a la vez; el historial se conserva) |
| RelacionComercial | usa | RangoTarifa | * — 1 |
| RelacionComercial | tiene | Pausa | 1 — 0..* |
| Cliente | recibe | Factura | 1 — 0..* |
| Factura | se compone de | LineaFactura | 1 (composición) — 1..* |
| LineaFactura | aplica | Impuesto | * — 1 |
| ConceptoCatalogo | tiene por defecto | Impuesto | * — 1 |
| EntidadEmisora | tiene | SerieFacturacion | 1 — 0..* (la serie usada al emitir pertenece a la entidad emisora de la factura) |
| RelacionComercial | se factura con | ConfiguracionRecurrente | 1 — 0..1 |
| FacturaRecurrente | se genera desde | ConfiguracionRecurrente | * — 1 |
| Factura | pertenece a | SerieFacturacion | * — 0..1 (un borrador no tiene serie; 1 una vez emitida) |
| Factura | la emite | EntidadEmisora | * — 1 |
| Factura | rectifica | Factura | 0..1 — 0..* (asociación reflexiva, FR-52) |
| LineaFactura | se basa en | ConceptoCatalogo | * — 0..1 |
| Factura | se concilia con | TransaccionPasarela, mediante Conciliacion | * — * |
| Factura | puede tener | BajaContable | 1 — 0..1 |
| Factura | registra | HistorialEstadoFactura | 1 (composición) — 0..* |
| HistorialEstadoFactura | realizado por | Usuario | * — 0..1 (nulo = transición del sistema) |
| SolicitudExcepcion | se refiere a | Factura | * — 1 |
| Factura | pertenece a | PeriodoContable | * — 0..1 (un borrador no tiene periodo; 1 una vez emitida) |
| PeriodoContable | tiene | ReaperturaPeriodo / PaqueteContable | 1 — 0..* |
| Factura | genera | Mensaje | 1 — 0..* |
| Usuario | tiene asignados | Cliente, mediante AsignacionCliente | * — * |
| Usuario | solicita / resuelve | SolicitudExcepcion | 1 — 0..* (dos asociaciones: solicitante y aprobador) |
| Usuario | genera | RegistroAuditoria | 0..1 — 0..* (nulo = acción del sistema) |
| Cliente | tiene | Incidencia | 1 — 0..* |
| Incidencia, Cliente, Factura | admiten | Comentario | 1 — 0..* cada una |
| Cliente | tiene | Tarea | 1 — 0..* |
| Usuario | es responsable de | Tarea | 1 — 0..* |
| CopiaSeguridad | se restaura en | RestauracionCopia | 1 — 0..* |

**Generalizaciones (para el diagrama de clases).**
- `Factura` ← `FacturaPuntual`, `FacturaRecurrente` (periodoInicio, periodoFin, prorrateada; restricción única configuración + periodoInicio, FR-100) y `FacturaRectificativa` (motivo; al emitirse marca la original como rectificada). Esta es la opción de herencia de la decisión 2.
- `Usuario` **no** usa herencia por rol. El rol es un atributo enumerado (`LECTOR`, `ADMINISTRADOR`, `SUPERADMINISTRADOR`) tanto en clases como en el E-R, porque un usuario puede cambiar de rol (FR-110, `Usuario.cambiarRol()`) y un objeto no puede cambiar de clase. Los roles siguen siendo jerárquicos (A-19): el Lector opera solo sobre los clientes que tiene asignados y los perfiles de administración sobre todos (RB-15), así que `AsignacionCliente` solo restringe al Lector.

---

## 6. Decisiones que conviene tomar en equipo antes de dibujar

1. **Estados de la factura.** Las transiciones ya están definidas en la sección 5 de los requisitos (estado documental, de envío y de cobro, más las marcas «en disputa» y «cobro excesivo»). Queda decidir cómo guardarlas: tres atributos en `Factura` más una tabla `HistorialEstadoFactura` (factura, tipoEstado, estadoAnterior, estadoNuevo, usuario, fecha, motivo) para las transiciones que pide FR-09. Una factura rechazada en la aprobación vuelve a `borrador`.
2. **Herencia frente a atributo `tipo`** en `Factura` (ver arriba). Para clases, la herencia luce más; para el E-R, una tabla única es más simple.
3. **Rol de usuario como clase o como atributo.** Decidido: atributo `rol` enumerado en clases y en el E-R, sin herencia. Criterio: se usa herencia solo cuando el tipo de un objeto no cambia en su vida (como `Factura`); un usuario sí puede cambiar de rol (FR-110, RB-38, RB-39). El control de acceso se resuelve con un Proxy de protección.
4. **Comentarios y documentos con varios destinos.** Propuesta: tablas separadas por destino o una columna `destinoTipo` + `destinoId`; hay que elegir una y mantenerla.
5. **Cliente con una o varias relaciones comerciales.** Los requisitos hablan de «la» relación comercial; guardar historial es lo más seguro (RB-12), y es lo que exige que la baja efectiva sea final (A-25): volver a trabajar con la empresa crea una relación nueva.
6. **Qué entra en el E-R y qué solo en clases.** Las entidades técnicas (§3) suelen ir en el E-R, pero pueden omitirse en el de clases.
7. **Preguntas abiertas de la Entrega 1 que afectan al diseño:** Q-04 (permisos de suplentes), Q-07 (configuración que afecta a lo nuevo o a lo ya emitido), Q-12 (qué se hace con el sobrante de un cobro excesivo; la marca `cobroExcesivo` ya existe).
8. **Datos de demostración (CU-55).** Deben convivir sin mezclarse con los de producción. Propuesta: un esquema o espacio separado (la ficha de CU-55 ya dice «en un espacio separado») en lugar de una marca `esDemo` en cada entidad.
9. **Dónde vive el estado del cliente.** Propuesta: en `Cliente.estadoCliente` (cinco valores) y no en `RelacionComercial`.
10. **Patrones de diseño** (se decide después de la 2). Propuesta: Factory Method para crear facturas (`GeneradorFactura` y tres generadores, con `DatosFactura` como objeto de transferencia), ya aplicado en el diagrama del área 3. State para el estado de la factura queda pendiente para la Entrega 3 (es un patrón de comportamiento que aún no se ha visto y harían falta tres jerarquías, una por estado); en la Entrega 2 el área 3 usa enumerados y métodos. Además, el catálogo recoge un **Proxy de protección** para los permisos (lo define el área 9 y protege los servicios de todas las áreas), el **Planificador** como componente interno que pasa por el proxy con una identidad de sistema (cuestión 8.11 del catálogo) y los **Adapter** de las integraciones simuladas (NFR-27). Las clases de patrón (generadores, `DatosFactura`, proxy, adaptadores) y el planificador no son tablas en el E-R; ver la sección 5 del catálogo.

## 7. Trazabilidad con las otras piezas de la entrega

- **E-R físico** → §1 a §3, con tipos de dato, claves primarias, claves foráneas y tablas intermedias (`Conciliacion`, `AsignacionCliente`).
- **Diagrama de clases** → §1 y §2 con operaciones tomadas de los casos de uso (p. ej. `Factura.emitir()`, `PeriodoContable.cerrar()`, `Conciliacion.deshacer()`).
- **Secuencia** → escenarios candidatos: emitir factura (CU-15), generar la facturación recurrente desde el planificador sin duplicar tras una caída (CU-17, FR-100), conciliar un cobro (CU-34 / CU-35), cerrar y reabrir un periodo (CU-25 / CU-26), enviar y reintentar un envío (CU-27 / CU-28) y aprobar o rechazar una factura propuesta (CU-22 / CU-23). Opcional si hay tiempo: restaurar una copia de seguridad (CU-59, con confirmación).
- **Componentes** → pendiente de las indicaciones del profesor.
