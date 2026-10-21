# Hoja de revisión — Cristóbal (bloque páginas 12-13)

Documento de referencia: `Requisitos_unificado_v9.md`. Esta hoja resume **solo lo tuyo**: dónde ha quedado cada requisito de tu bloque y qué hay que confirmar. Nada está cerrado: si algo no dice lo que querías decir, anótalo y lo vemos el jueves.

## 1. Resumen

| | Tenías | Siguen | Cambiados de fondo | Quitados |
|---|---|---|---|---|
| Requisitos de usuario | 33 | 27 | 4 | 6 |
| Requisitos funcionales | 31 | 30 | 0 | 1 |
| No funcionales | 4 | 3 | 0 | 1 |

*«Cambiados de fondo» = texto reformulado respecto al tuyo (el resto solo tiene ajustes de forma: «Poder…», «deberá», etc.).*

## 2. Lo que se ha quitado de tu bloque

| Tu ID | Qué decía | Dónde queda cubierto |
|---|---|---|
| UR-04 | Saber qué facturas están pagadas, pendientes, vencidas o en disputa, y por qué. | UR-03 (Imad) |
| UR-06 | Recibir notificaciones internas de los eventos relevantes de mis clientes (pago confirmado, vencida, rebote, d | UR-34 (Loraine) |
| UR-18 | Asignar, desasignar, reasignar y delegar temporalmente clientes a usuarios. | UR-43 (Loraine) |
| UR-20 | Ver un dashboard financiero (semanal, mensual, trimestral, anual) con cifras que pueda desglosar, e informes e | UR-36 (Loraine) |
| UR-29 | Consultar y filtrar la auditoría para saber quién hizo qué, cuándo y por qué, sin poder reescribir el pasado. | UR-46 (Loraine) |
| UR-30 | Ver una pantalla de monitoreo: última generación recurrente, cola de emails, errores, último backup correcto;  | UR-58 (Naybet) |
| FR-07 | El sistema deberá permitir reasignar clientes con una aprobación a otro administrador o definir suplentes, reg | repetía FR-86 y la duda Q-10 (aprobación) (ronda de depuración) |
| NFR-04 | Idempotencia en UI por doble clic | FR-191 (Cristóbal) (doble clic) y NFR-15 (Loraine) (idempotencia) |

Si crees que alguno no debería haberse quitado, dilo y se recupera.

## 3. Lo que se ha reformulado de fondo

| Tu ID | Ahora es | Texto actual |
|---|---|---|
| UR-16 | UR-70 | Poder evitar duplicados por doble clic o reintento al emitir, enviar o conciliar. |
| UR-35 | UR-74 | Poder cargar datos ficticios para demostraciones sin mezclarlos con los de producción (opcional) |
| UR-19.1 | UR-78 | Poder consultar en una bandeja el estado (aprobada, rechazada o pendiente) de las solicitudes económicas realizadas. |
| UR-19.3 | UR-80 | Poder garantizar la separación de funciones: nadie aprueba sus propias solicitudes sensibles. |

**Sin cambios de fondo** (solo forma): UR-69, UR-71, UR-72, UR-73, UR-75, UR-76, UR-77, UR-79, UR-81, UR-82, UR-83, UR-84, UR-85, UR-86, UR-87, UR-88, UR-89, UR-90, UR-91, UR-92, UR-93, UR-94, UR-95, FR-167, FR-168, FR-169, FR-170, FR-171, FR-172, FR-173, FR-174, FR-175, FR-176, FR-177, FR-178, FR-179, FR-180, FR-181, FR-182, FR-183, FR-184, FR-185, FR-186, FR-187, FR-188, FR-189, FR-190, FR-191, FR-192, FR-193, FR-194, FR-195, FR-196, NFR-30, NFR-31, NFR-32

## 4. Lo que se ha añadido en tu zona

| ID | Texto |
|---|---|
| UR-109 | Poder asegurar que los datos de facturación no se usan automáticamente para campañas comerciales |
| UR-111 | Poder programar informes periódicos y su envío a las personas que indique (opcional) |
| FR-215 | El sistema deberá permitir al administrador indicar a quién se envían los resúmenes periódicos (opcional) |
| FR-216 | El sistema deberá enviar los informes programados que contengan detalle de clientes solo a usuarios con permiso para verlos (opcional) |
| FR-217 | El sistema deberá enviar en los informes programados una notificación con enlace autenticado al informe en lugar de adjuntarlo (opcional) |

*Tus FR-193 pasan a colgar de un UR nuevo de esta zona (ver tabla).*

## 5. Decisiones del 21-10 que te afectan

| # | Tema | Qué se decidió | Pendiente de ti |
|---|---|---|---|
| 3 | Asignar, reasignar y delegar | Dueña Loraine (UR-43…45). Se elimina el UR de Cristóbal (FR-07 pasa a colgar del UR de asignación de Loraine) y el UR y FR de acceso del Lector de Luca | Cristóbal: recortar su FR-07 a «reasignar con aprobación» |
| 4 | Monitorización | Dueño Naybet (UR-06). Se elimina el UR de monitoreo de Cristóbal; su FR-08 (tareas en segundo plano con estado) pasa a colgar de UR-06 | Naybet: decidir si añade un FR de «registro de ejecución de procesos automáticos» |
| 6 | Estado de cobro | Dueño Imad (UR-07). Se eliminan el UR de estados de Ana y el de Cristóbal. El FR de historial de versiones de Ana pasa a UR-07 de Imad; el FR del único contacto de facturación de Cristóbal pasa a UR-03 de Imad | Ana y Cristóbal: confirmar los cambios de UR |
| 8 | Dashboard e informes | Dueña Loraine (UR-04). Se elimina el UR de dashboard de Cristóbal; su FR de proyecto o línea de negocio pasa a UR-04. Se mantienen UR de informes programados (Cristóbal), informes de facturas fallidas (Ana) y eficiencia operativa (Luca) | Cristóbal: añadir un FR para programar informes; Ana: revisar solapamiento parcial con el FR de informes filtrables de Loraine |
| 9 | Notificaciones | Dueña Loraine (UR-02). Se elimina el UR genérico de notificaciones de Cristóbal; se mantienen sus cuatro alertas concretas | Unificar la lista de eventos (Cristóbal incluye «aprobación rechazada») |
| 10 | Errores y no perder trabajo | Se mantienen los UR de Naybet y Luca. UR de Cristóbal se queda solo por su FR de doble clic. Se quita «o envíos a Hacienda» del FR de confirmación de Luca | Cristóbal: recortar el texto de su UR a «evitar duplicados por doble clic o reintento» |
| 11 | Estado de envío | No se elimina nada. Guille es dueño del registro de intentos (FR-46); el estado de envío de Naybet (FR-167) es el resumen visible; el de Cristóbal (FR-204) amplía estados por mensaje | Anotado a petición de Naybet: **quitar de FR-204 la parte final «(en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado)»** y dejar que la lista de estados la fije una sola vez, de acuerdo entre Guille y Cristóbal |
| 13 | Plazos y cadencia de recordatorios | No se elimina nada. La cadencia queda en el UR de Guille (propuesto); el UR de Cristóbal se ajusta a «plazo de pago y calendario laboral» (se quita «cadencia de recordatorios» de su redacción) | Cristóbal: confirmar el recorte; Guille: confirmar el UR propuesto de cadencia |

## 6. Cambios de las últimas rondas que te afectan

| Cambio | Detalle |
|---|---|
| v3 → v4 · 1 | «Las facturas emitidas no se tocan» estaba en cuatro FR | Se quitan FR-19 (tarifas) y FR-129 (nuevo precio) de v3. FR-115 pasa a ser la regla única y se enlaza con UR-55, UR-10 y UR-57. FR-230 (v3) se recorta a su alcance: «aplicar un cambio de configuración global únicamente a las facturas y condiciones que se creen después del cambio» (sigue ligado a Q-07). |
| v3 → v4 · 2 | FR-106 (v3) era un paraguas de tres acciones, ya cubierto por FR-245 a FR-249 (v3) | Se quita FR-106. UR-50 conserva la búsqueda de direcciones y los cinco FR de incidencias. |
| v4.1 → v5 · B2 | UR-73 → «Poder configurar las monedas en las que se emiten las facturas». UR-50 → «Poder abrir y seguir incidencias de facturación sobre un cliente». Nuevo **UR-108** «Poder buscar direcciones al registrar los datos de un cliente» (FR de búsqueda de direcciones, bajo BR-09) |
| v4.1 → v5 · B3.1 | Se quita FR-139 (v4) («una llamada externa no hace lo que un usuario no pueda»); queda la regla de la API |
| v4.1 → v5 · B3.5 | Se quita FR-196 (v4) (reasignar con aprobación o suplentes). La aprobación pasa a **Q-10** |
| v4.1 → v5 · B4.7 | Se quita FR-129 (v4); lo cubre FR-199 (v4) |
| v5 → v6 · C1 | **Estados de factura** en tres ejes: documental (borrador, pendiente de aprobación, emitida, rectificada), cobro (pendiente, vencida, parcialmente conciliada, pagada, en disputa, anulada, incobrable) y envío (enviada, fallo de envío). FR-16 con la lista completa; FR-54 «parcialmente conciliada»; FR-204 «pagada»; FR-47 solo «en disputa». Glosario actualizado |
| v5 → v6 · C3 | RB-16 limitada a plantillas de factura y recordatorio. NFR-39: «único punto de configuración» en vez de «una sola constante». FR-220 neutro, sin resolver Q-07. RB-02 alineada con FR-09 y FR-10 |
| v5 → v6 · C4 | Nuevo **UR-109** (no usar datos de facturación para campañas comerciales; FR-193; BR-14). Nuevo **UR-110** (cálculo financiero determinista sin IA; FR-205, FR-206; BR-04). Nuevo **FR-241** (dashboard de eficiencia operativa, UR-101). Fuentes de BR-08 y BR-09 sin identificadores antiguos |
| v6 → v7 · 7 | UR-71 se parte: UR-71 (objetivos mensuales y anuales, FR-186) y nuevo **UR-111** (informes periódicos programados, opcional; FR-215 a FR-217) |
| v7 → v8 · 2 | UR en primera persona o sin «Poder…» reformulados: UR-45, UR-78, UR-79, UR-80, UR-82, UR-91, UR-93, UR-94. Ya todos los UR empiezan por «Poder…» |
| v7 → v8 · 4 | FR-188 solo «emitir la factura en una moneda concreta y conservar su importe original» (la conversión ya está en FR-189) |

## 7. Cifras en tu bloque (¿de dónde salen?)

Confirma que vienen del cliente o que estás de acuerdo con que sean suposiciones nuestras:

- **FR-183**: El sistema deberá detectar y notificar la acumulación de más de 3 fallos consecutivos en el envío de comunicaciones a un cliente. 
- **NFR-30**: Las operaciones pesadas no deberán bloquear la interfaz Generar 3.000 facturas con PDF; la UI sigue operativa y muestra estado y progreso; Deberá hacerse test de estrés

## 8. Para el jueves

- [ ] Revisar las secciones 2, 3 y 4 de esta hoja.
- [ ] Confirmar o corregir las cifras.
- [ ] Decir si algo se ha quitado y no debería.
