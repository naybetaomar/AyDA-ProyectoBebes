# Informe Scrum: Entrega 1 
 
## 1. Identificación del equipo 
 
| Nombre y apellidos | Rol | 
|---|---| 
| Abdelnaybet Aomar Hamed   | Scrum Master | 
| Imad El Founti Chaib          | Miembro | 
| Luca Fernández Cordeiro        | Miembro | 
| Ana Guerrero Martín            | Miembro | 
| Guillermo Herrera Lozano       | Miembro | 
| Loraine Meijer Arboleda        | Miembro | 
| Cristóbal Jesús Subires Macías | Miembro | 
 

## 2. Organización del trabajo

El equipo está formado por siete personas. Un miembro ejerció de coordinador / Scrum Master (convocar las reuniones, mantener el tablero, proponer criterios comunes y vigilar la coherencia entre las partes), y el resto del equipo se repartió la especificación de requisitos por bloques de páginas de la transcripción ampliada del cliente (págs. 1-3, 4-5, 6-7, 8-9, 10-11, 12-13 y 14-15). Cada persona fue responsable de redactar los requisitos de su bloque (requisitos de usuario, funcionales y no funcionales, reglas de negocio, suposiciones y glosario) siguiendo la plantilla de la asignatura.

Herramientas y canales: repositorio compartido con un único fichero Markdown de requisitos al que cada miembro sube su bloque; tablero Trello; reunión de equipo semanal los domingos; chat del grupo para dudas intermedias Discord y WhatsApp.

Decisiones de organización tomadas durante la entrega:
- Una **rúbrica común de 8 criterios** para que todos redactaran con el mismo estándar (un requisito = un comportamiento; verificable y sin diseño; relación UR↔FR; calidad del requisito de usuario; sin duplicados; uso de "deberá" y marcado de ampliaciones como "(opcional)"; cobertura del bloque; coherencia con lo dicho por el cliente).
- **Revisión cruzada circular**: cada miembro revisa el bloque consecutivo con la rúbrica una vez subidos todos.
- Una **tabla de responsable por tema** para resolver los temas que aparecían en varios bloques (por ejemplo baja, envío, conciliación, PDF o API).
- En la reunión del 18 de octubre se acordó:
  - La **lista de actores** del sistema, que se recoge en la plantilla común donde se unifica toda la especificación.
  - Que los valores concretos que el cliente no fijó (tamaños mínimos, tiempos y similares) **siguen el criterio de cada autor** en su bloque, documentándolos como suposición, y que los duplicados entre bloques se eliminan en el momento de la unificación.
  - El planteamiento del **stand del 27 de octubre**.

## 3. Sprints realizados

### Sprint 1

- Fecha de inicio: 30/09/2026
- Fecha de finalización: 18/10/2026
- Objetivo del Sprint: Obtener una primera versión de los requisitos de cada bloque de la transcripción ampliada, usando la plantilla de la asignatura.
- Tareas planificadas:
  - Leer la transcripción ampliada y repartir los bloques de páginas.
  - Redactar los requisitos de usuario, funcionales y no funcionales de cada bloque.
  - Subir cada bloque al repositorio compartido.
- Tareas completadas:
  - Lectura de la transcripción ampliada y reparto de los siete bloques de páginas entre los miembros del equipo.
  - Redacción de los requisitos de cada bloque (de usuario, funcionales y no funcionales, reglas de negocio, suposiciones y glosario) siguiendo la plantilla de la asignatura.
  - Subida de los siete bloques al repositorio compartido.
  - Propuesta de una rúbrica común y de una revisión cruzada entre bloques consecutivos.
- Reuniones realizadas: 30/09/2026 y 07/10/2026
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

![Tablero al inicio del sprint 1](<capturas trello/sprint 1 inicio.png>)


#### Estado del tablero en la Sprint Retrospective
![Tablero al final del sprint 1](<capturas trello/sprint 1 final.png>)

### Sprint 2

- Fecha de inicio: 18/10/2026
- Fecha de finalización: 23/10/2026
- Objetivo del Sprint: Unificar los bloques en una única especificación coherente (actores, requisitos de negocio, trazabilidad y glosario) y preparar los diagramas de casos de uso.
- Tareas planificadas:
  - Corregir cada bloque según la rúbrica y la revisión cruzada.
  - Fusionar los bloques en un único documento, eliminando los duplicados, y consolidar los requisitos de negocio.
  - Tener todos los requisitos resueltos para la sesión de prácticas del miércoles 21 de octubre, y empezar en ella el diagrama de casos de uso del grupo (PlantUML).
  - Completar la trazabilidad entre requisitos de negocio, de usuario y del sistema.
  - Quedada del jueves 22 de octubre a las 17:30 para organizar el stand, cerrar este informe Scrum y revisar la plantilla.
  - Entrega el viernes 23 de octubre.
- Tareas completadas:
  - Unificación de los siete bloques en un único documento de requisitos, con requisitos de negocio, de usuario, funcionales y no funcionales, reglas de negocio, suposiciones, dudas abiertas y trazabilidad (negocio → usuario → sistema), y eliminación de duplicados entre bloques.
  - Diagramas de casos de uso en PlantUML de cada miembro del equipo sobre los requisitos unificados, y posterior versión unificada: los casos de uso se reorganizaron por área funcional en 11 diagramas, con los actores definidos en la sección 1.3 del documento de requisitos y la jerarquía Lector < Administrador < Superadministrador.
  - Especificación textual de los 58 casos de uso con la plantilla de la asignatura (identificación, precondiciones, flujo principal, flujos alternativos y de excepción, postcondiciones) y trazabilidad a los requisitos de usuario y funcionales.
  - Generación de los PDF de requisitos y de especificación de casos de uso a partir de los ficheros Markdown fuente, y exportación de los diagramas en formato PlantUML.
  - Redacción de este informe Scrum.
- Reuniones realizadas:
  - Domingo 18 de octubre, 18:00: unificación de actores, acuerdo de revisión circular, aclaración de dudas de cada bloque, criterio para los valores no fijados por el cliente, planteamiento del stand del 27 de octubre y calendario hasta la entrega.
  - Sesión de prácticas del miércoles 21 de octubre: aplicación de las correcciones propuestas, inicio de la unificación de los bloques en una única plantilla y comienzo de los casos de uso.
  - Quedada del jueves 22 de octubre, 17:30: cierre de la unificación de la plantilla de requisitos, ajustes en los diagramas de casos de uso y redacción de la plantilla de especificación proporcionada para los casos de uso.
- Problemas encontrados:
  - Algunas cifras no figuraban en el texto del cliente (tiempos de respuesta, volumen de clientes, plazo de conservación) y se habían inventado de forma distinta en cada bloque.
  - Falta de cobertura de algunos temas (informes programados, etiquetas, estados del cliente, disponibilidad tras una caída).
  - Los diagramas de cada miembro se habían hecho por bloque de requisitos y usaban identificadores del bloque original en lugar de los de la especificación unificada.
- Soluciones aplicadas:
  - Documentar las cifras sin fuente como suposiciones en la sección 6 de cada bloque, y dejar el valor al criterio de cada autor.
  - Eliminar los duplicados entre bloques durante la unificación, quedándose con la versión del bloque al que corresponde el tema.
  - Reorganizar los diagramas por área funcional (11 diagramas), consolidar los casos de uso a nivel de objetivo y redactar la especificación de los 58 casos de uso con la plantilla, que se revisó en equipo.
  
#### Estado del tablero en el Sprint Planning
![Tablero al inicio del sprint 2](<capturas trello/sprint 2 inicio.png>)
#### Estado del tablero en la Sprint Retrospective

![Tablero al final del sprint 2](<capturas trello/sprint 2 final.png>)

## 4. Problemas y riesgos

| Problema / riesgo | Impacto | Medida adoptada |
|---|---|---|
| Criterios de redacción distintos entre bloques | Documento incoherente, requisitos contradictorios | Rúbrica común y revisión cruzada |
| Temas repetidos en varios bloques | Duplicados y contradicciones entre requisitos | Tabla de responsable por tema decidida en reunión |
| Actores con nombres diferentes | Trazabilidad y diagramas inconsistentes | Lista única de actores acordada en reunión |
| Lecturas erróneas de la transcripción | Requisitos que no corresponden a lo que pidió el cliente | Revisión de cada bloque contra el texto original |
| Cifras sin fuente en el texto del cliente | Requisitos no justificables; posibles valores distintos para lo mismo | Documentarlas como suposición en la sección 6 y comprobar la coherencia en la unificación |
| Entrega próxima y exámenes de otras asignaturas | Retrasos en la entrega de algún bloque | Calendario con fechas intermedias y reparto de los temas pendientes |

## 5. Valoración final

El trabajo en bloques permitió avanzar en paralelo, pero la principal dificultad fue la coherencia entre las partes: sin criterios comunes desde el principio, cada bloque se redactó con un estilo y un nivel de detalle diferentes, y los temas compartidos se repitieron. La rúbrica común, la revisión cruzada y la tabla de responsable por tema resolvieron buena parte de este problema, aunque llegaron cuando ya había mucho texto escrito.

Como propuestas de mejora para próximas entregas:

- Preparar una rúbrica **antes** de empezar a redactar.
- Programar una primera revisión cruzada a mitad de sprint, no al final.
