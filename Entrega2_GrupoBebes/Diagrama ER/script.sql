-- =====================================================================
-- E-R físico — Áreas 3 (Emisión de facturas) y 6 (Cobros, conciliación y saldo)
-- Turbine · Grupo Bebes · Entrega 2 · PostgreSQL 16
-- Sigue la sección 7 del catálogo (Catalogo_clases_referencia_E2_v2.17).
-- Estado: PROPUESTA. Las clases de las áreas 3 y 6 están en «Propuesta»,
-- no en «Aprobada»: este script se cierra cuando el grupo las apruebe.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Tablas de otras áreas (solo lo mínimo para las FK).
-- Las define cada área en su parte del E-R; aquí son marcadores.
-- ---------------------------------------------------------------------
CREATE TABLE usuario              (id BIGSERIAL PRIMARY KEY);   -- área 9
CREATE TABLE cliente              (id BIGSERIAL PRIMARY KEY);   -- área 1
CREATE TABLE relacion_comercial   (id BIGSERIAL PRIMARY KEY);   -- área 2
CREATE TABLE periodo_contable     (id BIGSERIAL PRIMARY KEY);   -- área 4
CREATE TABLE solicitud_excepcion  (id BIGSERIAL PRIMARY KEY);   -- área 4

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
    importe_mensual          DECIMAL(12,2) CHECK (importe_mensual >= 0),  -- nulo = precio del RangoTarifa
    excepcion_sin_prorrateo  BOOLEAN       NOT NULL DEFAULT FALSE,
    activa                   BOOLEAN       NOT NULL DEFAULT FALSE,
    fecha_activacion         DATE,
    creado_por               BIGINT        REFERENCES usuario(id),
    creado_en                TIMESTAMP     NOT NULL DEFAULT (now() AT TIME ZONE 'UTC'),
    modificado_por           BIGINT        REFERENCES usuario(id),
    modificado_en            TIMESTAMP,
    CONSTRAINT ck_conf_activa_fecha CHECK (NOT activa OR fecha_activacion IS NOT NULL)
);

-- Factura y sus subclases en una sola tabla con discriminador «tipo».
CREATE TABLE factura (
    id                           BIGSERIAL     PRIMARY KEY,
    tipo                         VARCHAR(20)   NOT NULL CHECK (tipo IN ('PUNTUAL', 'RECURRENTE', 'RECTIFICATIVA')),

    -- Comunes (Factura)
    numero_factura               VARCHAR(30),
    estado_documental            VARCHAR(25)   NOT NULL DEFAULT 'BORRADOR'
        CHECK (estado_documental IN ('BORRADOR', 'PENDIENTE_APROBACION', 'EMITIDA', 'RECTIFICADA')),
    estado_cobro                 VARCHAR(25)
        CHECK (estado_cobro IN ('PENDIENTE', 'VENCIDA', 'PARCIALMENTE_CONCILIADA', 'PAGADA', 'ANULADA', 'INCOBRABLE')),
    estado_envio                 VARCHAR(15)
        CHECK (estado_envio IN ('SIN_ENVIAR', 'ENVIADA', 'FALLO_ENVIO')),
    en_disputa                   BOOLEAN       NOT NULL DEFAULT FALSE,
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
-- Reglas que NO puede comprobar un CHECK (cruzan tablas o dependen de cálculos).
-- Las garantiza la aplicación (servicios de las áreas 3 y 6):
--   · emitir(): serie.entidad_emisora_id = factura.entidad_emisora_id, y
--     serie.tipo = RECTIFICATIVA si la factura lo es; ORDINARIA en otro caso.
--   · conciliacion: importe_aplicado ≤ saldo pendiente de la factura;
--     movimiento.moneda = factura.moneda (FR-84).
--   · baja_contable: misma factura que su solicitud_excepcion.
-- El saldo pendiente no es columna: lo calcula ServicioCobros (RB-10, A-27).
-- =====================================================================
