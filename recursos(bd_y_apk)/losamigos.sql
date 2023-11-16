-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: bin07922repd91xmnlyb-mysql.services.clever-cloud.com:3306
-- Tiempo de generación: 16-11-2023 a las 05:08:58
-- Versión del servidor: 8.0.22-13
-- Versión de PHP: 8.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bin07922repd91xmnlyb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `rut` int NOT NULL,
  `razon_social` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `encargado_pedido` varchar(45) DEFAULT NULL,
  `direccion_despacho` varchar(45) DEFAULT NULL,
  `comuna` varchar(45) DEFAULT NULL,
  `telefono_contacto` varchar(45) DEFAULT NULL,
  `dia_visita` varchar(45) DEFAULT NULL,
  `horario` varchar(45) DEFAULT NULL,
  `metodo_pago` varchar(45) DEFAULT NULL,
  `limites_de_pago` varchar(45) DEFAULT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `patente_alcohol` varchar(45) DEFAULT NULL,
  `Venta_codigo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_has_vendedor`
--

CREATE TABLE `cliente_has_vendedor` (
  `Cliente_rut` int NOT NULL,
  `Vendedor_id_vendedor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int NOT NULL,
  `fecha` date NOT NULL,
  `idVenta` int NOT NULL,
  `fechaVencimiento` date NOT NULL,
  `idUsuario` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id`, `fecha`, `idVenta`, `fechaVencimiento`, `idUsuario`) VALUES
(1, '2023-09-12', 2, '2023-09-30', 2),
(2, '2023-11-05', 1, '2023-11-30', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listaproductousuario`
--

CREATE TABLE `listaproductousuario` (
  `id` int NOT NULL,
  `idUsuario` int NOT NULL,
  `idProducto` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `listaproductousuario`
--

INSERT INTO `listaproductousuario` (`id`, `idUsuario`, `idProducto`, `cantidad`, `fecha`) VALUES
(1, 2, 6, 7, '2022-05-16 16:44:14'),
(2, 2, 7, 4, '2023-06-05 22:29:18'),
(3, 2, 5, 25, '2023-11-15 02:50:59'),
(4, 2, 7, 745, '2023-11-15 02:50:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oferta`
--

CREATE TABLE `oferta` (
  `id` int NOT NULL,
  `idUsuario` int NOT NULL,
  `cantidadProd` int NOT NULL,
  `fechaLimite` date NOT NULL,
  `porcDescuento` int NOT NULL,
  `limiteUsos` int NOT NULL,
  `idProducto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `oferta`
--

INSERT INTO `oferta` (`id`, `idUsuario`, `cantidadProd`, `fechaLimite`, `porcDescuento`, `limiteUsos`, `idProducto`) VALUES
(1, 2, 6, '2024-01-31', 20, 2, 5),
(2, 2, 12, '2023-11-30', 50, 1, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codigo` varchar(45) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `envase` varchar(45) DEFAULT NULL,
  `formato` varchar(45) DEFAULT NULL,
  `tipo_display` varchar(45) DEFAULT NULL,
  `codigo_impuesto` int DEFAULT NULL,
  `estado` tinyint DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productoOld`
--

CREATE TABLE `productoOld` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `precio` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productoOld`
--

INSERT INTO `productoOld` (`id`, `nombre`, `descripcion`, `precio`) VALUES
(5, 'Coca-Cola 3L', 'Coca-Cola es una bebida azucarada gaseosa vendida a nivel mundial en tiendas, restaurantes y máquinas expendedoras en más de doscientos países o territorios. Es el principal producto de The Coca-Cola Company, de origen estadounidense.', 2890),
(6, 'Pepsi 3L', 'Pepsi, anteriormente Brad\'s Drink y Pepsi-Cola, es una bebida azucarada y gaseosa de cola creada en los Estados Unidos y producida por la compañía PepsiCo. Su mayor competidora es la también estadounidense Coca-Cola.', 2640),
(7, 'Sprite 3L', 'Sprite es un refresco hecho a base de agua carbonatada con sabor a lima o limón, incolora y sin cafeína, creada por The Coca-Cola Company\".​En Venezuela se comercializa bajo el nombre de Chinotto, marca propiedad de Hit de Venezuela que desde 1996 es propiedad de Coca-Cola.', 2490);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_general_ci NOT NULL,
  `password` text COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `password`) VALUES
(2, 'user', 'password'),
(3, 'vacio', 'password'),
(4, 'lanatt', 'lanajeje'),
(5, 'test', 'test'),
(6, 'testnavigator', '12345'),
(7, 'prueba', 'asd'),
(8, 'testclever', 'testing');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE `vendedor` (
  `id_vendedor` int NOT NULL,
  `supervisor` varchar(45) DEFAULT NULL,
  `canal_venta` varchar(45) DEFAULT NULL,
  `UEN` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `codigo` varchar(45) NOT NULL,
  `tipo_documento` varchar(45) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `rut` int DEFAULT NULL,
  `razon_social` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `envase` varchar(45) DEFAULT NULL,
  `formato` varchar(45) DEFAULT NULL,
  `proveedor` varchar(45) DEFAULT NULL,
  `exento` tinyint DEFAULT NULL,
  `unidad` varchar(45) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_compra_unitario_neto` float DEFAULT NULL,
  `precio_venta_unitario_neto` float DEFAULT NULL,
  `monto_descuento` tinyint DEFAULT NULL,
  `porcentaje_descuento` float DEFAULT NULL,
  `porcentaje_impuesto_adicional` float DEFAULT NULL,
  `subtotal_neto` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_has_producto`
--

CREATE TABLE `venta_has_producto` (
  `Venta_codigo` varchar(45) NOT NULL,
  `Producto_codigo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`rut`,`Venta_codigo`),
  ADD KEY `fk_Cliente_Venta1_idx` (`Venta_codigo`);

--
-- Indices de la tabla `cliente_has_vendedor`
--
ALTER TABLE `cliente_has_vendedor`
  ADD PRIMARY KEY (`Cliente_rut`,`Vendedor_id_vendedor`),
  ADD KEY `fk_Cliente_has_Vendedor_Vendedor1_idx` (`Vendedor_id_vendedor`),
  ADD KEY `fk_Cliente_has_Vendedor_Cliente_idx` (`Cliente_rut`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`idVenta`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `listaproductousuario`
--
ALTER TABLE `listaproductousuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `oferta`
--
ALTER TABLE `oferta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `productoOld`
--
ALTER TABLE `productoOld`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id_vendedor`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `venta_has_producto`
--
ALTER TABLE `venta_has_producto`
  ADD PRIMARY KEY (`Venta_codigo`,`Producto_codigo`),
  ADD KEY `fk_Venta_has_Producto_Producto1_idx` (`Producto_codigo`),
  ADD KEY `fk_Venta_has_Producto_Venta1_idx` (`Venta_codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `listaproductousuario`
--
ALTER TABLE `listaproductousuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `oferta`
--
ALTER TABLE `oferta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productoOld`
--
ALTER TABLE `productoOld`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_Cliente_Venta1` FOREIGN KEY (`Venta_codigo`) REFERENCES `venta` (`codigo`);

--
-- Filtros para la tabla `cliente_has_vendedor`
--
ALTER TABLE `cliente_has_vendedor`
  ADD CONSTRAINT `fk_Cliente_has_Vendedor_Cliente` FOREIGN KEY (`Cliente_rut`) REFERENCES `cliente` (`rut`),
  ADD CONSTRAINT `fk_Cliente_has_Vendedor_Vendedor1` FOREIGN KEY (`Vendedor_id_vendedor`) REFERENCES `vendedor` (`id_vendedor`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`idVenta`) REFERENCES `listaproductousuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `listaproductousuario`
--
ALTER TABLE `listaproductousuario`
  ADD CONSTRAINT `listaproductousuario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `listaproductousuario_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `productoOld` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `oferta`
--
ALTER TABLE `oferta`
  ADD CONSTRAINT `oferta_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `oferta_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `productoOld` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `venta_has_producto`
--
ALTER TABLE `venta_has_producto`
  ADD CONSTRAINT `fk_Venta_has_Producto_Producto1` FOREIGN KEY (`Producto_codigo`) REFERENCES `producto` (`codigo`),
  ADD CONSTRAINT `fk_Venta_has_Producto_Venta1` FOREIGN KEY (`Venta_codigo`) REFERENCES `venta` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
