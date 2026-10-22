## 2. Organización del trabajo

El equipo está formado por siete personas. Un miembro ejerció de coordinador / Scrum Master (convocar las reuniones, mantener el tablero, proponer criterios comunes y vigilar la coherencia entre las partes), y el resto del equipo se repartió la especificación de requisitos por bloques de páginas de la transcripción ampliada del cliente (págs. 1-3, 4-5, 6-7, 8-9, 10-11, 12-13 y 14-15). Cada persona fue responsable de redactar los requisitos de su bloque (requisitos de usuario, funcionales y no funcionales, reglas de negocio, suposiciones y glosario) siguiendo la plantilla de la asignatura.

Herramientas y canales: repositorio compartido con un único fichero Markdown de requisitos al que cada miembro sube su bloque; tablero `[COMPLETAR: Trello / GitHub Projects / otro]`; reunión de equipo semanal los domingos; chat del grupo para dudas intermedias `[COMPLETAR: WhatsApp / Discord / otro]`.

Decisiones de organización tomadas durante la entrega:
- Una **rúbrica común de 8 criterios** para que todos redactaran con el mismo estándar (un requisito = un comportamiento; verificable y sin diseño; relación UR↔FR; calidad del requisito de usuario; sin duplicados; uso de "deberá" y marcado de ampliaciones como "(opcional)"; cobertura del bloque; coherencia con lo dicho por el cliente). Se trató como una guía propuesta por el equipo, no como una norma fija: a partir de la respuesta de los profesores se revisó el primer criterio (ver Sprint 2).
- **Revisión cruzada circular**: cada miembro revisa el bloque consecutivo con la rúbrica una vez subidos todos.
- Una **tabla de responsable por tema** para resolver los temas que aparecían en varios bloques (por ejemplo baja, envío, conciliación, PDF o API).
- Convenciones comunes: identificadores con sufijo (b, c) al dividir un requisito, sin renumerar; fuente indicada como "Transcripción ampliada, pág. N".
- En la reunión del 18 de octubre se acordó:
  - La **lista de actores** del sistema, que se recoge en la plantilla común donde se unifica toda la especificación.
  - Que, además de volver a revisar el propio bloque, cada miembro **revisa el bloque consecutivo** (revisión circular).
  - Que los valores concretos que el cliente no fijó (tamaños mínimos, tiempos y similares) **siguen el criterio de cada autor** en su bloque, documentándolos como suposición, y que los duplicados entre bloques se eliminan en el momento de la unificación.
  - El planteamiento del **stand del 27 de octubre**.
- Decisiones tomadas durante la unificación (Sprint 2):
  - Se conserva el nombre de actor **"Lector"** (el cliente habla de "usuarios operativos" pero dijo que lo importante es la capacidad y no el nombre) y se documenta la jerarquía de roles como suposición (A-19).
  - Cada autor recibió una **hoja de revisión** con lo que se quitó, reformuló o movió de su bloque, para confirmarlo antes de congelar el documento.
  - Se **congela el documento** como versión de entrega salvo cambios acordados en la reunión del 22 de octubre; las versiones anteriores se conservan como reserva.

## 3. Sprints realizados

### Sprint 1

- Fecha de inicio: `[30/09/2026]`
- Fecha de finalización: `[18/10/2026]`
- Objetivo del Sprint: Obtener una primera versión de los requisitos de cada bloque de la transcripción ampliada, usando la plantilla de la asignatura.
- Tareas planificadas:
  - Leer la transcripción ampliada y repartir los bloques de páginas.
  - Redactar los requisitos de usuario, funcionales y no funcionales de cada bloque.
  - Subir cada bloque al repositorio compartido.
- Tareas completadas: Los 7 fragmentos del documento fueron completados.
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
- Tareas completadas:
  - Unificación de los siete bloques en un único documento, con requisitos de negocio, trazabilidad (negocio → usuario → sistema) y glosario. El documento unificado contiene 14 requisitos de negocio, 111 de usuario, 50 no funcionales, 35 reglas de negocio, 19 suposiciones y 12 dudas.
  - Eliminación de duplicados y solapes entre bloques en varias rondas de revisión, dejando constancia de cada cambio en un registro de cambios.
  - Revisión del nivel de detalle de los requisitos funcionales tras la respuesta de los dos profesores: se pasó de 244 requisitos funcionales (uno por comportamiento) a 109 formulados como capacidades del sistema. Los pasos de interacción, las condiciones y los valores concretos se trasladaron a reglas de negocio, a requisitos no funcionales y a una sección de condiciones para los casos de uso, y se conservó el detalle completo en un anexo para quien redacte cada caso de uso.
  - Una hoja de revisión por autor, con lo que se quitó, reformuló o movió de su bloque y las cuestiones que debía confirmar. La revisión de la hoja de uno de los miembros (que había subido una versión nueva de su bloque mientras se unificaba) permitió corregir referencias y fuentes de cifras del documento.
  - Diagramas de casos de uso de los miembros del equipo en PlantUML sobre los requisitos de usuario del documento unificado `[COMPLETAR: cuántos diagramas y qué miembros los han subido]`.
  - `[COMPLETAR: informe Scrum, plantilla, stand, tablero]`
- Reuniones realizadas:
  - Domingo 18 de octubre, 18:00: unificación de actores, acuerdo de revisión circular, aclaración de dudas de cada bloque, criterio para los valores no fijados por el cliente, planteamiento del stand del 27 de octubre y calendario hasta la entrega.
  - Sesión de prácticas del miércoles 21 de octubre `[COMPLETAR tras la sesión: se empezaron los diagramas de casos de uso]`.
  - Quedada del jueves 22 de octubre, 17:30 `[COMPLETAR tras la reunión: decisiones sobre la versión de entrega, reparto de los apartados 1.1, 1.2, 2, 8 y 9, confirmación de cada hoja de revisión]`.
- Problemas encontrados:
  - Algunas cifras no figuraban en el texto del cliente (tiempos de respuesta, volumen de clientes, plazo de conservación) y se habían inventado de forma distinta en cada bloque. Otras sí procedían de ejemplos del cliente (por ejemplo, tres fallos de envío, una semana sin resolver o 3.000 facturas) y se documentaron con su fuente.
  - Falta de cobertura de algunos temas (informes programados, etiquetas, estados del cliente, disponibilidad tras una caída).
  - **Exceso de requisitos funcionales y de nivel de detalle.** La rúbrica interna ("un requisito = un comportamiento") produjo 244 requisitos funcionales. Los dos profesores señalaron que eran demasiados y de grano muy fino y que un requisito funcional debe describir qué hace el sistema (la capacidad), dejando los pasos de interacción para los casos de uso y las condiciones para las reglas de negocio.
  - Un miembro subió una versión nueva de su bloque mientras se hacía la unificación, por lo que su hoja de revisión partía de una versión anterior.
  - Algunos diagramas de casos de uso usaban identificadores del bloque original y no los de la especificación unificada.
- Soluciones aplicadas:
  - Documentar las cifras sin fuente como suposiciones en la sección 6 de cada bloque, y dejar el valor al criterio de cada autor; las que tienen fuente en el texto del cliente se justifican con ella.
  - Eliminar los duplicados entre bloques durante la unificación, quedándose con la versión del bloque al que corresponde el tema.
  - Reformular los requisitos funcionales como capacidades del sistema (de 244 a 109), llevar las condiciones a reglas de negocio y a requisitos no funcionales y conservar el detalle en un anexo para los casos de uso. Se mantiene la versión anterior como reserva.
  - Comprobar la hoja de cada autor contra su última versión y corregir lo que no coincidía; pedir el mapa de identificadores antiguo → unificado para los diagramas.
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
| Requisitos funcionales demasiado numerosos y detallados | El profesorado los considera "de grano muy fino"; riesgo de mala evaluación y de documento difícil de mantener | Reformular como capacidades (de 244 a 109), llevar las condiciones a reglas de negocio y requisitos no funcionales, y conservar el detalle en un anexo para los casos de uso |
| Versiones de bloque que cambian durante la unificación | Hojas de revisión y trazabilidad desfasadas | Contrastar cada hoja con la última versión del autor y congelar versiones hasta la entrega |
| Diagramas con identificadores distintos a los del documento unificado | Diagramas que no se pueden relacionar con los requisitos | Mapa de equivalencias y revisión de los diagramas contra los requisitos de usuario del documento |
| Un bloque entregado con retraso | Riesgo de no tener la fusión a tiempo | Reparto de sus temas entre varios miembros `[CONFIRMAR]` |
| Poco margen entre la congelación de requisitos (miércoles 21) y la entrega (viernes 23) | Errores de última hora en la trazabilidad o los diagramas | Dar el jueves como fecha objetivo interna y usar el viernes como colchón |
| Trazabilidad sin responsable asignado | Retraso o incoherencia en la tabla de trazabilidad | Asignar una persona responsable una vez congelados los requisitos `[COMPLETAR]` |

## 5. Valoración final

`[COMPLETAR con tu opinión; propuesta de borrador a continuación]`

El trabajo en bloques permitió avanzar en paralelo, pero la principal dificultad fue la coherencia entre las partes: sin criterios comunes desde el principio, cada bloque se redactó con un estilo y un nivel de detalle diferentes, y los temas compartidos se repitieron. La rúbrica común, la revisión cruzada y la tabla de responsable por tema resolvieron buena parte de este problema, aunque llegaron cuando ya había mucho texto escrito.

Una segunda lección fue el nivel de abstracción de los requisitos funcionales. Aplicar al pie de la letra "un requisito = un comportamiento" llevó a fragmentar capacidades del sistema en muchos requisitos de grano muy fino. La respuesta de los profesores permitió corregirlo, pasando a formular cada requisito como una capacidad (qué hace el sistema) y dejando los pasos de interacción para los casos de uso y las condiciones para las reglas de negocio. Esto redujo el documento a menos de la mitad de los requisitos funcionales sin perder contenido.

Como propuestas de mejora para próximas entregas:
- Acordar la plantilla, la rúbrica y la lista de actores **antes** de empezar a redactar.
- Validar con el profesorado el **nivel de abstracción** de los requisitos funcionales con un ejemplo antes de redactar el documento completo.
- Asignar los temas transversales a un único responsable desde el reparto inicial.
- Programar una primera revisión cruzada a mitad de sprint, no al final.
- Leer cada bloque contra la transcripción original durante la revisión, para detectar lecturas erróneas.
- Congelar las versiones de cada bloque durante la unificación y usar los mismos identificadores en los diagramas y en el documento.
