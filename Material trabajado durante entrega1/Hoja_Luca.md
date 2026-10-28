# Hoja de revisión — Luca (bloque páginas 14-15)

Documento de referencia: `Requisitos_unificado_v9.md`. Esta hoja resume **solo lo tuyo**: dónde ha quedado cada requisito de tu bloque y qué hay que confirmar. Nada está cerrado: si algo no dice lo que querías decir, anótalo y lo vemos el jueves.

## 1. Resumen

| | Tenías | Siguen | Cambiados de fondo | Quitados |
|---|---|---|---|---|
| Requisitos de usuario | 14 | 6 | 0 | 8 |
| Requisitos funcionales | 26 | 10 | 0 | 16 |
| No funcionales | 11 | 7 | 0 | 4 |

*«Cambiados de fondo» = texto reformulado respecto al tuyo (el resto solo tiene ajustes de forma: «Poder…», «deberá», etc.).*

## 2. Lo que se ha quitado de tu bloque

| Tu ID | Qué decía | Dónde queda cubierto |
|---|---|---|
| UR-01 | El administrador deberá registrar la información fiscal y operativa de nuevos clientes. | UR-01 (Imad) |
| UR-02 | El administrador deberá establecer el tipo de cobro (suscripción o pago puntual) a cada cliente. | UR-17 (Imad) |
| UR-04 | El usuario deberá encontrar clientes y registros aplicando filtros. | UR-37 (Loraine) |
| UR-08 | El administrador deberá delimitar el acceso a la información asignando clientes específicos a cada usuario con | UR-42 (Loraine) |
| UR-09 | El administrador deberá poder analizar la evolución global mediante un dashboard. | UR-36 (Loraine) |
| UR-10 | El sistema deberá reclamar la deuda de clientes inactivos o dados de baja. | UR-22 (Guille) |
| UR-12 | El superadministrador deberá poder configurar los vencimientos y recurrencia de notificaciones. | UR-31 (Guille) |
| UR-14 | Brain deberá obtener el estado actualizado de pagos pendientes de cualquier cliente. | UR-61 (Naybet) |
| FR-01 | El sistema deberá registrar los campos obligatorios de cliente: nombre, NIF/CIF, dirección fiscal, sector y co | FR-01 (Imad) (alta de cliente) |
| FR-02 | El sistema deberá permitir la carga masiva de clientes y contactos desde archivos CSV. | FR-71 (Loraine) (importar CSV) |
| FR-03 | El sistema deberá vincular cada cliente a un modelo de cobro de suscripción recurrente o de servicio puntual. | FR-07 (Imad)/FR-08 (Imad) (modalidad puntual/recurrente) |
| FR-04 | El sistema deberá crear las facturas de las suscripciones el primer día de cada mes para los clientes en estad | FR-09 (Imad) (generación mensual) |
| FR-05 | El sistema deberá calcular el importe basado en los días efectivos restantes del mes en curso de nueva suscrip | FR-10 (Imad) (prorrateo) |
| FR-07 | El sistema deberá disponer filtros de búsqueda basados en ubicación, sector comercial, estado de pago y fechas | FR-69 (Loraine) (filtros; se añaden estado de pago y fechas a su redacción) |
| FR-11 | El sistema deberá capturar las notificaciones de eventos duplicados emitidas por la pasarela de pagos y report | FR-51 (Guille) (eventos duplicados de pasarela) |
| FR-13 | El sistema deberá restringir la visualización y edición del rol Lector estrictamente al conjunto de clientes v | UR-42 (Loraine) / FR-90 y RB de Ana (acceso del Lector a clientes asignados) |
| FR-14 | El sistema deberá autenticar a los usuarios validando obligatoriamente el uso de un correo de la empresa. | FR-77 (Loraine) (acceso con correo corporativo) |
| FR-15 | El sistema deberá generar un dashboard resumiendo la facturación total y deuda pendiente semanalmente, mensual | FR-64 (Loraine) (dashboard) |
| FR-16 | El sistema deberá suspender la generación de facturas futuras recurrentes para aquellos clientes dados de baja | FR-33 (Guille) (baja con deuda) |
| FR-17 | El sistema deberá continuar el envío de avisos de impago sobre las facturas emitidas no pagadas. | FR-33 (Guille) (baja con deuda) |
| FR-19 | El sistema deberá poder ajustar la recurrencia de los avisos y cobros según la configuración del Superadminist | FR-45 (Guille) (cadencia de recordatorios) |
| FR-21 | El sistema deberá exponer una API que responda con el estado de deuda asociado a un identificador de cliente. | FR-130 (Naybet) y FR-138 (Naybet) (API) |
| FR-22 | El sistema deberá comparar el identificador de la pasarela con el identificador de la factura para marcar su e | FR-52 (Guille) (conciliación) |
| FR-24 | El sistema deberá transmitir las facturas emitidas en formato digital mediante la vía de contacto registrada d | FR-41 (Guille) (envío de facturas) |
| NFR-03 | El sistema deberá procesar las búsquedas de clientes de forma fluida. | NFR-13 (Loraine) (búsquedas rápidas) |
| NFR-05 | El sistema deberá ser escalable en la base de datos sin degradación para el usuario. | NFR-14 (Loraine) (crecimiento: usuarios y clientes) |
| NFR-11 | El sistema deberá procesar la contabilidad usando operaciones aritméticas convencionales. | NFR-31 (Cristóbal) (precisión decimal) y FR-205 (Luca) (cálculo determinista) |
| NFR-12 | El sistema deberá garantizar la persistencia de las facturas. | NFR-03 (Imad), NFR-37 (Luca), FR-40 (Guille) y RB-07 (Guille) (inmutabilidad/persistencia de facturas) |

Si crees que alguno no debería haberse quitado, dilo y se recupera.

## 3. Lo que se ha reformulado de fondo

Nada de fondo.

**Sin cambios de fondo** (solo forma): UR-96, UR-97, UR-98, UR-99, UR-100, UR-101, FR-197, FR-198, FR-199, FR-200, FR-201, FR-202, FR-203, FR-204, FR-205, FR-206, NFR-33, NFR-34, NFR-35, NFR-36, NFR-37, NFR-38, NFR-39

## 4. Lo que se ha añadido en tu zona

| ID | Texto |
|---|---|
| UR-110 | Poder confiar en que el cálculo financiero es determinista y no depende de inteligencia artificial |
| FR-241 | El sistema deberá mostrar al Superadministrador un dashboard de eficiencia operativa con las métricas recogidas |

*Tus FR-205, FR-206 pasan a colgar de un UR nuevo de esta zona (ver tabla).*

## 5. Decisiones del 21-10 que te afectan

| # | Tema | Qué se decidió | Pendiente de ti |
|---|---|---|---|
| 3 | Asignar, reasignar y delegar | Dueña Loraine (UR-43…45). Se elimina el UR de Cristóbal (FR-07 pasa a colgar del UR de asignación de Loraine) y el UR y FR de acceso del Lector de Luca | Cristóbal: recortar su FR-07 a «reasignar con aprobación» |
| 8 | Dashboard e informes | Dueña Loraine (UR-04). Se elimina el UR de dashboard de Cristóbal; su FR de proyecto o línea de negocio pasa a UR-04. Se mantienen UR de informes programados (Cristóbal), informes de facturas fallidas (Ana) y eficiencia operativa (Luca) | Cristóbal: añadir un FR para programar informes; Ana: revisar solapamiento parcial con el FR de informes filtrables de Loraine |
| 10 | Errores y no perder trabajo | Se mantienen los UR de Naybet y Luca. UR de Cristóbal se queda solo por su FR de doble clic. Se quita «o envíos a Hacienda» del FR de confirmación de Luca | Cristóbal: recortar el texto de su UR a «evitar duplicados por doble clic o reintento» |
| 12 | Filtros y búsqueda | Dueña Loraine (UR-05). Se elimina el UR y FR de Luca. Se amplía el FR de filtros de Loraine con lo que aportaba Luca: «ubicación, sector comercial, estado de pago y fechas» | Loraine: revisar la redacción ampliada de su FR |
| 15 | NFR repetidos | Se eliminan 6 NFR: «pocos pasos» de Imad, «restringir acceso por permisos» de Imad, «búsquedas fluidas», «escalable en la base de datos», «aritmética convencional» y «persistencia de las facturas» de Luca | Se dejan anotados sin tocar: reintentos (Loraine/Guille), retención y minimización, 5 NFR de mantenibilidad, y las cifras sin origen (90 %, <3 y <5 clics) para que cada autor las justifique o las quite |

## 6. Cambios de las últimas rondas que te afectan

| Cambio | Detalle |
|---|---|
| v5 → v6 · C2 | UR-21 con actor «Lector / Administrador». FR-237: solo un Administrador indica que una incidencia pause recordatorios. RB-04 aclara que lo que supera el umbral lo aprueba un Superadministrador; nueva **Q-11** (bloqueo si el único Superadministrador propone). UR-87 a UR-89 pasan a tratar del contacto, con actor «Lector / Administrador» |
| v5 → v6 · C3 | RB-16 limitada a plantillas de factura y recordatorio. NFR-39: «único punto de configuración» en vez de «una sola constante». FR-220 neutro, sin resolver Q-07. RB-02 alineada con FR-09 y FR-10 |
| v7 → v8 · 2 | UR en primera persona o sin «Poder…» reformulados: UR-45, UR-78, UR-79, UR-80, UR-82, UR-91, UR-93, UR-94. Ya todos los UR empiezan por «Poder…» |

## 7. Cifras en tu bloque (¿de dónde salen?)

Confirma que vienen del cliente o que estás de acuerdo con que sean suposiciones nuestras:

- **NFR-33**: El sistema deberá posibilitar que un usuario administrativo asimile el alta de un cliente de forma directa. Al menos el 90% de los sujetos de prueba sin experiencia completarán el alta de suscripción 
- **NFR-34**: El sistema deberá requerir una carga mínima de interacciones para las operaciones fundamentales de la empresa. Crear y emitir una factura puntual requiere como máximo 5 clics, sin contar la vista prev

## 8. Para el jueves

- [ ] Revisar las secciones 2, 3 y 4 de esta hoja.
- [ ] Confirmar o corregir las cifras.
- [ ] Decir si algo se ha quitado y no debería.
