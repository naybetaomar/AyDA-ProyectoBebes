# Diagramas UML de secuencia

## Selección de escenarios

Se han elegido escenarios sobre todo de los casos de uso del **núcleo** de la primera versión (apartado 1.4 de los requisitos). CU-57/58 son complementarios, pero se incluyen porque son la única entrada por la API externa. Entre ellos se han elegido los que pasan por las piezas más importantes de la arquitectura:

- el proxy de permisos;
- la fachada de la API externa;
- el planificador;
- los adaptadores de proveedores externos;
- los avisos (eventos) entre áreas.

Entre todos, cada uno de los cinco eventos entre áreas aparece al menos en una secuencia. «Impago sobre el límite» no lo dispara ningún caso de uso, sino una tarea diaria del planificador, así que tiene su propio escenario automático. Las variantes de un mismo caso de uso (un flujo alternativo o de excepción relevante) van en un diagrama aparte.

| Diagrama | Caso de uso y escenario | Responsable |
|---|---|---|
| `cu15_1_emitir_factura.puml` | CU-15, flujo principal: emisión directa | Abdelnaybet |
| `cu15_2_emitir_requiere_aprobacion.puml` | CU-15, FA-3: supera el umbral y pasa a aprobación | Abdelnaybet |
| `cu19_1_emitir_rectificativa.puml` | CU-19 (1), flujo principal: emisión de la rectificativa | Abdelnaybet |
| `cu19_2_abono_recalculo_cobro.puml` | CU-19 (2): el área 6 recibe el abono y recalcula el cobro de la original (A-27) | Abdelnaybet |
| `tarea_1_vencimientos.puml` | Tarea diaria del planificador (1): facturas que pasan a vencidas | Abdelnaybet |
| `tarea_2_impagos.puml` | Tarea diaria del planificador (2): alertas de impago (UR-92, UR-93; la alerta se ve en CU-37) | Abdelnaybet |
| *pendiente* | CU-17: facturación recurrente lanzada por el planificador | Luca |
| *pendiente* | CU-27 / CU-28: envío de una factura y fallo de envío | Ana |
| *pendiente* | CU-22 / CU-23: proponer una excepción y resolverla | Cristóbal |
| *pendiente* | CU-48: acceder al sistema | Guille |
| *pendiente* | CU-34 / CU-35: cobro por la pasarela y conciliación | Loraine |
| *pendiente* | CU-57 / CU-58: consulta y solicitud por la API externa | Imad |

## Notación

Todos los diagramas siguen las mismas reglas:

- **Participantes:** instancias con el nombre subrayado (`: ServicioFacturacion`, `r : FacturaRectificativa`).
- **Llamadas:** solo se numeran las llamadas. Las respuestas son flechas discontinuas sin número.
- **Creación:** los objetos se crean con una flecha discontinua hacia la caja del participante, que aparece a esa altura.
- **Base de datos:** el acceso a la base de datos se dibuja como un mensaje hacia un punto en el borde derecho («buscar… en BD», «guardar… en BD»). La persistencia no es una clase del dominio.
- **Avisos entre áreas (eventos):** flecha verde. Indica que el área que emite no llama a la que escucha (ver «Lógica entre áreas en un solo sentido» en `diagrama_clases.md`).
- **Comprobación de permisos:** toda petición de un usuario, de la API o del planificador entra por el proxy de permisos, que la autoriza y la registra en la auditoría antes de llamar al servicio.

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

La tarea se divide en dos diagramas, uno por paso, dentro de la misma `EjecucionProceso`: el diagrama 1 la crea y el diagrama 2 la finaliza.

1. **Vencimientos (diagrama 1).** `ServicioCobros.actualizarVencimientos()` pasa a VENCIDA las facturas pendientes sin ningún cobro cuyo vencimiento ha pasado, con `registrarEstadoCobro()`. Es la transición «Pendiente → Vencida (Sistema)» de la Entrega 1.
2. **Límites de impago (diagrama 2).** `ServicioCobros.comprobarImpagos()` lee los dos límites de `ConfiguracionGlobal`:
   - Revisa **todas** las facturas con saldo y el vencimiento pasado (`estaVencida()`), no solo las que acaban de vencer. Las que vencieron hace días siguen envejeciendo, y son ellas las que cruzan el límite de días (UR-92).
   - Comprueba la deuda de cada cliente afectado con `consultarSaldo()` (UR-93).
   - Si se supera un límite, emite «impago sobre el límite». El área 7 lo escucha (`ManejadorAlertasCobro`) y crea la alerta (`FACTURA_VENCIDA` o `ALERTA_DEUDA`), que el usuario ve en su pantalla de trabajo (CU-37).

**Decisiones**

- **La alerta no se repite.** El área 6 avisa cada día mientras siga el impago, y el área 7 no crea otra alerta si ya hay una sin resolver del mismo tipo y para la misma factura o cliente. Así el área 6 no guarda si ya avisó, y si la tarea falla un día, al siguiente avisa igual. *Pendiente: que `Notificacion` (área 7) se relacione con la factura o el cliente.*
- **UR-93 puede llegar con hasta un día de retraso.** La deuda también crece al emitir una factura (área 3), pero solo se comprueba en esta tarea. Comprobarlo también al emitir obligaría al área 3 a conocer los límites de cobro. Se acepta para la primera versión.
- **Detecta el área 6 y avisa el área 7.** El área 6 es la que conoce el saldo y el vencimiento; el área 7 solo crea la alerta.

## Otros escenarios

*Cada responsable describe aquí su diagrama: escenario, pasos principales y decisiones.*

## Trazabilidad

| Diagrama | Caso de uso | Participantes / responsabilidades |
|---|---|---|
| `cu15_1_emitir_factura.puml` | CU-15 (flujo principal, FE-1 en nota) | `InterfazWeb`; `ProxyFacturacion` (RB-15, auditoría); `ServicioFacturacion` (orquesta); `GeneradorPuntual` (crea); `FacturaPuntual`, `LineaFactura`, `HistorialEstadoFactura`; `ConfiguracionGlobal` (umbral); `SerieFacturacion` (número, RB-01); `GestorDocumentos` (PDF) |
| `cu15_2_emitir_requiere_aprobacion.puml` | CU-15 FA-3, CU-22 | Los anteriores y `ServicioAprobaciones` (área 4), que crea la `SolicitudExcepcion` |
| `cu19_1_emitir_rectificativa.puml` | CU-19 (flujo principal, FE-1 y FA-1 en nota) | `ProxyFacturacion` (RB-21); `ServicioFacturacion`; `GeneradorRectificativa`; `FacturaRectificativa`; la factura original (`marcarRectificada()`); `GestorDocumentos` (PDF) |
| `cu19_2_abono_recalculo_cobro.puml` | CU-19 (abono), A-27, RB-37 | `ServicioCobros` (área 6: escucha el abono, `calcularSaldoPendiente()`); la factura original (`registrarEstadoCobro()`, `marcarCobroExcesivo()`); `ServicioRecordatorios` (área 5, `alCambiarEstadoCobro()`) |
| `tarea_1_vencimientos.puml` | Transición «Pendiente → Vencida», CU-56 (fallo de la tarea) | `Planificador` y `EjecucionProceso` (área 10); `ProxyCobros` (identidad de sistema); `ServicioCobros` (`actualizarVencimientos()`); `Factura` (`registrarEstadoCobro()`) |
| `tarea_2_impagos.puml` | UR-92, UR-93, CU-37 (alerta) | `Planificador` y `EjecucionProceso` (área 10); `ProxyCobros`; `ServicioCobros` (`comprobarImpagos()`, `estaVencida()`, `consultarSaldo()`); `ConfiguracionGlobal` (límites); `ManejadorAlertasCobro` y `ServicioNotificaciones` (área 7) |

## Consistencia

- **Con el diagrama de clases.** Los participantes y operaciones del dominio y de los servicios existen en los diagramas de clases con el mismo nombre y los mismos parámetros. Las secuencias de las áreas 3 y 6 usan `area3_1`, `area3_2` y `area6_2`. `InterfazWeb` es un componente de la arquitectura, no una clase. *Pendiente: `ProxyPermisos` (área 9) y `GestorDocumentos` (responsable por decidir) se comprobarán cuando estén sus diagramas.*
- **Con la arquitectura.** Los participantes siguen las capas de la vista 1: la interfaz y la API entran por el proxy de permisos, el proxy llama al servicio del área, y el servicio usa el dominio, la configuración, el gestor de documentos y la persistencia. Los avisos en verde son los mismos que las flechas verdes de la vista 2.
- **Diferencia de nivel de abstracción.** Las secuencias no muestran el mecanismo de los eventos (Observer, Entrega 3) ni las clases de persistencia: el acceso a la base de datos se resume en un mensaje.
