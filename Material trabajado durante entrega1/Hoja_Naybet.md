# Hoja de revisión — Naybet (bloque páginas 10-11)

Documento de referencia: `Requisitos_unificado_v9.md`. Esta hoja resume **solo lo tuyo**: dónde ha quedado cada requisito de tu bloque y qué hay que confirmar. Nada está cerrado: si algo no dice lo que querías decir, anótalo y lo vemos el jueves.

## 1. Resumen

| | Tenías | Siguen | Cambiados de fondo | Quitados |
|---|---|---|---|---|
| Requisitos de usuario | 16 | 16 | 0 | 0 |
| Requisitos funcionales | 67 | 63 | 0 | 4 |
| No funcionales | 14 | 13 | 0 | 1 |

*«Cambiados de fondo» = texto reformulado respecto al tuyo (el resto solo tiene ajustes de forma: «Poder…», «deberá», etc.).*

## 2. Lo que se ha quitado de tu bloque

| Tu ID | Qué decía | Dónde queda cubierto |
|---|---|---|
| FR-01 | El sistema deberá generar facturas en formato PDF | FR-39 (Guille) (PDF) |
| FR-17b | El sistema no deberá modificar las facturas ya emitidas de meses anteriores al aplicar un nuevo precio | repetía FR-109 (ronda de depuración) |
| FR-19b | El sistema deberá permitir consultar el estado de procesamiento de los emails pendientes | repetía FR-156 (ronda de depuración) |
| FR-27b | Una llamada externa no deberá hacer ninguna operación que un usuario no pueda realizar | repetía FR-133 (ronda de depuración) |
| NFR-09 | El acceso a un adjunto deberá seguir los permisos del cliente y de la factura a la que está asociado | repetía FR-166 (ronda de depuración) |

Si crees que alguno no debería haberse quitado, dilo y se recupera.

## 3. Lo que se ha reformulado de fondo

Nada de fondo.

**Sin cambios de fondo** (solo forma): UR-53, UR-54, UR-55, UR-56, UR-57, UR-58, UR-59, UR-60, UR-61, UR-62, UR-63, UR-64, UR-65, UR-66, UR-67, UR-68, FR-104, FR-105, FR-106, FR-107, FR-108, FR-109, FR-110, FR-111, FR-112, FR-113, FR-114, FR-115, FR-116, FR-117, FR-118, FR-119, FR-120, FR-121, FR-122, FR-123, FR-124, FR-125, FR-126, FR-127, FR-128, FR-129, FR-130, FR-131, FR-132, FR-133, FR-134, FR-135, FR-136, FR-137, FR-138, FR-139, FR-140, FR-141, FR-142, FR-143, FR-144, FR-145, FR-146, FR-147, FR-148, FR-149, FR-150, FR-151, FR-152, FR-153, FR-154, FR-155, FR-156, FR-157, FR-158, FR-159, FR-160, FR-161, FR-162, FR-163, FR-164, FR-165, FR-166, NFR-17, NFR-18, NFR-19, NFR-20, NFR-21, NFR-22, NFR-23, NFR-24, NFR-25, NFR-26, NFR-27, NFR-28, NFR-29

## 4. Lo que se ha añadido en tu zona

Nada.

## 5. Decisiones del 21-10 que te afectan

| # | Tema | Qué se decidió | Pendiente de ti |
|---|---|---|---|
| 1 | Revisión anual de plan | Se queda la campaña de Naybet (UR-05); Imad conserva configuración de rangos y inmutabilidad (UR-10, FR-19, FR-25). Se elimina su UR-11 con FR-24…28 | Imad: ya no aparece «avisos de revisión» como UR propio |
| 2 | Rectificativas | Se elimina FR-39 de Imad; dueño Naybet. Se mantiene RB de Loraine | NFR de inmutabilidad se trata en la ronda de NFR |
| 4 | Monitorización | Dueño Naybet (UR-06). Se elimina el UR de monitoreo de Cristóbal; su FR-08 (tareas en segundo plano con estado) pasa a colgar de UR-06 | Naybet: decidir si añade un FR de «registro de ejecución de procesos automáticos» |
| 10 | Errores y no perder trabajo | Se mantienen los UR de Naybet y Luca. UR de Cristóbal se queda solo por su FR de doble clic. Se quita «o envíos a Hacienda» del FR de confirmación de Luca | Cristóbal: recortar el texto de su UR a «evitar duplicados por doble clic o reintento» |
| 11 | Estado de envío | No se elimina nada. Guille es dueño del registro de intentos (FR-46); el estado de envío de Naybet (FR-167) es el resumen visible; el de Cristóbal (FR-204) amplía estados por mensaje | Anotado a petición de Naybet: **quitar de FR-204 la parte final «(en cola, enviado, entregado si el proveedor lo informa, fallido, reintentado)»** y dejar que la lista de estados la fije una sola vez, de acuerdo entre Guille y Cristóbal |
| 16 | Barrido de contenido parecido | Se eliminan FR de bloqueo por falta de dato fiscal de Guille (dueño: Naybet) y FR de registro de destinatarios de Imad (dueño: Guille) | Se dejan sin tocar: baja por API frente a baja interna, series de facturación frente a series por entidad emisora |
| 17 | Complemento del bloque 8-9 | Se integra al final de las tablas (UR-102 en adelante) el complemento redactado para las páginas 8 y 9, validado por Naybet. Se elimina toda mención a la aplicación Zoom (Ana confirma que fue un error): se quita del UR de dispositivos y su suposición; se conserva su FR reescrito como requisito de accesibilidad (zoom del navegador), que sí sale de la transcripción | Ana: revisar el complemento y los dos cambios en su bloque |

## 6. Cambios de las últimas rondas que te afectan

Ninguno con tu nombre. Los cambios de redacción general (tiempos verbales, «deberá poder», «Poder…») están ya aplicados en todo el documento.

## 7. Cifras en tu bloque (¿de dónde salen?)

Confirma que vienen del cliente o que estás de acuerdo con que sean suposiciones nuestras:

- **FR-129**: El sistema deberá cerrar sesión automáticamente tras 30 minutos de inactividad 
- **FR-146**: Tras 5 intentos fallidos de login consecutivos, el sistema deberá bloquear temporalmente el acceso del usuario durante 15 minutos 
- **NFR-25**: El sistema deberá limitar el tamaño de cada archivo adjunto (10 MB) Un archivo mayor de 10 MB es rechazado con un mensaje explicativo (supuesto A-05)

## 8. Para el jueves

- [ ] Revisar las secciones 2, 3 y 4 de esta hoja.
- [ ] Confirmar o corregir las cifras.
- [ ] Decir si algo se ha quitado y no debería.
