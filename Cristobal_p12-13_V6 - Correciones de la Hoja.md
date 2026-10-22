## 5. Para el jueves

⚠ RESUELTOS
| UR-01 | Clasificar y categorizar las facturas por proyecto o línea de negocio para su análisis, pudiendo gestionar las | UR-36 (solo el FR-185 sigue colgando de él) | revisar | ⚠ HUECO: su UR desapareció y FR-185 (clasificar por proyecto) cuelga ahora 
| UR-16 | No perder trabajo (borradores automáticos, deshacer cuando proceda) y recibir mensajes de error comprensibles  | UR-96 (borradores), NFR-45 (mensajes de error comprensibles) | revisar | ⚠ «Deshacer cuando proceda» no está en ningún sitio. ¿Se 
| UR-35 | Desplegar sistema de pruebas automáticas y entornos reproducibles. | Sin UR. NFR-29 (entorno reproducible/pruebas) y NFR-24 | revisar | ⚠ Es un requisito de despliegue/calidad: ¿vale como NFR o quieres UR? FR-195 (datos ficticios) cuelga de 
| FR-16 | El sistema deberá ofrecer un panel de auditoría general que permita consultar, filtrar y exportar los registro | FR-92 a FR-94 | revisar | Consultar y filtrar. ⚠ «Exportar» los registros de auditoría no aparece |
| FR-20 | El sistema deberá disponer de un dashboard financiero interactivo con vistas temporalizadas que permita desglo | FR-64, FR-65, FR-66 | revisar | ⚠ «Importar» informes no está (solo exportar) |

- [X] Contestar a los ⚠ de la sección 3 (¿recuperar UR-01 propio? ¿«deshacer»? ¿UR-35 como NFR?).
- [X] Confirmar que tus FR con ‘ajustado’ o ‘reformulado’ siguen diciendo lo que querías (están listados en la sección 2).
- [X] Confirmar las cifras que aparecen en tus FR/NFR: más de 3 fallos consecutivos (FR-183), 3.000 facturas (NFR-30) y una semana sin gestionar (FR-184).
    - "Si rebota, no marques la factura como correctamente notificada. Avísale al responsable del cliente, deja una incidencia de entrega y permite corregir el contacto y reenviar. [...] Y que quede claro cuál fue el envío original y cuáles fueron reintentos." Hay que poner un límite de intentos para no saturar
    - 3.000 facturas Aparece como ejemplo random en el PDF, Pruebas de estrés es más generico;
    - una semana sin gestionar es otro ejemplo que aparece en el pdf "'si una revisión anual lleva una semana sin resolver'", "el cliente nos dice que su departamento financiero está investigando una incidencia y nos pide una semana."


# 1. Cuestiones a Comentar (METER EN REQUISITO NO FUNCIONAL)

| ID / Requisito | Diagnóstico y Reubicación | Estado / Resolución |
| --- | --- | --- |
| **UR-16 / UR-96** <br> *(Borradores automáticos, deshacer y errores)* | Se desglosa en **UR-96** (autoguardado de borradores) y **NFR-45** (mensajes de error comprensibles). | La función *"deshacer cuando proceda"* queda cubierta por **UR-97** (`FR-198`). |


# 2. Requisitos Corregidos

| ID Original | Descripción | Estado Anterior | Estado Actual / Propuesta |
| --- | --- | --- | --- |
| **UR-01** | Clasificar y categorizar las facturas por proyecto o línea de negocio para su análisis. | `UR-36` (asociado erróneamente solo a `FR-185`) | Se reasigna a **`UR-107`** para mantener la coherencia con la clasificación por etiquetas/categorías. |


# 3. Requisitos Eliminados o Delegados de este Bloque

| ID | Actor | Requisito de Usuario | Razón de Reubicación |
| --- | --- | --- | --- |
| **UR-04** | Lector / Administrador | Saber qué facturas están pagadas, pendientes, vencidas o en disputa, y por qué. | Fusionado con estado de cobro. Delegado al bloque anterior (**Imad** - `UR-07`, `FR-16`, `FR-17`, `FR-47`). |
| **UR-05** | Administrador | Garantizar que los clientes activos mantengan siempre al menos un contacto válido para la emisión de facturas. | Cubierto por `FR-196`. Delegado al bloque anterior (**Imad** - `UR-03`). |
| **UR-43 / UR-44** | Administrador | Cambiar la asignación y delegar temporalmente clientes a usuarios. | Delegado al bloque de **Loraine**. |
| **UR-36** | Administrador | Ver un dashboard financiero (semanal, mensual, trimestral, anual) con cifras desglosables e informes exportables. | Delegado al bloque de **Loraine** (`FR-64`, `FR-65`, `FR-66`). |
| **UR-58** | Superadministrador / Administrador | Ver una pantalla de monitoreo (última generación recurrente, cola de emails, errores, backup, registro de procesos). | Delegado al bloque de **Naybet** (`FR-124` a `FR-127`, `FR-212`, `FR-213`). |
| **UR-10 / UR-11 / UR-73** | Superadministrador | Configurar el sistema de monedas, impuestos, tarifas y rangos. | Repartido en otros bloques previos. |
| **BR-06** | Negocio | La aplicación no debe usar automáticamente datos de facturación para campañas comerciales. | Eliminado por duplicidad; queda cubierto por **BR-14**. |
| **FR-191** | Sistema | Impedir duplicados por doble clic o reintento en emisión, envío y conciliación. | Asignado a **UR-70** en su correspondiente bloque. |


# 5. Requisitos de Calidad y Despliegue (NFR)

| ID | Actor | Requisito / Descripción | Criterio de Reubicación |
| --- | --- | --- | --- |
| **UR-35** | Superadministrador | Desplegar sistema de pruebas automáticas y entornos reproducibles. | Reclasificado a Requisito No Funcional: **NFR-29** (entornos reproducibles) y **NFR-24** (testabilidad). `FR-195` (datos ficticios) se asigna a **UR-74**. |


# 6. Mapeo de FRs Huérfanos por Reorganización

| ID FR | Requisito Funcional | Destino / Cobertura en la Matriz |
| --- | --- | --- |
| **FR-04** | Emitir facturas en moneda concreta y conservar tanto el importe original como el convertido. | Integrado en **FR-188 / FR-189** (`UR-76`). |
| **FR-04.1** | Consultar e identificar el estado detallado de cada factura y motivo de disputa. | Delegado al bloque de **Imad** (`UR-07`). |
| **FR-07** | Reasignar clientes con aprobación a otro administrador o definir suplentes. | Delegado al bloque de **Loraine** (`UR-43 / UR-44`, `FR-87`, `FR-88`). |
| **FR-08 / FR-190** | Ejecutar tareas largas en segundo plano con estado visible sin bloquear la interfaz. | Asignado a **UR-58 / NFR-30** (Monitoreo y rendimiento). |
| **FR-17 / FR-195** | Cargar datos ficticios aislados para entornos de demo. | Asignado a **UR-74** (Entornos de prueba). |
| **FR-19 / FR-196** | Impedir eliminar o inactivar el único contacto de facturación de un cliente activo. | Delegado al bloque de **Imad** (`UR-03`). |
| **FR-20** | Disponer de un dashboard financiero interactivo con vistas temporalizadas y exportación. | Delegado al bloque de **Loraine** (`UR-36`, `FR-64` a `FR-66`). |