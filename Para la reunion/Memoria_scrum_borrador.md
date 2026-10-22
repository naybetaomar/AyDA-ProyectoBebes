## 2. Organización del trabajo

El equipo está formado por siete personas. Un miembro ejerció de coordinador / Scrum Master (convocar las reuniones, mantener el tablero, proponer criterios comunes y vigilar la coherencia entre las partes), y el resto del equipo se repartió la especificación de requisitos por bloques de páginas de la transcripción ampliada del cliente (págs. 1-3, 4-5, 6-7, 8-9, 10-11, 12-13 y 14-15). Cada persona fue responsable de redactar los requisitos de su bloque (requisitos de usuario, funcionales y no funcionales, reglas de negocio, suposiciones y glosario) siguiendo la plantilla de la asignatura.

Herramientas y canales: repositorio compartido con un único fichero Markdown de requisitos al que cada miembro sube su bloque; tablero `[COMPLETAR: Trello / GitHub Projects / otro]`; reunión de equipo semanal los domingos; chat del grupo para dudas intermedias `[COMPLETAR: WhatsApp / Discord / otro]`.

Decisiones de organización tomadas durante la entrega:
- Una **rúbrica común de 8 criterios** para que todos redactaran con el mismo estándar (un requisito = un comportamiento; verificable y sin diseño; relación UR↔FR; calidad del requisito de usuario; sin duplicados; uso de "deberá" y marcado de ampliaciones como "(opcional)"; cobertura del bloque; coherencia con lo dicho por el cliente).
- **Revisión cruzada circular**: cada miembro revisa el bloque consecutivo con la rúbrica una vez subidos todos.
- Una **tabla de responsable por tema** para resolver los temas que aparecían en varios bloques (por ejemplo baja, envío, conciliación, PDF o API).
- Convenciones comunes: identificadores con sufijo (b, c) al dividir un requisito, sin renumerar; fuente indicada como "Transcripción ampliada, pág. N".
- En la reunión del 18 de octubre se acordó:
  - La **lista de actores** del sistema, que se recoge en la plantilla común donde se unifica toda la especificación.
  - Que, además de volver a revisar el propio bloque, cada miembro **revisa el bloque consecutivo** (revisión circular).
  - Que los valores concretos que el cliente no fijó (tamaños mínimos, tiempos y similares) **siguen el criterio de cada autor** en su bloque, documentándolos como suposición, y que los duplicados entre bloques se eliminan en el momento de la unificación.
  - El planteamiento del **stand del 27 de octubre**.

## 3. Sprints realizados

### Sprint 1

- Fecha de inicio: `[30/09/2026]`
- Fecha de finalización: `[18/10/2026]`
- Objetivo del Sprint: Obtener una primera versión de los requisitos de cada bloque de la transcripción ampliada, usando la plantilla de la asignatura.
- Tareas planificadas:
  - Leer la transcripción ampliada y repartir los bloques de páginas.
  - Redactar los requisitos de usuario, funcionales y no funcionales de cada bloque.
  - Subir cada bloque al repositorio compartido.
- Tareas completadas: `[Los 7 fragmentos del documento fueron completados"]`
- Reuniones realizadas: `[30/09/2026]` y `[07/10/2026]`
- Problemas encontrados:
  - Cada bloque se redactó con criterios distintos (formato de identificadores, fuentes, nivel de detalle).
  - Aparecieron temas duplicados entre bloques y actores con nombres distintos ("Lector", "Personal administrativo", "Editor").
  - Algunos requisitos agrupaban varios comportamientos.
  - La transcripción está redactada de forma narrativa y fue difícil identificar los requisitos en ella.
- Soluciones aplicadas:
  - Se propuso una rúbrica común de 8 criterios.
  - Se acordó una revisión cruzada entre bloques consecutivos.
  - Se preparó una lista de temas duplicados para asignar un responsable en la reunión de equipo.

#### Estado del tablero en el Sprint Planning

![alt text](image-1.png)


#### Estado del tablero en la Sprint Retrospective

![alt text](image.png)
### Sprint 2

- Fecha de inicio: `[18/10/2026]`
- Fecha de finalización:  `[23/10/2026]`
- Objetivo del Sprint: Unificar los bloques en una única especificación coherente (actores, requisitos de negocio, trazabilidad y glosario) y preparar los diagramas de casos de uso.
- Tareas planificadas:
  - Corregir cada bloque según la rúbrica y la revisión cruzada.
  - Fusionar los bloques en un único documento, eliminando los duplicados, y consolidar los requisitos de negocio.
  - Tener todos los requisitos resueltos para la sesión de prácticas del miércoles 21 de octubre, y empezar en ella el diagrama de casos de uso del grupo (PlantUML).
  - Completar la trazabilidad entre requisitos de negocio, de usuario y del sistema.
  - Quedada del jueves 22 de octubre a las 17:30 para organizar el stand, cerrar este informe Scrum y revisar la plantilla.
  - Entrega el viernes 23 de octubre.
- Tareas completadas: `[COMPLETAR]`
- Reuniones realizadas:
  - Domingo 18 de octubre, 18:00: unificación de actores, acuerdo de revisión circular, aclaración de dudas de cada bloque, criterio para los valores no fijados por el cliente, planteamiento del stand del 27 de octubre y calendario hasta la entrega.
  - Sesión de prácticas del miércoles 21 de octubre `[COMPLETAR tras la sesión]`.
  - Quedada del jueves 22 de octubre, 17:30 `[COMPLETAR tras la reunión]`.
- Problemas encontrados:
  - El bloque 8-9 llegó con retraso y con errores de lectura de la transcripción (por ejemplo, interpretar "zoom" como la aplicación Zoom cuando el cliente se refería al zoom del navegador).
  - Algunas cifras no figuraban en el texto del cliente (tiempos de respuesta, volumen de clientes, plazo de conservación) y se habían inventado de forma distinta en cada bloque.
  - Falta de cobertura de algunos temas (informes programados, etiquetas, estados del cliente, disponibilidad tras una caída).
  - Coincidencia con exámenes de otras asignaturas.
- Soluciones aplicadas:
  - Documentar las cifras sin fuente como suposiciones en la sección 6 de cada bloque, y dejar el valor al criterio de cada autor.
  - Eliminar los duplicados entre bloques durante la unificación, quedándose con la versión del bloque al que corresponde el tema.
  - Repartir los temas pendientes del bloque 8-9 entre varios miembros `[CONFIRMAR]`.
  - Calendario hasta la entrega: requisitos resueltos para el miércoles 21, quedada el jueves 22 a las 17:30 y entrega el viernes 23, dejando el jueves como fecha objetivo interna para tenerlo todo listo.

#### Estado del tablero en el Sprint Planning

![alt text](image-3.png)
#### Estado del tablero en la Sprint Retrospective

[Insertar captura del tablero]

## 4. Problemas y riesgos

| Problema / riesgo | Impacto | Medida adoptada |
|---|---|---|
| Criterios de redacción distintos entre bloques | Documento incoherente, requisitos duplicados o contradictorios | Rúbrica común y revisión cruzada |
| Temas repetidos en varios bloques | Duplicados y contradicciones entre requisitos | Tabla de responsable por tema decidida en reunión |
| Actores con nombres diferentes | Trazabilidad y diagramas inconsistentes | Lista única de actores acordada en reunión |
| Lecturas erróneas de la transcripción | Requisitos que no corresponden a lo que pidió el cliente | Revisión de cada bloque contra el texto original |
| Cifras sin fuente en el texto del cliente | Requisitos no justificables; posibles valores distintos para lo mismo | Documentarlas como suposición en la sección 6 y comprobar la coherencia en la unificación |
| Entrega próxima y exámenes de otras asignaturas | Retrasos en la entrega de algún bloque | Calendario con fechas intermedias y reparto de los temas pendientes |
| Un bloque entregado con retraso | Riesgo de no tener la fusión a tiempo | Reparto de sus temas entre varios miembros `[CONFIRMAR]` |
| Poco margen entre la congelación de requisitos (miércoles 21) y la entrega (viernes 23) | Errores de última hora en la trazabilidad o los diagramas | Dar el jueves como fecha objetivo interna y usar el viernes como colchón |
| Trazabilidad sin responsable asignado | Retraso o incoherencia en la tabla de trazabilidad | Asignar una persona responsable una vez congelados los requisitos `[COMPLETAR]` |

## 5. Valoración final

`[COMPLETAR con tu opinión; propuesta de borrador a continuación]`

El trabajo en bloques permitió avanzar en paralelo, pero la principal dificultad fue la coherencia entre las partes: sin criterios comunes desde el principio, cada bloque se redactó con un estilo y un nivel de detalle diferentes, y los temas compartidos se repitieron. La rúbrica común, la revisión cruzada y la tabla de responsable por tema resolvieron buena parte de este problema, aunque llegaron cuando ya había mucho texto escrito.

Como propuestas de mejora para próximas entregas:
- Acordar la plantilla, la rúbrica y la lista de actores **antes** de empezar a redactar.
- Asignar los temas transversales a un único responsable desde el reparto inicial.
- Programar una primera revisión cruzada a mitad de sprint, no al final.
- Leer cada bloque contra la transcripción original durante la revisión, para detectar lecturas erróneas.
