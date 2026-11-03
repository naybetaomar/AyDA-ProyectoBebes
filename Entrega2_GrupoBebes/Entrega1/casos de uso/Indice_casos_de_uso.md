# Índice de casos de uso

59 casos de uso, objetivo de usuario (CU-59 se numera al final para no alterar la numeración existente). La columna Origen indica si lo pidió el cliente (Entrevista), lo sugirió como ampliación (Sugerido por el cliente) o lo deduce el equipo (Inferencia del equipo). Cada UR está en al menos un CU (salvo UR-52, transversal).

| CU | Nombre | Actor principal | UR | FR | Área | Origen |
|---|---|---|---|---|---|---|
| CU-01 | Registrar cliente | Lector | 01, 45, 64, 97, 105, 108 | 01, 42, 48, 64, 70, 92, 106 | Clientes y contactos | Entrevista |
| CU-02 | Consultar cliente e historial | Lector | 02, 59, 68 | 01, 57, 71 | Clientes y contactos | Entrevista |
| CU-03 | Gestionar contactos y preferencias de comunicación | Lector | 03, 87, 88, 89 | 02, 78 | Clientes y contactos | Entrevista |
| CU-04 | Adjuntar documentos a cliente o factura | Lector | 67 | 67 | Clientes y contactos | Entrevista |
| CU-05 | Importar clientes desde CSV | Lector | 38 | 34 | Clientes y contactos | Entrevista |
| CU-06 | Importar histórico de facturas | Administrador | 39 | 35 | Clientes y contactos | Sugerido por el cliente |
| CU-07 | Ejecutar acción masiva sobre clientes | Lector | 106 | 107 | Clientes y contactos | Entrevista |
| CU-08 | Etiquetar clientes y clasificar facturas (opcional) | Lector | 107 | 81, 108 | Clientes y contactos | Sugerido por el cliente |
| CU-09 | Gestionar privacidad de datos personales | Administrador | 75, 109 | 89, 99 | Clientes y contactos | Entrevista |
| CU-10 | Gestionar relación comercial | Lector | 04, 19, 97 | 03, 07, 92 | Relación comercial y suscripciones | Entrevista |
| CU-11 | Pausar y reactivar suscripción | Lector | 20, 21 | 15 | Relación comercial y suscripciones | Entrevista |
| CU-12 | Dar de baja a un cliente | Lector | 22 | 16 | Relación comercial y suscripciones | Entrevista |
| CU-13 | Revisar anualmente el plan de un cliente | Administrador | 57 | 54, 55, 69 | Relación comercial y suscripciones | Entrevista |
| CU-14 | Configurar tarifas globales | Superadministrador | 10 | 10 | Relación comercial y suscripciones | Entrevista |
| CU-15 | Emitir factura puntual | Lector | 05, 11, 17, 23, 24, 29, 53, 66, 70, 98 | 04, 17, 18, 19, 66, 68, 87, 93 | Emisión de facturas | Entrevista |
| CU-16 | Gestionar borradores de factura | Lector | 05, 08, 96, 97 | 14, 92 | Emisión de facturas | Entrevista |
| CU-17 | Configurar facturación recurrente | Administrador | 05, 06, 17, 102 | 05, 06, 100 | Emisión de facturas | Entrevista |
| CU-18 | Programar emisión futura | Lector | 09 | 08 | Emisión de facturas | Inferencia del equipo |
| CU-19 | Emitir factura rectificativa | Administrador | 55 | 52 | Emisión de facturas | Entrevista |
| CU-20 | Gestionar presupuestos (opcional) | Lector | 54 | 51 | Emisión de facturas | Sugerido por el cliente |
| CU-21 | Configurar serie y numeración | Superadministrador | 16 | 13 | Emisión de facturas | Entrevista |
| CU-22 | Proponer excepción o factura para revisión | Lector | 12 | 11 | Aprobaciones y cierre contable | Entrevista |
| CU-23 | Resolver propuesta o autorizar sobre el umbral | Administrador | 13, 15, 80 | 11, 74 | Aprobaciones y cierre contable | Entrevista |
| CU-24 | Consultar mis solicitudes económicas | Lector | 78, 79 | 73 | Aprobaciones y cierre contable | Entrevista |
| CU-25 | Cerrar un periodo contable | Administrador | 81, 82 | 75 | Aprobaciones y cierre contable | Entrevista |
| CU-26 | Reabrir un periodo cerrado | Superadministrador | 83 | 76 | Aprobaciones y cierre contable | Entrevista |
| CU-27 | Enviar factura al cliente | Lector | 30, 53 | 20, 68 | Envío y comunicaciones | Entrevista |
| CU-28 | Gestionar fallo de envío de una factura | Lector | 25 | 21 | Envío y comunicaciones | Entrevista |
| CU-29 | Enviar recordatorios de pago automáticos | Lector | 31, 49 | 22, 46 | Envío y comunicaciones | Entrevista |
| CU-30 | Configurar recordatorios y plantillas | Superadministrador | 31, 49, 104 | 22, 46, 105 | Envío y comunicaciones | Entrevista |
| CU-31 | Marcar factura en disputa | Administrador | 26 | 23 | Envío y comunicaciones | Entrevista |
| CU-32 | Consultar estado de entrega de mensajes | Lector | 77 | 88 | Envío y comunicaciones | Entrevista |
| CU-33 | Consultar estado de cobro y saldo | Lector | 07, 18, 32, 56 | 09, 25, 47, 53 | Cobros, conciliación y saldo | Entrevista |
| CU-34 | Registrar cobro notificado por la pasarela | Pasarela de pagos | 32 | 25 | Cobros, conciliación y saldo | Entrevista |
| CU-35 | Conciliar cobros | Administrador | 28 | 26, 27 | Cobros, conciliación y saldo | Entrevista |
| CU-36 | Dar de baja contable una deuda | Administrador | 27 | 24 | Cobros, conciliación y saldo | Entrevista |
| CU-37 | Consultar pantalla de trabajo, notificaciones y alertas | Lector | 33, 34, 92, 93, 94, 95 | 28, 30, 80 | Notificaciones y colaboración | Entrevista |
| CU-38 | Configurar notificaciones y alertas | Superadministrador | 35, 92, 93, 94, 95 | 29, 80 | Notificaciones y colaboración | Entrevista |
| CU-39 | Buscar clientes y facturas | Lector | 37 | 33 | Notificaciones y colaboración | Entrevista |
| CU-40 | Gestionar incidencias de facturación y de cobro | Lector | 50, 99 | 25, 94, 109 | Notificaciones y colaboración | Entrevista |
| CU-41 | Comentar internamente | Lector | 69 | 90 | Notificaciones y colaboración | Entrevista |
| CU-42 | Consultar dashboard financiero | Administrador | 36 | 31 | Informes y contabilidad | Entrevista |
| CU-43 | Generar y exportar informes | Lector | 36, 51, 76, 100 | 32, 50, 85, 95 | Informes y contabilidad | Entrevista |
| CU-44 | Programar informes periódicos (opcional) | Administrador | 111 | 102 | Informes y contabilidad | Sugerido por el cliente |
| CU-45 | Fijar objetivos de facturación y cobro | Administrador | 71 | 82 | Informes y contabilidad | Entrevista |
| CU-46 | Generar paquete contable del periodo | Administrador | 84, 85, 86 | 77 | Informes y contabilidad | Entrevista |
| CU-47 | Consultar eficiencia operativa | Superadministrador | 101 | 96 | Informes y contabilidad | Inferencia del equipo |
| CU-48 | Acceder al sistema | Lector | 40, 41, 60 | 36, 38, 58, 72 | Usuarios, seguridad y auditoría | Entrevista |
| CU-49 | Gestionar usuarios | Administrador | 40 | 37, 39, 110 | Usuarios, seguridad y auditoría | Entrevista |
| CU-50 | Asignar y delegar clientes | Administrador | 42, 43, 44 | 39, 40, 41 | Usuarios, seguridad y auditoría | Entrevista |
| CU-51 | Descargar documentos autorizados | Lector | 48 | 45 | Usuarios, seguridad y auditoría | Entrevista |
| CU-52 | Consultar auditoría de negocio y exportaciones | Superadministrador | 46, 90, 91 | 43, 79 | Usuarios, seguridad y auditoría | Entrevista |
| CU-53 | Realizar y consultar copias de seguridad | Superadministrador | 47 | 44 | Usuarios, seguridad y auditoría | Entrevista |
| CU-59 | Restaurar copia de seguridad | Superadministrador | 47 | 44 | Usuarios, seguridad y auditoría | Entrevista |
| CU-54 | Gestionar configuración global | Superadministrador | 14, 65, 66, 72, 73, 103, 110 | 12, 65, 66, 83, 84, 98, 103, 104 | Configuración y sistema | Entrevista |
| CU-55 | Cargar datos de demostración | Superadministrador | 74 | 91 | Configuración y sistema | Entrevista |
| CU-56 | Consultar estado del sistema y errores | Administrador | 58, 62, 63 | 56, 62, 63, 86, 101 | Configuración y sistema | Entrevista |
| CU-57 | Consultar datos mediante la API | Sistema externo | 61 | 59, 61 | API externa | Entrevista |
| CU-58 | Enviar solicitud mediante la API | Sistema externo | 61 | 60 | API externa | Entrevista |

## Requisitos sin caso de uso propio (transversales)

- **UR-52** (dispositivos, idioma y zona horaria): requisito no funcional, se verifica con NFR-17 y FR-49.
- **UR-97** (deshacer modificaciones accidentales, FR-92): comportamiento transversal; se recoge como flujo alternativo en CU-01, CU-10, CU-16 y en la conciliación (CU-35).
- **UR-102** (recuperación tras una caída, FR-100): se recoge como flujo de excepción de CU-17 y se apoya en NFR-15.
- **UR-45** (conflicto de edición concurrente, FR-42) y **UR-70** (duplicados por doble clic, FR-87): flujos de excepción en CU-01 y CU-15.
- **UR-110** (cálculo determinista sin IA): FR-97 es una regla del sistema que ningún caso de uso puede incumplir; la desactivación opcional de la IA (FR-98) está en CU-54.
