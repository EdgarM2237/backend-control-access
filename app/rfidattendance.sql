-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-05-2024 a las 06:21:27
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `rfidattendance`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(30) NOT NULL,
  `admin_email` varchar(80) NOT NULL,
  `admin_pwd` longtext NOT NULL,
  `admin_tipo` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `admin_name`, `admin_email`, `admin_pwd`, `admin_tipo`) VALUES
(1, 'Cristian Daniel Henao Florez', 'cristian.henao@parqueexplora.org', '$2y$10$H6004YPuo1JUkZsz7F1AuOg4iC5koUfhO6MGyvoE6jmeBvdza9gPC', 1),
(4, 'Marco Castillo', 'marco.castillo@parqueexplora.org', '$2y$10$PNhnCQBS9jPDzo6Q3LXIH.CrtULweFgg0yxYJT5dtfqULjzETc/DS', 4),
(5, 'Edgar', 'edgarmendezcruz75@gmail.com', '$2y$10$jlpN/uugZCaIaxd.zNzm/urK2wyrr1amWMOqn4.g1nYCYR112AEge', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `device_name` varchar(50) NOT NULL,
  `device_dep` varchar(20) NOT NULL,
  `device_uid` text NOT NULL,
  `device_date` date NOT NULL,
  `device_mode` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `devices`
--

INSERT INTO `devices` (`id`, `device_name`, `device_dep`, `device_uid`, `device_date`, `device_mode`) VALUES
(1, 'Enrolamiento', 'Servidor', '75fadad09480d1b3', '2023-05-20', 1),
(2, 'Oficinas Administrativas', 'Oficinas Administrat', '628afb50c90a805f', '2023-05-20', 1),
(3, 'Control', 'Control', 'acff7ec234a2b5d1', '2023-05-20', 1),
(4, 'ACU', 'Acuario', 'd435346d9482a5dd', '2023-06-29', 1),
(8, 'ENT', 'Puerta ', '6f4e3d3ed24ca05e', '2024-01-16', 0),
(9, 'ADE', 'Administración Exter', 'a506d3f53cb32442', '2024-01-27', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `idmenu` int(11) NOT NULL,
  `nombre_menu` varchar(255) NOT NULL,
  `ruta` varchar(255) NOT NULL,
  `reg_eli` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`idmenu`, `nombre_menu`, `ruta`, `reg_eli`) VALUES
(1, 'Crear Usuarios', 'crea_usuarios.php', 0),
(2, 'Crear Menu', 'crea_menu.php', 1),
(3, 'Usuarios', 'index.php', 0),
(4, 'Gestionar Usuarios', 'ManageUsers.php', 0),
(5, 'Log Accesos', 'UsersLog.php', 0),
(6, 'Dispositivos', 'devices.php', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `idpermiso` int(11) NOT NULL,
  `tipo_usuario` int(11) NOT NULL,
  `menu` int(11) NOT NULL,
  `reg_eli` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`idpermiso`, `tipo_usuario`, `menu`, `reg_eli`) VALUES
(5, 4, 4, 0),
(6, 4, 6, 0),
(8, 5, 5, 0),
(9, 3, 5, 0),
(16, 1, 3, 0),
(17, 1, 5, 0),
(18, 2, 5, 0),
(19, 2, 3, 0),
(20, 1, 4, 0),
(21, 1, 6, 0),
(22, 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pwd_reset`
--

CREATE TABLE `pwd_reset` (
  `id` int(11) NOT NULL,
  `pwd_reset_email` varchar(255) NOT NULL,
  `pwd_reset_selector` varchar(255) NOT NULL,
  `pwd_reset_token` varchar(255) NOT NULL,
  `pwd_reset_expires` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `pwd_reset`
--

INSERT INTO `pwd_reset` (`id`, `pwd_reset_email`, `pwd_reset_selector`, `pwd_reset_token`, `pwd_reset_expires`) VALUES
(56, 'cristian.henao@parqueexplora.org', 'e860992e1b47ea3d', '$2y$10$C2NyFjsXoPlizCNlirNpIOsxS794LnC6XY5kk83ARcZJxNGgR3QHu', 1716602369);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_usuario`
--

CREATE TABLE `tipos_usuario` (
  `idtipo` int(11) NOT NULL,
  `nombre_tipo` varchar(255) NOT NULL,
  `reg_eli` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipos_usuario`
--

INSERT INTO `tipos_usuario` (`idtipo`, `nombre_tipo`, `reg_eli`) VALUES
(1, 'Administrador', 0),
(2, 'Visitante', 0),
(4, 'Gestor', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL DEFAULT 'None',
  `serialnumber` double NOT NULL DEFAULT 0,
  `gender` varchar(10) NOT NULL DEFAULT 'None',
  `email` varchar(50) NOT NULL DEFAULT 'None',
  `card_uid` varchar(30) NOT NULL,
  `card_select` tinyint(1) NOT NULL DEFAULT 0,
  `user_date` date NOT NULL,
  `add_card` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `serialnumber`, `gender`, `email`, `card_uid`, `card_select`, `user_date`, `add_card`) VALUES
(5, 'Luciana R. Henao', 234157190118, 'Female', '987123abc@gmail.com', '234157190118', 0, '2023-06-29', 1),
(6, 'Daniela Tuberquia', 211127145172, 'Male', 'danielatuber@gmail.com', '211127145172', 0, '2023-07-03', 1),
(8, 'Cristian D. Henao', 234181190118, 'Male', '234181190118', '234181190118', 0, '2023-08-18', 1),
(28, 'Santiago V. Henao', 922425050, 'Male', 'valenciahenaosantiago43@gmail.com', '922425050', 0, '2023-08-20', 1),
(29, 'Sergio A. Henao', 185250253226, 'Male', 'sergio@hotmail.com', '185250253226', 0, '2023-08-21', 1),
(30, 'Cristian C. Perez', 20233126171, 'Male', 'camilo.perez@parqueexplora.org', '20233126171', 0, '2023-08-26', 1),
(378, 'Jesus', 58146196118, 'Male', 'cristian051984@gmail.com', '58146196118', 1, '2024-04-19', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_logs`
--

CREATE TABLE `users_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `serialnumber` double NOT NULL,
  `card_uid` varchar(30) NOT NULL,
  `device_uid` varchar(20) NOT NULL,
  `device_dep` varchar(20) NOT NULL,
  `checkindate` date NOT NULL,
  `timein` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users_logs`
--

INSERT INTO `users_logs` (`id`, `username`, `serialnumber`, `card_uid`, `device_uid`, `device_dep`, `checkindate`, `timein`) VALUES
(433, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:22:03'),
(434, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:22:34'),
(435, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:23:01'),
(436, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:32:08'),
(437, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:32:56'),
(438, 'Sergio A. Henao', 185250253226, '185250253226', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:33:41'),
(439, 'Sergio A. Henao', 185250253226, '185250253226', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:34:27'),
(440, 'Sergio A. Henao', 185250253226, '185250253226', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:37:56'),
(441, 'Sergio A. Henao', 185250253226, '185250253226', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:43:11'),
(442, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:43:21'),
(443, 'Luciana R. Henao', 234157190118, '234157190118', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:43:57'),
(444, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:44:06'),
(445, 'Sergio A. Henao', 185250253226, '185250253226', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:44:29'),
(446, 'Sergio A. Henao', 185250253226, '185250253226', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:44:57'),
(447, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:46:01'),
(448, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '21:51:42'),
(449, 'Daniela Tuberquia', 211127145172, '211127145172', 'd435346d9482a5dd', 'Acuario', '2023-09-22', '23:51:43'),
(450, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:00:09'),
(451, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:01:03'),
(452, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:01:23'),
(453, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:08:58'),
(454, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:09:58'),
(455, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:10:10'),
(456, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:12:19'),
(457, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:13:22'),
(458, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:26:02'),
(459, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:32:30'),
(460, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:33:03'),
(461, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '19:35:12'),
(462, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '20:30:00'),
(463, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '20:30:19'),
(464, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-09', '20:38:03'),
(465, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:11:27'),
(466, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:11:55'),
(467, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:13:11'),
(468, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:13:54'),
(469, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:15:10'),
(470, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:16:07'),
(471, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:16:28'),
(472, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:19:32'),
(473, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:23:20'),
(474, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:24:04'),
(475, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:24:23'),
(476, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:24:50'),
(477, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:25:28'),
(478, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:25:43'),
(479, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:29:16'),
(480, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '12:29:48'),
(481, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:25:35'),
(482, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:28:58'),
(483, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:31:03'),
(484, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:35:16'),
(485, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:39:21'),
(486, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:39:31'),
(487, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:42:41'),
(488, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '16:57:36'),
(489, 'Cristian D. Henao', 234181190118, '234181190118', 'a506d3f53cb32442', 'Administración Exter', '2024-02-13', '17:13:17'),
(490, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-02-14', '16:48:28'),
(491, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-02-14', '17:31:11'),
(492, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-02-14', '17:34:54'),
(493, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-02-14', '17:35:12'),
(494, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '14:37:22'),
(495, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '14:37:36'),
(496, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '14:37:43'),
(497, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '14:37:49'),
(498, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '14:37:55'),
(499, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '14:48:27'),
(500, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '14:55:24'),
(501, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-16', '15:28:20'),
(502, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-17', '00:17:06'),
(503, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-17', '00:19:57'),
(504, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '01:21:33'),
(505, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '01:21:45'),
(506, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '01:25:36'),
(507, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '01:26:16'),
(508, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '10:20:21'),
(509, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '10:20:54'),
(510, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '10:25:28'),
(511, 'Cristian D. Henao', 234181190118, '234181190118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '10:28:26'),
(512, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '10:29:11'),
(513, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-04-19', '10:29:48'),
(514, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-07', '10:13:14'),
(515, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-07', '18:58:36'),
(516, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-07', '23:50:08'),
(517, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '00:08:05'),
(518, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '00:08:28'),
(519, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '08:50:59'),
(520, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '09:04:46'),
(521, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '09:05:36'),
(522, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '09:11:52'),
(523, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '09:59:02'),
(524, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '10:37:34'),
(525, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '10:40:50'),
(526, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '10:47:39'),
(527, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '10:47:46'),
(528, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '10:48:47'),
(529, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '10:50:34'),
(530, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:13:04'),
(531, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:17:39'),
(532, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:18:22'),
(533, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:23:05'),
(534, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:25:17'),
(535, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:34:45'),
(536, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:51:11'),
(537, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:54:22'),
(538, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:55:53'),
(539, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '11:58:56'),
(540, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '12:00:29'),
(541, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '12:01:48'),
(542, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '12:02:04'),
(543, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '12:03:03'),
(544, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '12:03:18'),
(545, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '12:05:26'),
(546, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-08', '13:57:24'),
(547, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '12:01:51'),
(548, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '12:06:18'),
(549, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '13:03:35'),
(550, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '13:18:00'),
(551, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '13:35:56'),
(552, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '13:37:43'),
(553, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '13:38:56'),
(554, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-15', '13:54:19'),
(555, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-17', '18:48:22'),
(556, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-17', '19:53:49'),
(557, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-18', '11:18:56'),
(558, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-24', '23:08:30'),
(559, 'Jesus', 58146196118, '58146196118', 'd435346d9482a5dd', 'Acuario', '2024-05-24', '23:09:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_devices`
--

CREATE TABLE `user_devices` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_device` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `user_devices`
--

INSERT INTO `user_devices` (`id`, `id_user`, `id_device`) VALUES
(115, 30, 4),
(116, 30, 3),
(175, 5, 4),
(176, 5, 3),
(177, 6, 4),
(208, 378, 4),
(211, 8, 9),
(212, 28, 4),
(213, 28, 3),
(214, 28, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`idmenu`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indices de la tabla `pwd_reset`
--
ALTER TABLE `pwd_reset`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipos_usuario`
--
ALTER TABLE `tipos_usuario`
  ADD PRIMARY KEY (`idtipo`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users_logs`
--
ALTER TABLE `users_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `user_devices`
--
ALTER TABLE `user_devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_devices_id_user_foreign` (`id_user`),
  ADD KEY `user_devices_id_device_foreign` (`id_device`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `idmenu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `pwd_reset`
--
ALTER TABLE `pwd_reset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de la tabla `tipos_usuario`
--
ALTER TABLE `tipos_usuario`
  MODIFY `idtipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=379;

--
-- AUTO_INCREMENT de la tabla `users_logs`
--
ALTER TABLE `users_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=560;

--
-- AUTO_INCREMENT de la tabla `user_devices`
--
ALTER TABLE `user_devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `user_devices`
--
ALTER TABLE `user_devices`
  ADD CONSTRAINT `user_devices_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_devices_ibfk_2` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id`),
  ADD CONSTRAINT `user_devices_id_device_foreign` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_devices_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
