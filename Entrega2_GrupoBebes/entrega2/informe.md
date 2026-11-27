# Entrega 2 · Diseño del sistema

**Asignatura:** Análisis y Diseño de Aplicaciones · Grupo A · 2026–27  
**Equipo:** Bebés 

| Nombre y apellidos |
|---|
| Abdelnaybet Aomar Hamed |
| Imad El Founti Chaib | 
| Luca Fernández Cordeiro | 
| Ana Guerrero Martín | 
| Guillermo Herrera Lozano |
| Loraine Meijer Arboleda |
| Cristóbal Jesús Subires Macías | 

**Fecha:** 27/11/2026

**Repositorio:** https://github.com/naybetaomar/AyDA-ProyectoBebes.git


## 1. Introducción y alcance

Turbine necesita una herramienta interna para gestionar la administración, la facturación y los cobros, independiente de su producto principal, Brain. El sistema debe permitir gestionar miles de clientes, suscripciones, facturas recurrentes y puntuales, cobros, recordatorios y distintos flujos operativos. Además, debe garantizar la trazabilidad de las operaciones y la inmutabilidad de los documentos emitidos, sin llegar a la complejidad propia de un ERP.

Los requisitos y los 59 casos de uso se encuentran en la Entrega 1, actualizada en un PDF independiente.

En este informe se presenta el diseño del sistema propuesto, incluyendo los siguientes apartados:

- **Modelo físico de datos:** se incluye un diagrama E-R para cada área y un script SQL encargado de crear todas las tablas y sus restricciones. El script se ha construido y probado área por área sobre PostgreSQL 16, tanto con inserciones válidas como con casos que las restricciones deben rechazar.

- **Diagrama de clases:** se organiza según las 11 áreas funcionales definidas en la Entrega 1. Para cada área se muestran sus principales clases, los servicios que intervienen, los patrones utilizados y las relaciones existentes con el resto de áreas.

- **Diagramas de secuencia:** se representan distintos escenarios correspondientes a los casos de uso del núcleo de la primera versión, definidos en el apartado 1.4 de los requisitos. Se han seleccionado aquellos que permiten mostrar el funcionamiento de las principales piezas de la arquitectura.

- **Arquitectura:** se presentan tres vistas del sistema: la lógica en capas, el detalle de los servicios y el despliegue.

Las 11 áreas funcionales son las siguientes:

| Área | Nombre | Responsable |
|---|---|---|
| 1 | Clientes y contactos | Ana Guerrero |
| 2 | Relación comercial y suscripciones | Ana Guerrero |
| 3 | Emisión de facturas | Abdelnaybet Aomar |
| 4 | Aprobaciones y cierre contable | Loraine Meijer |
| 5 | Envío y comunicaciones | Loraine Meijer |
| 6 | Cobros, conciliación y saldo | Abdelnaybet Aomar |
| 7 | Notificaciones y colaboración | Luca Fernández |
| 8 | Informes y contabilidad | Luca Fernández |
| 9 | Usuarios, seguridad y auditoría | Imad El Founti |
| 10 | Configuración y sistema | Cristóbal Subires |
| 11 | API externa | Guillermo Herrera |

**Ideas que recorren todo el diseño**

- **Un servicio por área** como punto de entrada. De esta forma, ninguna área accede directamente a las clases internas de otra.

- **La lógica va en un solo sentido** entre las áreas, evitando ciclos de dependencia. Cuando un área necesita reaccionar a algo que ocurre en otra, lo hacemos mediante **eventos**, como «abono emitido», «solicitud creada», «solicitud resuelta», «estado de cobro cambiado», «impago sobre el límite» o «fallos de envío».

- **Un proxy de permisos** (área 9) se coloca delante de todos los servicios. Se encarga de comprobar el rol y la cartera del usuario y, además, registra la acción en la auditoría.

- **Lo que se puede calcular no se guarda.** Por ejemplo, el estado del cliente, el rango de tarifa vigente y el saldo pendiente se obtienen cuando hacen falta. Así evitamos tener datos duplicados o contradictorios y no necesitamos tareas diarias para mantenerlos actualizados.

## 2. Actualizaciones de la Entrega 1

**Documento:** `cambios_entrega1.md`.

Resumen de lo que más afecta al diseño:

- **Primera versión del sistema** (apartado 1.4 nuevo): los casos de uso se clasifican en núcleo, complementario y opcional. Los escenarios de secuencia salen sobre todo del núcleo.
- **Rol «Lector» → «Usuario operativo»**, el término del cliente. En el enumerado `Rol` es `OPERATIVO`.
- **Numeración y estado de cobro:** el número de factura y el estado de cobro existen solo desde la emisión (RB-01, A-23).
- **Abonos** (A-27) y **cobros que superan el saldo** (A-28): cómo afectan al cobro de la factura original.
- **Cambio de rol de un usuario** (A-26, FR-110, RB-38, RB-39).
- **Transición «pendiente → vencida»:** la ejecuta una tarea diaria del planificador.
- **Feedback de la Entrega 1:** cartera asignada del Usuario operativo, comentario obligatorio al rechazar una propuesta con aviso al solicitante, reenvío de solicitudes rechazadas y excepción de prorrateo sin factura.


## 3. Modelo físico de datos (Entidad–Relación)

**Documento:** `documentacion/modelo_datos.md`.

**Figuras** (exportar desde `diagramas/modelo_datos/`), una por área:

| Figura | Fuente |
|---|---|
| E-R área 1: Clientes y contactos | `er_area1.puml` |
| E-R área 2: Relación comercial, tarifas y revisión anual | `er_area2.puml` |
| E-R área 3: Facturación | `er_area3.puml` |
| E-R área 4: Aprobaciones y periodos contables | `er_area4.puml` |
| E-R área 5: Envío y comunicaciones | `er_area5.puml` |
| E-R área 6: Cobros | `er_area6.puml` |
| E-R área 7: Notificaciones y colaboración | `er_area7.puml` |
| E-R área 8: Informes y contabilidad | `er_area8.puml` |
| E-R área 9: Usuarios, seguridad y auditoría | `er_area9.puml` |
| E-R área 10: Configuración y sistema | `er_area10.puml` |
| E-R área 11: API externa | `er_area11.puml` |

El script `diagramas/modelo_datos/script.sql` crea las 64 tablas con sus restricciones y disparadores. No se copia en el PDF; se cita como fuente.

## 4. Diagrama UML de clases

**Documento:** `documentacion/diagrama_clases.md`.

**Figuras** (exportar desde `diagramas/clases/areaNN/`), agrupadas por área y en este orden dentro de cada una: modelo, servicio y patrones, relaciones con otras áreas.

| Área | Fuentes |
|---|---|
| 1 | `area1_1_modelo_clientes`, `area1_2_servicio_clientes` |
| 2 | `area2_1_relacion_comercial`, `area2_2_servicio_relacion_comercial` |
| 3 | `area3_1_modelo_facturacion`, `area3_2_factory_method`, `area3_3_relaciones_otras_areas` |
| 4 | `area4_1_modelo_aprobaciones`, `area4_2_servicio_aprobaciones` |
| 5 | `area5_1_modelo_comunicaciones`, `area5_2_servicios_adapter` |
| 6 | `area6_1_modelo_cobros`, `area6_2_adapter_servicio`, `area6_3_relaciones_otras_areas` |
| 7 | `area7_1_modelo_notificaciones`, `area7_2_patrones_notificaciones`, `area7_3_relaciones_notificaciones` |
| 8 | `area8_1_modelo_informes`, `area8_2_patrones_informes`, `area8_3_relaciones_informes` |
| 9 | `area9_1_modelo_usuarios_y_auditoria`, `area9_2_patron_proxy_permisos`, `area9_3_relaciones_otras_areas`, `area9_4_acceso_y_copias` |
| 10 | `area10_1_configuracion`, `area10_2_planificador`, `area10_3_calendario` |
| 11 | `area11_api_externa` |


## 5. Diagramas UML de secuencia

**Documento:** `documentacion/diagramas_secuencia.md`.

**Figuras** (exportar desde `diagramas/secuencias/`, una carpeta por caso de uso). Cada una con su caso de uso y su escenario en el pie:

| Figura | Caso de uso y escenario |
|---|---|
| `cu15_1_emitir_factura` | CU-15, flujo principal: emisión directa |
| `cu15_2_emitir_requiere_aprobacion` | CU-15 FA-3: supera el umbral y pasa a aprobación (CU-22) |
| `cu19_1_emitir_rectificativa` | CU-19 (1): emisión de la rectificativa |
| `cu19_2_abono_recalculo_cobro` | CU-19 (2): el abono recalcula el cobro de la original (A-27) |
| `tarea_1_vencimientos` | Tarea diaria del planificador (1): facturas que pasan a vencidas |
| `tarea_2_impagos` | Tarea diaria del planificador (2): alertas de impago |
| `cu17_1_generar_recurrentes` | CU-17 (1): generación mensual por el planificador |
| `cu17_2_recuperacion_tras_caida` | CU-17 (2): recuperación tras una caída |
| `cu27_enviar_factura` | CU-27: envío de una factura; el fallo avisa al área 7 |
| `cu28_gestionar_fallo_envio` | CU-28: consultar el fallo, corregir el contacto y reintentar |
| `cu48_1_acceso_correcto` | CU-48 (1): acceso correcto |
| `cu48_2_credencial_incorrecta` | CU-48 (2): credencial incorrecta |
| `cu48_3_cuenta_bloqueada` | CU-48 (3): cuenta bloqueada |
| `cu22_proponer_excepcion_prorrateo` | CU-22: proponer una excepción de prorrateo |
| `cu23_1_aprobar_solicitud` | CU-23 (1): aprobar; autoaprobación y umbral como alternativas |
| `cu23_2_rechazar_solicitud` | CU-23 (2): rechazar; la factura vuelve a borrador |
| `cu34_registrar_cobro_pasarela` | CU-34: la pasarela notifica un pago; evento repetido |
| `cu35_1_conciliar_manualmente` | CU-35 (1): bandeja y conciliación manual |
| `cu35_2_deshacer_conciliacion` | CU-35 (2): deshacer una conciliación |
| *pendiente* | CU-57 / CU-58: consulta y solicitud por la API externa |


## 6. Arquitectura y componentes

**Documento:** `documentacion/arquitectura.md`.

**Figuras** (exportar desde `diagramas/arquitectura/`):

| Figura | Vista |
|---|---|
| `arquitectura_1_general` | Arquitectura lógica en capas (vista principal) |
| `arquitectura_2_servicios` | Dependencias entre los servicios de las áreas y eventos |
| `arquitectura_3_despliegue` | Despliegue (complementaria) |

## 7. Informe Scrum

**Documento:** `informe_scrum.md`, con las capturas reales del tablero de `evidencias/` (inicio y final del sprint).

## 8. Conclusiones y cuestiones pendientes

**Decisiones principales**

- **Diseño dividido por áreas**, con un servicio como punto de entrada en cada una y la lógica entre áreas en un solo sentido. Cada área se puede cambiar sin tocar las demás y no hay ciclos de dependencia.
- **Eventos entre áreas** en lugar de llamadas cruzadas. Se declaran ahora y el mecanismo (Observer) se formaliza en la Entrega 3.
- **Proxy de permisos** con un `ContextoSeguridad`. Ninguna operación de ningún servicio lleva el solicitante como parámetro, y el planificador y la API pasan por el mismo control con su propia identidad.
- **Datos derivados sin guardar**, que se calculan cuando se consultan:
  - el estado del cliente;
  - el rango de tarifa vigente;
  - el saldo pendiente;
  - el importe vigente de la facturación recurrente, calculado a partir de sus tramos.
- **Restricciones en la base de datos** siempre que se pueden expresar:
  - sin solapes de pausas, tarifas, periodos, asignaciones y relaciones comerciales (`EXCLUDE`);
  - auditoría inalterable (disparadores);
  - numeración única por serie.

  Las que necesitan contar o consultar otras tablas (por ejemplo, RB-39) las comprueba el servicio y quedan anotadas en `modelo_datos.md`.

**Cuestiones pendientes**

- **Q-12:** qué hacer con el importe sobrante de un abono mayor que lo facturado o de un cobro excesivo. El diseño asume por ahora que queda como saldo a favor del cliente.
- **Q-07:** a qué afecta un cambio de configuración (facturas nuevas, condiciones nuevas o ambas).
- **Q-13:** qué pasa con la cartera y las solicitudes pendientes cuando un usuario cambia de rol.
- **Q-10:** si la reasignación de clientes necesita la aprobación de otro administrador.
- **Primera versión:** si CU-12 (baja de cliente) o CU-53 (copias) suben al núcleo.