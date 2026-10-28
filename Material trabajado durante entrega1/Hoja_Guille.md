# Hoja de revisión — Guille (bloque páginas 4-5)

Documento de referencia: `Requisitos_unificado_v9.md`. Esta hoja resume **solo lo tuyo**: dónde ha quedado cada requisito de tu bloque y qué hay que confirmar. Nada está cerrado: si algo no dice lo que querías decir, anótalo y lo vemos el jueves.

## 1. Resumen

| | Tenías | Siguen | Cambiados de fondo | Quitados |
|---|---|---|---|---|
| Requisitos de usuario | 10 | 9 | 0 | 1 |
| Requisitos funcionales | 30 | 28 | 2 | 2 |
| No funcionales | 2 | 1 | 0 | 1 |
| Reglas de negocio | 4 | 4 | 0 | 0 |

*«Cambiados de fondo» = texto reformulado respecto al tuyo (el resto solo tiene ajustes de forma: «Poder…», «deberá», etc.).*

## 2. Lo que se ha quitado de tu bloque

| Tu ID | Qué decía | Dónde queda cubierto |
|---|---|---|
| UR-04 | Poder consultar duplicados por identificador fiscal al dar de alta o reingresar clientes para reactivar expedi | UR-64 (Naybet) |
| FR-60 | Al dar de alta o el reingreso de un cliente, el sistema deberá buscar coincidencias por identificador fiscal y | FR-142 (Naybet)/FR-143 (Naybet) (duplicados por identificador fiscal) |
| FR-64b | El sistema bloqueará automáticamente el envío de una factura si detecta que falta algún dato fiscal imprescind | FR-161 (Naybet) (bloqueo por falta de dato fiscal) |
| NFR-13 | El sistema de notificaciones debe gestionar los reintentos tras errores de red o entrega sin provocar duplicid | repetía NFR-15 (ronda de depuración) |

Si crees que alguno no debería haberse quitado, dilo y se recupera.

## 3. Lo que se ha reformulado de fondo

| Tu ID | Ahora es | Texto actual |
|---|---|---|
| FR-70 | FR-44 | Ante un rebote o un fallo de correo, el sistema deberá marcar el envío como fallido y generar una incidencia de entrega |
| FR-76b | FR-53 | El sistema deberá derivar a una bandeja de revisión manual los movimientos cuya referencia no identifique con claridad una única factura (sin referencia o ambig |

**Sin cambios de fondo** (solo forma): UR-20, UR-21, UR-22, UR-23, UR-24, UR-25, UR-26, UR-27, UR-28, FR-28, FR-29, FR-30, FR-31, FR-32, FR-33, FR-34, FR-35, FR-36, FR-37, FR-38, FR-39, FR-40, FR-41, FR-42, FR-43, FR-45, FR-46, FR-47, FR-48, FR-49, FR-50, FR-51, FR-52, FR-54, FR-55, NFR-06, RB-05, RB-06, RB-07, RB-08

## 4. Lo que se ha añadido en tu zona

| ID | Texto |
|---|---|
| UR-29 | Poder disponer de la factura emitida en PDF, con su aspecto y contenido inalterables aunque cambie la marca o el catálogo |
| UR-30 | Poder enviar las facturas emitidas al contacto de facturación por correo electrónico o WhatsApp (simulado) |
| UR-31 | Poder configurar la cadencia de los recordatorios automáticos de impago y que respeten el vencimiento acordado con cada cliente |
| UR-32 | Poder consultar los cobros notificados por la pasarela de pagos sin que un mismo evento se contabilice dos veces |
| FR-242 | Ante un cobro por un importe superior al total de la factura, el sistema deberá asociar el movimiento a la factura, registrar la diferencia y señalarla como pendiente de  |
| FR-243 | Ante un rebote o un fallo de correo, el sistema deberá notificar al responsable asignado |
| FR-244 | Tras un fallo de envío, el sistema deberá permitir modificar los datos de contacto y reintentar el envío sin duplicar la factura |

## 5. Decisiones del 21-10 que te afectan

| # | Tema | Qué se decidió | Pendiente de ti |
|---|---|---|---|
| 11 | Estado de envío | No se elimina nada. Guille es dueño del registro de intentos (FR-46); el estado de envío de Naybet (FR-167) es el resumen visible; el de Cristóbal (FR-204) amplía estados por mensaje | Anotado a petición de Naybet: **quitar de FR-204 la parte final «(en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado)»** y dejar que la lista de estados la fije una sola vez, de acuerdo entre Guille y Cristóbal |
| 13 | Plazos y cadencia de recordatorios | No se elimina nada. La cadencia queda en el UR de Guille (propuesto); el UR de Cristóbal se ajusta a «plazo de pago y calendario laboral» (se quita «cadencia de recordatorios» de su redacción) | Cristóbal: confirmar el recorte; Guille: confirmar el UR propuesto de cadencia |
| 15 | NFR repetidos | Se eliminan 6 NFR: «pocos pasos» de Imad, «restringir acceso por permisos» de Imad, «búsquedas fluidas», «escalable en la base de datos», «aritmética convencional» y «persistencia de las facturas» de Luca | Se dejan anotados sin tocar: reintentos (Loraine/Guille), retención y minimización, 5 NFR de mantenibilidad, y las cifras sin origen (90 %, <3 y <5 clics) para que cada autor las justifique o las quite |
| 16 | Barrido de contenido parecido | Se eliminan FR de bloqueo por falta de dato fiscal de Guille (dueño: Naybet) y FR de registro de destinatarios de Imad (dueño: Guille) | Se dejan sin tocar: baja por API frente a baja interna, series de facturación frente a series por entidad emisora |

## 6. Cambios de las últimas rondas que te afectan

| Cambio | Detalle |
|---|---|
| v5 → v6 · C1 | **Estados de factura** en tres ejes: documental (borrador, pendiente de aprobación, emitida, rectificada), cobro (pendiente, vencida, parcialmente conciliada, pagada, en disputa, anulada, incobrable) y envío (enviada, fallo de envío). FR-16 con la lista completa; FR-54 «parcialmente conciliada»; FR-204 «pagada»; FR-47 solo «en disputa». Glosario actualizado |
| v5 → v6 · C2 | UR-21 con actor «Lector / Administrador». FR-237: solo un Administrador indica que una incidencia pause recordatorios. RB-04 aclara que lo que supera el umbral lo aprueba un Superadministrador; nueva **Q-11** (bloqueo si el único Superadministrador propone). UR-87 a UR-89 pasan a tratar del contacto, con actor «Lector / Administrador» |
| v6 → v7 · 1 | FR-155 pasa de «estado creada/no creada» a *«mostrar al usuario el fallo de creación de una factura y su causa»* (un fallo de creación no es un estado). FR-214 también cuelga de UR-53. FR-156 aclara que es el estado de envío de la factura, distinto del estado de cada mensaje (FR-192) |
| v6 → v7 · 2 | FR-54 solo para el cobro inferior («parcialmente conciliada»). Nuevo **FR-242** para el cobro superior (registrar la diferencia y marcar «cobro excesivo») |
| v6 → v7 · 3 | «En disputa» deja de ser un estado de cobro y pasa a ser una marca superpuesta (FR-16, FR-47, glosario), para que una factura vencida en disputa siga constando como vencida. Se añade la marca «cobro excesivo» |
| v7 → v8 · 3 | FR-44 se parte en tres: marcar el envío como fallido y generar incidencia (FR-44), notificar al responsable (**FR-243**) y permitir corregir contacto y reintentar sin duplicar (**FR-244**). *Si el profesor pide agrupar, se vuelve a juntar* |
| v7 → v8 · 5 | Términos ambiguos: FR-82 caduca a las 24 h (nueva **A-18**); FR-38 desviación sobre porcentaje configurable respecto a la media del cliente; FR-52 y FR-53 con criterio de coincidencia (referencia e importe con una única factura); FR-191 con aviso de «operación en proceso» |
| v8 → v9 · 1 | **Conciliación (FR-52, FR-53).** FR-52 concilia automáticamente si la referencia coincide con una única factura (la diferencia de importe la tratan FR-54 y FR-242). FR-53 deriva a revisión manual los movimientos sin referencia clara o ambigua. Es coherente con el cliente: «si hay una coincidencia clara… la concilia; si hay dudas, se la presenta a una persona» |
| v8 → v9 · 2 | **FR-242 (cobro superior).** Asocia el movimiento, registra la diferencia y la señala como pendiente de revisión («cobro excesivo»). *No se marca «pagada»*: el cliente dice que en el pago de más se hace «lo mismo» que en el parcial, es decir, dejar el movimiento asociado y señalar una diferencia pendiente de revisión. Nueva **Q-12** sobre el estado de la factura y el destino del sobrante |

## 7. Cifras en tu bloque (¿de dónde salen?)

Confirma que vienen del cliente o que estás de acuerdo con que sean suposiciones nuestras:

- **NFR-06**: La interfaz del catálogo de productos deberá ofrecer una experiencia de usuario ligera y ágil para la consulta y selección de conceptos frecuentes La selección de un concepto del catálogo e inserción 

## 8. Para el jueves

- [ ] Revisar las secciones 2, 3 y 4 de esta hoja.
- [ ] Confirmar o corregir las cifras.
- [ ] Decir si algo se ha quitado y no debería.
