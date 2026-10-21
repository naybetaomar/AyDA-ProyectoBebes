# Hoja de revisión — Imad (bloque páginas 1-3)

Documento de referencia: `Requisitos_unificado_v9.md`. Esta hoja resume **solo lo tuyo**: dónde ha quedado cada requisito de tu bloque y qué hay que confirmar. Nada está cerrado: si algo no dice lo que querías decir, anótalo y lo vemos el jueves.

## 1. Resumen

| | Tenías | Siguen | Cambiados de fondo | Quitados |
|---|---|---|---|---|
| Requisitos de usuario | 23 | 19 | 0 | 4 |
| Requisitos funcionales | 41 | 27 | 0 | 14 |
| No funcionales | 8 | 5 | 0 | 3 |
| Reglas de negocio | 4 | 4 | 1 | 0 |

*«Cambiados de fondo» = texto reformulado respecto al tuyo (el resto solo tiene ajustes de forma: «Poder…», «deberá», etc.).*

## 2. Lo que se ha quitado de tu bloque

| Tu ID | Qué decía | Dónde queda cubierto |
|---|---|---|
| UR-11 | El personal administrativo deberá poder recibir avisos de revisión de rangos de precios y consultar el rango p | UR-57 (Naybet) |
| UR-19 | El personal administrativo deberá poder generar y consultar las facturas en formato PDF. | UR-29 (Guille) |
| UR-21 | El administrador deberá poder gestionar los usuarios del sistema y asignar sus permisos de acceso. | UR-40 (Loraine) |
| UR-22 | El personal administrativo deberá poder consultar de forma global la situación de clientes y facturas sin abri | UR-36 (Loraine) |
| FR-05 | El sistema deberá poder registrar los destinatarios y direcciones de correo utilizados en cada envío de factur | FR-43 (Guille) (registro de cada intento de envío con destinatario) |
| FR-17 | El sistema deberá poder generar y mostrar la representación en archivo PDF de una factura. | FR-39 (Guille) (PDF) |
| FR-20 | El sistema deberá poder registrar pagos parciales reflejando de forma transparente el saldo e importe pendient | FR-54 (Guille) (pagos parciales/excesivos) |
| FR-21 | El sistema deberá poder transmitir recordatorios de cobro para facturas vencidas y registrar la fecha del enví | FR-45 (Guille) (recordatorios y cadencia) |
| FR-22 | El sistema deberá poder mostrar un cuadro de mando con el resumen global consolidado de clientes y facturas. | FR-64 (Loraine) (dashboard) |
| FR-24 | El sistema deberá poder registrar la facturación anual verificada de un cliente. | FR-116 a FR-119 (Naybet) (revisión anual de plan: se queda la campaña de Naybet) |
| FR-25 | El sistema deberá poder notificar cuando corresponda revisar el rango de tarifa aplicable a un cliente. | FR-116 a FR-119 (Naybet) (revisión anual de plan: se queda la campaña de Naybet) |
| FR-26 | El sistema deberá poder calcular la propuesta de tarifa aplicable en función de la facturación anual verificad | FR-116 a FR-119 (Naybet) (revisión anual de plan: se queda la campaña de Naybet) |
| FR-27 | El sistema deberá poder exigir validación humana previa antes de aplicar un cambio de rango de tarifa. | FR-116 a FR-119 (Naybet) (revisión anual de plan: se queda la campaña de Naybet) |
| FR-28 | El sistema deberá poder registrar el usuario aprobador, la fecha, la tarifa anterior y la tarifa nueva al modi | FR-116 a FR-119 (Naybet) (revisión anual de plan: se queda la campaña de Naybet) |
| FR-29 | El sistema mantendrá inalterados los importes y datos de las facturas históricas emitidas tras cambios en la c | repetía FR-109 (ronda de depuración) |
| FR-37 | El sistema deberá poder mantener el número y la factura original sin generar duplicados ante el reintento de e | FR-44 (Guille) y NFR-13 de Guille (quitado) (reintentos sin duplicar) |
| FR-39 | El sistema deberá poder conservar la factura original emitida y registrar una factura rectificativa vinculada  | FR-109 (Naybet)/FR-110 (Naybet) (rectificativas) |
| FR-41 | El sistema deberá poder permitir al administrador gestionar los usuarios de la plataforma y asignar sus permis | FR-79 (Loraine)/FR-80 (Loraine) (gestión de usuarios) |
| NFR-02 | El sistema deberá poder realizar operaciones administrativas con pocos pasos. | NFR-34 (Luca) (pocos clics) |
| NFR-04 | El sistema deberá poder utilizarse desde un telefono movil. | NFR-17 (Naybet) (responsive) |
| NFR-05 | El sistema deberá poder restringir el acceso segun los permisos asignados a cada usuario. | FR-83 (Loraine)/FR-30 de Loraine (quitado), FR-166 (Naybet) y RB-15 (Ana) (acceso del Lector a clientes asignados) |

Si crees que alguno no debería haberse quitado, dilo y se recupera.

## 3. Lo que se ha reformulado de fondo

| Tu ID | Ahora es | Texto actual |
|---|---|---|
| RB-02 | RB-02 | Las facturas recurrentes se emitirán el día 1 de cada mes; la primera, en el mes de alta, se calcula por prorrateo desde el día de inicio de la relación, salvo  |

**Sin cambios de fondo** (solo forma): UR-01, UR-02, UR-03, UR-04, UR-05, UR-06, UR-07, UR-08, UR-09, UR-10, UR-11, UR-12, UR-13, UR-14, UR-15, UR-16, UR-17, UR-18, UR-19, FR-01, FR-02, FR-03, FR-04, FR-05, FR-06, FR-07, FR-08, FR-09, FR-10, FR-11, FR-12, FR-13, FR-14, FR-15, FR-16, FR-17, FR-18, FR-19, FR-20, FR-21, FR-22, FR-23, FR-24, FR-25, FR-26, FR-27, NFR-01, NFR-02, NFR-03, NFR-04, NFR-05, RB-01, RB-03, RB-04

## 4. Lo que se ha añadido en tu zona

Nada.

## 5. Decisiones del 21-10 que te afectan

| # | Tema | Qué se decidió | Pendiente de ti |
|---|---|---|---|
| 1 | Revisión anual de plan | Se queda la campaña de Naybet (UR-05); Imad conserva configuración de rangos y inmutabilidad (UR-10, FR-19, FR-25). Se elimina su UR-11 con FR-24…28 | Imad: ya no aparece «avisos de revisión» como UR propio |
| 2 | Rectificativas | Se elimina FR-39 de Imad; dueño Naybet. Se mantiene RB de Loraine | NFR de inmutabilidad se trata en la ronda de NFR |
| 5 | Gestión de usuarios | Dueña Loraine. Se elimina el UR y FR de Imad | Loraine: valorar un FR «cambiar el rol de un usuario» |
| 6 | Estado de cobro | Dueño Imad (UR-07). Se eliminan el UR de estados de Ana y el de Cristóbal. El FR de historial de versiones de Ana pasa a UR-07 de Imad; el FR del único contacto de facturación de Cristóbal pasa a UR-03 de Imad | Ana y Cristóbal: confirmar los cambios de UR |
| 15 | NFR repetidos | Se eliminan 6 NFR: «pocos pasos» de Imad, «restringir acceso por permisos» de Imad, «búsquedas fluidas», «escalable en la base de datos», «aritmética convencional» y «persistencia de las facturas» de Luca | Se dejan anotados sin tocar: reintentos (Loraine/Guille), retención y minimización, 5 NFR de mantenibilidad, y las cifras sin origen (90 %, <3 y <5 clics) para que cada autor las justifique o las quite |
| 16 | Barrido de contenido parecido | Se eliminan FR de bloqueo por falta de dato fiscal de Guille (dueño: Naybet) y FR de registro de destinatarios de Imad (dueño: Guille) | Se dejan sin tocar: baja por API frente a baja interna, series de facturación frente a series por entidad emisora |

## 6. Cambios de las últimas rondas que te afectan

| Cambio | Detalle |
|---|---|
| v4.1 → v5 · B4.8 | FR-11: «mostrar» el prorrateo (el cálculo es FR-10) |
| v5 → v6 · C1 | **Estados de factura** en tres ejes: documental (borrador, pendiente de aprobación, emitida, rectificada), cobro (pendiente, vencida, parcialmente conciliada, pagada, en disputa, anulada, incobrable) y envío (enviada, fallo de envío). FR-16 con la lista completa; FR-54 «parcialmente conciliada»; FR-204 «pagada»; FR-47 solo «en disputa». Glosario actualizado |
| v5 → v6 · C3 | RB-16 limitada a plantillas de factura y recordatorio. NFR-39: «único punto de configuración» en vez de «una sola constante». FR-220 neutro, sin resolver Q-07. RB-02 alineada con FR-09 y FR-10 |
| v6 → v7 · 3 | «En disputa» deja de ser un estado de cobro y pasa a ser una marca superpuesta (FR-16, FR-47, glosario), para que una factura vencida en disputa siga constando como vencida. Se añade la marca «cobro excesivo» |
| v6 → v7 · 4 | RB-02: «salvo excepción comercial aprobada (FR-12)» |
| v7 → v8 · 1 | «Deberá poder» → «deberá» en FR-01 a FR-27 (27 filas). FR-02 reformulado |
| v7 → v8 · 5 | Términos ambiguos: FR-82 caduca a las 24 h (nueva **A-18**); FR-38 desviación sobre porcentaje configurable respecto a la media del cliente; FR-52 y FR-53 con criterio de coincidencia (referencia e importe con una única factura); FR-191 con aviso de «operación en proceso» |
| v8 → v9 · 3 | FR-38: la advertencia no bloquea la emisión (el cliente: «la advertencia no siempre debe bloquear») |
| v8 → v9 · 4 | «Deberá permitir…» en las acciones del usuario: FR-04, 06, 07, 08, 12, 13, 15, 19, 20 y 27 |

## 7. Cifras en tu bloque (¿de dónde salen?)

Sin cifras relevantes en los requisitos.

## 8. Para el jueves

- [ ] Revisar las secciones 2, 3 y 4 de esta hoja.
- [ ] Confirmar o corregir las cifras.
- [ ] Decir si algo se ha quitado y no debería.
