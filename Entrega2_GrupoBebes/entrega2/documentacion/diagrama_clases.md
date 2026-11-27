# Diagrama UML de clases

## Alcance

El diagrama de clases cubre las 11 áreas funcionales de la Entrega 1. Un solo diagrama no se leería, así que está **dividido por áreas**: cada una tiene su carpeta en `diagramas/clases/areaNN/`, con su responsable.

Cuando el diagrama de un área no cabe en una página, se parte en tres:

1. **Modelo del área:** sus clases, atributos, métodos y enumerados.
2. **Servicio y patrones:** el servicio que hace de punto de entrada del área y los patrones de diseño que usa.
3. **Relaciones con otras áreas:** las asociaciones con clases de otras áreas.

Cada clase se define completa en un solo diagrama. En los demás aparece solo con su nombre o con los atributos que hacen falta para entender la relación.

| Área | Responsable | Diagramas |
|---|---|---|
| 1. Clientes y contactos | Ana | `area1_1_modelo_clientes`, `area1_2_servicio_clientes` |
| 2. Relación comercial y suscripciones | Ana | `area2_1_relacion_comercial`, `area2_2_servicio_relacion_comercial` |
| 3. Emisión de facturas | Abdelnaybet | `area3_1_modelo_facturacion`, `area3_2_factory_method`, `area3_3_relaciones_otras_areas` |
| 4. Aprobaciones y cierre contable | Loraine | `area4_1_modelo_aprobaciones`, `area4_2_servicio_aprobaciones` |
| 5. Envío y comunicaciones | Loraine | `area5_1_modelo_comunicaciones`, `area5_2_servicios_adapter` |
| 6. Cobros, conciliación y saldo | Abdelnaybet | `area6_1_modelo_cobros`, `area6_2_adapter_servicio`, `area6_3_relaciones_otras_areas` |
| 7. Notificaciones y colaboración | Luca | `area7_1_modelo_notificaciones`, `area7_2_patrones_notificaciones`, `area7_3_relaciones_notificaciones` |
| 8. Informes y contabilidad | Luca | `area8_1_modelo_informes`, `area8_2_patrones_informes`, `area8_3_relaciones_informes` |
| 9. Usuarios, seguridad y auditoría | Imad | `area9_1_modelo_usuarios_y_auditoria`, `area9_2_patron_proxy_permisos`, `area9_3_relaciones_otras_areas`, `area9_4_acceso_y_copias` |
| 10. Configuración y sistema | Cristóbal | `area10_1_configuracion`, `area10_2_planificador`, `area10_3_calendario` |
| 11. API externa | Guillermo | `area11_api_externa` |


## Convenciones comunes

Todas las áreas siguen las mismas reglas de notación:

- Atributos **privados** (`-`) y operaciones públicas (`+`). Derivados con `/` (`/total`, `/importeSinAplicar`), inmutables con `{readOnly}` y opcionales con `[0..1]`.
- Toda asociación lleva **multiplicidad en los dos extremos** y un verbo o nombre de rol.
- Los estados y tipos cerrados son **enumerados**, nunca `String`. Los compartidos (`EstadoCobro`, `Rol`, `Canal`…) tienen un único conjunto de valores para todas las áreas.
- Una clase de otra área se dibuja con el estereotipo **`<<referencia área N>>`**, donde N es el área que la define: solo su nombre o sus atributos clave. Se define completa en su área. Una clase de la misma área que aparece en otro diagrama del área va solo con su nombre, sin estereotipo. El enumerado compartido `Canal` es del área 1 (nace en `Contacto.canalPreferido`); las áreas 5 y 7 lo usan como referencia.
- **`<<infraestructura>>`** marca los componentes técnicos que no son de ningún área funcional, como `GestorDocumentos` (guarda los ficheros: PDF, adjuntos y exportaciones). Se describen en `arquitectura.md`.
- Las restricciones que no se ven en las flechas van en notas: `{único: …}`, invariantes y precondiciones.
- Los campos de trazabilidad (`creadoPor`, `creadoEn`, `modificadoPor`, `modificadoEn`, NFR-03) no se dibujan en cada clase. Se indican una vez en una nota del diagrama.
- **Usuario nulo = Sistema.** Cuando una acción la hace el sistema (una tarea programada o una llamada de la API externa), el usuario que la realiza queda nulo. Los usuarios no se borran, solo se desactivan (FR-37), así que un nulo nunca es un usuario borrado.

## Decisiones de diseño comunes

**Un servicio por área como punto de entrada.** Cada área tiene un servicio (`ServicioFacturacion`, `ServicioCobros`, `ServicioAprobaciones`, `ServicioEnvio`…) con los casos de uso del área como operaciones. Las demás áreas, la interfaz, la API externa y el planificador no tocan las clases internas de un área: llaman a su servicio. La interfaz, la API, la pasarela y el planificador entran por el proxy de permisos; las llamadas entre servicios son internas y no vuelven a pasar por él.

**Lógica entre áreas en un solo sentido.** Las asociaciones entre áreas pueden navegarse en los dos sentidos, pero la lógica no. Una clase solo calcula o decide con datos de su propia área; si necesita algo interno de otra, se lo pide al servicio de esa área. Por ejemplo, `Factura` (área 3) no calcula su saldo pendiente: lo calcula `ServicioCobros` (área 6), porque depende de las conciliaciones. Así no hay ciclos de dependencia entre áreas y cada una se puede cambiar sin tocar las demás.

**Avisos entre áreas como eventos.** Cuando un área necesita reaccionar a algo que pasa en otra, la segunda no la llama: emite un evento y la primera lo escucha. En la Entrega 2 los eventos se declaran en notas. El mecanismo (patrón Observer) se formalizará en la Entrega 3.

| Evento | Lo emite | Lo escucha | Para qué |
|---|---|---|---|
| «abono emitido» | Área 3 (`FacturaRectificativa`) | Área 6 | Recalcular el estado de cobro de la factura original (A-27) |
| «solicitud creada» | Área 4 (`ServicioAprobaciones`) | Área 7 | Avisar a los aprobadores de que hay una solicitud pendiente (CU-22 paso 4) |
| «solicitud resuelta» | Área 4 (`ServicioAprobaciones`) | Áreas 3, 6 y 7 | Emitir o devolver a borrador la factura, registrar la baja contable y notificar al solicitante (CU-23, CU-36, CU-37) |
| «estado de cobro cambiado» | Área 6 (`ServicioCobros`) | Área 5 | Cancelar o reanudar recordatorios (RB-37) |
| «impago sobre el límite» | Área 6 | Área 7 | Avisar al responsable |
| «fallos de envío» | Área 5 | Área 7 | Crear la incidencia (CU-28) |

La excepción documentada es el área 9: el proxy de permisos y la auditoría son infraestructura que usan todas las áreas.

**Sin herencia por rol.** `Usuario` tiene un atributo `rol : Rol` (Usuario operativo, Administrador, Superadministrador) en lugar de una subclase por rol. Un usuario puede cambiar de rol (FR-110), y un objeto no puede cambiar de clase.

**El estado del cliente se calcula, no se guarda**: Las dos transiciones automáticas de la Entrega 1 (pendiente de activación → activo y baja solicitada → baja efectiva) ocurren cuando llega una fecha de la relación comercial. Por eso `Cliente./estadoCliente` es derivado: lo calcula `RelacionComercial.estadoCliente(fecha)` (área 2) sobre la relación comercial más reciente, en este orden: fecha de baja pasada → baja efectiva; fecha de baja futura → baja solicitada (la baja termina una pausa); fecha de inicio futura → pendiente de activación; pausa en curso → pausado; si no, activo. Un cliente sin ninguna relación está pendiente de activación. Con el mismo criterio, el rango de tarifa vigente sale de las revisiones anuales aplicadas y su fecha de efecto. Así no hace falta una tarea diaria, no hay dos datos que puedan contradecirse y la dependencia entre las áreas 1 y 2 va en un solo sentido.

**DTO para los datos que cruzan áreas.** Lo que un servicio devuelve a otra área o a la API se agrupa en clases `<<DTO>>` sin comportamiento (`DatosFactura`, `ResumenSaldo`, `ResumenFactura`…), para no exponer las clases del dominio.

## Patrones de diseño

| Patrón | Dónde | Clases | Motivo |
|---|---|---|---|
| **Factory Method** | Área 3 | `GeneradorFactura` y sus subclases `GeneradorPuntual`, `GeneradorRecurrente` y `GeneradorRectificativa` | Los tres tipos de factura se crean con los mismos pasos (validar, calcular totales, comprobar el umbral) y solo cambia qué clase se crea. Añadir un tipo nuevo no obliga a tocar el servicio |
| **Adapter** | Áreas 5 y 6 | `CanalEnvio` (correo, WhatsApp); `ReceptorNotificacionesPago` y `ProveedorExtractos` (Stripe, banco) | Los proveedores externos tienen su propia interfaz. Cambiar de proveedor es escribir otro adaptador (NFR-27) |
| **Proxy de protección** | Área 9 | Proxy de permisos | Comprueba rol y cartera (RB-15, RB-21, RB-22) y registra en la auditoría antes de llamar al servicio real, en un único sitio para todas las áreas. Hay un proxy por servicio (`ProxyFacturacion`, `ProxyCobros`…) con la misma interfaz que el servicio real; el solicitante lo da `ContextoSeguridad`, así que ninguna operación cambia su firma. El login (`ServicioAcceso`) no pasa por el proxy |
| **Facade** | Área 11 | `FachadaAPI` | Un único punto de entrada para los sistemas externos, con las mismas reglas que la interfaz (RB-31) |

Los patrones de comportamiento (Observer para los eventos, State para los estados de la factura, Command para las tareas del planificador y Strategy para los formatos de exportación) se dejan para la Entrega 3. En la Entrega 2 los estados son enumerados con métodos.

## Área 1: Clientes y contactos

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area1_1_modelo_clientes` | `Cliente`, `Contacto`, `ConsentimientoCanal`, `Documento`, `Etiqueta`, `CategoriaFactura` y los enumerados `EstadoCliente` y `Canal` |
| `area1_2_servicio_clientes` | `ServicioClientes` y los DTO del área (`DatosCliente`, `FichaCliente`…) |

**Decisiones**

- **Los datos personales están en `Contacto`.** Así la privacidad (CU-09) se resuelve en una sola clase: `anonimizar()` borra lo permitido y conserva lo que exige la ley contable (RB-17).
- **Un único contacto de facturación por cliente.** Un cliente activo no puede quedarse sin él (RB-27): `quitarContacto()` no lo permite sin designar otro.
- **El consentimiento es por canal** (`ConsentimientoCanal`). El área 5 lo consulta con `tieneConsentimiento()` antes de enviar (RB-28).
- **`/estadoCliente` es derivado.** Lo calcula el área 2 (ver «Decisiones de diseño comunes»).
- **`Documento` va sobre un cliente o sobre una factura, exactamente uno** (CU-04). El fichero lo guarda `GestorDocumentos`.
- **Las acciones masivas crean una `Tarea`** (área 7) para seguir el progreso. REASIGNAR la hace el área 9 a través del proxy.

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-01, CU-02 | `registrarCliente()`, `consultarFicha()`, `FichaCliente`, `{único: identificadorFiscal}` | Alta sin duplicados y ficha con sus facturas |
| CU-03, RB-28 | `Contacto`, `ConsentimientoCanal`, `registrarConsentimiento()` | Contactos y consentimiento por canal |
| CU-04 | `Documento`, `adjuntarACliente()`, `adjuntarAFactura()` | Adjuntos |
| CU-05 a CU-08 | `importarClientes()`, `importarHistoricoFacturas()`, `ejecutarAccionMasiva()`, `Etiqueta` | Importación, acciones masivas y etiquetas |
| CU-09, RB-17 | `localizarDatosPersonales()`, `anonimizarContacto()`, `Contacto.anonimizar()` | Privacidad |
| RB-27 | `Cliente.contactoFacturacion()`, `quitarContacto()` | Siempre un contacto de facturación |

## Área 2: Relación comercial y suscripciones

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area2_1_relacion_comercial` | `RelacionComercial`, `Pausa`, `RangoTarifa`, `RevisionAnualPlan` y `EstadoRevision` |
| `area2_2_servicio_relacion_comercial` | `ServicioRelacionComercial` y las operaciones del área 3 que usa |

**Decisiones**

- **Estado del cliente y rango vigente calculados** con `estadoCliente(fecha)` y `rangoVigente(fecha)`, sin tarea diaria (ver «Decisiones de diseño comunes»).
- **La baja es definitiva** (A-25). Volver a trabajar con la empresa crea una relación nueva, y el historial se conserva (RB-12). Como mucho hay una relación activa por cliente.
- **Una pausa sigue en curso hasta que se confirma la reactivación**, aunque haya pasado la fecha prevista (RB-29, CU-11 FA-1). El aviso de reactivación lo lanza el planificador.
- **El área 2 no factura.** Comunica al área 3 el importe, las pausas y la baja, cada uno con su fecha. La dependencia va del área 2 al área 3, nunca al revés.
- **Revisión anual con doble control.** Quien corrige la facturación no puede aprobar la revisión (FR-74). El nuevo importe se aplica desde su fecha de efecto y las facturas anteriores no cambian (RB-36).
- **`comprobarBaja()` la usa también la API** (CU-58, RB-31): una baja pedida desde fuera sigue las mismas reglas.

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-10 | `crearRelacion()`, `modificarRelacion()` | Alta y modificación de la relación |
| CU-11, RB-05, RB-29 | `pausar()`, `reactivar()`, `Pausa`, `avisarReactivacionesPendientes()` | Pausas |
| CU-12, RB-13 | `darDeBaja()`, `comprobarBaja()` | Baja, con el recobro pendiente |
| CU-13, RB-26, RB-36, FR-74 | `prepararRevisionAnual()`, `RevisionAnualPlan`, `aplicarRevision()`, `mantenerPlan()` | Revisión anual |
| CU-14 | `configurarRangos()`, `RangoTarifa`, `{sin solapes ni huecos}` | Rangos de tarifa |

## Área 3: Emisión de facturas

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area3_1_modelo_facturacion` | `Factura` (abstracta) y sus subclases, líneas, impuestos, series, entidad emisora, configuración recurrente, historial de estados y enumerados |
| `area3_2_factory_method` | `ServicioFacturacion`, los generadores (Factory Method) y `DatosFactura` |
| `area3_3_relaciones_otras_areas` | `Cliente`, `RelacionComercial`, `PeriodoContable`, `SolicitudExcepcion`, `Conciliacion` y `Usuario` como referencias |

**Decisiones**

- **Herencia por tipo de factura.** `Factura` es abstracta, con `FacturaPuntual`, `FacturaRecurrente` y `FacturaRectificativa`. Cada subclase añade lo suyo: el periodo y el prorrateo en la recurrente, y el motivo y `esAbono()` en la rectificativa.
- **Tres estados independientes.** `estadoDocumental` (borrador, pendiente de aprobación, emitida, rectificada), `estadoCobro` y `estadoEnvio`. Los dos últimos son nulos hasta que la factura se emite (A-23). Cada cambio de cualquiera de los tres queda en `HistorialEstadoFactura` (FR-09).
- **Identificador y número legal separados.** `id` existe desde el borrador. `numeroFactura` se asigna en `emitir()` desde la serie y no cambia (RB-01).
- **Los estados de cobro y envío los cambian otras áreas con métodos propios de `Factura`.** El área 6 usa `registrarEstadoCobro()` y `marcarCobroExcesivo()`; el área 5 usa `registrarEstadoEnvio()`, `marcarEnDisputa()` y `quitarDisputa()`. `Factura` no sabe nada de esas áreas.
- **La rectificativa no modifica la original.** `FacturaRectificativa.emitir()` emite y después marca la original como rectificada (RB-11). Si es un abono (total negativo), emite el evento «abono emitido» y el área 6 recalcula el cobro de la original (A-27).
- **El impuesto se copia en la línea.** `LineaFactura.porcentajeImpuesto` guarda el porcentaje vigente al crear la línea, para que un cambio de impuesto no altere lo ya facturado (RB-06).
- **`ServicioFacturacion` pide la serie y el periodo, no `Factura`.** Así el área 3 no depende del área 4.

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-15 | `ServicioFacturacion.emitirPuntual()`, `GeneradorPuntual`, `Factura.emitir()` | Emitir una factura puntual |
| CU-15 FA-3, RB-25 | `Factura.requiereAprobacion()`, `marcarPendienteAprobacion()` | Facturas por encima del umbral |
| CU-16 | `Factura.agregarLinea()`, `quitarLinea()`, `volverABorrador()` | Gestionar borradores |
| CU-17, FR-100 | `ServicioFacturacion.generarRecurrentes()`, `GeneradorRecurrente`, `{único: configuración + periodoInicio}` | Facturación recurrente sin duplicados |
| CU-19, RB-11, A-27 | `ServicioFacturacion.emitirRectificativa()`, `FacturaRectificativa.emitir()`, `esAbono()`, `Factura.marcarRectificada()` | Rectificar sin modificar la original |
| RB-01 | `SerieFacturacion.asignarSiguienteNumeroFactura()` | Número correlativo por serie al emitir |
| RB-06 | `LineaFactura.porcentajeImpuesto` | Lo facturado no cambia si cambia el impuesto |
| FR-09 | `HistorialEstadoFactura` | Historial de los tres estados |
| CU-23 | `ServicioFacturacion.alResolverSolicitud()` | Emitir o devolver a borrador al resolverse la aprobación |

## Área 4: Aprobaciones y cierre contable

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area4_1_modelo_aprobaciones` | `SolicitudExcepcion`, `PeriodoContable`, `ReaperturaPeriodo` y sus enumerados |
| `area4_2_servicio_aprobaciones` | `ServicioAprobaciones` |

**Decisiones**

- **Solicitud genérica.** `SolicitudExcepcion` no sabe qué se aprueba (descuento, factura sobre el umbral, prorrateo o baja contable). Quien la pide actúa al recibir «solicitud resuelta», así que el área 4 no depende de las áreas 3 y 6.
- **Sobre una factura o sobre una configuración recurrente, exactamente una.** La excepción de prorrateo se pide antes de que exista la factura (CU-22).
- **Quién aprueba depende del importe.** Por encima del umbral de `ConfiguracionGlobal`, solo un Superadministrador (RB-04), y nadie aprueba su propia solicitud (FR-74). Rechazar exige comentario.
- **Dos avisos:** «solicitud creada» (el área 7 avisa a los aprobadores) y «solicitud resuelta» (la escuchan las áreas 3, 6 y 7).
- **Cierre de periodo.** No se cierra con operaciones pendientes (CU-25 FE-2). Solo un Superadministrador lo reabre, con motivo, y queda una `ReaperturaPeriodo` (CU-26).

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-22, RB-25 | `solicitar()`, `solicitarExcepcionProrrateo()` | Proponer sin emitir |
| CU-23, RB-04, FR-74 | `listarPendientes()`, `aprobar()`, `rechazar()`, `SolicitudExcepcion.aprobar()` | Resolver según el umbral |
| CU-24 | `listarMisSolicitudes()` | Bandeja del solicitante |
| CU-25 | `cerrarPeriodo()`, `operacionesPendientes()` | Cierre contable |
| CU-26 | `reabrirPeriodo()`, `ReaperturaPeriodo` | Reapertura con motivo |

## Área 5: Envío y comunicaciones

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area5_1_modelo_comunicaciones` | `PlantillaComunicacion`, `ReglaRecordatorio`, `Mensaje` y sus enumerados |
| `area5_2_servicios_adapter` | `ServicioEnvio`, `ServicioRecordatorios` y el patrón Adapter de los canales |

**Decisiones**

- **Dos servicios.** `ServicioEnvio` es el punto de entrada (envío, plantillas y disputa). `ServicioRecordatorios` lo lanza el planificador y escucha «estado de cobro cambiado».
- **Adapter para los canales.** `CanalEnvio`, con `AdaptadorCorreo` y `AdaptadorWhatsApp`, que llaman a servicios simulados (A-03, NFR-27).
- **Un `Mensaje` por envío,** con la plantilla usada (RB-35). Reintentar suma un intento al mismo mensaje: la factura no se duplica.
- **El área 5 no toca la factura.** Pide al área 3 el cambio de estado de envío y la disputa.
- **Plantillas validadas:** deben llevar las variables obligatorias (RB-16), y hay una activa por tipo e idioma.
- **Recordatorios:** no se envían a facturas pagadas, en disputa o de relaciones no iniciadas (RB-37, RB-30). Una fecha que cae en festivo pasa al siguiente día laborable (FR-83).

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-27, RB-28 | `enviarFactura()`, `CanalEnvio`, `Mensaje` | Envío por el canal preferido |
| CU-28, FR-80 | `consultarMensajes()`, `reintentarEnvio()`, evento «fallos de envío» | Gestionar el fallo |
| CU-29, CU-30, RB-16 | `ReglaRecordatorio`, `procesarVencimientos()`, `PlantillaComunicacion.validarVariables()` | Recordatorios y plantillas |
| CU-31 | `marcarEnDisputa()`, `quitarDisputa()` | Factura en disputa |
| RB-37 | `alCambiarEstadoCobro()` | Cancelar recordatorios de lo pagado |

## Área 6: Cobros, conciliación y saldo

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area6_1_modelo_cobros` | `MovimientoCobro`, `Conciliacion`, `BajaContable`, `ResumenSaldo` y enumerados |
| `area6_2_adapter_servicio` | `ServicioCobros` y los adaptadores de la pasarela (Stripe) y del banco |
| `area6_3_relaciones_otras_areas` | `Factura`, `FacturaRectificativa`, `Cliente`, `Usuario` y `SolicitudExcepcion` como referencias |

**Decisiones**

- **Un movimiento de cobro, varias conciliaciones.** Un `MovimientoCobro` (entrada de dinero de la pasarela o del banco) puede pagar varias facturas, y una factura puede cobrarse con varios movimientos. Cada aplicación es una `Conciliacion`, que crea el propio movimiento con `aplicarA()`.
- **Deshacer no borra.** `Conciliacion.deshacer()` marca la conciliación con fecha, motivo y usuario, y conserva la traza (FR-27).
- **El sobrante se queda en el movimiento.** Si se cobra más de lo que se debe, el exceso no se aplica a la factura: queda en `/importeSinAplicar` y la factura se marca con cobro excesivo (A-28).
- **El saldo y el vencimiento los calcula el servicio.** `ServicioCobros.calcularSaldoPendiente()` resta del total las conciliaciones vigentes, la baja contable y los abonos (RB-10, A-27). `estaVencida()` indica si hay saldo con el vencimiento pasado. Ninguno de los dos se guarda.
- **El estado `VENCIDA` sí se guarda.** Lo pone una tarea diaria del planificador (`actualizarVencimientos()`) en las facturas pendientes sin ningún cobro, siguiendo la tabla de transiciones de la Entrega 1.
- **«Vencida» responde a dos preguntas distintas.** `VENCIDA` es la transición de la Entrega 1 para facturas sin ningún cobro; una factura cobrada en parte sigue `PARCIALMENTE_CONCILIADA` aunque pase el plazo. `estaVencida()` responde otra cosa: si queda saldo con el vencimiento pasado, y es lo que usan las alertas de impago. El estado de cobro se guarda, a diferencia del estado del cliente, porque cada cambio deja historial y avisa a otras áreas («estado de cobro cambiado»).
- **Dos interfaces pequeñas para los proveedores.** `ReceptorNotificacionesPago` para la pasarela y `ProveedorExtractos` para el banco, en lugar de una sola. Cada adaptador implementa solo lo que usa (segregación de interfaces).
- **La baja contable reutiliza la aprobación del área 4.** `BajaContable` solo se crea al aprobarse su `SolicitudExcepcion`, y no guarda solicitante ni aprobador (CU-36).

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-33, RB-10 | `ServicioCobros.consultarSaldo()`, `ResumenSaldo` | Saldo del cliente, distinto de la facturación acumulada |
| CU-34, FR-25 | `ServicioCobros.registrarNotificacion()`, `AdaptadorStripe`, `{único: origen + idExterno}` | Registrar pagos de la pasarela sin duplicados |
| CU-35, FR-84, FR-87 | `consultarBandejaConciliacion()`, `importarMovimientos()`, `conciliarAutomaticamente()`, `conciliarManualmente()`, `deshacerConciliacion()`, `MovimientoCobro.aplicarA()` | Conciliar con la misma moneda y sin duplicar |
| FR-27 | `Conciliacion.deshacer()` | Deshacer conservando la traza |
| CU-36, RB-08, A-24 | `solicitarBajaContable()`, `registrarBajaAprobada()`, `BajaContable` | Baja contable aprobada, nunca como «pagada» |
| A-27 | `recalcularEstadoCobro()` (escucha «abono emitido») | El abono compensa el saldo de la original |
| A-28 | `MovimientoCobro./importeSinAplicar`, `enRevision`, `Factura.cobroExcesivo` | Cobros por encima del saldo |
| RB-37 | Evento «estado de cobro cambiado» | Cancelar o reanudar recordatorios |

## Área 7: Notificaciones y colaboración

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area7_1_modelo_notificaciones` | `Notificacion`, `PreferenciaNotificacion`, `Incidencia`, `Comentario`, `Tarea` y sus enumerados |
| `area7_2_patrones_notificaciones` | `ServicioNotificaciones` y los manejadores de eventos |
| `area7_3_relaciones_notificaciones` | `Usuario`, `Cliente` y `Factura` como referencias |

**Decisiones**

- **El área 7 escucha, no decide.** `ManejadorAlertasCobro`, `ManejadorAlertasEnvio` y `ManejadorSolicitudesResueltas` implementan `EscuchadorEventosDominio` y crean la notificación. Es la base del Observer de la Entrega 3.
- **Las alertas no se repiten.** No se crea otra si ya hay una sin resolver del mismo tipo para la misma factura o cliente.
- **Leída y resuelta son estados distintos** (CU-37).
- **Comentarios internos.** No se envían al cliente, y los restringidos solo los ven Administrador y Superadministrador (RB-32). Cada uno va sobre un cliente, una factura o una incidencia, exactamente uno.
- **Tareas** para las acciones masivas y las solicitudes de la API. Responsable nulo = sin asignar; cliente nulo = varios clientes.

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-37, CU-38 | `Notificacion`, `obtenerPantallaTrabajo()`, `PreferenciaNotificacion` | Pantalla de trabajo y preferencias |
| CU-40, RB-20, RB-22 | `Incidencia`, `abrirIncidencia()`, `cerrarIncidencia()` | Incidencias internas |
| CU-41, RB-32 | `Comentario`, `comentar()`, `esVisiblePara()` | Comentarios internos |
| CU-07, CU-58 | `Tarea`, `crearTarea()`, `asignarTarea()` | Tareas de seguimiento |
| UR-92, UR-93, FR-80 | `ManejadorAlertasCobro`, `ManejadorAlertasEnvio` | Alertas de impago y de envío |

## Área 8: Informes y contabilidad

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area8_1_modelo_informes` | `ObjetivoFacturacion`, `PaqueteContable`, `TipoCambio`, `ExportacionMasiva`, `InformeProgramado` y sus enumerados |
| `area8_2_patrones_informes` | `ServicioInformes`, `GeneradorPaqueteContable` y `ResumenFinancieroDTO` |
| `area8_3_relaciones_informes` | `PeriodoContable` y `Usuario` como referencias |

**Decisiones**

- **El área 8 solo lee.** Pide las cifras a `ServicioFacturacion` y `ServicioCobros` y no consulta las tablas de otras áreas.
- **Paquete contable inalterable.** Solo se genera con el periodo cerrado, es un ZIP con su hash y cada versión se conserva (RB-19).
- **Tipo de cambio solo para informes.** Convierte a la moneda base sin alterar el total legal de las facturas (FR-85).
- **Exportaciones temporales.** Caducan, y las borra el planificador con `borrarExportacionesCaducadas()` (FR-95).

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-42 | `generarDashboardFinanciero()`, `ResumenFinancieroDTO` | Dashboard |
| CU-43, FR-95 | `exportarInforme()`, `ExportacionMasiva`, `borrarExportacionesCaducadas()` | Exportaciones que caducan |
| CU-44 | `InformeProgramado`, `ejecutarInformeProgramado()` | Informes programados |
| CU-45, FR-82 | `ObjetivoFacturacion` | Objetivos de facturación y cobro |
| CU-46, RB-19 | `compilarPaqueteContable()`, `GeneradorPaqueteContable` | Paquete contable |
| FR-85 | `TipoCambio` | Consolidación de divisas |

## Área 9: Usuarios, seguridad y auditoría

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area9_1_modelo_usuarios_y_auditoria` | `Usuario`, `Sesion`, `TokenRecuperacion`, `AsignacionCliente`, `Delegacion`, `RegistroAuditoria`, `DescargaFichero`, copias y enumerados |
| `area9_2_patron_proxy_permisos` | Proxy de permisos, `ContextoSeguridad`, `Solicitante`, `IdentidadSistema` y `ControlAcceso` |
| `area9_3_relaciones_otras_areas` | `Cliente`, `Documento` y `ExportacionMasiva` como referencias |
| `area9_4_acceso_y_copias` | `ServicioAcceso` y `ServicioCopias` |

**Decisiones**

- **Un proxy por servicio** (Proxy de protección), con la misma interfaz que el servicio real. `ControlAcceso` decide y el proxy deja el `RegistroAuditoria`.
- **`ContextoSeguridad` da el solicitante.** Es un `Usuario` o la `IdentidadSistema` del planificador, de la API y de los webhooks (interfaz `Solicitante`), así que ninguna operación lleva el solicitante como parámetro.
- **El inicio de sesión no pasa por el proxy.** `ServicioAcceso` bloquea la cuenta 15 minutos tras 5 fallos seguidos (A-07), cierra la sesión tras 30 minutos sin actividad (A-06) y guarda solo el hash del enlace de recuperación.
- **Cartera.** Cada cliente tiene un solo responsable vigente (`AsignacionCliente`). Una `Delegacion` cede toda la cartera durante un periodo (FR-41).
- **Auditoría inalterable.** Solo se crea y se consulta; usuario nulo = Sistema.
- **Siempre queda un Superadministrador activo** (RB-39). Lo comprueba `ServicioUsuarios`, porque hay que contar usuarios.

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-48, A-06, A-07 | `ServicioAcceso.autenticar()`, `validarSesion()`, `Usuario.estaBloqueado()`, `Sesion` | Acceso y sesión |
| CU-49, FR-110, RB-38, RB-39 | `invitarUsuario()`, `cambiarRol()`, `desactivar()` | Gestión de usuarios |
| CU-50, RB-15, FR-39, FR-41 | `asignarCliente()`, `reasignarCliente()`, `delegarClientes()`, `AsignacionCliente`, `Delegacion` | Cartera y delegación |
| NFR-03 | `RegistroAuditoria`, `ProxyPermisos.autorizarYRegistrar()` | Auditoría |
| FR-79, FR-95 | `DescargaFichero`, `registrarDescarga()` | Registro de descargas |
| CU-53, CU-59, NFR-11 | `ServicioCopias.lanzarCopia()`, `restaurar()` | Copias de seguridad |

## Área 10: Configuración y sistema

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area10_1_configuracion` | `ConfiguracionGlobal` y `EntradaConfiguracion` |
| `area10_2_planificador` | `Planificador`, `TareaAutomatica`, `TareaProgramada`, `EjecucionProceso`, `DetalleFallo` y `ErrorTecnico` |
| `area10_3_calendario` | `CalendarioLaboral` y `FechaFestiva` |

**Decisiones**

- **Configuración con vigencia.** Cada valor tiene sus fechas, y las demás áreas leen con `obtenerValor(clave, fecha)`. Así se sabe qué valor aplicaba en una fecha (Q-07).
- **Una tarea por tipo de proceso.** `Planificador.ejecutar(tipo)` crea la `EjecucionProceso` y se la pasa a la `TareaAutomatica` de ese tipo, que llama a su servicio por el proxy con la `IdentidadSistema`. Una nota del diagrama dice qué operación lanza cada tipo.
- **Cada ejecución queda registrada** con sus fallos (CU-56). Tras una caída se puede repetir sin duplicar (FR-100).
- **Errores técnicos.** El mensaje interno nunca se muestra al usuario, que ve un texto con el código de incidencia (FR-61, FR-62).
- **El calendario laboral lo consultan las demás áreas** (FR-83). El área 10 no conoce `Factura` ni `Mensaje`.

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| Q-07, RB-04 | `ConfiguracionGlobal.obtenerValor()`, `EntradaConfiguracion` | Parámetros con vigencia (umbral, límites…) |
| FR-86, FR-100 | `Planificador.ejecutar()`, `TareaAutomatica`, `TipoProceso` | Tareas en segundo plano |
| CU-56 | `EjecucionProceso`, `DetalleFallo` | Estado de las ejecuciones |
| FR-61, FR-62 | `ErrorTecnico`, `/mensajeParaUsuario()` | Errores sin detalles internos |
| FR-83, Q-02 | `CalendarioLaboral.siguienteDiaLaborable()`, `FechaFestiva` | Días laborables |
| CU-55 | `TipoProceso.CARGA_DATOS_DEMO` | Datos de demostración |

## Área 11: API externa

**Diagramas**

| Diagrama | Contenido |
|---|---|
| `area11_api_externa` | `FachadaAPI`, `ConsumidorAPI`, `LlamadaAPI`, `SolicitudExterna`, `DatosConsultaCliente` y sus enumerados |

**Decisiones**

- **Facade.** `FachadaAPI` es el único punto de entrada de los sistemas externos y pasa por el proxy con las mismas reglas que la interfaz (RB-31).
- **Recibe la credencial, no el consumidor.** Una credencial mala no tiene `ConsumidorAPI`. Cada llamada deja una `LlamadaAPI`, también las no autorizadas.
- **Límite de solicitudes** por consumidor y periodo.
- **La API no modifica datos.** Una baja pedida por la API se comprueba con las mismas reglas (`comprobarBaja()`) y solo crea una tarea; la baja la hace una persona (CU-58, CU-12 FA-1).
- **Solo DTO hacia fuera** (`DatosConsultaCliente`), nunca entidades del dominio.

**Trazabilidad**

| Requisito / CU | Clases y operaciones | Motivo |
|---|---|---|
| CU-57 | `consultarDatos()`, `DatosConsultaCliente` | Consulta de datos autorizados |
| CU-58, RB-31 | `enviarSolicitud()`, `SolicitudExterna`, `comprobarBaja()`, `crearTarea()` | Solicitudes con las mismas reglas |
| NFR-50 | `ConsumidorAPI.credencialHash` | Credenciales separadas |
| FR-61 | `LlamadaAPI.codigoIncidencia` | Errores con código |

## Consistencia con otros modelos

**Con el modelo de datos.** No toda clase tiene tabla:

- Los servicios, los generadores, los adaptadores, el proxy y los DTO son clases de diseño y no se guardan.
- Las herencias se guardan en una sola tabla con una columna `tipo`. Por ejemplo, las tres subclases de `Factura` van en la tabla `factura`.
- Los atributos derivados (`/total`, `/importeSinAplicar`, el saldo pendiente) no son columnas, salvo los que se guardan para que una factura emitida no cambie (RB-07, RB-11).
- Los enumerados son columnas de texto con su `CHECK`.
- Los campos de trazabilidad sí son columnas.

El detalle está en `modelo_datos.md`.

**Con las secuencias y la arquitectura.** Las clases que aparecen en los diagramas de secuencia existen en algún diagrama de clases, con los mismos nombres de operación. Por ejemplo, las secuencias de CU-19 usan `ServicioFacturacion.emitirRectificativa()`, `FacturaRectificativa.emitir()`, `Factura.marcarRectificada()` y `Factura.registrarEstadoCobro()`. Los servicios de cada área son los componentes de la capa de servicios de la arquitectura (`arquitectura.md`).

## Alternativas descartadas

| Alternativa | Por qué se descartó |
|---|---|
| Una subclase de `Usuario` por rol | Un usuario puede cambiar de rol y un objeto no puede cambiar de clase |
| Saldo pendiente como atributo derivado de `Factura` | Obligaba al área 3 a conocer las conciliaciones del área 6 (lógica en los dos sentidos) |
| Una sola interfaz `PasarelaPagos` para la pasarela y el banco | Un banco no es una pasarela, y cada adaptador habría implementado métodos que no usa |
| Que `ServicioAprobaciones` emita la factura o registre la baja al aprobar | El área 4 tendría que conocer las áreas 3 y 6. Es genérico y avisa con «solicitud resuelta» |
| Patrón State para los estados de la factura en esta entrega | Es un patrón de comportamiento que corresponde a la Entrega 3, y habría tres jerarquías, una por estado |
