# Hoja de revisión — Ana (bloque páginas 8-9)

Documento de referencia: `Requisitos_unificado_v9.md`. Esta hoja resume **solo lo tuyo**: dónde ha quedado cada requisito de tu bloque y qué hay que confirmar. Nada está cerrado: si algo no dice lo que querías decir, anótalo y lo vemos el jueves.

## 1. Resumen

| | Tenías | Siguen | Cambiados de fondo | Quitados |
|---|---|---|---|---|
| Requisitos de usuario | 5 | 4 | 1 | 1 |
| Requisitos funcionales | 10 | 5 | 1 | 5 |
| No funcionales | 3 | 1 | 0 | 2 |
| Reglas de negocio | 3 | 3 | 0 | 0 |

*«Cambiados de fondo» = texto reformulado respecto al tuyo (el resto solo tiene ajustes de forma: «Poder…», «deberá», etc.).*

## 2. Lo que se ha quitado de tu bloque

| Tu ID | Qué decía | Dónde queda cubierto |
|---|---|---|
| UR-02 | Poder consultar de forma clara los estados de las facturas (pago e impago), el NIF del cliente, las fechas de  | UR-07 (Imad) |
| FR-01 | El sistema deberá permitir la creación, almacenamiento y envío de facturas por correo electrónico | FR-41 (Guille) (envío de facturas) |
| FR-03 | El sistema deberá permitir programar y enviar recordatorios previos a los vencimientos de las facturas | repetía FR-45 (ronda de depuración) |
| FR-04 | El sistema deberá registrar y mostrar el estado de las facturas diferenciando entre pago e impago, asociadas a | FR-17/FR-16 (Imad) (estado de cobro de facturas) |
| FR-06 | El sistema deberá permitir asignar clientes específicos a los empleados encargados de su gestión | FR-86 (Loraine) (asignar clientes) |
| FR-07 | El sistema deberá permitir la apertura, seguimiento y gestión de incidencias asociadas a los clientes | repetía los FR de incidencias (abrir, asignar, adjuntar, pausar recordatorios, cerrar) (ronda de depuración) |
| NFR-02 | El sistema deberá operar, registrar fechas y calcular vencimientos ajustados a la zona horaria oficial de Espa | repetía NFR-42 (ronda de depuración) |
| NFR-03 | La aplicación deberá ser plenamente funcional y accesible desde ordenadores, tabletas y teléfonos móviles | NFR-17 (Naybet) (responsive) |

Si crees que alguno no debería haberse quitado, dilo y se recupera.

## 3. Lo que se ha reformulado de fondo

| Tu ID | Ahora es | Texto actual |
|---|---|---|
| UR-03 | UR-50 | Poder abrir y seguir incidencias de facturación sobre un cliente |
| FR-09 | FR-102 | El sistema deberá funcionar con el zoom del navegador ampliado sin perder funcionalidad |

**Sin cambios de fondo** (solo forma): UR-49, UR-51, UR-52, FR-99, FR-100, FR-101, FR-103, NFR-16, RB-14, RB-15, RB-16

## 4. Lo que se ha añadido en tu zona

| ID | Texto |
|---|---|
| FR-11 | El sistema deberá mostrar el importe prorrateado y la mensualidad normal antes de la confirmación final del alta. |
| FR-210 | Al restablecerse tras una caída, el sistema deberá detectar las facturas recurrentes que no se generaron en su fecha |
| FR-211 | El sistema deberá generar las facturas recurrentes pendientes tras una caída sin duplicar las ya generadas |
| FR-218 | El sistema deberá validar los cambios de configuración global antes de aplicarlos |
| FR-219 | El sistema deberá registrar en la auditoría quién cambia la configuración global, cuándo, y el valor anterior y el nuevo |
| FR-220 | El sistema deberá aplicar un cambio de configuración global a partir del momento de su validación |
| FR-221 | El sistema deberá permitir al superadministrador configurar el logo y la plantilla de las facturas |
| FR-222 | El sistema deberá permitir enviar a un usuario un correo de prueba con una plantilla de comunicación antes de activar un cambio |
| FR-223 | El sistema deberá permitir previsualizar el calendario de recordatorios que resultaría de una regla para un cliente de ejemplo |
| FR-224 | El sistema deberá avisar en la previsualización de una plantilla cuando falte alguna de sus variables |
| FR-227 | El sistema deberá proponer en las altas frecuentes valores por defecto de país, moneda, vencimiento y tarifa sugerida según el rango |
| FR-228 | El sistema deberá mostrar cuántos elementos afecta una acción masiva antes de ejecutarla |
| FR-229 | El sistema deberá pedir confirmación antes de ejecutar una acción masiva destructiva o sensible |
| FR-230 | El sistema deberá mostrar al terminar una acción masiva el resultado con los elementos correctos y los erróneos |
| FR-231 | El sistema no deberá permitir marcar facturas como pagadas mediante una acción masiva |
| FR-232 | El sistema deberá permitir crear etiquetas y asignarlas a clientes (opcional) |
| FR-233 | El sistema no deberá sustituir con etiquetas manuales los estados derivados, como «impagado» (opcional) |
| UR-102 | Poder confiar en que una caída breve del sistema no hace perder ni duplicar emisiones o generaciones mensuales de facturas |
| UR-103 | Poder gestionar la configuración global del sistema con cambios validados y auditados, sin que afecten a lo ya emitido |
| UR-104 | Poder probar los cambios de plantillas y de reglas de recordatorio antes de activarlos |
| UR-105 | Poder dar de alta clientes de forma ágil, con valores por defecto y revisando el resultado antes de confirmar |
| UR-106 | Poder ejecutar acciones masivas sobre clientes con control del alcance y del resultado |
| UR-107 | Poder etiquetar clientes para organizarlos de forma flexible (opcional) |
| UR-108 | Poder buscar direcciones al registrar los datos de un cliente |

*Tus FR-101 pasan a colgar de un UR nuevo de esta zona (ver tabla).*

## 5. Decisiones del 21-10 que te afectan

| # | Tema | Qué se decidió | Pendiente de ti |
|---|---|---|---|
| 6 | Estado de cobro | Dueño Imad (UR-07). Se eliminan el UR de estados de Ana y el de Cristóbal. El FR de historial de versiones de Ana pasa a UR-07 de Imad; el FR del único contacto de facturación de Cristóbal pasa a UR-03 de Imad | Ana y Cristóbal: confirmar los cambios de UR |
| 8 | Dashboard e informes | Dueña Loraine (UR-04). Se elimina el UR de dashboard de Cristóbal; su FR de proyecto o línea de negocio pasa a UR-04. Se mantienen UR de informes programados (Cristóbal), informes de facturas fallidas (Ana) y eficiencia operativa (Luca) | Cristóbal: añadir un FR para programar informes; Ana: revisar solapamiento parcial con el FR de informes filtrables de Loraine |
| 17 | Complemento del bloque 8-9 | Se integra al final de las tablas (UR-102 en adelante) el complemento redactado para las páginas 8 y 9, validado por Naybet. Se elimina toda mención a la aplicación Zoom (Ana confirma que fue un error): se quita del UR de dispositivos y su suposición; se conserva su FR reescrito como requisito de accesibilidad (zoom del navegador), que sí sale de la transcripción | Ana: revisar el complemento y los dos cambios en su bloque |

## 6. Cambios de las últimas rondas que te afectan

| Cambio | Detalle |
|---|---|
| v3 → v4 · 1 | «Las facturas emitidas no se tocan» estaba en cuatro FR | Se quitan FR-19 (tarifas) y FR-129 (nuevo precio) de v3. FR-115 pasa a ser la regla única y se enlaza con UR-55, UR-10 y UR-57. FR-230 (v3) se recorta a su alcance: «aplicar un cambio de configuración global únicamente a las facturas y condiciones que se creen después del cambio» (sigue ligado a Q-07). |
| v3 → v4 · 3 | FR-238 (v3) era la versión genérica y poco verificable de FR-11 | Se quita FR-238. FR-11 se enlaza también con UR-105. UR-105 se reformula con un solo objetivo: «Poder dar de alta clientes de forma ágil, con valores por defecto y revisando el resultado antes de confirmar». |
| v4.1 → v5 · B2 | UR-73 → «Poder configurar las monedas en las que se emiten las facturas». UR-50 → «Poder abrir y seguir incidencias de facturación sobre un cliente». Nuevo **UR-108** «Poder buscar direcciones al registrar los datos de un cliente» (FR de búsqueda de direcciones, bajo BR-09) |
| v4.1 → v5 · B3.3 | FR-222 (v4) → «permitir indicar a quién se envían los resúmenes periódicos (opcional)»; los resúmenes los genera FR-107 (v4) |
| v4.1 → v5 · B4.6 | Se quita FR-60 (v4); FR-61 (v4) → «marcar como leída o resuelta/atendida, distinguiendo ambos estados»; FR-62 (v4) solo prioridad |
| v5 → v6 · C3 | RB-16 limitada a plantillas de factura y recordatorio. NFR-39: «único punto de configuración» en vez de «una sola constante». FR-220 neutro, sin resolver Q-07. RB-02 alineada con FR-09 y FR-10 |
| v7 → v8 · 2 | UR en primera persona o sin «Poder…» reformulados: UR-45, UR-78, UR-79, UR-80, UR-82, UR-91, UR-93, UR-94. Ya todos los UR empiezan por «Poder…» |

## 7. Cifras en tu bloque (¿de dónde salen?)

Sin cifras relevantes en los requisitos.

## 8. Para el jueves

- [ ] Revisar las secciones 2, 3 y 4 de esta hoja.
- [ ] Confirmar o corregir las cifras.
- [ ] Decir si algo se ha quitado y no debería.
