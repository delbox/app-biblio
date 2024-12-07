CREATE TABLE sincronizacion (
    id INTEGER PRIMARY KEY,
    tabla TEXT,
    fechaUltimaSincronizacion TIMESTAMP
);

CREATE TABLE caja (
    id INTEGER PRIMARY KEY,
    codigo TEXT,
    numeroActivoFijo TEXT,
    subNumeroActivoFijo TEXT,
    descripcion TEXT
);

CREATE TABLE almacen (
    id INTEGER PRIMARY KEY,
    descripcion TEXT
);

CREATE TABLE almacen_login (
    id INTEGER PRIMARY KEY,
    descripcion TEXT
);

CREATE TABLE camion (
    id INTEGER PRIMARY KEY,
    chapa TEXT,
    descripcion TEXT,
    choferId INTEGER,
    choferNombre TEXT
);

CREATE TABLE viaje (
    id INTEGER PRIMARY KEY,
    idEntidad INTEGER,
    almacenOrigenId INTEGER,
    almacenDestinoId INTEGER,
    camionId INTEGER,
    choferId INTEGER,
    fechaCreacion TIMESTAMP,
    fechaModificacion TIMESTAMP,
    fechaEliminacion TIMESTAMP,
    usuarioCreacion INTEGER,
    usuarioModificacion INTEGER,
    usuarioEliminacion INTEGER,
    sincronizado TEXT,
    estado TEXT,
    comentarioFin TEXT
);

CREATE TABLE viaje_caja (
    id INTEGER PRIMARY KEY,
    viajeTmpId INTEGER,
    viajeId INTEGER,
    cajaId INTEGER,
    usuarioEnvio INTEGER,
    fechaEnvio TIMESTAMP,
    usuarioRecepcion TIMESTAMP,
    fechaRecepcion TIMESTAMP,
    envio TEXT,
    recepcion TEXT,
    fechaCreacion TIMESTAMP,
    fechaModificacion TIMESTAMP,
    fechaEliminacion TIMESTAMP,
    usuarioCreacion INTEGER,
    usuarioModificacion INTEGER,
    usuarioEliminacion INTEGER,
    sincronizado TEXT
);

CREATE TABLE viaje_caja_recepcion (
    id INTEGER PRIMARY KEY,
    viajeId INTEGER,
    cajaId INTEGER,
    fechaCreacion TIMESTAMP
);

CREATE TABLE chofer (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    apellido TEXT,
    usuario TEXT
);