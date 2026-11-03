# Matriz de permisos actor × caso de uso

Construida a partir de la ficha de cada caso de uso (**actores participantes**), de las reglas de negocio y de lo que dijo el cliente en la entrevista ampliada.

## Cómo leerla

- **P**: actor principal del caso de uso. **●**: participa en el caso de uso. **T**: lo inicia una tarea programada del sistema (el Planificador no es un actor).
- Los roles son jerárquicos (A-19): el Administrador puede hacer todo lo que hace el Lector, y el Superadministrador todo lo que hace el Administrador, salvo aprobar sus propias solicitudes sensibles (FR-74). La matriz refleja el actor de cada ficha; lo que se hereda no se repite en cada fila.
- **Alcance sobre clientes**: el Lector opera solo sobre los clientes que tiene asignados; los perfiles de administración, sobre todos (RB-15, FR-39). Se comprueba en cada acceso, incluso por dirección directa (FR-72).

## Sobre el nombre «Lector»

El cliente explicó en la entrevista ampliada que primero lo llamaron «lector» y luego dijeron que también podía editar, y pidió no aferrarse al nombre: «lo que importa es la capacidad». Por eso este documento lo describe como el **usuario operativo**: trabaja sobre sus clientes asignados, ve y modifica su información operativa, crea facturas si su permiso lo permite, sigue cobros y descarga documentos. No puede darse a sí mismo acceso a otro cliente, cambiar tarifas globales, crear series de facturación ni ver el dashboard financiero global.

## Matriz

| CU | Caso de uso | Lector | Administrador | Superadministrador | Sistema externo | Pasarela de pagos | Tarea programada | Base |
|---|---|---|---|---|---|---|---|---|
| CU-01 | Registrar cliente | P |  |  |  |  |  |   |
| CU-02 | Consultar cliente e historial | P |  |  |  |  |  |   |
| CU-03 | Gestionar contactos y preferencias de comunicación | P |  |  |  |  |  |   |
| CU-04 | Adjuntar documentos a cliente o factura | P |  |  |  |  |  |   |
| CU-05 | Importar clientes desde CSV | P |  |  |  |  |  |  El Lector opera sobre sus clientes asignados (RB-15, FR-39). |
| CU-06 | Importar histórico de facturas |  | P |  |  |  |  |   |
| CU-07 | Ejecutar acción masiva sobre clientes | P |  |  |  |  |  |  Reasignar clientes solo el Administrador; marcar pagadas en masa, nadie (RB-23). |
| CU-08 | Etiquetar clientes y clasificar facturas (opcional) | P |  |  |  |  |  |   |
| CU-09 | Gestionar privacidad de datos personales |  | P |  |  |  |  |   |
| CU-10 | Gestionar relación comercial | P |  |  |  |  |  |   |
| CU-11 | Pausar y reactivar suscripción | P |  |  |  |  | T |   |
| CU-12 | Dar de baja a un cliente | P |  |  |  |  |  |  Lector, coherente con el usuario operativo que gestiona sus clientes («puede ver y modificar la información operativa de esos clientes»). El cliente no asigna rol concreto a la baja. |
| CU-13 | Revisar anualmente el plan de un cliente |  | P | ● |  |  | T |   |
| CU-14 | Configurar tarifas globales |  |  | P |  |  |  |  Cliente: el usuario operativo «no puede cambiar tarifas globales». |
| CU-15 | Emitir factura puntual | P |  |  |  |  |  |  El usuario operativo puede «crear facturas si su permiso lo permite» (entrevista ampliada). |
| CU-16 | Gestionar borradores de factura | P |  |  |  |  |  |  Los borradores forman parte de crear facturas: mismo criterio que CU-15. |
| CU-17 | Configurar facturación recurrente |  | P |  |  |  | T |  Activar una facturación mensual automática compromete importes futuros: perfil de gestión. El Lector crea facturas puntuales y borradores (CU-15, CU-16). |
| CU-18 | Programar emisión futura | P |  |  |  |  | T |   |
| CU-19 | Emitir factura rectificativa |  | P |  |  |  |  |  RB-21: solo Administrador o Superadministrador. |
| CU-20 | Gestionar presupuestos (opcional) | P |  |  |  |  |  |   |
| CU-21 | Configurar serie y numeración |  |  | P |  |  |  |  Cliente: el usuario operativo «no puede crear series de facturación». |
| CU-22 | Proponer excepción o factura para revisión | P |  |  |  |  |  |   |
| CU-23 | Resolver propuesta o autorizar sobre el umbral |  | P | ● |  |  |  |  RB-04 y FR-74: el Superadministrador autoriza sobre el umbral y nadie aprueba lo propio. |
| CU-24 | Consultar mis solicitudes económicas | P |  |  |  |  |  |   |
| CU-25 | Cerrar un periodo contable |  | P |  |  |  |  |   |
| CU-26 | Reabrir un periodo cerrado |  |  | P |  |  |  |  Configuración profunda: Superadministrador. |
| CU-27 | Enviar factura al cliente | P |  |  |  |  |  |   |
| CU-28 | Gestionar fallo de envío de una factura | P |  |  |  |  |  |  Corregir los datos de contacto de sus clientes entra en «ver y modificar la información operativa de esos clientes». |
| CU-29 | Enviar recordatorios de pago automáticos | P |  |  |  |  | T |  Lo dispara el sistema por la cadencia; el Lector, como responsable del cliente, consulta el resultado. |
| CU-30 | Configurar recordatorios y plantillas |  | ● | P |  |  |  |   |
| CU-31 | Marcar factura en disputa |  | P |  |  |  |  |  RB-22: solo Administrador o Superadministrador pausa recordatorios. |
| CU-32 | Consultar estado de entrega de mensajes | P |  |  |  |  |  |   |
| CU-33 | Consultar estado de cobro y saldo | P |  |  |  |  |  |   |
| CU-34 | Registrar cobro notificado por la pasarela |  |  |  |  | P |  |  Evento de la pasarela; la consulta de los cobros se hace en CU-33. |
| CU-35 | Conciliar cobros |  | P |  |  |  |  |  Decisión del equipo: el Administrador, porque concilia cobros de cualquier cliente y puede deshacerse (FR-27). El cliente no asigna rol. |
| CU-36 | Dar de baja contable una deuda |  | P | ● |  |  |  |   |
| CU-37 | Consultar pantalla de trabajo, notificaciones y alertas | P |  |  |  |  |  |   |
| CU-38 | Configurar notificaciones y alertas |  |  | P |  |  |  |   |
| CU-39 | Buscar clientes y facturas | P |  |  |  |  |  |   |
| CU-40 | Gestionar incidencias de facturación y de cobro | P | ● |  |  |  |  |  RB-22 para pausar recordatorios por incidencia. |
| CU-41 | Comentar internamente | P |  |  |  |  |  |  RB-32: las notas restringidas solo las ven los administradores. |
| CU-42 | Consultar dashboard financiero |  | P |  |  |  |  |  Cliente: el usuario operativo no ve «el dashboard financiero global»; el Lector ve solo sus clientes (glosario). |
| CU-43 | Generar y exportar informes | P | ● |  |  |  |  |   |
| CU-44 | Programar informes periódicos (opcional) |  | P |  |  |  |  |   |
| CU-45 | Fijar objetivos de facturación y cobro |  | P |  |  |  |  |   |
| CU-46 | Generar paquete contable del periodo |  | P |  |  |  |  |   |
| CU-47 | Consultar eficiencia operativa |  |  | P |  |  |  |   |
| CU-48 | Acceder al sistema | P |  |  |  |  |  |   |
| CU-49 | Gestionar usuarios |  | P |  |  |  |  |  Gestión de usuarios: Administrador y Superadministrador. |
| CU-50 | Asignar y delegar clientes |  | P |  |  |  |  |  FR-40, FR-41: «un administrador asigna y desasigna clientes» y delega. |
| CU-51 | Descargar documentos autorizados | P |  |  |  |  |  |   |
| CU-52 | Consultar auditoría de negocio y exportaciones |  |  | P |  |  |  |   |
| CU-53 | Realizar y consultar copias de seguridad |  |  | P |  |  | T |  Configuración profunda: Superadministrador. |
| CU-54 | Gestionar configuración global |  |  | P |  |  |  |  Configuración global: Superadministrador. |
| CU-55 | Cargar datos de demostración |  |  | P |  |  |  |   |
| CU-56 | Consultar estado del sistema y errores |  | P |  |  |  |  |   |
| CU-57 | Consultar datos mediante la API |  |  |  | P |  |  |  Credenciales de API distintas de las de la interfaz (NFR-50). |
| CU-58 | Enviar solicitud mediante la API |  |  |  | P |  |  |  Solicitud controlada, no modifica datos directamente (RB-31). |
| CU-59 | Restaurar copia de seguridad |  |  | P |  |  |  |  Configuración profunda: Superadministrador. |

## Decisiones sobre la asignación de roles

- **CU-12 (baja)**: se mantiene en el Lector.
- **CU-35 (conciliar cobros)**: pasa al Administrador.
- **CU-17 (facturación recurrente)**: pasa al Administrador.
- **UR-05 y UR-17 ('Lector / Administrador')**: vienen de la entrevista y no distinguen modalidad. El Lector gestiona facturas puntuales y borradores (CU-15, CU-16); las recurrentes (CU-17, UR-06), el Administrador.
- **CU-07 (acciones masivas)**: el Lector actúa en masa sobre sus clientes asignados; reasignar clientes solo lo hace el Administrador.
- **CU-34 (cobro de la pasarela)**: sin Lector; la consulta de cobros notificados está en CU-33.
- **CU-29 (recordatorios)**: el Lector es el principal; lo dispara el sistema por tiempo.
- **CU-53 y CU-59**: copia automática y restauración, ambas del Superadministrador.
