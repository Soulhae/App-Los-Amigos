-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: bin07922repd91xmnlyb-mysql.services.clever-cloud.com:3306
-- Generation Time: Jun 30, 2023 at 09:47 PM
-- Server version: 8.0.22-13
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bin07922repd91xmnlyb`
--

-- --------------------------------------------------------

--
-- Table structure for table `listaproductousuario`
--

CREATE TABLE `listaproductousuario` (
  `id` int NOT NULL,
  `idUsuario` int NOT NULL,
  `idProducto` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `listaproductousuario`
--

INSERT INTO `listaproductousuario` (`id`, `idUsuario`, `idProducto`, `cantidad`, `fecha`) VALUES
(1, 2, 6, 7, '2022-05-16 16:44:14'),
(2, 2, 7, 4, '2023-06-05 22:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `precio` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `producto`
--

INSERT INTO `producto` (`id`, `nombre`, `descripcion`, `precio`) VALUES
(5, 'Coca-Cola 3L', 'Coca-Cola es una bebida azucarada gaseosa vendida a nivel mundial en tiendas, restaurantes y máquinas expendedoras en más de doscientos países o territorios. Es el principal producto de The Coca-Cola Company, de origen estadounidense.', 2890),
(6, 'Pepsi 3L', 'Pepsi, anteriormente Brad\'s Drink y Pepsi-Cola, es una bebida azucarada y gaseosa de cola creada en los Estados Unidos y producida por la compañía PepsiCo. Su mayor competidora es la también estadounidense Coca-Cola.', 2640),
(7, 'Sprite 3L', 'Sprite es un refresco hecho a base de agua carbonatada con sabor a lima o limón, incolora y sin cafeína, creada por The Coca-Cola Company\".​En Venezuela se comercializa bajo el nombre de Chinotto, marca propiedad de Hit de Venezuela que desde 1996 es propiedad de Coca-Cola.', 2490);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_general_ci NOT NULL,
  `password` text COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `password`) VALUES
(2, 'user', 'password'),
(3, 'vacio', 'password'),
(4, 'lanatt', 'lanajeje'),
(5, 'test', 'test'),
(6, 'testnavigator', '12345'),
(7, 'prueba', 'asd'),
(8, 'testclever', 'testing');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `listaproductousuario`
--
ALTER TABLE `listaproductousuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `listaproductousuario`
--
ALTER TABLE `listaproductousuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `listaproductousuario`
--
ALTER TABLE `listaproductousuario`
  ADD CONSTRAINT `listaproductousuario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `listaproductousuario_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
