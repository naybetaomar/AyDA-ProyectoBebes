# Hoja de revisión — Loraine (bloque páginas 6-7)

Documento de referencia: `Requisitos_unificado_v9.md`. Esta hoja resume **solo lo tuyo**: dónde ha quedado cada requisito de tu bloque y qué hay que confirmar. Nada está cerrado: si algo no dice lo que querías decir, anótalo y lo vemos el jueves.

## 1. Resumen

| | Tenías | Siguen | Cambiados de fondo | Quitados |
|---|---|---|---|---|
| Requisitos de usuario | 16 | 16 | 1 | 0 |
| Requisitos funcionales | 46 | 43 | 2 | 3 |
| No funcionales | 12 | 9 | 1 | 3 |
| Reglas de negocio | 7 | 5 | 0 | 2 |

*«Cambiados de fondo» = texto reformulado respecto al tuyo (el resto solo tiene ajustes de forma: «Poder…», «deberá», etc.).*

## 2. Lo que se ha quitado de tu bloque

| Tu ID | Qué decía | Dónde queda cubierto |
|---|---|---|
| FR-05 | El sistema debe permitir marcar las notificaciones como leídas | repetía FR-60 (ronda de depuración) |
| FR-30 | El sistema debe implementar un modelo centralizado y coherente de autorización de permisos | repetía NFR-10 (modelo centralizado de autorización) (ronda de depuración) |
| FR-44 | Las facturas, datos fiscales y contactos no deben ser accesibles mediante URLs públicas adivinables | repetía FR-166 (ronda de depuración) |
| NFR-03 | Los secretos y credenciales de Stripe simulado no deben almacenarse en el repositorio | NFR-28 (Naybet) (secretos y configuración) |
| NFR-07 | El sistema de backup debe estar diseñado y demostrado | FR-101 (restauración demostrada) |
| NFR-08 | Capacidad de anonimizar datos personales por normativa sin destruir la trazabilidad de auditoría | repetía FR-208 (ronda de depuración) |
| RB-05 | El cálculo del prorrateo se realiza dividiendo la cuota mensual entre los días reales del mes en curso y multi | B1 A-01 (prorrateo) |
| RB-06 | Las facturas en estado borrador no consumen numeración oficial definitiva, la cual se asigna de forma concurre | RB-01 (Imad) (numeración definitiva solo al emitir) |

Si crees que alguno no debería haberse quitado, dilo y se recupera.

## 3. Lo que se ha reformulado de fondo

| Tu ID | Ahora es | Texto actual |
|---|---|---|
| UR-13 | UR-45 | Poder evitar sobrescribir cambios de otros usuarios mediante la detección de conflictos de edición concurrente |
| FR-06 | FR-60 | El sistema deberá permitir marcar una notificación como leída o como resuelta/atendida, distinguiendo ambos estados |
| FR-43 | FR-96 | El sistema deberá permitir restaurar las copias de seguridad |
| NFR-10 | NFR-13 | Las operaciones y búsquedas habituales deberán sentirse prácticamente inmediatas |

**Sin cambios de fondo** (solo forma): UR-33, UR-34, UR-35, UR-36, UR-37, UR-38, UR-39, UR-40, UR-41, UR-42, UR-43, UR-44, UR-46, UR-47, UR-48, FR-56, FR-57, FR-58, FR-59, FR-61, FR-62, FR-63, FR-64, FR-65, FR-66, FR-67, FR-68, FR-69, FR-70, FR-71, FR-72, FR-73, FR-74, FR-75, FR-76, FR-77, FR-78, FR-79, FR-80, FR-81, FR-82, FR-83, FR-84, FR-85, FR-86, FR-87, FR-88, FR-89, FR-90, FR-91, FR-92, FR-93, FR-94, FR-95, FR-97, FR-98, NFR-07, NFR-08, NFR-09, NFR-10, NFR-11, NFR-12, NFR-14, NFR-15, RB-09, RB-10, RB-11, RB-12, RB-13

## 4. Lo que se ha añadido en tu zona

Nada.

## 5. Decisiones del 21-10 que te afectan

| # | Tema | Qué se decidió | Pendiente de ti |
|---|---|---|---|
| 2 | Rectificativas | Se elimina FR-39 de Imad; dueño Naybet. Se mantiene RB de Loraine | NFR de inmutabilidad se trata en la ronda de NFR |
| 3 | Asignar, reasignar y delegar | Dueña Loraine (UR-43…45). Se elimina el UR de Cristóbal (FR-07 pasa a colgar del UR de asignación de Loraine) y el UR y FR de acceso del Lector de Luca | Cristóbal: recortar su FR-07 a «reasignar con aprobación» |
| 5 | Gestión de usuarios | Dueña Loraine. Se elimina el UR y FR de Imad | Loraine: valorar un FR «cambiar el rol de un usuario» |
| 8 | Dashboard e informes | Dueña Loraine (UR-04). Se elimina el UR de dashboard de Cristóbal; su FR de proyecto o línea de negocio pasa a UR-04. Se mantienen UR de informes programados (Cristóbal), informes de facturas fallidas (Ana) y eficiencia operativa (Luca) | Cristóbal: añadir un FR para programar informes; Ana: revisar solapamiento parcial con el FR de informes filtrables de Loraine |
| 9 | Notificaciones | Dueña Loraine (UR-02). Se elimina el UR genérico de notificaciones de Cristóbal; se mantienen sus cuatro alertas concretas | Unificar la lista de eventos (Cristóbal incluye «aprobación rechazada») |
| 12 | Filtros y búsqueda | Dueña Loraine (UR-05). Se elimina el UR y FR de Luca. Se amplía el FR de filtros de Loraine con lo que aportaba Luca: «ubicación, sector comercial, estado de pago y fechas» | Loraine: revisar la redacción ampliada de su FR |
| 15 | NFR repetidos | Se eliminan 6 NFR: «pocos pasos» de Imad, «restringir acceso por permisos» de Imad, «búsquedas fluidas», «escalable en la base de datos», «aritmética convencional» y «persistencia de las facturas» de Luca | Se dejan anotados sin tocar: reintentos (Loraine/Guille), retención y minimización, 5 NFR de mantenibilidad, y las cifras sin origen (90 %, <3 y <5 clics) para que cada autor las justifique o las quite |

## 6. Cambios de las últimas rondas que te afectan

| Cambio | Detalle |
|---|---|
| v3 → v4 · 1 | «Las facturas emitidas no se tocan» estaba en cuatro FR | Se quitan FR-19 (tarifas) y FR-129 (nuevo precio) de v3. FR-115 pasa a ser la regla única y se enlaza con UR-55, UR-10 y UR-57. FR-230 (v3) se recorta a su alcance: «aplicar un cambio de configuración global únicamente a las facturas y condiciones que se creen después del cambio» (sigue ligado a Q-07). |
| v4.1 → v5 · B1 | Se quitan A-03 a A-07 (repetían A-10 a A-15). Suposiciones renumeradas de A-01 a A-17 |
| v4.1 → v5 · B3.2 | Se quita FR-85 (v4) («modelo centralizado de autorización»); queda NFR-11 (v4) |
| v4.1 → v5 · B3.4 | Se quita FR-103 (v4) (recordatorios previos); FR-45 (v4) pasa a colgar también de UR-49 |
| v4.1 → v5 · B4.3 | Se quitan FR-99 (v4) y NFR-30 (v4); lo cubre FR-172 (v4) |
| v4.1 → v5 · B4.5 | FR-102 (v4) → «completar automáticamente en las plantillas las variables…» (la edición por tipo y permiso sigue en FR-232 v4) |
| v5 → v6 · C2 | UR-21 con actor «Lector / Administrador». FR-237: solo un Administrador indica que una incidencia pause recordatorios. RB-04 aclara que lo que supera el umbral lo aprueba un Superadministrador; nueva **Q-11** (bloqueo si el único Superadministrador propone). UR-87 a UR-89 pasan a tratar del contacto, con actor «Lector / Administrador» |
| v7 → v8 · 2 | UR en primera persona o sin «Poder…» reformulados: UR-45, UR-78, UR-79, UR-80, UR-82, UR-91, UR-93, UR-94. Ya todos los UR empiezan por «Poder…» |
| v7 → v8 · 5 | Términos ambiguos: FR-82 caduca a las 24 h (nueva **A-18**); FR-38 desviación sobre porcentaje configurable respecto a la media del cliente; FR-52 y FR-53 con criterio de coincidencia (referencia e importe con una única factura); FR-191 con aviso de «operación en proceso» |

## 7. Cifras en tu bloque (¿de dónde salen?)

Confirma que vienen del cliente o que estás de acuerdo con que sean suposiciones nuestras:

- **FR-82**: Los enlaces de recuperación de contraseña deberán caducar a las 24 horas de su emisión (supuesto A-18) 
- **NFR-13**: Las operaciones y búsquedas habituales deberán sentirse prácticamente inmediatas Con 5.000 clientes de prueba, una búsqueda o apertura habitual responde en menos de 3 segundos (supuesto A-17)
- **NFR-14**: El sistema deberá soportar crecimiento a decenas o centenares de usuarios internos y miles de clientes Una prueba de carga con 300 usuarios internos y 5.000 clientes se supera sin cambiar el modelo de

## 8. Para el jueves

- [ ] Revisar las secciones 2, 3 y 4 de esta hoja.
- [ ] Confirmar o corregir las cifras.
- [ ] Decir si algo se ha quitado y no debería.
