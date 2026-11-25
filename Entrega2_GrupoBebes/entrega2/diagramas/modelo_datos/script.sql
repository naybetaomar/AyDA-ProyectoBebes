-- =====================================================================
-- E-R físico — Turbine · Grupo Bebes · Entrega 2 · PostgreSQL 16
-- Áreas 1 (clientes), 2 (relación comercial), 3 (facturas), 4 (aprobaciones
-- y periodos), 5 (envío y comunicaciones), 6 (cobros), 7 (notificaciones),
-- 8 (informes y contabilidad), 9 (usuarios, seguridad y auditoría)
-- y 11 (API externa).
-- Las tablas van en orden de dependencia: por eso las de un área que apuntan
-- a factura (áreas 1 y 4) están después del área 3, y la descarga de
-- ficheros (área 9) va al final.
-- Reglas de traducción: snake_case, PK id, FK <tabla>_id, herencia en una tabla
-- con columna tipo, enumerados como VARCHAR + CHECK y columnas de trazabilidad.
-- v2 (17/11): integra el parche de inalterabilidad, la FK compuesta de la serie
-- y documenta VENCIDA y A-28.
-- v3 (24/11): importe por tramos (tramo_importe) y pausas como intervalos
-- (periodo_pausa); configuracion_recurrente pierde importe_mensual, activa,
-- pausada_desde, importe_nuevo y fecha_cambio_importe.
-- v4 (24/11): añade las tablas de las áreas 1, 2, 4 y 5.
-- v5 (24/11): añade las tablas de las áreas 7 y 8.
-- v6 (24/11): añade las tablas del área 9; usuario deja de ser un marcador.
-- v7 (25/11): añade las tablas del área 11.
-- v8 (25/11): área 4 con motivo y fecha de resolución; área 5 con idioma de la
-- plantilla y motivo del fallo del mensaje.
-- v9 (25/11): motivo y fecha de revisión de la disputa de una factura (CU-31).
-- v10 (25/11): solicitud de excepción sobre una factura o una configuración
-- recurrente (prorrateo, CU-22); formato de la exportación masiva.
-- =====================================================================

-- =====================================================================
-- ÁREA 9 — USUARIOS, SEGURIDAD Y AUDITORÍA (asignacion_cliente va tras el
-- área 1 y descarga_fichero al final, porque apuntan a cliente, documento
-- y exportacion_masiva)
-- =====================================================================

CREATE TABLE usuario (
    id                 BIGSERIAL     PRIMARY KEY,
    nombre             VARCHAR(200)  NOT NULL,
    email              VARCHAR(255)  NOT NULL,      -- único sin distinguir mayúsculas (índice abajo)
    rol                VARCHAR(20)   NOT NULL CHECK (rol IN ('OPERATIVO', 'ADMINISTRADOR', 'SUPERADMINISTRADOR')),
    activo             BOOLEAN       NOT NULL DEFAULT TRUE,
    credencial_hash    VARCHAR(255)  NOT NULL,     -- nunca la contraseña en claro
    intentos_fallidos  INTEGER       NOT NULL DEFAULT 0 CHECK (intentos_fallidos >= 0),
    bloqueado_hasta    TIMESTAMP,                  -- 5 fallos seguidos = 15 min (A-07)
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- a@x.es y A@X.ES son la misma cuenta. ServicioAcceso pasa el email a minúsculas.
CREATE UNIQUE INDEX uq_usuario_email ON usuario (lower(email));

CREATE EXTENSION IF NOT EXISTS btree_gist;  -- EXCLUDE con igualdad (rangos, periodos, pausas, asignaciones)

-- Las tablas que son en sí un registro (sesion, token_recuperacion,
-- registro_auditoria, descarga_fichero) no llevan columnas de trazabilidad.
CREATE TABLE sesion (
    id                BIGSERIAL  PRIMARY KEY,
    usuario_id        BIGINT     NOT NULL REFERENCES usuario(id),
    inicio            TIMESTAMP  NOT NULL,
    ultima_actividad  TIMESTAMP  NOT NULL,
    cerrada_en        TIMESTAMP,                   -- se cierra tras 30 min de inactividad (A-06)
    CONSTRAINT ck_sesion_fechas CHECK (ultima_actividad >= inicio AND (cerrada_en IS NULL OR cerrada_en >= inicio))
);

CREATE TABLE token_recuperacion (
    id          BIGSERIAL  PRIMARY KEY,
    usuario_id  BIGINT     NOT NULL REFERENCES usuario(id),
    token_hash  CHAR(64)   NOT NULL UNIQUE CHECK (token_hash ~ '^[0-9a-f]{64}$'),  -- SHA-256 del enlace, en hexadecimal
    emitido_en  TIMESTAMP  NOT NULL,
    caduca_en   TIMESTAMP  NOT NULL,
    usado_en    TIMESTAMP,
    CONSTRAINT ck_token_caducidad CHECK (caduca_en = emitido_en + INTERVAL '24 hours'),
    CONSTRAINT ck_token_uso CHECK (usado_en IS NULL OR usado_en BETWEEN emitido_en AND caduca_en)
);

CREATE TABLE delegacion (
    id           BIGSERIAL  PRIMARY KEY,
    origen_id    BIGINT     NOT NULL REFERENCES usuario(id),
    suplente_id  BIGINT     NOT NULL REFERENCES usuario(id),
    desde        DATE       NOT NULL,
    caducidad    DATE       NOT NULL,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_delegacion_fechas CHECK (desde <= caducidad),
    CONSTRAINT ck_delegacion_usuarios CHECK (origen_id <> suplente_id)
);

-- Inalterable: solo se crea y se consulta (ver el disparador). usuario nulo = Sistema.
CREATE TABLE registro_auditoria (
    id                BIGSERIAL     PRIMARY KEY,
    fecha             TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    usuario_id        BIGINT        REFERENCES usuario(id),
    entidad_afectada  VARCHAR(100)  NOT NULL,
    accion            VARCHAR(100)  NOT NULL,
    valor_anterior    TEXT,
    valor_nuevo       TEXT
);

CREATE FUNCTION fn_auditoria_inalterable() RETURNS trigger AS $$
BEGIN
    RAISE EXCEPTION 'El registro de auditoría no se modifica ni se borra';
END $$ LANGUAGE plpgsql;

CREATE TRIGGER tg_auditoria_inalterable
    BEFORE UPDATE OR DELETE ON registro_auditoria
    FOR EACH ROW EXECUTE FUNCTION fn_auditoria_inalterable();

-- Tampoco se vacía de golpe.
CREATE TRIGGER tg_auditoria_sin_truncate
    BEFORE TRUNCATE ON registro_auditoria
    FOR EACH STATEMENT EXECUTE FUNCTION fn_auditoria_inalterable();

CREATE TABLE copia_seguridad (
    id      BIGSERIAL    PRIMARY KEY,
    fecha   TIMESTAMP    NOT NULL,
    estado  VARCHAR(10)  NOT NULL DEFAULT 'EN_CURSO' CHECK (estado IN ('EN_CURSO', 'CORRECTA', 'FALLIDA')),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

CREATE TABLE restauracion_copia (
    id                  BIGSERIAL    PRIMARY KEY,
    copia_seguridad_id  BIGINT       NOT NULL REFERENCES copia_seguridad(id),
    usuario_id          BIGINT       NOT NULL REFERENCES usuario(id),
    fecha               TIMESTAMP    NOT NULL,
    resultado           VARCHAR(10)  NOT NULL CHECK (resultado IN ('CORRECTA', 'FALLIDA')),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- =====================================================================
-- ÁREA 1 — CLIENTES Y CONTACTOS (núcleo; documento y factura_categoria
-- van después del área 3 porque apuntan a factura)
-- =====================================================================

-- estado_cliente no es columna: se calcula desde la relación comercial más
-- reciente (RelacionComercial.estadoCliente(), área 2).
CREATE TABLE cliente (
    id                   BIGSERIAL     PRIMARY KEY,
    razon_social         VARCHAR(255)  NOT NULL,
    identificador_fiscal VARCHAR(30)   NOT NULL,
    pais                 CHAR(2)       NOT NULL,
    moneda               CHAR(3)       NOT NULL,
    direccion            VARCHAR(500)  NOT NULL,
    datos_pendientes     BOOLEAN       NOT NULL DEFAULT FALSE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT uq_cliente_identificador UNIQUE (identificador_fiscal)   -- CU-01
);

CREATE TABLE contacto (
    id                       BIGSERIAL     PRIMARY KEY,
    cliente_id               BIGINT        NOT NULL REFERENCES cliente(id) ON DELETE CASCADE,  -- composición
    nombre                   VARCHAR(200)  NOT NULL,
    email                    VARCHAR(255)  NOT NULL,
    telefono                 VARCHAR(30)   NOT NULL,
    idioma                   VARCHAR(10)   NOT NULL,
    canal_preferido          VARCHAR(10)   NOT NULL CHECK (canal_preferido IN ('EMAIL', 'WHATSAPP')),
    es_contacto_facturacion  BOOLEAN       NOT NULL DEFAULT FALSE,
    anonimizado              BOOLEAN       NOT NULL DEFAULT FALSE,  -- CU-09: se sobrescriben los datos, la fila se conserva
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);
-- Como mucho un contacto de facturación por cliente. El «al menos uno» (RB-27)
-- lo garantiza ServicioClientes: no se expresa con una restricción de fila.
CREATE UNIQUE INDEX uq_contacto_facturacion ON contacto (cliente_id) WHERE es_contacto_facturacion;

CREATE TABLE consentimiento_canal (
    id           BIGSERIAL    PRIMARY KEY,
    contacto_id  BIGINT       NOT NULL REFERENCES contacto(id) ON DELETE CASCADE,  -- composición
    canal        VARCHAR(10)  NOT NULL CHECK (canal IN ('EMAIL', 'WHATSAPP')),
    otorgado     BOOLEAN      NOT NULL,
    fecha        TIMESTAMP    NOT NULL,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT uq_consentimiento UNIQUE (contacto_id, canal)
);

CREATE TABLE etiqueta (
    id      BIGSERIAL     PRIMARY KEY,
    nombre  VARCHAR(100)  NOT NULL UNIQUE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- Cliente * — * Etiqueta (CU-08, opcional).
CREATE TABLE cliente_etiqueta (
    cliente_id   BIGINT  NOT NULL REFERENCES cliente(id) ON DELETE CASCADE,
    etiqueta_id  BIGINT  NOT NULL REFERENCES etiqueta(id) ON DELETE CASCADE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    PRIMARY KEY (cliente_id, etiqueta_id)
);

CREATE TABLE categoria_factura (
    id      BIGSERIAL     PRIMARY KEY,
    nombre  VARCHAR(100)  NOT NULL UNIQUE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- ÁREA 9 — Asignación de clientes (apunta a cliente).
-- Un solo responsable vigente por cliente: las asignaciones no se solapan.
CREATE TABLE asignacion_cliente (
    id          BIGSERIAL  PRIMARY KEY,
    usuario_id  BIGINT     NOT NULL REFERENCES usuario(id),
    cliente_id  BIGINT     NOT NULL REFERENCES cliente(id),
    desde       DATE       NOT NULL,
    hasta       DATE,      -- nulo = vigente
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_asignacion_fechas CHECK (hasta IS NULL OR hasta > desde),
    CONSTRAINT ex_asignacion_solape EXCLUDE USING gist (
        cliente_id WITH =,
        daterange(desde, hasta, '[)') WITH &&
    )
);

-- =====================================================================
-- ÁREA 2 — RELACIÓN COMERCIAL, TARIFAS Y REVISIÓN ANUAL
-- =====================================================================

CREATE TABLE rango_tarifa (
    id                 BIGSERIAL      PRIMARY KEY,
    facturacion_desde  DECIMAL(14,2)  NOT NULL CHECK (facturacion_desde >= 0),
    facturacion_hasta  DECIMAL(14,2),            -- nulo = último rango, sin tope
    precio_mensual     DECIMAL(12,2)  NOT NULL CHECK (precio_mensual >= 0),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_rango_limites CHECK (facturacion_hasta IS NULL OR facturacion_hasta > facturacion_desde),
    -- Sin solapes (CU-14 FE-1). Los huecos los comprueba ServicioRelacionComercial.configurarRangos().
    CONSTRAINT ex_rango_solape EXCLUDE USING gist (numrange(facturacion_desde, facturacion_hasta, '[)') WITH &&)
);

CREATE TABLE relacion_comercial (
    id                BIGSERIAL     PRIMARY KEY,
    cliente_id        BIGINT        NOT NULL REFERENCES cliente(id),
    rango_tarifa_id   BIGINT        NOT NULL REFERENCES rango_tarifa(id),  -- rango contratado
    fecha_inicio      DATE          NOT NULL,
    condiciones_pago  VARCHAR(500)  NOT NULL,
    fecha_baja        DATE,         -- futura = BAJA_SOLICITADA; pasada = BAJA_EFECTIVA
    motivo_baja       VARCHAR(500),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_relacion_baja CHECK ((fecha_baja IS NULL) = (motivo_baja IS NULL)),
    CONSTRAINT ck_relacion_fechas CHECK (fecha_baja IS NULL OR fecha_baja >= fecha_inicio),
    -- {a lo sumo una relación activa por cliente} (RB-12, A-25): las relaciones de un
    -- cliente no se solapan en [fecha_inicio, fecha_baja). Una nueva empieza el día
    -- de la baja de la anterior o después; dos sin baja se solapan siempre.
    CONSTRAINT ex_relacion_solape EXCLUDE USING gist (
        cliente_id WITH =,
        daterange(fecha_inicio, fecha_baja, '[)') WITH &&
    )
);
-- A lo sumo una relación sin baja por cliente (lo cubre también el EXCLUDE;
-- el índice lo deja explícito y es más barato de comprobar).
CREATE UNIQUE INDEX uq_relacion_sin_baja ON relacion_comercial (cliente_id) WHERE fecha_baja IS NULL;

CREATE TABLE pausa (
    id                           BIGSERIAL     PRIMARY KEY,
    relacion_comercial_id        BIGINT        NOT NULL REFERENCES relacion_comercial(id) ON DELETE CASCADE,  -- composición
    motivo                       VARCHAR(500)  NOT NULL,
    fecha_inicio                 DATE          NOT NULL,
    fecha_prevista_reactivacion  DATE          NOT NULL,
    fecha_reactivacion           DATE,         -- nulo = en curso, aunque haya pasado la prevista (RB-29)
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_pausa_prevista CHECK (fecha_prevista_reactivacion >= fecha_inicio),
    CONSTRAINT ck_pausa_reactivacion CHECK (fecha_reactivacion IS NULL OR fecha_reactivacion > fecha_inicio),
    -- Sin solapes entre pausas de la misma relación, en curso o pasadas (CU-11).
    -- Intervalo [fecha_inicio, fecha_reactivacion), igual que periodo_pausa (área 3).
    CONSTRAINT ex_pausa_relacion_solape EXCLUDE USING gist (
        relacion_comercial_id WITH =,
        daterange(fecha_inicio, fecha_reactivacion, '[)') WITH &&
    )
);
-- Como mucho una pausa en curso por relación (CU-11); también lo cubre el EXCLUDE.
CREATE UNIQUE INDEX uq_pausa_en_curso ON pausa (relacion_comercial_id) WHERE fecha_reactivacion IS NULL;

CREATE TABLE revision_anual_plan (
    id                      BIGSERIAL      PRIMARY KEY,
    relacion_comercial_id   BIGINT         NOT NULL REFERENCES relacion_comercial(id),
    anio                    INTEGER        NOT NULL,
    facturacion_anual       DECIMAL(14,2)  CHECK (facturacion_anual >= 0),  -- nulo = dato no disponible (FA-2)
    fuente_facturacion      VARCHAR(200),
    fecha_dato_facturacion  DATE,
    rango_anterior_id       BIGINT         NOT NULL REFERENCES rango_tarifa(id),
    rango_propuesto_id      BIGINT         REFERENCES rango_tarifa(id),
    fecha_efecto            DATE,
    estado                  VARCHAR(15)    NOT NULL DEFAULT 'PENDIENTE'
                                           CHECK (estado IN ('PENDIENTE', 'APLICADA', 'PLAN_MANTENIDO')),
    fecha_resolucion        TIMESTAMP,
    corregido_por_id        BIGINT         REFERENCES usuario(id),
    aprobado_por_id         BIGINT         REFERENCES usuario(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT uq_revision_anio UNIQUE (relacion_comercial_id, anio),   -- una por relación y año
    -- Sin facturación no hay rango propuesto; con ella, fuente y fecha del dato.
    CONSTRAINT ck_revision_dato CHECK (
        (facturacion_anual IS NULL AND rango_propuesto_id IS NULL AND fuente_facturacion IS NULL AND fecha_dato_facturacion IS NULL)
        OR (facturacion_anual IS NOT NULL AND rango_propuesto_id IS NOT NULL AND fuente_facturacion IS NOT NULL AND fecha_dato_facturacion IS NOT NULL)),
    -- Pendiente ⇔ sin resolver; aplicada ⇒ fecha de efecto.
    CONSTRAINT ck_revision_resolucion CHECK ((estado = 'PENDIENTE') = (fecha_resolucion IS NULL AND aprobado_por_id IS NULL)),
    CONSTRAINT ck_revision_aplicada CHECK (estado <> 'APLICADA' OR (fecha_efecto IS NOT NULL AND rango_propuesto_id IS NOT NULL)),
    CONSTRAINT ck_revision_cuatro_ojos CHECK (aprobado_por_id IS DISTINCT FROM corregido_por_id OR aprobado_por_id IS NULL)  -- FR-74
);

-- =====================================================================
-- ÁREA 4 — PERIODOS CONTABLES (solicitud_excepcion va tras el área 3)
-- =====================================================================

CREATE TABLE periodo_contable (
    id      BIGSERIAL    PRIMARY KEY,
    tipo    VARCHAR(10)  NOT NULL CHECK (tipo IN ('MES', 'TRIMESTRE')),
    inicio  DATE         NOT NULL,
    fin     DATE         NOT NULL,
    estado  VARCHAR(10)  NOT NULL DEFAULT 'ABIERTO' CHECK (estado IN ('ABIERTO', 'CERRADO')),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_periodo_fechas CHECK (fin >= inicio),
    -- Dos periodos del mismo tipo no se solapan.
    CONSTRAINT ex_periodo_solape EXCLUDE USING gist (tipo WITH =, daterange(inicio, fin, '[]') WITH &&)
);

CREATE TABLE reapertura_periodo (
    id                   BIGSERIAL     PRIMARY KEY,
    periodo_contable_id  BIGINT        NOT NULL REFERENCES periodo_contable(id),
    usuario_id           BIGINT        NOT NULL REFERENCES usuario(id),   -- Superadministrador (CU-26)
    motivo               VARCHAR(500)  NOT NULL,
    fecha                TIMESTAMP     NOT NULL,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC')
);


-- =====================================================================
-- ÁREA 3 — EMISIÓN DE FACTURAS
-- =====================================================================

CREATE TABLE impuesto (
    id              BIGSERIAL     PRIMARY KEY,
    nombre          VARCHAR(100)  NOT NULL,
    porcentaje      DECIMAL(5,2)  NOT NULL CHECK (porcentaje >= 0),
    pais            CHAR(2)       NOT NULL,
    creado_por      BIGINT        REFERENCES usuario(id),
    creado_en       TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por  BIGINT        REFERENCES usuario(id),
    modificado_en   TIMESTAMP
);

CREATE TABLE concepto_catalogo (
    id                  BIGSERIAL     PRIMARY KEY,
    descripcion         VARCHAR(255)  NOT NULL,
    precio_por_defecto  DECIMAL(12,2) NOT NULL CHECK (precio_por_defecto >= 0),
    impuesto_id         BIGINT        NOT NULL REFERENCES impuesto(id),   -- impuesto por defecto
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

CREATE TABLE entidad_emisora (
    id              BIGSERIAL     PRIMARY KEY,
    razon_social    VARCHAR(255)  NOT NULL,
    datos_fiscales  TEXT          NOT NULL,
    creado_por      BIGINT        REFERENCES usuario(id),
    creado_en       TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por  BIGINT        REFERENCES usuario(id),
    modificado_en   TIMESTAMP
);

CREATE TABLE serie_facturacion (
    id                  BIGSERIAL    PRIMARY KEY,
    entidad_emisora_id  BIGINT       NOT NULL REFERENCES entidad_emisora(id),
    prefijo             VARCHAR(20)  NOT NULL,
    tipo                VARCHAR(20)  NOT NULL CHECK (tipo IN ('ORDINARIA', 'RECTIFICATIVA')),
    siguiente_numero    INTEGER      NOT NULL DEFAULT 1 CHECK (siguiente_numero >= 1),
    creado_por          BIGINT       REFERENCES usuario(id),
    creado_en           TIMESTAMP    NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT       REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    -- Propuesta: un prefijo no se repite dentro de la misma entidad emisora.
    CONSTRAINT uq_serie_prefijo UNIQUE (entidad_emisora_id, prefijo)
);

CREATE TABLE configuracion_recurrente (
    id                       BIGSERIAL     PRIMARY KEY,
    relacion_comercial_id    BIGINT        NOT NULL UNIQUE REFERENCES relacion_comercial(id),  -- 1 — 0..1
    excepcion_sin_prorrateo  BOOLEAN       NOT NULL DEFAULT FALSE,
    fecha_activacion         DATE          NOT NULL,  -- fecha de inicio de la relación (área 2)
    fecha_fin                DATE,         -- la fija el área 2 al dar de baja (CU-12); no se generan cuotas desde ese día
    creado_por               BIGINT        REFERENCES usuario(id),
    creado_en                TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por           BIGINT        REFERENCES usuario(id),
    modificado_en            TIMESTAMP,
    CONSTRAINT ck_conf_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_activacion)
);

-- Importe por tramos (RB-36): cada cambio de importe añade un tramo y no
-- borra los anteriores, así una cuota recuperada tarde (FR-100) sale con el
-- importe de su periodo. Importe vigente = tramo con el mayor «desde» ≤ fecha.
-- 1..*: el servicio crea la configuración y su primer tramo en la misma transacción.
CREATE TABLE tramo_importe (
    id                           BIGSERIAL     PRIMARY KEY,
    configuracion_recurrente_id  BIGINT        NOT NULL REFERENCES configuracion_recurrente(id) ON DELETE CASCADE,  -- composición
    desde                        DATE          NOT NULL,
    importe                      DECIMAL(12,2) NOT NULL CHECK (importe >= 0),  -- lo fija el área 2
    creado_por                   BIGINT        REFERENCES usuario(id),
    creado_en                    TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    CONSTRAINT uq_tramo_desde UNIQUE (configuracion_recurrente_id, desde)
);

-- Pausas de la facturación recurrente (CU-11, RB-05). Se conservan las pasadas:
-- la recuperación (FR-100) no factura los meses que estuvieron en pausa.
-- Intervalo [desde, hasta): hasta = fecha de reanudación; nulo = pausa en curso.
CREATE TABLE periodo_pausa (
    id                           BIGSERIAL     PRIMARY KEY,
    configuracion_recurrente_id  BIGINT        NOT NULL REFERENCES configuracion_recurrente(id) ON DELETE CASCADE,  -- composición
    desde                        DATE          NOT NULL,
    hasta                        DATE,
    creado_por                   BIGINT        REFERENCES usuario(id),
    creado_en                    TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por               BIGINT        REFERENCES usuario(id),
    modificado_en                TIMESTAMP,
    CONSTRAINT ck_pausa_fechas CHECK (hasta IS NULL OR hasta > desde),
    -- Sin solapes entre pausas de la misma configuración (y como mucho una en curso).
    CONSTRAINT ex_pausa_solape EXCLUDE USING gist (
        configuracion_recurrente_id WITH =,
        daterange(desde, hasta, '[)') WITH &&
    )
);

-- Factura y sus subclases en una sola tabla con discriminador «tipo».
CREATE TABLE factura (
    id                           BIGSERIAL     PRIMARY KEY,
    tipo                         VARCHAR(20)   NOT NULL CHECK (tipo IN ('PUNTUAL', 'RECURRENTE', 'RECTIFICATIVA')),

    -- Comunes (Factura)
    numero_factura               VARCHAR(30),
    estado_documental            VARCHAR(25)   NOT NULL DEFAULT 'BORRADOR'
        CHECK (estado_documental IN ('BORRADOR', 'PENDIENTE_APROBACION', 'EMITIDA', 'RECTIFICADA')),
    -- VENCIDA = vencimiento pasado SIN ningún cobro: la pone cada día una tarea programada
    -- (ServicioCobros.actualizarVencimientos(), usuario nulo en el historial).
    -- No es lo mismo que ServicioCobros.estaVencida() = vencimiento pasado y saldo > 0,
    -- que incluye también las PARCIALMENTE_CONCILIADA (recordatorios y alertas).
    estado_cobro                 VARCHAR(25)
        CHECK (estado_cobro IN ('PENDIENTE', 'VENCIDA', 'PARCIALMENTE_CONCILIADA', 'PAGADA', 'ANULADA', 'INCOBRABLE')),
    estado_envio                 VARCHAR(15)
        CHECK (estado_envio IN ('SIN_ENVIAR', 'ENVIADA', 'FALLO_ENVIO')),
    en_disputa                   BOOLEAN       NOT NULL DEFAULT FALSE,
    motivo_disputa               VARCHAR(500),   -- CU-31
    fecha_revision_disputa       DATE,           -- CU-31: fecha en que se revisa la disconformidad
    cobro_excesivo               BOOLEAN       NOT NULL DEFAULT FALSE,
    modificacion_manual          BOOLEAN       NOT NULL DEFAULT FALSE,
    moneda                       CHAR(3)       NOT NULL,
    base_imponible               DECIMAL(12,2) NOT NULL DEFAULT 0,  -- derivado guardado (RB-07, RB-11)
    impuestos                    DECIMAL(12,2) NOT NULL DEFAULT 0,  -- derivado guardado
    total                        DECIMAL(12,2) NOT NULL DEFAULT 0,  -- derivado guardado
    fecha_emision                DATE,
    fecha_emision_programada     DATE,
    fecha_vencimiento            DATE          NOT NULL,
    ruta_pdf                     VARCHAR(500),
    hash_pdf                     VARCHAR(128),
    migrada                      BOOLEAN       NOT NULL DEFAULT FALSE,

    -- Propias de FacturaRecurrente
    periodo_inicio               DATE,
    periodo_fin                  DATE,
    prorrateada                  BOOLEAN,

    -- Propia de FacturaRectificativa
    motivo                       VARCHAR(500),

    -- Asociaciones
    cliente_id                   BIGINT NOT NULL REFERENCES cliente(id),
    entidad_emisora_id           BIGINT NOT NULL REFERENCES entidad_emisora(id),
    serie_facturacion_id         BIGINT REFERENCES serie_facturacion(id),   -- 0..1 en borrador; 1 emitida
    periodo_contable_id          BIGINT REFERENCES periodo_contable(id),    -- 0..1 en borrador; 1 emitida
    configuracion_recurrente_id  BIGINT REFERENCES configuracion_recurrente(id),
    factura_rectificada_id       BIGINT REFERENCES factura(id),

    -- Trazabilidad (NFR-03)
    creado_por                   BIGINT REFERENCES usuario(id),
    creado_en                    TIMESTAMP NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por               BIGINT REFERENCES usuario(id),
    modificado_en                TIMESTAMP,

    -- Unicidad
    CONSTRAINT uq_factura_numero   UNIQUE (serie_facturacion_id, numero_factura),           -- RB-01
    CONSTRAINT uq_factura_mes      UNIQUE (configuracion_recurrente_id, periodo_inicio),    -- FR-100

    -- Subclase RECURRENTE: sus columnas, y solo ella
    CONSTRAINT ck_factura_recurrente CHECK (
        (tipo = 'RECURRENTE'
            AND configuracion_recurrente_id IS NOT NULL AND periodo_inicio IS NOT NULL
            AND periodo_fin IS NOT NULL AND prorrateada IS NOT NULL
            AND periodo_fin >= periodo_inicio)
     OR (tipo <> 'RECURRENTE'
            AND configuracion_recurrente_id IS NULL AND periodo_inicio IS NULL
            AND periodo_fin IS NULL AND prorrateada IS NULL)),

    -- Subclase RECTIFICATIVA: sus columnas, y solo ella
    CONSTRAINT ck_factura_rectificativa CHECK (
        (tipo = 'RECTIFICATIVA' AND motivo IS NOT NULL AND factura_rectificada_id IS NOT NULL)
     OR (tipo <> 'RECTIFICATIVA' AND motivo IS NULL AND factura_rectificada_id IS NULL)),
    CONSTRAINT ck_factura_no_se_rectifica_a_si_misma CHECK (factura_rectificada_id <> id),

    -- Antes de emitirse no hay estado de cobro ni de envío (A-23).
    -- Tampoco hay estado de cobro en un abono: rectificativa con total negativo (A-27).
    CONSTRAINT ck_factura_estados_no_emitida CHECK (
        estado_documental IN ('EMITIDA', 'RECTIFICADA')
        OR (estado_cobro IS NULL AND estado_envio IS NULL)),
    CONSTRAINT ck_factura_estado_cobro CHECK (
        CASE
          WHEN estado_documental NOT IN ('EMITIDA', 'RECTIFICADA') THEN estado_cobro IS NULL
          WHEN tipo = 'RECTIFICATIVA' AND total < 0               THEN estado_cobro IS NULL
          ELSE estado_cobro IS NOT NULL
        END),

    -- Una vez emitida: número, serie, periodo y fecha de emisión obligatorios.
    CONSTRAINT ck_factura_emitida CHECK (
        estado_documental NOT IN ('EMITIDA', 'RECTIFICADA')
        OR (numero_factura IS NOT NULL AND serie_facturacion_id IS NOT NULL
            AND periodo_contable_id IS NOT NULL AND fecha_emision IS NOT NULL
            AND estado_envio IS NOT NULL)),

    -- El total cuadra con la base y los impuestos.
    CONSTRAINT ck_factura_disputa CHECK (en_disputa = (motivo_disputa IS NOT NULL AND fecha_revision_disputa IS NOT NULL)),
    CONSTRAINT ck_factura_total CHECK (total = base_imponible + impuestos)
);

-- Solo se puede borrar un borrador (RB-03, RB-11, CU-16).
-- Va sobre la tabla padre: las líneas y el historial caen por la cascada.
CREATE FUNCTION fn_factura_solo_borra_borradores() RETURNS trigger AS $$
BEGIN
    IF OLD.estado_documental <> 'BORRADOR' THEN
        RAISE EXCEPTION 'No se puede borrar la factura %: solo se borran borradores (RB-11)', OLD.id;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_factura_solo_borra_borradores
    BEFORE DELETE ON factura
    FOR EACH ROW EXECUTE FUNCTION fn_factura_solo_borra_borradores();

CREATE TABLE linea_factura (
    id                    BIGSERIAL     PRIMARY KEY,
    factura_id            BIGINT        NOT NULL REFERENCES factura(id) ON DELETE CASCADE,  -- composición
    concepto_catalogo_id  BIGINT        REFERENCES concepto_catalogo(id),
    impuesto_id           BIGINT        NOT NULL REFERENCES impuesto(id),
    concepto              VARCHAR(255)  NOT NULL,
    cantidad              DECIMAL(12,3) NOT NULL CHECK (cantidad > 0),
    precio_unitario       DECIMAL(12,2) NOT NULL,
    descuento             DECIMAL(5,2)  NOT NULL DEFAULT 0 CHECK (descuento BETWEEN 0 AND 100),  -- porcentaje
    porcentaje_impuesto   DECIMAL(5,2)  NOT NULL CHECK (porcentaje_impuesto >= 0),  -- copia del impuesto (RB-06)
    creado_por            BIGINT        REFERENCES usuario(id),
    creado_en             TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por        BIGINT        REFERENCES usuario(id),
    modificado_en         TIMESTAMP
    -- importe no se guarda: se deriva (cantidad × precio × (1 − descuento/100)).
);

CREATE TABLE historial_estado_factura (
    id                BIGSERIAL     PRIMARY KEY,
    factura_id        BIGINT        NOT NULL REFERENCES factura(id) ON DELETE CASCADE,  -- composición
    tipo_estado       VARCHAR(15)   NOT NULL CHECK (tipo_estado IN ('DOCUMENTAL', 'COBRO', 'ENVIO')),
    estado_anterior   VARCHAR(25),
    estado_nuevo      VARCHAR(25)   NOT NULL,
    fecha             TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    motivo            VARCHAR(500),
    realizado_por_id  BIGINT        REFERENCES usuario(id)   -- nulo = Sistema
    -- Es en sí un registro de auditoría: no lleva columnas creado_/modificado_.
);

-- ---------------------------------------------------------------------
-- Reglas del área 3 que garantiza la propia base de datos
-- (además del CHECK, los UNIQUE y el trigger de borrado de arriba)
-- ---------------------------------------------------------------------

-- 1) La serie debe pertenecer a la entidad emisora de la factura.
--    Clave compuesta: si la serie es nula (borrador) la FK no se comprueba.
ALTER TABLE serie_facturacion
    ADD CONSTRAINT uq_serie_id_entidad UNIQUE (id, entidad_emisora_id);
ALTER TABLE factura
    ADD CONSTRAINT fk_factura_serie_misma_entidad
    FOREIGN KEY (serie_facturacion_id, entidad_emisora_id)
    REFERENCES serie_facturacion (id, entidad_emisora_id);

-- 2) Inalterabilidad de la factura emitida (RB-07, RB-11).
--    En una factura EMITIDA o RECTIFICADA solo pueden cambiar:
--    estado_cobro, estado_envio, en_disputa (con su motivo y fecha), cobro_excesivo,
--    modificado_por, modificado_en y el paso EMITIDA -> RECTIFICADA.
--    Cualquier otra columna, presente o futura, queda bloqueada.
CREATE FUNCTION fn_factura_emitida_inalterable() RETURNS trigger AS $$
DECLARE
    permitido factura%ROWTYPE;
BEGIN
    IF OLD.estado_documental NOT IN ('EMITIDA', 'RECTIFICADA') THEN
        RETURN NEW;
    END IF;

    -- Transiciones válidas: EMITIDA -> EMITIDA | RECTIFICADA; RECTIFICADA -> RECTIFICADA.
    IF NOT (NEW.estado_documental = OLD.estado_documental
            OR (OLD.estado_documental = 'EMITIDA' AND NEW.estado_documental = 'RECTIFICADA')) THEN
        RAISE EXCEPTION 'Transición no permitida en la factura %: % -> %',
            OLD.id, OLD.estado_documental, NEW.estado_documental;
    END IF;

    -- Copia de NEW con las columnas permitidas devueltas a su valor anterior:
    -- si aún difiere de OLD, se ha tocado algo que no se puede tocar.
    permitido := NEW;
    permitido.estado_documental := OLD.estado_documental;
    permitido.estado_cobro      := OLD.estado_cobro;
    permitido.estado_envio      := OLD.estado_envio;
    permitido.en_disputa        := OLD.en_disputa;
    permitido.motivo_disputa    := OLD.motivo_disputa;
    permitido.fecha_revision_disputa := OLD.fecha_revision_disputa;
    permitido.cobro_excesivo    := OLD.cobro_excesivo;
    permitido.modificado_por    := OLD.modificado_por;
    permitido.modificado_en     := OLD.modificado_en;
    IF ROW(permitido.*) IS DISTINCT FROM ROW(OLD.*) THEN
        RAISE EXCEPTION 'La factura % está emitida y no se puede modificar (RB-07, RB-11)', OLD.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_factura_emitida_inalterable
    BEFORE UPDATE ON factura
    FOR EACH ROW EXECUTE FUNCTION fn_factura_emitida_inalterable();

-- 3) Las líneas solo se tocan mientras la factura es un BORRADOR.
--    También quedan bloqueadas en PENDIENTE_APROBACION: lo que se aprueba
--    tiene que ser exactamente lo que vio el aprobador (CU-22, CU-23).
CREATE FUNCTION fn_linea_solo_en_borrador() RETURNS trigger AS $$
DECLARE
    v_factura BIGINT := COALESCE(NEW.factura_id, OLD.factura_id);
    v_estado  VARCHAR(25);
BEGIN
    SELECT estado_documental INTO v_estado FROM factura WHERE id = v_factura;
    -- Si la factura ya no existe es un borrado en cascada de un borrador: se deja pasar.
    IF v_estado IS NOT NULL AND v_estado <> 'BORRADOR' THEN
        RAISE EXCEPTION 'Las líneas de la factura % no se modifican: no es un borrador (RB-11)', v_factura;
    END IF;
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_linea_solo_en_borrador
    BEFORE INSERT OR UPDATE OR DELETE ON linea_factura
    FOR EACH ROW EXECUTE FUNCTION fn_linea_solo_en_borrador();

-- =====================================================================
-- ÁREA 4 — SOLICITUDES DE EXCEPCIÓN (apunta a factura)
-- =====================================================================

CREATE TABLE solicitud_excepcion (
    id                    BIGSERIAL      PRIMARY KEY,
    tipo                  VARCHAR(25)    NOT NULL CHECK (tipo IN ('DESCUENTO', 'CAMBIO_IMPORTE', 'CAMBIO_FECHA',
                                                    'FACTURA_SOBRE_UMBRAL', 'EXCEPCION_PRORRATEO', 'BAJA_CONTABLE')),
    importe               DECIMAL(12,2)  NOT NULL,
    motivo                VARCHAR(1000),  -- nulo solo en FACTURA_SOBRE_UMBRAL, que crea el área 3 (CU-15 FA-3)
    estado                VARCHAR(10)    NOT NULL DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'APROBADA', 'RECHAZADA')),
    comentario_aprobador  VARCHAR(1000),
    fecha                 TIMESTAMP      NOT NULL,
    fecha_resolucion      TIMESTAMP,      -- CU-23 paso 4
    factura_id            BIGINT         REFERENCES factura(id) ON DELETE CASCADE,  -- se borra con su borrador
    configuracion_recurrente_id BIGINT   REFERENCES configuracion_recurrente(id),  -- excepción de prorrateo (CU-22)
    solicitante_id        BIGINT         NOT NULL REFERENCES usuario(id),
    aprobador_id          BIGINT         REFERENCES usuario(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_solicitud_resuelta CHECK ((estado = 'PENDIENTE') = (aprobador_id IS NULL)
                                       AND (estado = 'PENDIENTE') = (fecha_resolucion IS NULL)),
    CONSTRAINT ck_solicitud_motivo CHECK (tipo = 'FACTURA_SOBRE_UMBRAL' OR motivo IS NOT NULL),  -- CU-22 paso 2
    -- Sobre una factura o sobre una configuración recurrente; la de prorrateo, sobre la configuración.
    CONSTRAINT ck_solicitud_objeto CHECK (num_nonnulls(factura_id, configuracion_recurrente_id) = 1),
    CONSTRAINT ck_solicitud_prorrateo CHECK ((tipo = 'EXCEPCION_PRORRATEO') = (configuracion_recurrente_id IS NOT NULL)),
    CONSTRAINT ck_solicitud_comentario CHECK (estado <> 'RECHAZADA' OR comentario_aprobador IS NOT NULL),  -- CU-23
    CONSTRAINT ck_solicitud_cuatro_ojos CHECK (aprobador_id IS NULL OR aprobador_id <> solicitante_id)    -- FR-74
);

-- =====================================================================
-- ÁREA 1 — DOCUMENTOS Y CATEGORÍAS DE FACTURA (apuntan a factura)
-- =====================================================================

CREATE TABLE documento (
    id          BIGSERIAL     PRIMARY KEY,
    cliente_id  BIGINT        REFERENCES cliente(id),
    factura_id  BIGINT        REFERENCES factura(id) ON DELETE CASCADE,  -- se borra con su borrador
    nombre      VARCHAR(255)  NOT NULL,
    formato     VARCHAR(20)   NOT NULL,
    tamano      BIGINT        NOT NULL CHECK (tamano >= 0),
    ruta        VARCHAR(500)  NOT NULL,     -- el fichero lo guarda GestorDocumentos
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_documento_destino CHECK (num_nonnulls(cliente_id, factura_id) = 1)   -- CU-04
);

-- CategoriaFactura 0..1 — * Factura (CU-08, opcional). Tabla del área 1 para que
-- la tabla factura (área 3) no dependa del área 1.
CREATE TABLE factura_categoria (
    factura_id            BIGINT  PRIMARY KEY REFERENCES factura(id) ON DELETE CASCADE,
    categoria_factura_id  BIGINT  NOT NULL REFERENCES categoria_factura(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- =====================================================================
-- ÁREA 5 — ENVÍO Y COMUNICACIONES
-- =====================================================================

CREATE TABLE plantilla_comunicacion (
    id      BIGSERIAL     PRIMARY KEY,
    tipo    VARCHAR(15)   NOT NULL CHECK (tipo IN ('FACTURA', 'RECORDATORIO')),
    idioma  VARCHAR(10)   NOT NULL,       -- el del contacto (CU-29 paso 3)
    asunto  VARCHAR(200)  NOT NULL,
    cuerpo  TEXT          NOT NULL,
    activa  BOOLEAN       NOT NULL DEFAULT TRUE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- Una plantilla activa por tipo e idioma.
CREATE UNIQUE INDEX uq_plantilla_activa ON plantilla_comunicacion (tipo, idioma) WHERE activa;

-- variablesObligatorias (multivaluado) normalizado.
CREATE TABLE variable_plantilla (
    id                         BIGSERIAL    PRIMARY KEY,
    plantilla_comunicacion_id  BIGINT       NOT NULL REFERENCES plantilla_comunicacion(id) ON DELETE CASCADE,
    nombre                     VARCHAR(50)  NOT NULL,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    CONSTRAINT uq_variable_plantilla UNIQUE (plantilla_comunicacion_id, nombre)
);

CREATE TABLE regla_recordatorio (
    id                         BIGSERIAL  PRIMARY KEY,
    plantilla_comunicacion_id  BIGINT     NOT NULL REFERENCES plantilla_comunicacion(id),
    cadencia                   INTEGER    NOT NULL CHECK (cadencia > 0),   -- días entre recordatorios
    dias_tras_vencimiento      INTEGER    NOT NULL,
    activa                     BOOLEAN    NOT NULL DEFAULT TRUE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

CREATE TABLE mensaje (
    id                         BIGSERIAL    PRIMARY KEY,
    factura_id                 BIGINT       NOT NULL REFERENCES factura(id),
    contacto_id                BIGINT       NOT NULL REFERENCES contacto(id),
    plantilla_comunicacion_id  BIGINT       NOT NULL REFERENCES plantilla_comunicacion(id),
    canal                      VARCHAR(10)  NOT NULL CHECK (canal IN ('EMAIL', 'WHATSAPP')),
    estado_entrega             VARCHAR(10)  NOT NULL DEFAULT 'PENDIENTE'
                                            CHECK (estado_entrega IN ('PENDIENTE', 'ENVIADO', 'ENTREGADO', 'FALLIDO')),
    intentos                   INTEGER      NOT NULL DEFAULT 0 CHECK (intentos >= 0),
    fecha_envio                TIMESTAMP,
    motivo_fallo               VARCHAR(500),   -- se muestra en la incidencia (CU-28 paso 2)
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_mensaje_enviado CHECK (estado_entrega NOT IN ('ENVIADO', 'ENTREGADO') OR fecha_envio IS NOT NULL),
    CONSTRAINT ck_mensaje_fallo CHECK (estado_entrega <> 'FALLIDO' OR motivo_fallo IS NOT NULL)
);

-- =====================================================================
-- ÁREA 6 — COBROS, CONCILIACIÓN Y SALDO
-- =====================================================================

CREATE TABLE movimiento_cobro (
    id                  BIGSERIAL     PRIMARY KEY,
    origen              VARCHAR(10)   NOT NULL CHECK (origen IN ('PASARELA', 'BANCO')),
    id_externo          VARCHAR(100)  NOT NULL,
    referencia          VARCHAR(100),
    importe             DECIMAL(12,2) NOT NULL CHECK (importe > 0),
    moneda              CHAR(3)       NOT NULL,
    fecha_movimiento    TIMESTAMP     NOT NULL,
    datos_confirmacion  TEXT,
    en_revision         BOOLEAN       NOT NULL DEFAULT FALSE,
    motivo_revision     VARCHAR(500),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    -- El mismo evento no se cuenta dos veces (CU-34 FE-1).
    CONSTRAINT uq_movimiento_externo UNIQUE (origen, id_externo),
    CONSTRAINT ck_movimiento_revision CHECK (NOT en_revision OR motivo_revision IS NOT NULL)
    -- No se guarda el estado: se deriva de los importes y de en_revision.
);

-- Tabla intermedia movimiento * — * factura, con atributos propios.
CREATE TABLE conciliacion (
    id                   BIGSERIAL     PRIMARY KEY,
    movimiento_cobro_id  BIGINT        NOT NULL REFERENCES movimiento_cobro(id),
    factura_id           BIGINT        NOT NULL REFERENCES factura(id),
    importe_aplicado     DECIMAL(12,2) NOT NULL CHECK (importe_aplicado > 0),
    fecha                TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    fecha_deshecho       TIMESTAMP,
    motivo_deshacer      VARCHAR(500),
    realizado_por_id     BIGINT        REFERENCES usuario(id),  -- nulo = conciliación automática
    deshecho_por_id      BIGINT        REFERENCES usuario(id),
    creado_por           BIGINT        REFERENCES usuario(id),
    creado_en            TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por       BIGINT        REFERENCES usuario(id),
    modificado_en        TIMESTAMP,
    -- Deshacer: los tres datos van juntos (deshecha se deriva de fecha_deshecho).
    CONSTRAINT ck_conciliacion_deshecho CHECK (
        (fecha_deshecho IS NULL AND motivo_deshacer IS NULL AND deshecho_por_id IS NULL)
     OR (fecha_deshecho IS NOT NULL AND motivo_deshacer IS NOT NULL AND deshecho_por_id IS NOT NULL))
);

-- Una sola conciliación vigente por movimiento + factura (FR-87).
-- Índice parcial: una pareja deshecha puede volver a conciliarse.
CREATE UNIQUE INDEX uq_conciliacion_vigente
    ON conciliacion (movimiento_cobro_id, factura_id)
    WHERE fecha_deshecho IS NULL;

CREATE TABLE baja_contable (
    id                      BIGSERIAL     PRIMARY KEY,
    factura_id              BIGINT        NOT NULL UNIQUE REFERENCES factura(id),              -- 1 — 0..1
    solicitud_excepcion_id  BIGINT        NOT NULL UNIQUE REFERENCES solicitud_excepcion(id),  -- aprobada mediante
    tipo                    VARCHAR(15)   NOT NULL CHECK (tipo IN ('ANULADA', 'INCOBRABLE')),  -- nunca «pagada» (RB-08)
    importe_dado_de_baja    DECIMAL(12,2) NOT NULL CHECK (importe_dado_de_baja > 0),
    motivo                  VARCHAR(500)  NOT NULL,
    fecha                   TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    creado_por              BIGINT        REFERENCES usuario(id),
    creado_en               TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por          BIGINT        REFERENCES usuario(id),
    modificado_en           TIMESTAMP
    -- {baja.factura = baja.solicitud.factura}: lo comprueba la aplicación
    -- (cruza dos tablas; no cabe en un CHECK).
);

-- =====================================================================
-- ÁREA 7 — NOTIFICACIONES Y COLABORACIÓN
-- =====================================================================

CREATE TABLE notificacion (
    id                  BIGSERIAL     PRIMARY KEY,
    tipo                VARCHAR(25)   NOT NULL CHECK (tipo IN ('ALERTA_DEUDA', 'ALERTA_INCIDENCIA_ENVIO',
                                          'REVISION_PENDIENTE', 'TAREA_ASIGNADA', 'FACTURA_VENCIDA', 'SOLICITUD_RESUELTA')),
    prioridad           VARCHAR(10)   NOT NULL CHECK (prioridad IN ('ALTA', 'MEDIA', 'BAJA')),
    estado              VARCHAR(10)   NOT NULL DEFAULT 'NUEVA' CHECK (estado IN ('NUEVA', 'LEIDA', 'RESUELTA')),
    titulo              VARCHAR(200)  NOT NULL,
    mensaje             TEXT          NOT NULL,
    fecha_creacion      TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    fecha_lectura       TIMESTAMP,
    fecha_resolucion    TIMESTAMP,
    usuario_destino_id  BIGINT        REFERENCES usuario(id),   -- nulo = notificación general
    cliente_id          BIGINT        REFERENCES cliente(id),
    factura_id          BIGINT        REFERENCES factura(id) ON DELETE SET NULL,  -- no impide borrar un borrador
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    -- Las fechas van con el estado: NUEVA sin ninguna, LEIDA con lectura, RESUELTA con resolución.
    CONSTRAINT ck_notificacion_fechas CHECK (
        (estado = 'NUEVA'    AND fecha_lectura IS NULL AND fecha_resolucion IS NULL) OR
        (estado = 'LEIDA'    AND fecha_lectura IS NOT NULL AND fecha_resolucion IS NULL) OR
        (estado = 'RESUELTA' AND fecha_resolucion IS NOT NULL)),
    -- Las alertas dicen siempre de qué cliente son (para abrirlas desde la pantalla de trabajo).
    CONSTRAINT ck_notificacion_alerta_cliente CHECK (
        tipo NOT IN ('ALERTA_DEUDA', 'ALERTA_INCIDENCIA_ENVIO', 'FACTURA_VENCIDA') OR cliente_id IS NOT NULL)
);
-- No repetir una alerta sin resolver del mismo tipo y elemento (los nulos cuentan como iguales).
CREATE UNIQUE INDEX uq_notificacion_alerta_abierta
    ON notificacion (tipo, usuario_destino_id, cliente_id, factura_id) NULLS NOT DISTINCT
    WHERE estado <> 'RESUELTA' AND tipo IN ('ALERTA_DEUDA', 'ALERTA_INCIDENCIA_ENVIO', 'FACTURA_VENCIDA');

CREATE TABLE preferencia_notificacion (
    id                     BIGSERIAL    PRIMARY KEY,
    usuario_id             BIGINT       NOT NULL REFERENCES usuario(id),
    canal                  VARCHAR(10)  NOT NULL CHECK (canal IN ('EMAIL', 'WHATSAPP')),
    in_app_activa          BOOLEAN      NOT NULL DEFAULT TRUE,
    email_activo           BOOLEAN      NOT NULL DEFAULT TRUE,
    resumen_diario_activo  BOOLEAN      NOT NULL DEFAULT FALSE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT uq_preferencia_canal UNIQUE (usuario_id, canal)
);

CREATE TABLE incidencia (
    id                   BIGSERIAL    PRIMARY KEY,
    tipo                 VARCHAR(15)  NOT NULL CHECK (tipo IN ('FACTURACION', 'COBRO', 'ENVIO', 'REVISION')),
    estado               VARCHAR(15)  NOT NULL DEFAULT 'ABIERTA' CHECK (estado IN ('ABIERTA', 'EN_PROCESO', 'RESUELTA', 'CANCELADA')),
    prioridad            VARCHAR(10)  NOT NULL CHECK (prioridad IN ('ALTA', 'MEDIA', 'BAJA')),
    descripcion          TEXT         NOT NULL,
    fecha_apertura       TIMESTAMP    NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    fecha_cierre         TIMESTAMP,
    pausa_recordatorios  BOOLEAN      NOT NULL DEFAULT FALSE,   -- RB-22
    cliente_id           BIGINT       NOT NULL REFERENCES cliente(id),
    factura_id           BIGINT       REFERENCES factura(id) ON DELETE SET NULL,
    responsable_id       BIGINT       REFERENCES usuario(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    -- Cerrada si y solo si tiene fecha de cierre, y nunca antes de la apertura.
    CONSTRAINT ck_incidencia_cierre CHECK ((estado IN ('RESUELTA', 'CANCELADA')) = (fecha_cierre IS NOT NULL)),
    CONSTRAINT ck_incidencia_fechas CHECK (fecha_cierre IS NULL OR fecha_cierre >= fecha_apertura)
);

CREATE TABLE comentario (
    id             BIGSERIAL  PRIMARY KEY,
    texto          TEXT       NOT NULL,
    restringido    BOOLEAN    NOT NULL DEFAULT FALSE,   -- RB-32
    fecha          TIMESTAMP  NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    autor_id       BIGINT     REFERENCES usuario(id),   -- nulo = Sistema
    cliente_id     BIGINT     REFERENCES cliente(id),
    factura_id     BIGINT     REFERENCES factura(id) ON DELETE CASCADE,  -- se borra con su borrador
    incidencia_id  BIGINT     REFERENCES incidencia(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_comentario_destino CHECK (num_nonnulls(cliente_id, factura_id, incidencia_id) = 1)
);

CREATE TABLE tarea (
    id                 BIGSERIAL     PRIMARY KEY,
    tipo               VARCHAR(25)   NOT NULL CHECK (tipo IN ('ACCION_MASIVA', 'REVISION_PLAN', 'REVISION_BAJA',
                                         'INCIDENCIA_COBRO', 'CONCILIACION_MANUAL')),
    estado             VARCHAR(15)   NOT NULL DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'EN_PROCESO', 'COMPLETADA', 'CANCELADA')),
    prioridad          VARCHAR(10)   NOT NULL CHECK (prioridad IN ('ALTA', 'MEDIA', 'BAJA')),
    descripcion        TEXT          NOT NULL,
    origen             VARCHAR(100)  NOT NULL,
    fecha_creacion     TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    fecha_vencimiento  DATE,
    fecha_completada   TIMESTAMP,
    cliente_id         BIGINT        REFERENCES cliente(id),   -- nulo = acción masiva sobre varios clientes (CU-07)
    responsable_id     BIGINT        REFERENCES usuario(id),   -- nulo = sin asignar
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_tarea_completada CHECK ((estado = 'COMPLETADA') = (fecha_completada IS NOT NULL))
);

-- =====================================================================
-- ÁREA 8 — INFORMES Y CONTABILIDAD
-- =====================================================================

CREATE TABLE objetivo_facturacion (
    id                          BIGSERIAL      PRIMARY KEY,
    tipo_periodo                VARCHAR(10)    NOT NULL CHECK (tipo_periodo IN ('MENSUAL', 'TRIMESTRAL', 'ANUAL')),
    anio                        INTEGER        NOT NULL,
    mes                         INTEGER,
    importe_objetivo_facturado  DECIMAL(12,2)  NOT NULL CHECK (importe_objetivo_facturado >= 0),
    importe_objetivo_cobrado    DECIMAL(12,2)  NOT NULL CHECK (importe_objetivo_cobrado >= 0),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    -- Un trimestre se identifica por su primer mes (1, 4, 7 o 10); un año no lleva mes.
    CONSTRAINT ck_objetivo_mes CHECK (
        (tipo_periodo = 'MENSUAL'    AND mes BETWEEN 1 AND 12) OR
        (tipo_periodo = 'TRIMESTRAL' AND mes IN (1, 4, 7, 10)) OR
        (tipo_periodo = 'ANUAL'      AND mes IS NULL)),
    -- Un solo objetivo por periodo; el histórico (FR-82) queda en la auditoría.
    CONSTRAINT uq_objetivo_periodo UNIQUE NULLS NOT DISTINCT (tipo_periodo, anio, mes)
);

-- Cada regeneración es una fila nueva con la versión siguiente. Sin CASCADE: se conserva (RB-19).
CREATE TABLE paquete_contable (
    id                   BIGSERIAL     PRIMARY KEY,
    version              INTEGER       NOT NULL CHECK (version >= 1),   -- regeneración = version > 1
    fecha_generacion     TIMESTAMP     NOT NULL,
    ruta_zip             VARCHAR(500)  NOT NULL,
    hash_fichero         CHAR(64)      NOT NULL,
    periodo_contable_id  BIGINT        NOT NULL REFERENCES periodo_contable(id),
    generado_por_id      BIGINT        NOT NULL REFERENCES usuario(id),   -- dato de negocio (FR-77)
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT uq_paquete_version UNIQUE (periodo_contable_id, version)
);

-- Sin FK: no toca el total legal de ninguna factura (FR-85).
CREATE TABLE tipo_cambio (
    id      BIGSERIAL      PRIMARY KEY,
    moneda  CHAR(3)        NOT NULL,
    fecha   DATE           NOT NULL,
    valor   DECIMAL(12,6)  NOT NULL CHECK (valor > 0),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT uq_tipo_cambio UNIQUE (moneda, fecha)
);

-- Al caducar se borra el fichero, no la fila: es el registro auditado (FR-79, FR-95).
CREATE TABLE exportacion_masiva (
    id                 BIGSERIAL     PRIMARY KEY,
    criterios          TEXT          NOT NULL,
    formato            VARCHAR(5)    NOT NULL CHECK (formato IN ('CSV', 'PDF')),
    fecha_exportacion  TIMESTAMP     NOT NULL,
    ruta_fichero       VARCHAR(500)  NOT NULL,
    fecha_caducidad    TIMESTAMP     NOT NULL,
    usuario_id         BIGINT        NOT NULL REFERENCES usuario(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_exportacion_caducidad CHECK (fecha_caducidad > fecha_exportacion)
);
-- Para la tarea de limpieza de ficheros caducados.
CREATE INDEX ix_exportacion_caducidad ON exportacion_masiva (fecha_caducidad);

CREATE TABLE informe_programado (
    id            BIGSERIAL    PRIMARY KEY,
    tipo_informe  VARCHAR(25)  NOT NULL CHECK (tipo_informe IN ('DASHBOARD_FINANCIERO', 'RESUMEN_VENTAS',
                                   'INCIDENCIAS_ENVIO', 'EFICIENCIA_OPERATIVA')),
    periodicidad  VARCHAR(10)  NOT NULL CHECK (periodicidad IN ('SEMANAL', 'MENSUAL', 'TRIMESTRAL')),
    activo        BOOLEAN      NOT NULL DEFAULT TRUE,
    creador_id    BIGINT       NOT NULL REFERENCES usuario(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- InformeProgramado * — 1..* Usuario. El mínimo de un destinatario y el permiso
-- (RB-33) los garantiza ServicioInformes.
CREATE TABLE destinatario_informe (
    id                     BIGSERIAL  PRIMARY KEY,
    informe_programado_id  BIGINT     NOT NULL REFERENCES informe_programado(id) ON DELETE CASCADE,
    usuario_id             BIGINT     NOT NULL REFERENCES usuario(id),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT uq_destinatario UNIQUE (informe_programado_id, usuario_id)
);

-- =====================================================================
-- ÁREA 11 — API EXTERNA (apunta a cliente y a tarea)
-- =====================================================================

CREATE TABLE consumidor_api (
    id                  BIGSERIAL     PRIMARY KEY,
    credencial_hash     VARCHAR(100)  NOT NULL UNIQUE,   -- nunca la credencial en claro
    limite_solicitudes  INTEGER       NOT NULL CHECK (limite_solicitudes > 0),
    periodo_limite      VARCHAR(10)   NOT NULL CHECK (periodo_limite IN ('MINUTO', 'HORA', 'DIA')),
    activo              BOOLEAN       NOT NULL DEFAULT TRUE,
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP
);

-- Una fila por invocación; es en sí un registro. consumidor nulo = credencial inválida.
CREATE TABLE llamada_api (
    id                 BIGSERIAL    PRIMARY KEY,
    consumidor_api_id  BIGINT       REFERENCES consumidor_api(id),
    fecha              TIMESTAMP    NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    operacion          VARCHAR(20)  NOT NULL CHECK (operacion IN ('CONSULTAR_DATOS', 'ENVIAR_SOLICITUD')),
    resultado          VARCHAR(20)  NOT NULL CHECK (resultado IN ('CORRECTA', 'NO_AUTORIZADA', 'LIMITE_EXCEDIDO', 'RECHAZADA', 'ERROR')),
    codigo_incidencia  VARCHAR(50),
    CONSTRAINT ck_llamada_consumidor CHECK (consumidor_api_id IS NOT NULL OR resultado = 'NO_AUTORIZADA'),
    CONSTRAINT ck_llamada_error CHECK (resultado <> 'ERROR' OR codigo_incidencia IS NOT NULL)
);
-- Para contar las llamadas del periodo al comprobar el límite.
CREATE INDEX ix_llamada_consumidor_fecha ON llamada_api (consumidor_api_id, fecha);

-- Nace VALIDADA (con su tarea) o RECHAZADA (con motivo) en la misma llamada (RB-31).
CREATE TABLE solicitud_externa (
    id                 BIGSERIAL     PRIMARY KEY,
    consumidor_api_id  BIGINT        NOT NULL REFERENCES consumidor_api(id),
    cliente_id         BIGINT        NOT NULL REFERENCES cliente(id),
    tarea_id           BIGINT        UNIQUE REFERENCES tarea(id),
    tipo               VARCHAR(10)   NOT NULL CHECK (tipo IN ('BAJA')),
    estado_validacion  VARCHAR(10)   NOT NULL CHECK (estado_validacion IN ('VALIDADA', 'RECHAZADA')),
    motivo_rechazo     VARCHAR(500),
    creado_por          BIGINT        REFERENCES usuario(id),
    creado_en           TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por      BIGINT        REFERENCES usuario(id),
    modificado_en       TIMESTAMP,
    CONSTRAINT ck_solicitud_externa_resultado CHECK (
        (estado_validacion = 'VALIDADA'  AND tarea_id IS NOT NULL AND motivo_rechazo IS NULL) OR
        (estado_validacion = 'RECHAZADA' AND tarea_id IS NULL AND motivo_rechazo IS NOT NULL))
);

-- =====================================================================
-- ÁREA 9 — DESCARGAS (apunta a documento, área 1, y exportacion_masiva, área 8)
-- =====================================================================

CREATE TABLE descarga_fichero (
    id                     BIGSERIAL  PRIMARY KEY,
    usuario_id             BIGINT     NOT NULL REFERENCES usuario(id),
    fecha                  TIMESTAMP  NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    documento_id           BIGINT     REFERENCES documento(id),
    exportacion_masiva_id  BIGINT     REFERENCES exportacion_masiva(id),
    CONSTRAINT ck_descarga_destino CHECK (num_nonnulls(documento_id, exportacion_masiva_id) = 1)  -- FR-79, FR-95
);

-- =====================================================================
-- Reglas que NO comprueba la base de datos (suman filas o cruzan tablas).
-- Las garantiza la aplicación (servicios de las áreas 3 y 6):
--   · emitir(): serie.tipo = RECTIFICATIVA si la factura lo es; ORDINARIA en otro caso.
--     (Que la serie sea de la misma entidad emisora ya lo garantiza la FK compuesta.)
--   · conciliacion: importe_aplicado ≤ saldo pendiente de la factura;
--     movimiento.moneda = factura.moneda (FR-84).
--   · conciliacion: la suma de las conciliaciones vigentes de un movimiento
--     no supera su importe (A-28; el excedente queda sin aplicar en el movimiento).
--   · baja_contable: misma factura que su solicitud_excepcion.
-- El saldo pendiente no es columna: lo calcula ServicioCobros (RB-10, A-27).
-- =====================================================================
