# Catálogo de clases de referencia — Entrega 2 (v2.11)

Tabla única de nombres y atributos que todos copian. **Fuente de verdad:** si una clase aparece en tu diagrama de clases o en el E-R, su nombre y sus atributos clave coinciden con esta tabla. Un atributo nuevo se propone al grupo antes de usarlo y se anota en el registro de cambios (sección 9).

Este catálogo es también el **contrato entre quienes terminan los diagramas de clases y quienes hacen el E-R en paralelo**. Por eso cada clase indica su estado.

Se genera a partir de `Propuesta_entidades_y_clases_Entrega2.md`, `Reparto_clases_por_area.md` y de los diagramas del área 3 (`area3_1_modelo_facturacion.puml`, `area3_2_factory_method.puml` y `area3_3_relaciones_otras_areas.puml`).

**Núcleo** en este catálogo = las 11 clases que se aprueban en la sesión. La sección 1 de la propuesta se llama «Entidades principales» y es una lista más amplia.

## 0. Estados de una clase

| Estado | Significado | ¿Se puede pasar al E-R? |
|---|---|---|
| **Borrador** | El área la está definiendo | No |
| **Propuesta** | El área la da por cerrada; se confirma en la sesión | No, hasta confirmarse |
| **Aprobada** | Revisada y confirmada por el grupo | **Sí**. Cualquier cambio posterior se anuncia y se registra en la sección 9 |

## 1. Áreas

1. Clientes y contactos
2. Relación comercial y suscripciones
3. Emisión de facturas
4. Aprobaciones y cierre contable
5. Envío y comunicaciones
6. Cobros, conciliación y saldo
7. Notificaciones y colaboración
8. Informes y contabilidad
9. Usuarios, seguridad y auditoría
10. Configuración y sistema
11. API externa

## 2. Convenciones del diagrama de clases (definición de terminado)

- Todos los atributos son **privados** (`-`); se accede a ellos con operaciones públicas.
- Atributo derivado: prefijo `/` (`/total`, `/saldoPendiente`).
- Atributo que no cambia tras asignarse: `{readOnly}`. Opcional: `[0..1]`.
- Toda asociación lleva **multiplicidad en los dos extremos** y un nombre de rol o un verbo.
- Una clase de otra área se dibuja con el estereotipo `<<referencia>>` y solo sus atributos clave.
- Los estados y tipos cerrados son **enumerados** (sección 6), nunca `String`.
- Las restricciones que no se ven en las flechas van en una nota: `{único: …}`, invariantes, precondiciones.
- Los campos de trazabilidad `creadoPor`, `creadoEn`, `modificadoPor`, `modificadoEn` (NFR-03) **no se dibujan** en cada clase: se indica una sola vez en una nota del diagrama. En el E-R sí son columnas (sección 7).
- Toda clase que aparezca en un diagrama de secuencia existe en algún diagrama de clases.
- El `.puml` compila y se ha exportado a PDF en `doc/`.
- **Recomendado:** si el diagrama de un área no se lee en una página, se parte en tres, como el área 3: (1) modelo propio del área, (2) patrones de diseño, (3) relaciones con otras áreas. Cada clase se define completa en un solo diagrama; en los demás aparece solo con su nombre.

## 3. Núcleo (se aprueba en la sesión)

| Clase | Área | Estado | Atributos clave | Relaciones | Referencia en áreas | Pendiente |
|---|---|---|---|---|---|---|
| **Cliente** | 1 | Borrador | id, razonSocial, identificadorFiscal, pais, moneda, direccion, estadoCliente : EstadoCliente, datosPendientes, anonimizado | Cliente recibe Factura (1 — 0..*)<br>Cliente tiene Contacto (1 — 1..*, RB-27)<br>Cliente tiene RelacionComercial (1 — 0..*, una activa a la vez; historial)<br>Usuario tiene asignados Cliente mediante AsignacionCliente (* — *) | 2, 3, 7, 8, 9, 11 | Dec. 5: ¿`estadoCliente` almacenado o derivado de la relación activa? Si se almacena, justificar frente a `RelacionComercial.fechaBaja` |
| **Contacto** | 1 | Borrador | id, nombre, email, telefono, idioma, canalPreferido : Canal, esContactoFacturacion, anonimizado | Cliente tiene Contacto (1 — 1..*)<br>Contacto tiene ConsentimientoCanal (1 — 0..*) | 5 | — |
| **RelacionComercial** | 2 | Borrador | id, fechaInicio, condicionesPago, fechaBaja [0..1] | Cliente tiene RelacionComercial (1 — 0..*)<br>RelacionComercial usa RangoTarifa (* — 1)<br>RelacionComercial tiene Pausa (1 — 0..*)<br>**RelacionComercial se factura con ConfiguracionRecurrente (1 — 0..1)** | 3 | Acordar con el área 3 la asociación con `ConfiguracionRecurrente` |
| **Factura** *(abstracta)* | 3 | **Propuesta** | id {readOnly}, numeroFactura [0..1] {readOnly}, estadoDocumental : EstadoDocumental, estadoCobro : EstadoCobro [0..1], estadoEnvio : EstadoEnvio [0..1], enDisputa, cobroExcesivo, modificacionManual, moneda, /baseImponible, /impuestos, /total, /saldoPendiente, fechaEmision [0..1], fechaEmisionProgramada [0..1], fechaVencimiento, rutaPdf [0..1], hashPdf [0..1], migrada | Cliente recibe Factura (1 — 0..*)<br>Factura se compone de LineaFactura (1, composición — 1..*)<br>Factura numerada en SerieFacturacion (* — 0..1; 1 una vez emitida)<br>Factura pertenece a PeriodoContable (* — 0..1; 1 una vez emitida)<br>Factura emitida por EntidadEmisora (* — 1)<br>Factura se concilia en Conciliacion (1 — 0..*)<br>SolicitudExcepcion sobre Factura (* — 1)<br>Factura registra HistorialEstadoFactura (1, composición — 0..*) | 1, 4, 5, 6, 7, 8, 11 | Ver sección 8: estado de cobro de una factura `RECTIFICADA` |
| **LineaFactura** | 3 | **Propuesta** | concepto, cantidad, precioUnitario, descuento, porcentajeImpuesto (copia del impuesto al crear la línea, RB-06), /importe | Factura se compone de LineaFactura<br>LineaFactura se basa en ConceptoCatalogo (* — 0..1)<br>LineaFactura aplica Impuesto (* — 1) | — | — |
| **TransaccionPasarela** | 6 | Borrador | id, idEventoExterno (único), importe, moneda, fechaEvento, estado | Se concilia con Factura mediante Conciliacion (* — *) | — | ¿Se generaliza a `MovimientoCobro` con `origen` (pasarela / banco / manual) para cubrir FR-26? |
| **Conciliacion** | 6 | Borrador | transaccion, factura, importeAplicado, fecha, deshecha | Factura (1 — 0..*)<br>TransaccionPasarela (1 — 0..*) | 3 | Q-12 (sobrante). Ver sección 8 |
| **SolicitudExcepcion** | 4 | Borrador | id, tipo, importe, estado : EstadoSolicitud, comentarioAprobador, fecha | Usuario solicita / resuelve SolicitudExcepcion (1 — 0..*; dos asociaciones: solicitante y aprobador)<br>**SolicitudExcepcion sobre Factura (* — 1)** | 3 | — |
| **PeriodoContable** | 4 | Borrador | id, tipo : TipoPeriodo, inicio, fin, estado : EstadoPeriodo | Factura pertenece a PeriodoContable (* — 0..1)<br>PeriodoContable tiene ReaperturaPeriodo / PaqueteContable (1 — 0..*) | 3, 8 | — |
| **Usuario** | 9 | Borrador | id, nombre, email, **rol : Rol**, activo, credencial (hash) | Usuario tiene asignados Cliente mediante AsignacionCliente (* — *)<br>Usuario solicita / resuelve SolicitudExcepcion<br>Usuario genera RegistroAuditoria (0..1 — 0..*; nulo = Sistema)<br>Usuario es responsable de Tarea (1 — 0..*) | 1, 4, 6, 7, 10 | Decidido: **sin herencia por rol** (un usuario puede cambiar de rol y un objeto no puede cambiar de clase). El control de acceso se resuelve con el Proxy (sección 5). Operación `cambiarRol(nuevoRol : Rol, realizadoPor : Usuario)` (FR-110, RB-38, RB-39, CU-49 FA-1). Q-13 pendiente |
| **AsignacionCliente** | 9 | Borrador | usuario, cliente, desde, hasta [0..1] | Usuario — Cliente (* — *) | 1 | — |

## 4. Resto de clases del dominio (las cierra el responsable del área)

### 4.1. Área 3 — Emisión de facturas

| Clase | Estado | Atributos clave | Relaciones | Pendiente |
|---|---|---|---|---|
| **FacturaPuntual** | **Propuesta** | — (hereda de Factura) | Factura ← FacturaPuntual | — |
| **FacturaRecurrente** | **Propuesta** | periodoInicio, periodoFin, prorrateada | Factura ← FacturaRecurrente<br>FacturaRecurrente generada desde ConfiguracionRecurrente (* — 1)<br>`{único: configuración + periodoInicio}` (FR-100) | — |
| **FacturaRectificativa** | **Propuesta** | motivo | Factura ← FacturaRectificativa<br>FacturaRectificativa rectifica Factura (* — 1)<br>Sobrescribe `emitir()`: al emitirse, la original pasa a `RECTIFICADA` | — |
| **HistorialEstadoFactura** | **Propuesta** | id, tipoEstado : TipoEstado, estadoAnterior [0..1], estadoNuevo, fecha, motivo [0..1] | Factura registra HistorialEstadoFactura (1, composición — 0..*)<br>HistorialEstadoFactura realizado por Usuario (* — 0..1; nulo = transición del sistema) | FR-09, decisión 1. Una fila por transición de cualquiera de los tres estados |
| **ConfiguracionRecurrente** | **Propuesta** | id, importeMensual [0..1] (si es nulo, el precio del RangoTarifa), excepcionSinProrrateo, activa, fechaActivacion [0..1] | RelacionComercial (1 — 0..1)<br>FacturaRecurrente (1 — 0..*) | Acordar con el área 2 |
| **SerieFacturacion** | **Propuesta** | id, prefijo, siguienteNumero | EntidadEmisora tiene SerieFacturacion (1 — 0..*)<br>Factura (0..1 — 0..*) | Invariante: la serie de `emitir()` pertenece a la EntidadEmisora de la factura |
| **EntidadEmisora** | **Propuesta** | id, razonSocial, datosFiscales, logo, plantillaFactura | SerieFacturacion (1 — 0..*)<br>Factura (1 — 0..*) | — |
| **ConceptoCatalogo** | **Propuesta** | id, descripcion, precioPorDefecto | LineaFactura (0..1 — 0..*)<br>ConceptoCatalogo usa Impuesto por defecto (* — 1) | — |
| **Impuesto** | **Propuesta** | id, nombre, porcentaje, pais | LineaFactura (1 — 0..*)<br>ConceptoCatalogo (1 — 0..*) | — |
| **Presupuesto** y **LineaPresupuesto** *(opcionales)* | Borrador | id, estado, fechaValidez | Cliente (1 — 0..*)<br>Puede generar una Factura (0..1 — 0..1); identidades independientes (RB-09) | CU-20 queda fuera del diagrama del área 3 por ser opcional. La propuesta (§4) sugiere no dibujarlos salvo que haya tiempo |

### 4.2. Resto de áreas

| Clase | Área | Estado | Atributos clave | Relaciones | Pendiente |
|---|---|---|---|---|---|
| **ConsentimientoCanal** | 1 | Borrador | contacto, canal : Canal, otorgado, fecha | Contacto (1 — 0..*) | — |
| **Documento** | 1 | Borrador | nombre, formato, tamano, ruta, destino (Cliente o Factura) | ver propuesta de entidades | Dec. 6 (destinos); ¿área 1 o 9? |
| **Etiqueta** y **CategoriaFactura** *(opcionales)* | 1 | Borrador | nombre | Etiqueta — Cliente (* — *)<br>CategoriaFactura — Factura (* — 0..1) | CU-08, FR-81, FR-108. No sustituyen a los estados derivados (RB-34). La propuesta (§4) sugiere no dibujarlas salvo que haya tiempo |
| **RangoTarifa** | 2 | Borrador | id, facturacionDesde, facturacionHasta, precioMensual | RelacionComercial (1 — 0..*) | — |
| **Pausa** | 2 | Borrador | relacionComercial, motivo, fechaInicio, fechaPrevistaReactivacion, reactivacionConfirmada | RelacionComercial (1 — 0..*) | — |
| **RevisionAnualPlan** | 2 | Borrador | cliente, anio, facturacionAnual, rangoPropuesto, fechaEfecto, aprobada | ver propuesta de entidades | — |
| **ReaperturaPeriodo** | 4 | Borrador | periodo, motivo, usuario, fecha | PeriodoContable (1 — 0..*) | — |
| **PlantillaComunicacion** | 5 | Borrador | id, tipo (factura / recordatorio), asunto, cuerpo, variablesObligatorias, activa | ver propuesta de entidades | — |
| **ReglaRecordatorio** | 5 | Borrador | cadencia, diasTrasVencimiento, activa | ver propuesta de entidades | — |
| **Mensaje** | 5 | Borrador | factura, contacto, canal : Canal, plantilla, estadoEntrega, intentos, fechaEnvio | Factura genera Mensaje (1 — 0..*) | — |
| **BajaContable** | 6 | Borrador | factura, tipo (anulada / incobrable), importeDadoDeBaja, motivo, aprobador, fecha | Factura puede tener BajaContable (1 — 0..1) | — |
| **Notificacion** | 7 | Borrador | usuarioDestino, cliente, tipo, prioridad, estado : EstadoNotificacion | ver propuesta de entidades | — |
| **PreferenciaNotificacion** | 7 | Borrador | usuario, canal (in-app / email / resumen diario) | ver propuesta de entidades | — |
| **Incidencia** | 7 | Borrador | id, cliente, factura [0..1], estado, responsable, pausaRecordatorios | Cliente (1 — 0..*) | Nace en el área 5, se gestiona en la 7 |
| **Comentario** | 7 | Borrador | autor, texto, restringido, fecha, destino (Cliente, Factura o Incidencia) | Incidencia, Cliente, Factura (1 — 0..* cada una) | Dec. 6 (destinos) |
| **Tarea** | 7 | Borrador | id, tipo, cliente, responsable, estado, origen, fecha | Cliente (1 — 0..*)<br>Usuario (1 — 0..*) | La usan las áreas 2, 7 y 11 |
| **PaqueteContable** | 8 | Borrador | periodo, version, generadoPor, fechaGeneracion | PeriodoContable (1 — 0..*) | — |
| **TipoCambio** | 8 | Borrador | moneda, fecha, valor | ver propuesta de entidades | — |
| **ExportacionMasiva** | 8 | Borrador | usuario, criterios, fecha, fichero, caducidad | ver propuesta de entidades | Frontera con DescargaFichero (áreas 8/9) |
| **ObjetivoFacturacion** | 8 | Borrador | tipoPeriodo (mensual / anual), periodo, importeObjetivoFacturado, importeObjetivoCobrado | Histórico de cambios vía RegistroAuditoria (FR-82) | CU-45 y FR-82 **no son opcionales** (origen: entrevista) |
| **InformeProgramado** *(opcional)* | 8 | Borrador | tipo, periodicidad, destinatarios, activo | Usuario (1 — 0..*) | CU-44; solo a usuarios con permiso (RB-33) |
| **Delegacion** | 9 | Borrador | usuarioOrigen, suplente, desde, caducidad | ver propuesta de entidades | Q-04 (permisos del suplente) |
| **RegistroAuditoria** | 9 | Borrador | id, usuario [0..1] (nulo = Sistema), fecha, entidadAfectada, accion, valorAnterior, valorNuevo | Usuario (0..1 — 0..*) | Nulo = acción automática, no hecha por una persona: planificador o API externa (cuestión 8.11) |
| **DescargaFichero** | 9 | Borrador | exportacion, usuario, fecha | ver propuesta de entidades | Frontera con ExportacionMasiva |
| **CopiaSeguridad** | 9 | Borrador | fecha, estado | RestauracionCopia (1 — 0..*) | — |
| **RestauracionCopia** | 9 | Borrador | copia, usuario, fecha, resultado | CopiaSeguridad (1 — 0..*) | — |
| **Sesion / TokenRecuperacion** | 9 | Borrador | Sesión autenticada y enlace de recuperación con caducidad | ver propuesta de entidades | Dec. 7 (¿E-R o solo clases?) |
| **ConfiguracionGlobal** | 10 | Borrador | Pares clave–valor validados y auditados (umbral de aprobación, plazos, moneda base…) | ver propuesta de entidades | Q-07 (efecto en lo emitido) |
| **CalendarioLaboral** | 10 | Borrador | Festivos y días laborables | ver propuesta de entidades | — |
| **EjecucionProceso** | 10 | Borrador | tipo, duración, procesados, fallos, causa | ver propuesta de entidades | — |
| **ErrorTecnico** | 10 | Borrador | codigoIncidencia, mensaje interno, fecha | ver propuesta de entidades | — |
| **ConsumidorAPI** | 11 | Borrador | credencial, limiteSolicitudes, activo | ver propuesta de entidades | — |
| **LlamadaAPI** | 11 | Borrador | consumidor, fecha, operacion, resultado | ver propuesta de entidades | — |
| **SolicitudExterna** | 11 | Borrador | consumidor, tipo, estadoValidacion | ver propuesta de entidades | — |

## 5. Patrones de Diseño

No son clases del dominio y **no tienen tabla en el E-R**, pero aparecen en los diagramas de clases y de secuencia. Los nombres quedan reservados para que nadie los invente de nuevo.

| Clase | Área | Estado | Patrón | Descripción |
|---|---|---|---|---|
| **GeneradorFactura** *(abstracta)* | 3 | **Propuesta** | Factory Method (Creator) | `generar(datos)`: valida, calcula totales y comprueba el umbral (RB-25); llama al método fábrica `crearFactura(datos)` |
| **GeneradorPuntual / GeneradorRecurrente / GeneradorRectificativa** | 3 | **Propuesta** | Factory Method (ConcreteCreator) | Cada uno crea su subclase de Factura. Solo crean; no cambian estados. `GeneradorRectificativa` rechaza una original que no esté emitida (precondición de CU-19) |
| **DatosFactura** `<<DTO>>` | 3 | **Propuesta** | — | Datos de entrada del generador: cliente, lineas, moneda, fechaVencimiento, fechaEmisionProgramada [0..1], configuracion [0..1], periodoInicio [0..1], facturaOriginal [0..1], motivo [0..1] |
| Proxy de permisos (nombre por decidir) | 9 | Borrador | Proxy de protección | Comprueba rol y asignación (RB-15, RB-21, RB-22, RB-38) y registra en RegistroAuditoria antes de delegar en el servicio real. Lo define el área 9, pero protege los servicios de todas las áreas. También filtra las llamadas del planificador con una identidad de sistema (cuestión 8.11) |
| Planificador | 10 | Borrador | — (componente interno) | Lanza las tareas automáticas a su hora: facturación recurrente (CU-17), recordatorios (CU-29), campaña anual (CU-13), caducidad de delegaciones y copias de seguridad (CU-53). Llama a los servicios a través del proxy. Cada ejecución queda en `EjecucionProceso` (FR-86). No es un actor (requisitos, sección 1.3) ni tiene tabla |
| `PasarelaPagos`, `AdaptadorStripe`, `AdaptadorBanco` | 6 | Borrador | Adapter | Integraciones simuladas (NFR-27) |
| `CanalEnvio`, `AdaptadorCorreo`, `AdaptadorWhatsApp` | 5 | Borrador | Adapter / Bridge | Canales de envío (NFR-27) |
| Facade de la API (nombre por decidir) | 11 | Borrador | Facade | Punto de entrada de la API externa; aplica las mismas reglas que la interfaz (RB-31) |

**State** para los estados de la factura queda **pendiente para la E3** (es un patrón de comportamiento que aún no se ha visto y habría tres jerarquías, una por estado). En la E2 los estados son enumerados con métodos.

## 6. Enumerados (valores únicos para todos)

| Enumerado | Valores | Usado en |
|---|---|---|
| **EstadoDocumental** | BORRADOR, PENDIENTE_APROBACION, EMITIDA, RECTIFICADA | Factura |
| **EstadoCobro** | PENDIENTE, VENCIDA, PARCIALMENTE_CONCILIADA, PAGADA, ANULADA, INCOBRABLE | Factura |
| **EstadoEnvio** | SIN_ENVIAR, ENVIADA, FALLO_ENVIO | Factura |
| **EstadoCliente** | PENDIENTE_ACTIVACION, ACTIVO, PAUSADO, BAJA_SOLICITADA, BAJA_EFECTIVA | Cliente (dec. 5) |
| **TipoEstado** | DOCUMENTAL, COBRO, ENVIO | HistorialEstadoFactura |
| **Rol** | LECTOR, ADMINISTRADOR, SUPERADMINISTRADOR | Usuario. Jerárquico (A-19): cada rol puede hacer lo del anterior |
| **EstadoSolicitud** | PENDIENTE, APROBADA, RECHAZADA | SolicitudExcepcion |
| **TipoPeriodo** | MES, TRIMESTRE | PeriodoContable |
| **EstadoPeriodo** | ABIERTO, CERRADO | PeriodoContable |
| **Canal** | EMAIL, WHATSAPP | Contacto, ConsentimientoCanal, Mensaje |
| **EstadoNotificacion** | NUEVA, LEIDA, RESUELTA | Notificacion |

Un valor nuevo se anuncia igual que un atributo nuevo.

**Pendientes de enumerar.** Estos atributos son estados o tipos cerrados, pero sus áreas siguen en Borrador. El responsable de cada área añade aquí su enumerado al cerrarla; hasta entonces no se pasan al E-R:

| Área | Atributos |
|---|---|
| 1 | `Documento.formato`, `Documento.destino` (según la decisión 4: puede acabar siendo una FK y no un enumerado) |
| 4 | `SolicitudExcepcion.tipo` |
| 5 | `Mensaje.estadoEntrega`, `PlantillaComunicacion.tipo` |
| 6 | `TransaccionPasarela.estado`, `BajaContable.tipo` |
| 7 | `Comentario.destino` (según la decisión 4), `Incidencia.estado`, `Tarea.tipo`, `Tarea.estado`, `Notificacion.tipo`, `Notificacion.prioridad`, `PreferenciaNotificacion.canal` |
| 9 | `CopiaSeguridad.estado`, `RestauracionCopia.resultado` |
| 10 | `EjecucionProceso.tipo` |
| 11 | `SolicitudExterna.tipo`, `SolicitudExterna.estadoValidacion`, `LlamadaAPI.operacion`, `LlamadaAPI.resultado` |

## 7. Reglas de traducción al E-R físico

Obligatorias para todos los que hagan el E-R. **Solo se traducen clases en estado Aprobada.**

**Nombres**
- Tablas en singular y `snake_case`: `factura`, `linea_factura`, `configuracion_recurrente`.
- Columnas en `snake_case`: `numero_factura`, `fecha_emision_programada`.
- PK: `id` en todas las tablas.
- FK: `<tabla>_id` (`cliente_id`). Si hay dos FK a la misma tabla, se nombran por el rol: `solicitante_id`, `aprobador_id`, `factura_rectificada_id`.

**Asociaciones**
- 1 — 0..* → FK en el lado "muchos". Multiplicidad mínima 1 → `NOT NULL`; 0 → admite nulos.
- Composición → FK `NOT NULL` con borrado en cascada: `linea_factura` e `historial_estado_factura` se borran junto con su factura.
- La cascada solo puede afectar a **borradores**: las facturas emitidas no se borran nunca (RB-03, RB-11), y un borrador sí se puede borrar (UR-08, CU-16: «los borrados dejan de existir»; no tiene efectos legales).
- **Garantía:** el borrado de una fila de `factura` solo se permite si `estado_documental = 'BORRADOR'`. Lo garantiza la aplicación (la operación de borrado de CU-16 comprueba el estado y FE-1 de CU-16 rechaza borrar una emitida) y, como defensa adicional en la base de datos, un disparador `BEFORE DELETE` **sobre `factura`** (no sobre las tablas hijas) que rechaza el borrado si el estado no es `BORRADOR`. Las líneas y el historial se borran después por la cascada de la propia base de datos, así que basta con controlar la tabla padre. Así un `DELETE` directo sobre una factura emitida no puede arrastrar sus líneas ni su historial.
- La trazabilidad del borrado (NFR-03) no depende del historial de estados: queda en `registro_auditoria` (quién borró qué borrador y cuándo), que no tiene FK a `factura` y sobrevive al borrado.
- Otras tablas que pueden apuntar a un borrador: ver cuestión 8.10.
- * — * → tabla intermedia con las dos FK (p. ej. `asignacion_cliente`, `conciliacion`, que además llevan atributos propios).
- Una asociación de una clase a sí misma → FK a la propia tabla (`factura.factura_rectificada_id`). En clases es `FacturaRectificativa → Factura (* — 1)`; en el E-R, como la tabla es única, la columna admite nulos (`0..1`, como en la propuesta §5). Es la misma relación a dos niveles.

**Herencia**
- `Factura` y sus subclases → **una sola tabla `factura`** con columna discriminadora `tipo` (PUNTUAL, RECURRENTE, RECTIFICATIVA). Las columnas propias de cada subclase admiten nulos, y un `CHECK` obliga a rellenarlas según el `tipo` (p. ej. `motivo` y `factura_rectificada_id` obligatorios si `tipo = RECTIFICATIVA`).

**Tipos**
- Enumerados → `VARCHAR` con `CHECK (valor IN (…))` usando los valores de la sección 6.
- Importes → `DECIMAL(12,2)`; porcentajes → `DECIMAL(5,2)`. Nunca coma flotante (NFR-31).
- Instantes (cuándo pasó algo) → `TIMESTAMP` en UTC. Fechas legales de factura → `DATE` con la fecha de negocio, no la del servidor (NFR-42, NFR-43).

**Trazabilidad**
- Toda tabla con cambios auditables lleva `creado_por`, `creado_en`, `modificado_por`, `modificado_en` (NFR-03). `creado_por` y `modificado_por` son FK a `usuario` que **admiten nulos**: nulo = Sistema, es decir, una acción automática (por ejemplo, las facturas recurrentes que crea el planificador en CU-17 o la `Tarea` que crea una solicitud de baja recibida por la API externa en CU-58).

**Atributos derivados**
- No se almacenan, salvo justificación.
- **Excepción justificada:** `base_imponible`, `impuestos` y `total` se guardan, porque una factura emitida es inalterable (RB-07, RB-11) y no puede depender de recalcular.
- `saldoPendiente` no se guarda nunca: se calcula (consulta o vista) a partir de las conciliaciones y la baja contable (RB-10).

**Restricciones que deben aparecer**
- `UNIQUE (configuracion_recurrente_id, periodo_inicio)` en `factura` (FR-100). **No choca con las facturas puntuales ni con las rectificativas:** en ellas las dos columnas son nulas, y las bases de datos habituales (PostgreSQL, MySQL, SQLite, Oracle) admiten varias filas con nulos en una restricción única porque un nulo no se considera igual a otro. Ojo: SQL Server solo admite un nulo; si se usara, haría falta un índice único filtrado (`WHERE tipo = 'RECURRENTE'`).
- `UNIQUE (serie_facturacion_id, numero_factura)` en `factura` (RB-01).
- `UNIQUE (id_evento_externo)` en la transacción de pasarela (no contar dos veces el mismo cobro).

**Qué no entra en el E-R**
- Clases de diseño de la sección 5 (generadores, DTO, adaptadores, proxy, fachada).
- Enumerados como tablas (son `CHECK`).
- `Sesion` y `TokenRecuperacion`: pendiente de la decisión 7.
- Datos de demostración (CU-55): no hay columna `es_demo`; van en un esquema separado con las mismas tablas (decisión 8).

**Organización**
- El E-R se hace por áreas, siguiendo el orden de aprobación de las clases. Una tabla solo puede tener FK hacia tablas del **núcleo** o de su propia área mientras el resto no esté aprobado.
- Una persona es responsable del E-R completo y junta las partes al final.

## 8. Cuestiones abiertas para la sesión

1. **Estado de cobro y conciliaciones de una factura `RECTIFICADA`** (áreas 3 y 6, relacionada con Q-12). Opciones: la original conserva su estado de cobro y el saldo se compensa con la rectificativa; el saldo pendiente pasa a la rectificativa; o se anula el saldo pendiente de la original.
2. **`TransaccionPasarela` o `MovimientoCobro`** con `origen` (área 6, FR-26).
3. **Dónde vive el estado del cliente** (decisión 5).
4. **Asociación `RelacionComercial` — `ConfiguracionRecurrente`** (áreas 2 y 3).
5. **Clases nuevas sin responsable confirmado:** Etiqueta, ObjetivoFacturacion, InformeProgramado; y si se modela Presupuesto.
6. Q-04, Q-07 y Q-12 siguen abiertas y se anotan como supuestos.
7. **Cambio de rol de un usuario (Q-13, áreas 9 y 4).** Al cambiar el rol, ¿qué pasa con sus clientes asignados (un Lector que asciende ya los ve todos; un Administrador que baja a Lector necesita asignaciones) y con las solicitudes de excepción que tenga pendientes de resolver? FR-110, RB-38 y el FA-1 de CU-49 ya están añadidos a los documentos de la Entrega 1.
8. **Contradicciones con la propuesta de entidades: resueltas** en la versión del 3/11 de `Propuesta_entidades_y_clases_Entrega2.md` (rol sin herencia, serie y periodo `* — 0..1`, `ObjetivoFacturacion` no opcional, CU-17 en las secuencias).
9. **Historial de un borrador eliminado: resuelta.** El historial se borra en cascada con el borrador (sección 7). Se descartan el borrado lógico (contradice UR-08 y CU-16) y la conservación del historial sin factura (filas huérfanas a cambio de poco). La composición del diagrama de clases se mantiene.
10. **Otras tablas que apuntan a un borrador** (áreas 4, 1 y 7). Al borrar un borrador:
    - **`SolicitudExcepcion` → `Factura`** (área 4). Un borrador cuya excepción se rechazó vuelve a borrador con su solicitud asociada. Propuesta: FK con `ON DELETE SET NULL`, para que la solicitud se conserve (CU-24 y auditoría de aprobaciones); en clases, la multiplicidad pasa de `* — 1` a `* — 0..1`. Acordar con el responsable del área 4.
      **Si se acepta, hay que cambiar `* — 1` por `* — 0..1` en cuatro sitios:**
      1. Catálogo, sección 3, fila de `SolicitudExcepcion` («SolicitudExcepcion sobre Factura (* — 1)»).
      2. Catálogo, sección 3, fila de `Factura` («SolicitudExcepcion sobre Factura (* — 1)»).
      3. Propuesta, sección 5, fila «SolicitudExcepcion se refiere a Factura».
      4. Diagrama `area3_3_relaciones_otras_areas.puml`: `SolicitudExcepcion "0..*" --> "1" Factura` pasa a `"0..1"`.
    - **`Comentario` y `Documento`** asociados a una factura (áreas 7 y 1). Dependen de la decisión 4; si apuntan a un borrador, se borran con él.
    - `Conciliacion` y `Mensaje` no se ven afectadas: solo existen para facturas emitidas.
11. **Acceso del planificador a los servicios** (áreas 9 y 10, arquitectura). Propuesta: **opción A**.
    - **A (propuesta):** el planificador llama a los servicios **a través del proxy**, con una **identidad de sistema** que tiene su propio conjunto de permisos, limitado a lo que hacen sus tareas (mínimo privilegio). Si cambian sus permisos o se añade una tarea, solo se toca ese conjunto de permisos: ni el planificador ni los servicios cambian.
    - B (descartada): el planificador llama directamente al servicio real. Sus permisos quedarían implícitos en el código y la auditoría tendría que resolverse aparte.
    - **La identidad de sistema no es un valor del enumerado `Rol`.** `Rol` describe personas, y mezclarlo complicaría RB-38 y RB-39. El proxy la reconoce como identidad técnica aparte.
    - **Solo la usa el planificador, desde dentro.** Nunca puede llegar por la interfaz ni por la API externa.
    - **Se audita igual:** sus acciones quedan en `RegistroAuditoria` como «Sistema».
    - **Cómo se representa «Sistema» en los datos: decidido, nulo = Sistema.** «Sistema» significa **acción automática, no hecha por una persona**: la del planificador o la de un sistema externo a través de la API (FR-59 a FR-61). Es el mismo criterio que `HistorialEstadoFactura`:
      - `Usuario genera RegistroAuditoria` pasa de `1 — 0..*` a `0..1 — 0..*`, y `RegistroAuditoria.usuario` es `[0..1]`.
      - `creado_por` y `modificado_por` admiten nulos (sección 7).
      - El nulo no se confunde con un usuario borrado: los usuarios no se borran, se desactivan (FR-37), así que un usuario nulo siempre es una acción automática.
      - Para saber **cuál** de las dos fue, cada una tiene su propia traza: `EjecucionProceso` para el planificador (FR-86) y `LlamadaAPI` para la API externa (FR-61).
      - Ojo con la API: según RB-31 sus solicitudes no modifican datos directamente, sino que pasan por validación o aprobación. Solo es «Sistema» la recepción (por ejemplo, la `Tarea` creada); si después una persona la aprueba, ese cambio queda a su nombre.
      - Descartada: una fila fija en `usuario` para el sistema. Obligaría a darle un rol que no puede ser de `Rol`, contradiría esta misma cuestión y complicaría RB-38 y RB-39.
    - **Las reglas de negocio se siguen comprobando en el servicio real** (RB-05, RB-26, RB-30, RB-37…): el proxy decide quién puede llamar, no si la operación es válida.
    - **Un rechazo del proxy a una tarea del planificador no puede pasar en silencio** (BR-04): se registra como fallo en `EjecucionProceso` (FR-86) y genera una alerta en el estado del sistema (CU-56).

## 9. Registro de cambios

### v2 (3/11/2026)

| Cambio | Motivo |
|---|---|
| `Factura.id` existe siempre; nuevo `numeroFactura` solo al emitir | El borrador necesita identificador; el número legal es correlativo por serie (RB-01, actualizada en el documento de requisitos) |
| `Factura` pasa a ser abstracta con tres subclases; se elimina `Factura.tipo` | Decisión 2 (herencia). `tipo` queda solo como discriminador en el E-R |
| Nuevos atributos de `Factura`: `modificacionManual`, `fechaEmisionProgramada`; `estadoEnvio` pasa a `[0..1]`; totales y saldo marcados como derivados | RB-25, CU-18, A-23, RB-10 |
| `pdfInalterable` se sustituye por `rutaPdf` + `hashPdf` | Expresar mejor RB-07 |
| `LineaFactura.impuesto` se sustituye por `porcentajeImpuesto` + asociación a `Impuesto` | RB-06: un cambio de impuesto no altera lo facturado |
| `ConceptoCatalogo.impuestoPorDefecto` pasa a ser asociación con `Impuesto` | Coherencia con la clase `Impuesto` |
| Nueva clase `ConfiguracionRecurrente` | CU-17, pasos 2 y 6 y FA-1 |
| Nuevas asociaciones: rectifica, generada desde, `SolicitudExcepcion` sobre `Factura`, `EntidadEmisora` tiene `SerieFacturacion`, `Factura` — `Conciliacion` | CU-19, CU-17, CU-22/23, glosario, RB-10 |
| `SerieFacturacion` y `PeriodoContable`: multiplicidad `0..1` desde `Factura` | Un borrador aún no tiene serie ni periodo |
| `Usuario`: `rol` como enumerado; se descarta la herencia por rol | Un usuario puede cambiar de rol |
| Nuevas secciones: estados de clase, convenciones, clases de diseño, enumerados, reglas de E-R, cuestiones abiertas | Trabajo en paralelo clases / E-R |
| Nuevas clases: Etiqueta, ObjetivoFacturacion, InformeProgramado, Presupuesto | CU-08, CU-45, CU-44, CU-20 |

### v2.1 (3/11/2026)

| Cambio | Motivo |
|---|---|
| Nueva clase `HistorialEstadoFactura` y enumerado `TipoEstado` (área 3) | FR-09 y decisión 1 de la propuesta |
| Convención de campos de trazabilidad (nota en clases, columnas en el E-R) | NFR-03 |
| Reglas de tipos: decimal exacto, instantes en UTC, fecha de negocio | NFR-31, NFR-42, NFR-43 |
| Datos de demostración en esquema separado | Decisión 8 de la propuesta |
| `ObjetivoFacturacion` deja de ser opcional; `Presupuesto`, `Etiqueta` y `CategoriaFactura` alineadas con la §4 de la propuesta | CU-45 y FR-82 vienen de la entrevista |
| Aclaración de la multiplicidad de «rectifica» en clases y en el E-R | Coherencia con la §5 de la propuesta |

### v2.2 (3/11/2026)

| Cambio | Motivo |
|---|---|
| `Usuario.cambiarRol()`; nuevos FR-110, RB-38, RB-39, A-26 y Q-13 en los requisitos, nota en UR-40 y FA-1, FE-2 y FE-3 en CU-49 | Hueco detectado: ningún caso de uso permitía cambiar el rol de un usuario existente |

### v2.3 (3/11/2026)

| Cambio | Motivo |
|---|---|
| La propuesta de entidades se alinea con este catálogo: rol sin herencia, serie y periodo `* — 0..1`, `ObjetivoFacturacion` no opcional, `HistorialEstadoFactura` y nuevas relaciones en la §5, CU-17 en las secuencias | Contradicciones de la sección 8.8 |
| El área 3 se divide en tres diagramas (`area3_1`, `area3_2`, `area3_3`); se recomienda la misma división al resto de áreas | El diagrama único superaba el tamaño que admite el servidor de PlantUML y era difícil de leer |

### v2.4 (3/11/2026)

| Cambio | Motivo |
|---|---|
| Lista de atributos pendientes de enumerar por área (sección 6) | La convención «enumerados, nunca `String`» no se cumplía aún en las áreas en Borrador |
| Nota sobre los nulos en `UNIQUE (configuracion_recurrente_id, periodo_inicio)` | Evitar que quien haga el E-R piense que choca con las facturas no recurrentes |
| Propuesta: sección 1 renombrada «Entidades principales»; historial con `estadoAnterior` / `estadoNuevo`; State pendiente para la E3; orden de las filas 33 / 33b; relación «HistorialEstadoFactura realizado por Usuario» | Incoherencias entre los dos documentos |
| Área 3, diagrama 3: `SolicitudExcepcion.estado` pasa de `String` a `EstadoSolicitud` | Convención de enumerados |

### v2.5 (3/11/2026)

| Cambio | Motivo |
|---|---|
| El borrado en cascada se limita a `linea_factura` de un borrador; las facturas emitidas no se borran; el historial va con `ON DELETE RESTRICT`; nueva cuestión 8.9 (sustituido en la v2.6) | La cascada borraba el historial de estados y chocaba con NFR-03 |
| Nuevos pendientes de enumerar: `Documento.formato` y `destino`, `Comentario.destino`, `LlamadaAPI.operacion` y `resultado` | Convención de enumerados |

### v2.6 (3/11/2026)

| Cambio | Motivo |
|---|---|
| `historial_estado_factura` se borra en cascada con su borrador; se elimina la regla provisional `ON DELETE RESTRICT`; cuestión 8.9 resuelta | `RESTRICT` impedía borrar cualquier borrador y contradecía UR-08 y CU-16. La trazabilidad queda en `RegistroAuditoria` |
| Nueva cuestión 8.10: FK de `SolicitudExcepcion` y comentarios y documentos de un borrador | Otras tablas que apuntan a una factura que puede borrarse |

### v2.7 (3/11/2026)

| Cambio | Motivo |
|---|---|
| Garantía de que solo se borran borradores: comprobación en la aplicación y disparador `BEFORE DELETE` | Sin ella, un `DELETE` sobre una factura emitida arrastraría su historial |
| La cuestión 8.10 enumera los cuatro sitios que cambian si se acepta `SET NULL` | Que no quede ninguno con la multiplicidad antigua |

### v2.8 (3/11/2026)

| Cambio | Motivo |
|---|---|
| Nueva cuestión 8.11: el planificador pasa por el proxy con una identidad de sistema y permisos propios (opción A) | Las tareas automáticas no tienen usuario; hay que decidir cómo las trata el control de acceso |
| `Planificador` añadido a las clases de diseño (área 10) y el proxy de permisos descrito como pieza transversal | El planificador no es un actor (análisis), pero sí un componente (diseño) |

### v2.9 (3/11/2026)

| Cambio | Motivo |
|---|---|
| «Sistema» se representa con usuario nulo: `Usuario genera RegistroAuditoria` pasa a `0..1 — 0..*`, `RegistroAuditoria.usuario` a `[0..1]`, y `creado_por` / `modificado_por` admiten nulos | La v2.8 hacía auditar al planificador como «Sistema», pero el modelo exigía siempre un usuario |

### v2.10 (3/11/2026)

| Cambio | Motivo |
|---|---|
| «Sistema» (usuario nulo) pasa a significar «acción automática, no hecha por una persona: planificador o API externa»; se indica cómo distinguirlas (`EjecucionProceso` / `LlamadaAPI`) | La API externa también actúa sin usuario (FR-59 a FR-61, CU-58) |

### v2.11 (3/11/2026)

| Cambio | Motivo |
|---|---|
| El estado «Congelada» pasa a llamarse **«Aprobada»** | «Congelada» podía entenderse como «detenida»; «Aprobada» expresa que el grupo la ha revisado y dado por buena |

### Cambios posteriores

| Fecha | Clase | Cambio | Quién lo propone | Aprobado |
|---|---|---|---|---|
| | | | | |

## 10. Cómo se usa

1. Antes de dibujar, busca tu clase aquí y copia nombre, atributos y enumerados.
2. Si necesitas un atributo, un valor de enumerado o una clase nueva, anótalo en la sección 9 y avisa al grupo.
3. Cuando tu área esté terminada, cambia sus clases a **Propuesta**; el grupo las confirma y pasan a **Aprobada**.
4. Quien hace el E-R solo traduce clases **Aprobadas** y siguiendo la sección 7.
5. Al revisar, comprueba la definición de terminado (sección 2) y que cada clase de referencia coincide con su fila.
6. Las operaciones no están aquí: salen de los pasos de las fichas de cada área.
