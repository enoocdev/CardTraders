DROP DATABASE IF EXISTS CardTraders;
CREATE DATABASE IF NOT EXISTS CardTraders;


USE CardTraders;

CREATE TABLE IF NOT EXISTS usuarios(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(50) UNIQUE,
    dni VARCHAR(50) UNIQUE

);

CREATE TABLE IF NOT EXISTS vendedores(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    monedero DECIMAL(20,2) DEFAULT 0,
    CONSTRAINT FOREIGN KEY (id_usuario) REFERENCES usuarios(id)

);


CREATE TABLE IF NOT EXISTS direcciones(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    pais VARCHAR(50),
    ciudad VARCHAR(50),
    calle VARCHAR(50),
    piso VARCHAR(50),
    CONSTRAINT FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS juegos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    logo VARCHAR(100)

);

CREATE TABLE IF NOT EXISTS cartas(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_juego INT,
    nombre VARCHAR(100),
    imagen VARCHAR(100),
    CONSTRAINT FOREIGN KEY (id_juego) REFERENCES juegos(id)
);

CREATE TABLE IF NOT EXISTS ediciones(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_juego INT,
    nombre_edicion VARCHAR(100),
    fecha_lanzamiento DATE,
    codigo_edicion VARCHAR(50),
    CONSTRAINT FOREIGN KEY (id_juego) REFERENCES juegos(id)

);



CREATE TABLE IF NOT EXISTS cartas_ediciones(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_carta BIGINT,
    id_edicion INT,
    rareza VARCHAR(100),
    CONSTRAINT FOREIGN KEY (id_carta) REFERENCES cartas(id),
    CONSTRAINT FOREIGN KEY (id_edicion) REFERENCES ediciones(id)

);


CREATE TABLE IF NOT EXISTS inventarios(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_vendedor INT,
    CONSTRAINT FOREIGN KEY (id_vendedor) REFERENCES vendedores(id)

);

CREATE TABLE IF NOT EXISTS ordenes_venta(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_inventario INT,
    id_carta BIGINT,
    estado VARCHAR(100),
    foil BOOLEAN,
    comentario TEXT,
    precio DECIMAL(10,2),
    vendido BOOLEAN DEFAULT FALSE,
    CONSTRAINT FOREIGN KEY (id_carta) REFERENCES cartas(id),
    CONSTRAINT FOREIGN KEY (id_inventario) REFERENCES inventarios(id)
);


CREATE TABLE IF NOT EXISTS ordenes_compra(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    estado enum("Finalizada","En proceso","Enviada","En camino","Perdida") DEFAULT("En proceso"),
    comentario TEXT,
    valoracion INT,
    CONSTRAINT FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS detalles_compra(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_ordenes_compra INT,
    id_orden_venta INT,
    CONSTRAINT FOREIGN KEY (id_orden_venta) REFERENCES ordenes_venta(id),
    CONSTRAINT FOREIGN KEY (id_ordenes_compra) REFERENCES ordenes_compra(id)
);

