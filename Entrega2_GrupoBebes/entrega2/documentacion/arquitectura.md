# Arquitectura y componentes

## Vista representada

La arquitectura se describe con tres diagramas complementarios, en `diagramas/arquitectura/`:

| Diagrama | Vista | Qué muestra |
|---|---|---|
| `arquitectura_1_general.puml` | **Arquitectura lógica en capas** (vista principal) | Capas, componentes, proxy de permisos, adaptadores de integración y servicios externos |
| `arquitectura_2_servicios.puml` | Detalle de los servicios | Dependencias de lógica entre los servicios de las áreas (flechas continuas) y avisos entre áreas (flechas verdes discontinuas, eventos) |
| `arquitectura_3_despliegue.puml` | Despliegue (complementaria) | Nodos físicos: puesto del usuario, servidor de aplicación en un contenedor, base de datos, almacenamiento de ficheros y de copias |

La vista 1 es la estructura **lógica**; la 3 es la **física** y solo la complementa. 

Estilo general: arquitectura en capas (presentación, seguridad, servicios de aplicación, persistencia) con un dominio compartido; en lo físico, cliente-servidor con la aplicación en un único contenedor.

Cada servicio corresponde a un área funcional de nuestro sistema (áreas 1 a la 8). Las áreas 9, 10 y 11 son transversales.

## Responsabilidades

| Componente | Responsabilidad | Relaciones principales |
|---|---|---|
| Interfaz web | Entrada y presentación de datos de los usuarios internos (Usuario operativo, Administrador, Superadministrador) | ProxyPermisos; ServicioAcceso (inicio de sesión) |
| FachadaAPI (área 11) | Punto de entrada de los sistemas externos (CU-57, CU-58). Sus credenciales son distintas de las de la interfaz (NFR-50) | ProxyPermisos |
| Receptor de webhooks | Recibe la notificación de pago de la pasarela | ProxyPermisos (con identidad de sistema) |
| ServicioAcceso (área 9) | Inicio de sesión, sesiones y recuperación de contraseña (CU-48). No pasa por el proxy, porque todavía no hay solicitante. En cada petición valida la sesión y deja el usuario en el `ContextoSeguridad` | Interfaz web; Auditoría |
| ProxyPermisos (área 9) | Único punto de entrada a los servicios: comprueba rol y cartera asignada (RB-15) y registra la acción. Hay un proxy por servicio, con la misma interfaz que el servicio real | Auditoría; servicios de aplicación |
| Auditoría (`RegistroAuditoria`) | Conserva quién hizo qué y cuándo (NFR-03); nulo = acción del Sistema | ProxyPermisos |
| ServicioClientes (área 1) | Clientes, contactos, preferencias de comunicación, documentos y privacidad | ServicioRelacionComercial (estado del cliente); ServicioFacturacion (facturas de la ficha, histórico importado); ServicioNotificaciones (tarea de la acción masiva); GestorDocumentos. Leído por ServicioEnvio |
| ServicioRelacionComercial (área 2) | Relación comercial, suscripciones, tarifas y revisión anual. Calcula el estado del cliente | ServicioFacturacion (importe, pausa y baja de la facturación recurrente; facturación anual, CU-13); ServicioNotificaciones (aviso de reactivación) |
| ServicioFacturacion (área 3) | Emisión de facturas puntuales, recurrentes y rectificativas; series y borradores | ServicioAprobaciones (solicita aprobación); GestorDocumentos (PDF); ConfiguracionGlobal (umbral) |
| ServicioAprobaciones (área 4) | Solicitudes de excepción y su resolución. Es genérico: no conoce facturas ni bajas | Avisa de «solicitud creada» a ServicioNotificaciones y de «solicitud resuelta» a ServicioFacturacion, ServicioCobros y ServicioNotificaciones; ConfiguracionGlobal (umbral, RB-04) |
| ServicioEnvio / Recordatorios (área 5) | Envío de facturas y recordatorios de pago | ServicioFacturacion, ServicioClientes, ServicioCobros (¿vencida?); GestorDocumentos; adaptadores de correo y WhatsApp; ConfiguracionGlobal (calendario) |
| ServicioCobros (área 6) | Registro de cobros, conciliación, saldo pendiente y bajas contables | ServicioFacturacion (estado de cobro); ServicioAprobaciones (bajas); adaptadores de Stripe y banco; avisa a ServicioEnvio y ServicioNotificaciones |
| ServicioNotificaciones (área 7) | Notificaciones, alertas, tareas e incidencias | Recibe avisos de las áreas 4, 5 y 6 |
| ServicioInformes (área 8) | Dashboard, informes y exportaciones | Lee cifras de ServicioFacturacion y ServicioCobros; GestorDocumentos (exportaciones) |
| Dominio (compartido) | Entidades del modelo (diagramas de clases) | Usado por los servicios y por el acceso a datos |
| Acceso a datos | Lectura y escritura de las entidades en la base de datos | PostgreSQL; Dominio |
| PostgreSQL | Persistencia (esquema del E-R) | Acceso a datos |
| Planificador (área 10) | Tareas automáticas en segundo plano (FR-86, FR-100). `ejecutar(tipo)` lanza la `TareaAutomatica` de cada tipo de proceso: facturas recurrentes, recordatorios, vencimientos e impagos, aviso de reactivación de pausas, campaña de revisión anual, caducidad de delegaciones, copias de seguridad, conciliación automática, informes programados y borrado de exportaciones caducadas. Cada ejecución queda registrada (CU-56) | ProxyPermisos, con identidad de sistema |
| ConfiguracionGlobal / CalendarioLaboral (área 10) | Umbral de aprobación, calendario y demás parámetros | Leído por los servicios de las áreas 3, 4 y 5 |
| GestorDocumentos | Genera y guarda los PDF de las facturas, adjuntos y exportaciones temporales | Almacén de ficheros |
| Almacén de ficheros | PDF inalterables (con su hash), exportaciones que caducan (FR-95) y adjuntos | GestorDocumentos |
| Adaptadores de integración (Stripe, banco, correo, WhatsApp) | Aíslan al sistema de cada proveedor externo | Servicios de las áreas 5 y 6; servicios externos simulados |

## Justificación y alternativas

**Arquitectura en capas.** Separa la interfaz, la seguridad, la lógica y la persistencia, de modo que cambiar una capa no obliga a tocar las demás (mantenibilidad). Los servicios se organizan **uno por área**.

**Proxy de permisos como entrada única.** Todo lo que entra al sistema pasa por él: interfaz, API, webhooks y planificador. La única excepción es el inicio de sesión (`ServicioAcceso`), que ocurre antes de que haya un solicitante y registra él mismo en la auditoría. Así se aplican en un solo sitio los permisos y la cartera asignada (RB-15, FR-39) y se registra la auditoría (NFR-03). Las solicitudes de sistemas externos pasan por las mismas reglas que la interfaz (RB-31), y sus credenciales están separadas de las de los usuarios (NFR-50).
- *Alternativa descartada:* comprobar los permisos dentro de cada servicio. Repite la lógica en cada área y facilita olvidar una comprobación.
- *Planificador:* no tiene usuario, así que llama a los servicios a través del proxy con una **identidad de sistema** propia, que no es un valor de `Rol`, con permisos limitados a lo que hacen sus tareas. En la auditoría queda como «Sistema» (usuario nulo).

**Dependencias de lógica en un solo sentido y avisos como eventos.** Entre áreas, la lógica va en un sentido y la respuesta se da con un aviso (evento). Por ejemplo, el área 3 solicita la aprobación al área 4, y esta avisa cuando la solicitud se resuelve. Evita ciclos entre áreas, que complican el mantenimiento. La vista 2 los muestra: ningún conjunto de flechas continuas forma un ciclo.
- *Alternativa descartada:* llamadas en los dos sentidos. Es más directa, pero crea dependencias circulares entre áreas.
- *Excepción documentada:* el área 9 (seguridad) es infraestructura transversal y las áreas dependen de ella.
- Los avisos se formalizarán como patrón **Observer** en la Entrega 3.

**Adaptadores para los proveedores externos.** Stripe, el banco, el correo y WhatsApp se usan solo a través de adaptadores, y son simulados (A-03). Cambiar de proveedor equivale a escribir otro adaptador y no obliga a modificar las facturas existentes (NFR-27).
- *Alternativa descartada:* llamar al proveedor directamente desde el servicio, que acopla la lógica de negocio a un proveedor concreto.
- Stripe solo envía notificaciones: no hay llamadas salientes hacia él.

**Dominio compartido y datos de otra área.** Cada servicio lee sus propios datos por el repositorio; los de otra área los pide a su servicio. El informe de cifras (área 8) lo hace igual y no consulta la base de datos de otras áreas.

**GestorDocumentos.** Centraliza los ficheros. El PDF de una factura emitida es inalterable (RB-07) y se guarda con su hash; las exportaciones son temporales y se borran al caducar (FR-95).

**Planificador.** Ejecuta las tareas largas en segundo plano (FR-86) y recupera, tras una caída, las facturas recurrentes pendientes sin duplicar las ya generadas (FR-100). Por eso debe haber **una sola instancia** (o un bloqueo en la base de datos): si se escalara a varias, las tareas se ejecutarían por duplicado.

**Despliegue.** La aplicación va en un único contenedor, con la interfaz y la API, el proxy, los servicios y el dominio, y el planificador. Es un monolito modular: sencillo de desplegar y suficiente para un sistema interno.
- *Alternativa descartada:* un servicio desplegable por área (microservicios). Añade infraestructura y comunicación que este tamaño no justifica.
- Las copias de seguridad van en una ubicación separada de los datos y se prueban restaurándolas (NFR-11, CU-53, CU-59): una copia en el mismo sitio no protege si ese sitio falla.
- Los datos de demostración (CU-55) viven en un esquema separado de la misma base de datos, no en una segunda base de producción.

**Restricciones de calidad que atraviesan todas las capas.** Importes con precisión decimal exacta (NFR-31) e instantes guardados en UTC y mostrados en la zona horaria de España (NFR-42).

| Atributo de calidad | Cómo se logra |
|---|---|
| Seguridad | Proxy único; credenciales de API separadas de las de usuario (NFR-50) |
| Mantenibilidad | Capas, adaptadores y dependencias de lógica en un solo sentido (NFR-27) |
| Disponibilidad | Recuperación tras una caída sin duplicar tareas (FR-100); copias probadas (NFR-11) |
| Rendimiento | Tareas largas en segundo plano (FR-86); tareas habituales en menos de un minuto (NFR-40) |

## Trazabilidad

| Requisito / caso de uso | Componentes que lo realizan |
|---|---|
| CU-01 a CU-04, CU-09 Clientes, contactos, documentos y privacidad | Interfaz web → ProxyPermisos → ServicioClientes; los adjuntos se guardan en GestorDocumentos (CU-04) |
| CU-02 Ficha del cliente | ServicioClientes → ServicioRelacionComercial (estado del cliente) y ServicioFacturacion (facturas) |
| CU-07 Acción masiva | ServicioClientes → ServicioNotificaciones (tarea en segundo plano, FR-107); REASIGNAR pasa por el área 9 |
| CU-10, CU-12 Relación comercial y baja | ServicioRelacionComercial → ServicioFacturacion (alta, importe y fin de la facturación recurrente) |
| CU-11 Pausar y reactivar | ServicioRelacionComercial → ServicioFacturacion (pausa desde su fecha de inicio); el aviso de reactivación lo lanza el Planificador y llega a ServicioNotificaciones (RB-29) |
| CU-13 Revisión anual | Planificador abre la campaña → ServicioRelacionComercial → ServicioFacturacion (facturación anual; nuevo importe con fecha de efecto, RB-36) |
| CU-15 Emitir factura puntual | Interfaz web → ProxyPermisos → ServicioFacturacion (con ConfiguracionGlobal para el umbral y GestorDocumentos para el PDF) → Acceso a datos → PostgreSQL |
| CU-15 FA-3, CU-22, CU-23 Aprobaciones | ServicioFacturacion solicita a ServicioAprobaciones, que avisa con «solicitud creada» a ServicioNotificaciones (los aprobadores); al resolverse, «solicitud resuelta» llega a ServicioFacturacion y ServicioNotificaciones (CU-37) |
| CU-17 Facturación recurrente, CU-29 Recordatorios | Planificador → ProxyPermisos (identidad de sistema) → ServicioFacturacion / ServicioEnvio |
| CU-27, CU-28 Envío de factura y fallo de envío | ServicioEnvio → ServicioFacturacion y ServicioClientes → adaptadores de correo y WhatsApp; el fallo se avisa a ServicioNotificaciones |
| CU-34 Cobro notificado por la pasarela | Stripe → Receptor de webhooks → ProxyPermisos → ServicioCobros → AdaptadorStripe → Acceso a datos (FR-25, FR-87) |
| CU-35, CU-36 Conciliación y baja contable | ServicioCobros → ServicioFacturacion (estado de cobro); la baja pide su aprobación a ServicioAprobaciones |
| CU-43 Exportar informes | ServicioInformes → ServicioFacturacion / ServicioCobros → GestorDocumentos (FR-95) |
| CU-48 Acceso al sistema | Interfaz web → ServicioAcceso (sin proxy) → Sesion, ContextoSeguridad y Auditoría |
| CU-49, CU-50 Usuarios y cartera | ProxyPermisos (rol y cartera, RB-15, FR-39) → ServicioUsuarios; Auditoría |
| CU-53, CU-59 Copias de seguridad | Almacenamiento de copias, separado de los datos (NFR-11) |
| CU-55 Datos de demostración | Esquema de demostración en el servidor de base de datos |
| CU-57, CU-58 API externa | Sistema externo → FachadaAPI → ProxyPermisos (RB-31, NFR-50) |
| NFR-27 | Adaptadores de integración |
| NFR-31, NFR-42 | Restricción transversal: decimal exacto y UTC |
| FR-86, FR-100 | Planificador, una sola instancia |
