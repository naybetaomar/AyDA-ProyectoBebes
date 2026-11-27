# Diagramas UML de secuencia

## Selección de escenarios

Se han elegido escenarios sobre todo de los casos de uso del **núcleo** de la primera versión (apartado 1.4 de los requisitos). CU-57/58 son complementarios, pero se incluyen porque son la única entrada por la API externa. Entre ellos se han elegido los que pasan por las piezas más importantes de la arquitectura:

- el proxy de permisos;
- la fachada de la API externa;
- el planificador;
- los adaptadores de proveedores externos;
- los avisos (eventos) entre áreas.

Entre todos, los eventos entre áreas aparecen al menos en una secuencia. «Impago sobre el límite» no lo dispara ningún caso de uso, sino una tarea diaria del planificador, así que tiene su propio escenario automático. Las variantes de un mismo caso de uso (un flujo alternativo o de excepción relevante) van en un diagrama aparte.

| Diagrama | Caso de uso y escenario | Responsable |
|---|---|---|
| `cu15_1_emitir_factura.puml` | CU-15, flujo principal: emisión directa | Abdelnaybet |
| `cu15_2_emitir_requiere_aprobacion.puml` | CU-15, FA-3: supera el umbral y pasa a aprobación | Abdelnaybet |
| `cu19_1_emitir_rectificativa.puml` | CU-19 (1), flujo principal: emisión de la rectificativa | Abdelnaybet |
| `cu19_2_abono_recalculo_cobro.puml` | CU-19 (2): el área 6 recibe el abono y recalcula el cobro de la original (A-27) | Abdelnaybet |
| `tarea_1_vencimientos.puml` | Tarea diaria del planificador (1): facturas que pasan a vencidas | Abdelnaybet |
| `tarea_2_impagos.puml` | Tarea diaria del planificador (2): alertas de impago (UR-92, UR-93; la alerta se ve en CU-37) | Abdelnaybet |
| `cu17_1_generar_recurrentes.puml` | CU-17 (1), flujo principal: generación mensual por el planificador | Luca |
| `cu17_2_recuperacion_tras_caida.puml` | CU-17 (2): recuperación tras una caída a mitad de la generación | Luca |
| `cu27_enviar_factura.puml` | CU-27, flujo principal: envío por correo; el fallo emite «fallos de envío» | Ana |
| `cu28_gestionar_fallo_envio.puml` | CU-28: consultar el fallo, corregir el contacto y reintentar | Ana |
| `cu48_1_acceso_correcto.puml` | CU-48 (1), flujo principal: acceso correcto | Guillermo |
| `cu48_2_credencial_incorrecta.puml` | CU-48 (2): credencial incorrecta | Guillermo |
| `cu48_3_cuenta_bloqueada.puml` | CU-48 (3): cuenta bloqueada | Guillermo |
| `cu22_proponer_excepcion_prorrateo.puml` | CU-22: proponer una excepción de prorrateo (la propuesta de una factura sigue CU-15, diagrama 2) | Cristóbal |
| `cu23_1_aprobar_solicitud.puml` | CU-23 (1), flujo principal: aprobar (FE-1 y FA-1 como alternativas) | Cristóbal |
| `cu23_2_rechazar_solicitud.puml` | CU-23 (2), FA-2: rechazar con comentario | Cristóbal |
| *pendiente* | CU-34 / CU-35: cobro por la pasarela y conciliación | Loraine |
| *pendiente* | CU-57 / CU-58: consulta y solicitud por la API externa | Imad |

## Notación

Todos los diagramas siguen las mismas reglas:

- **Participantes:** instancias con el nombre subrayado (`: ServicioFacturacion`, `r : FacturaRectificativa`).
- **Llamadas:** solo se numeran las llamadas. Las respuestas son flechas discontinuas sin número.
- **Creación:** los objetos se crean con una flecha discontinua hacia la caja del participante, que aparece a esa altura.
- **Base de datos:** el acceso a la base de datos se dibuja como un mensaje hacia un punto en el borde derecho («buscar… en BD», «guardar… en BD»). La persistencia no es una clase del dominio.
- **Avisos entre áreas (eventos):** flecha verde. Indica que el área que emite no llama a la que escucha (ver «Lógica entre áreas en un solo sentido» en `diagrama_clases.md`).
- **Comprobación de permisos:** toda petición de un usuario, de la API o del planificador entra por el proxy de permisos, que la autoriza y la registra en la auditoría antes de llamar al servicio. La única excepción es el inicio de sesión (CU-48), que ocurre antes de que haya un solicitante.

## CU-15: Emitir factura puntual

**Diagrama 1. Emisión directa.** El Usuario operativo pide emitir una factura y el proxy comprueba su rol y que el cliente esté en su cartera (RB-15). `ServicioFacturacion` usa el `GeneradorPuntual` (Factory Method), que crea la factura y sus líneas, calcula los totales y comprueba el umbral. Como no lo supera, el servicio busca el periodo contable abierto y la serie ordinaria, y llama a `factura.emitir()`. La factura toma el siguiente número de la serie (RB-01) y deja la transición en el historial. Al final, `GestorDocumentos` genera el PDF y se guarda todo.

**Diagrama 2. Supera el umbral (FA-3).** Igual hasta la comprobación del umbral. Como lo supera, la factura pasa a pendiente de aprobación y `ServicioFacturacion` crea la solicitud en `ServicioAprobaciones` (área 4). La factura no se emite todavía. Cuando se resuelve la solicitud, el área 4 emite «solicitud resuelta» y `ServicioFacturacion.alResolverSolicitud()` emite la factura (diagrama 1, desde el paso de emitir) o la devuelve a borrador (CU-23).

**Decisiones**

- La serie y el periodo los pide el servicio, no `Factura`, para que el área 3 no dependa del área 4.
- FE-1 (doble clic): la petición repetida se detecta y solo se emite una factura (FR-87). Se indica en una nota en lugar de en un diagrama aparte.

## CU-19: Emitir factura rectificativa

El caso se divide en dos diagramas para que se lean bien. El corte está en el evento «abono emitido»: el primero acaba cuando el área 3 lo emite y el segundo empieza cuando el área 6 lo recibe.

**Diagrama 1. Emisión de la rectificativa.** El Administrador pide rectificar una factura emitida. El proxy solo deja pasar a Administrador y Superadministrador (RB-21); un Usuario operativo recibe la denegación (FE-1). El `GeneradorRectificativa` comprueba que la original esté emitida (PRE-2), crea la rectificativa con las líneas corregidas y comprueba el umbral. `ServicioFacturacion` busca la serie de tipo rectificativa y llama a `emitir()`. La rectificativa numera y deja su historial, y después marca la original como rectificada sin modificarla (POST-1, RB-11).

Si la rectificativa es un **abono** (total negativo, `esAbono()`), emite el evento «abono emitido».

**Diagrama 2. El área 6 recalcula el cobro.** `ServicioCobros` (área 6) recibe «abono emitido» y recalcula el saldo de la original:

- **Saldo 0 o negativo:** si la original no estaba pagada, pasa a pagada con `registrarEstadoCobro()`. El área 6 emite «estado de cobro cambiado» y `ServicioRecordatorios.alCambiarEstadoCobro()` (área 5) cancela los recordatorios pendientes de esa factura (A-27, RB-37).
- **Saldo negativo:** el abono supera el saldo pendiente. Lo habitual es que se corrija una factura ya cobrada, pero también pasa si se abona más de lo que se debía. La diferencia queda a favor del cliente y la original se marca con `marcarCobroExcesivo()`. Qué se hace con ese dinero (devolución o saldo a favor) depende de Q-12, que sigue abierta.

**Decisiones**

- El abono va en un fragmento `opt` al final del diagrama 1: la única diferencia con una rectificativa positiva es el aviso al área 6. Una rectificativa positiva tiene su propio estado de cobro y no lanza el aviso, así que el diagrama 2 solo ocurre con abonos.
- El aviso se entrega cuando la emisión ya está guardada, para que el área 6 calcule el saldo con el abono incluido.
- FA-1 (sobre el umbral) sigue el mismo camino que el diagrama 2 de CU-15 y no se repite.
- POST-2 (el saldo del cliente refleja la corrección) no necesita ningún paso: el saldo del cliente no se guarda, se calcula al consultarlo (CU-33) y ya incluye el abono.

## Tarea diaria: vencimientos y alertas de impago

**Escenario automático, sin actor.** El planificador (área 10) entra por el proxy de permisos con la identidad de sistema: no es un rol de usuario, solo puede lanzar las tareas programadas y en la auditoría queda como «Sistema». Si el proxy la rechaza, se registra como fallo en `EjecucionProceso` y salta una alerta (CU-56).

El planificador lanza `ejecutar(ACTUALIZACION_VENCIMIENTOS)`: crea la `EjecucionProceso` y se la pasa a la `TareaAutomatica` de ese tipo, que llama al servicio del área 6 por su proxy y anota lo procesado. La tarea se divide en dos diagramas, uno por paso, dentro de la misma ejecución: el diagrama 1 la crea y el diagrama 2 la finaliza.

1. **Vencimientos (diagrama 1).** `ServicioCobros.actualizarVencimientos()` pasa a VENCIDA las facturas pendientes sin ningún cobro cuyo vencimiento ha pasado, con `registrarEstadoCobro()`. Es la transición «Pendiente → Vencida (Sistema)» de la Entrega 1.
2. **Límites de impago (diagrama 2).** `ServicioCobros.comprobarImpagos()` lee los dos límites de `ConfiguracionGlobal`:
   - Revisa **todas** las facturas con saldo y el vencimiento pasado (`estaVencida()`), no solo las que acaban de vencer. Las que vencieron hace días siguen envejeciendo, y son ellas las que cruzan el límite de días (UR-92).
   - Comprueba la deuda de cada cliente afectado con `consultarSaldo()` (UR-93).
   - Si se supera un límite, emite «impago sobre el límite». El área 7 lo escucha (`ManejadorAlertasCobro`) y crea la alerta (`FACTURA_VENCIDA` o `ALERTA_DEUDA`), que el usuario ve en su pantalla de trabajo (CU-37).

**Decisiones**

- **La alerta no se repite.** El área 6 avisa cada día mientras siga el impago, y el área 7 no crea otra alerta si ya hay una sin resolver del mismo tipo y para la misma factura o cliente. Así el área 6 no guarda si ya avisó, y si la tarea falla un día, al siguiente avisa igual. *Pendiente: que `Notificacion` (área 7) se relacione con la factura o el cliente.*
- **UR-93 puede llegar con hasta un día de retraso.** La deuda también crece al emitir una factura (área 3), pero solo se comprueba en esta tarea. Comprobarlo también al emitir obligaría al área 3 a conocer los límites de cobro. Se acepta para la primera versión.
- **Detecta el área 6 y avisa el área 7.** El área 6 es la que conoce el saldo y el vencimiento; el área 7 solo crea la alerta.

## CU-17: Generar facturas recurrentes

**Diagrama 1. Generación mensual.** El día 1 de cada mes el planificador lanza `ejecutar(FACTURACION_RECURRENTE)`: crea la `EjecucionProceso` y se la pasa a la `TareaAutomatica`, que entra por `ProxyFacturacion` con la identidad de sistema. `ServicioFacturacion.generarRecurrentes()` busca las configuraciones activas que aún no tienen factura ese mes y, para cada una:

- comprueba con `seFactura()` que no está en pausa ni dada de baja;
- toma el importe del tramo vigente (`importeVigente()`);
- crea la factura con el `GeneradorRecurrente` (Factory Method), que aplica el prorrateo el primer mes si el alta fue después del día 1;
- la emite como en CU-15 (serie, número y PDF) y la guarda.

Al final, la tarea anota en la ejecución las facturas generadas y el planificador la finaliza.

**Diagrama 2. Recuperación tras una caída.** Si el sistema se cae a mitad de la generación, al volver a arrancar el planificador encuentra la ejecución que quedó en curso, le registra el fallo y la finaliza. Después lanza una ejecución nueva, y `generarRecurrentes()` solo encuentra las configuraciones que se quedaron sin factura.

**Decisiones**

- **Sin duplicados.** La búsqueda excluye las configuraciones que ya tienen factura del mes, y además la base de datos impide guardar dos facturas del mismo mes para la misma configuración (FR-100). Repetir la generación es seguro.
- **Excepción sin prorrateo (FA-1).** Si se aprobó la excepción de CU-22, la configuración ya tiene aplicado `aplicarExcepcionSinProrrateo()` y el generador no prorratea. Se indica en una nota.
- El resultado de cada ejecución lo ve el Administrador en el estado del sistema (CU-56).

## CU-27 y CU-28: Enviar factura y gestionar el fallo

**CU-27. Enviar la factura.** El Usuario operativo pide enviar una factura emitida y `ProxyEnvio` comprueba que el cliente está en su cartera. `ServicioEnvio.enviarFactura()`:

1. Obtiene el contacto de facturación del cliente y comprueba el consentimiento para su canal preferido. WhatsApp solo con un número válido y consentimiento (RB-28).
2. Compone el texto con la plantilla (`generarTexto()`) y obtiene el PDF de `GestorDocumentos`.
3. Crea el `Mensaje`, registra el intento y lo envía por `CanalEnvio` (patrón Adapter). En el diagrama, `AdaptadorCorreo` llama al servicio de correo simulado.
4. Según el resultado:
   - **Aceptado:** marca el mensaje como enviado y pide al área 3 que pase la factura a `ENVIADA`.
   - **Rechazado:** marca el mensaje como fallido con el motivo, pide al área 3 `FALLO_ENVIO` y emite «fallos de envío». El área 7 (`ManejadorAlertasEnvio`) crea la alerta de la pantalla de trabajo (CU-37).

**CU-28. Gestionar el fallo.** Desde la alerta, el usuario consulta los mensajes de la factura (`consultarMensajes()`) y ve el motivo del fallo. Si es un dato de contacto erróneo, lo corrige (CU-03). Después reintenta con `reintentarEnvio()`. Si vuelve a fallar se emite de nuevo «fallos de envío», y con tres fallos seguidos el área 7 abre una incidencia (FE-1, FR-80).

**Decisiones**

- **El área 5 no toca la factura.** Pide el cambio de estado de envío al área 3 (`registrarEstadoEnvio()`), y cada cambio deja su historial (tipo ENVIO, FR-09).
- **El reintento usa el mismo mensaje y la misma factura.** Solo suma un intento: la factura no se duplica ni consume numeración.
- **Detecta el área 5 y avisa el área 7.** El área 5 no sabe nada de alertas ni de incidencias; solo emite el evento.
- Corregir el contacto es otro caso de uso (CU-03) y aparece como referencia.

## CU-48: Acceder al sistema

La persona escribe su email y su credencial, y la interfaz llama a `ServicioAcceso.autenticar()`. No pasa por el proxy, porque todavía no hay solicitante. El email se pasa a minúsculas antes de buscarlo. Hay un diagrama por cada resultado:

- **Diagrama 1. Acceso correcto.** Comprueba que la cuenta no está bloqueada (`estaBloqueado()`) y la credencial. Pone los intentos fallidos a 0 (`reiniciarIntentos()`), crea la `Sesion`, deja el usuario en el `ContextoSeguridad` (`establecer()`) y registra el acceso en la auditoría.
- **Diagrama 2. Credencial incorrecta.** Si el email no existe, solo registra el fallo. Si existe, suma un intento fallido (`registrarIntentoFallido()`); al quinto seguido, la cuenta queda bloqueada 15 minutos (A-07).
- **Diagrama 3. Cuenta bloqueada.** No comprueba la credencial ni suma intentos. Registra el intento y responde hasta cuándo dura el bloqueo.

**Decisiones**

- **El mismo error si el email no existe y si la credencial no coincide,** para no revelar qué emails están dados de alta.
- **`ServicioAcceso` registra él mismo en la auditoría,** porque el inicio de sesión no pasa por el proxy.
- **La caducidad de la sesión** (30 minutos sin actividad, A-06) la comprueba `validarSesion()` en cada petición. No hace falta una tarea programada.

## CU-22 y CU-23: Proponer una excepción y resolverla

**CU-22. Proponer una excepción de prorrateo.** El Usuario operativo propone no cobrar el prorrateo del primer mes de una facturación recurrente. La factura todavía no existe, así que la propuesta va sobre la `ConfiguracionRecurrente`. `ProxyAprobaciones` comprueba que el cliente está en su cartera (FE-1, RB-15). `ServicioAprobaciones.solicitarExcepcionProrrateo()` toma el solicitante del `ContextoSeguridad`, lee de la configuración el importe que se dejaría de facturar (`calcularPrimeraCuota()`) y crea la `SolicitudExcepcion` PENDIENTE. Al guardarla emite «solicitud creada», y el área 7 (`ManejadorSolicitudesResueltas`) avisa a cada aprobador (paso 4).

La **propuesta de una factura** (descuento, importe o fecha manual) no se repite: es el diagrama 2 de CU-15, con el tipo de la modificación y el motivo de `DatosFactura`. La factura queda pendiente de aprobación sin número (RB-25).

**CU-23 (1). Aprobar.** El Administrador abre la bandeja con `listarPendientes()` y aprueba una solicitud. `ServicioAprobaciones.aprobar()` toma el aprobador del `ContextoSeguridad`, lee el umbral de `ConfiguracionGlobal` y comprueba dos casos, que son las alternativas del diagrama:

- **FE-1, autoaprobación:** el aprobador es quien la pidió (FR-74).
- **FA-1, supera el umbral:** el importe supera el umbral y el aprobador no es Superadministrador (RB-04). La solicitud sigue pendiente hasta que la resuelva un Superadministrador.

Si puede aprobar, `s.aprobar()` guarda el aprobador, el comentario y la fecha (paso 4), y el servicio emite «solicitud resuelta». El área 3 (`alResolverSolicitud()`) aplica lo aprobado (paso 5): en una excepción de prorrateo llama a `aplicarExcepcionSinProrrateo()`; en una factura, la emite como en el diagrama 1 de CU-15. El área 7 avisa al solicitante.

**CU-23 (2). Rechazar (FA-2).** El comentario es obligatorio. `s.rechazar()` deja la solicitud rechazada y se emite «solicitud resuelta». Si era una factura, el área 3 la devuelve a borrador con `volverABorrador()`, conservando lo propuesto y dejando el historial, para que el solicitante la corrija y la reenvíe (POST-2). Si era una excepción de prorrateo, no se aplica. El área 7 avisa al solicitante con el motivo (CU-37).

**Decisiones**

- **El área 4 no toca la factura ni la configuración.** Solo resuelve la solicitud y emite el evento; quien la pidió (área 3, o área 6 en una baja contable) actúa al recibirlo. Así la dependencia va del área 3 a la 4 y no al revés.
- **El umbral lo lee el servicio, no la interfaz.** La interfaz no accede a `ConfiguracionGlobal`: todo pasa por el proxy.
- **Las comprobaciones de FE-1 y FA-1 se repiten al rechazar.** Se indica en una nota del diagrama 2 en lugar de dibujarlas otra vez.


## Trazabilidad

| Diagrama | Caso de uso | Participantes / responsabilidades |
|---|---|---|
| `cu15_1_emitir_factura.puml` | CU-15 (flujo principal, FE-1 en nota) | `InterfazWeb`; `ProxyFacturacion` (RB-15, auditoría); `ServicioFacturacion` (orquesta); `GeneradorPuntual` (crea); `FacturaPuntual`, `LineaFactura`, `HistorialEstadoFactura`; `ConfiguracionGlobal` (umbral); `SerieFacturacion` (número, RB-01); `GestorDocumentos` (PDF) |
| `cu15_2_emitir_requiere_aprobacion.puml` | CU-15 FA-3, CU-22 | Los anteriores y `ServicioAprobaciones` (área 4), que crea la `SolicitudExcepcion` |
| `cu19_1_emitir_rectificativa.puml` | CU-19 (flujo principal, FE-1 y FA-1 en nota) | `ProxyFacturacion` (RB-21); `ServicioFacturacion`; `GeneradorRectificativa`; `FacturaRectificativa`; la factura original (`marcarRectificada()`); `GestorDocumentos` (PDF) |
| `cu19_2_abono_recalculo_cobro.puml` | CU-19 (abono), A-27, RB-37 | `ServicioCobros` (área 6: escucha el abono, `calcularSaldoPendiente()`); la factura original (`registrarEstadoCobro()`, `marcarCobroExcesivo()`); `ServicioRecordatorios` (área 5, `alCambiarEstadoCobro()`) |
| `cu17_1_generar_recurrentes.puml` | CU-17 (flujo principal; FA-1 en nota) | `Planificador`, `TareaAutomatica` y `EjecucionProceso` (área 10); `ProxyFacturacion` (identidad de sistema); `ServicioFacturacion` (`generarRecurrentes()`, `emitir()`); `ConfiguracionRecurrente` (`seFactura()`, `importeVigente()`); `GeneradorRecurrente`; `FacturaRecurrente` (`aplicarProrrateo()`) |
| `cu17_2_recuperacion_tras_caida.puml` | CU-17 (recuperación), FR-100, CU-56 | `Planificador` y `EjecucionProceso` (`registrarFallo()`, `finalizar()`); `TareaAutomatica`; `ProxyFacturacion`; `ServicioFacturacion` |
| `cu27_enviar_factura.puml` | CU-27, RB-28, FR-09 | `ProxyEnvio`; `ServicioEnvio` (`enviarFactura()`); `Cliente` (`contactoFacturacion()`) y `Contacto` (`tieneConsentimiento()`) (área 1); `PlantillaComunicacion` (`generarTexto()`); `GestorDocumentos` (PDF); `Mensaje`; `AdaptadorCorreo` y `ServicioCorreoSimulado` (Adapter); `ServicioFacturacion` y `Factura` (`registrarEstadoEnvio()`) |
| `cu28_gestionar_fallo_envio.puml` | CU-28 (FE-1 en nota), CU-03 (referencia), FR-80 | `ProxyEnvio`; `ServicioEnvio` (`consultarMensajes()`, `reintentarEnvio()`); `Mensaje` (`registrarIntento()`, `marcarEnviado()`, `marcarFallido()`); `AdaptadorCorreo`; `ServicioFacturacion` |
| `cu48_1_acceso_correcto.puml` | CU-48 (flujo principal), A-06 | `ServicioAcceso` (`autenticar()`); `Usuario` (`estaBloqueado()`, `reiniciarIntentos()`); `Sesion`; `ContextoSeguridad` (`establecer()`); `RegistroAuditoria` |
| `cu48_2_credencial_incorrecta.puml` | CU-48 (credencial incorrecta), A-07 | `ServicioAcceso`; `Usuario` (`estaBloqueado()`, `registrarIntentoFallido()`); `RegistroAuditoria` |
| `cu48_3_cuenta_bloqueada.puml` | CU-48 (cuenta bloqueada), A-07 | `ServicioAcceso`; `Usuario` (`estaBloqueado()`); `RegistroAuditoria` |
| `cu22_proponer_excepcion_prorrateo.puml` | CU-22 (flujo principal; FE-1 en nota), RB-25 | `ProxyAprobaciones` (RB-15); `ServicioAprobaciones` (`solicitarExcepcionProrrateo()`); `ContextoSeguridad` (`solicitanteActual()`); `ConfiguracionRecurrente` (`calcularPrimeraCuota()`); `SolicitudExcepcion`; `ManejadorSolicitudesResueltas` y `ServicioNotificaciones` (área 7) |
| `cu23_1_aprobar_solicitud.puml` | CU-23 (flujo principal, FE-1, FA-1), FR-74, RB-04 | `ProxyAprobaciones`; `ServicioAprobaciones` (`listarPendientes()`, `aprobar()`); `ContextoSeguridad`; `ConfiguracionGlobal` (umbral); `SolicitudExcepcion` (`aprobar()`); `ServicioFacturacion` (`alResolverSolicitud()`); `ConfiguracionRecurrente` (`aplicarExcepcionSinProrrateo()`); `ManejadorSolicitudesResueltas` |
| `cu23_2_rechazar_solicitud.puml` | CU-23 FA-2, POST-2, CU-37 | `ProxyAprobaciones`; `ServicioAprobaciones` (`rechazar()`); `SolicitudExcepcion` (`rechazar()`); `ServicioFacturacion` (`alResolverSolicitud()`); `Factura` (`volverABorrador()`); `HistorialEstadoFactura`; `ManejadorSolicitudesResueltas` y `ServicioNotificaciones` (área 7) |
| `tarea_1_vencimientos.puml` | Transición «Pendiente → Vencida», CU-56 (fallo de la tarea) | `Planificador`, `TareaAutomatica` y `EjecucionProceso` (área 10); `ProxyCobros` (identidad de sistema); `ServicioCobros` (`actualizarVencimientos()`); `Factura` (`registrarEstadoCobro()`) |
| `tarea_2_impagos.puml` | UR-92, UR-93, CU-37 (alerta) | `Planificador`, `TareaAutomatica` y `EjecucionProceso` (área 10); `ProxyCobros`; `ServicioCobros` (`comprobarImpagos()`, `estaVencida()`, `consultarSaldo()`); `ConfiguracionGlobal` (límites); `ManejadorAlertasCobro` y `ServicioNotificaciones` (área 7) |

## Consistencia

- **Con el diagrama de clases.** Los participantes y operaciones del dominio y de los servicios existen en los diagramas de clases con el mismo nombre y los mismos parámetros. `InterfazWeb` es un componente de la arquitectura, no una clase. Cada servicio tiene su proxy (`ProxyFacturacion`, `ProxyCobros`, `ProxyEnvio`…), que implementa la misma interfaz que el servicio (`area9_2`). `GestorDocumentos` es infraestructura y no tiene operaciones definidas en el diagrama de clases; en las secuencias aparecen con un nombre que describe lo que hacen (`generarPdf()`, `obtenerPdf()`).
- **Con la arquitectura.** Los participantes siguen las capas de la vista 1: la interfaz y la API entran por el proxy de permisos, el proxy llama al servicio del área, y el servicio usa el dominio, la configuración, el gestor de documentos y la persistencia. Los avisos en verde son los mismos que las flechas verdes de la vista 2.
- **Diferencia de nivel de abstracción.** Las secuencias no muestran el mecanismo de los eventos (Observer, Entrega 3) ni las clases de persistencia: el acceso a la base de datos se resume en un mensaje.
