-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2021 a las 08:12:16
-- Versión del servidor: 10.1.19-MariaDB
-- Versión de PHP: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `Bajal`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items`
--

CREATE TABLE `items` (
  `codigo` varchar(7) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio_compra` int(11) NOT NULL,
  `precio_venta` int(11) NOT NULL,
  `unidad` varchar(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_user` int(3) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_user` int(3) NOT NULL,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `items`
--

INSERT INTO `items` (`codigo`, `nombre`, `precio_compra`, `precio_venta`, `unidad`, `stock`, `created_user`, `created_date`, `updated_user`, `updated_date`) VALUES
('B000001', 'Quetiazic', 25, 50, 'cajas', 30, 1, '2021-06-27 02:59:48', 1, '2021-06-27 02:09:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion_items`
--

CREATE TABLE `transaccion_items` (
  `codigo_transaccion` varchar(15) NOT NULL,
  `fecha` date NOT NULL,
  `codigo` varchar(7) NOT NULL,
  `numero` int(11) NOT NULL,
  `created_user` int(3) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tipo_transaccion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `transaccion_items`
--

INSERT INTO `transaccion_items` (`codigo_transaccion`, `fecha`, `codigo`, `numero`, `created_user`, `created_date`, `tipo_transaccion`) VALUES
('TB-2021-0000001', '2021-07-01', 'B000001', 5, 1, '2021-07-01 02:09:36', 'Salida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `codigo` varchar(7) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `ciudad` int(30) NOT NULL,
  `created_user` int(3) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_user` int(3) NOT NULL,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`codigo`, `nombre`, `nit`, `direccion`, `telefono`, `ciudad`, `created_user`, `created_date`, `updated_user`, `updated_date`) VALUES
('P000001', 'Acerias Paz del Rio', '900733396-5', 'Calle 11 # 11 35', '6517300', 'Belencito', 1, '2021-06-27 03:09:48', 1, '2021-06-27 03:59:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_user` int(3) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name_user` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(13) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `permisos_acceso` enum('Super Admin','Gerente','Almacen','Tesoreria') NOT NULL,
  `status` enum('activo','bloqueado') NOT NULL DEFAULT 'activo',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_user`, `username`, `name_user`, `password`, `email`, `telefono`, `foto`, `permisos_acceso`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Gaviria', '21232f297a57a5a743894a0e4a801fc3', 'info@sist.com', '7025', 'user-default.png', 'Super Admin', 'activo', '2017-04-01 08:15:15', '2017-07-25 23:35:23'),
(2, 'almacen', 'Almacen', 'a94652aa97c7211ba8954dd15a3cf838', 'almacen@bajal.com', '12000', NULL, 'Almacen', 'activo', '2017-07-25 22:34:03', '2017-07-25 22:42:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `created_user` (`created_user`),
  ADD KEY `updated_user` (`updated_user`);

--
-- Indices de la tabla `transaccion_items`
--
ALTER TABLE `transaccion_items`
  ADD PRIMARY KEY (`codigo_transaccion`),
  ADD KEY `id_barang` (`codigo`),
  ADD KEY `created_user` (`created_user`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `level` (`permisos_acceso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_user` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`created_user`) REFERENCES `usuarios` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `items_ibfk_2` FOREIGN KEY (`updated_user`) REFERENCES `usuarios` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `transaccion_items`
--
ALTER TABLE `transaccion_items`
  ADD CONSTRAINT `transaccion_items_ibfk_1` FOREIGN KEY (`codigo`) REFERENCES `items` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaccion_items_ibfk_2` FOREIGN KEY (`created_user`) REFERENCES `usuarios` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
