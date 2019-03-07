-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Vært: localhost
-- Genereringstid: 07. 03 2019 kl. 19:38:38
-- Serverversion: 10.3.13-MariaDB
-- PHP-version: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `CentralHub`
--
CREATE DATABASE IF NOT EXISTS `CentralHub` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `CentralHub`;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `Devices`
--

DROP TABLE IF EXISTS `Devices`;
CREATE TABLE `Devices` (
  `Id` int(11) NOT NULL COMMENT 'Id to allow indexing',
  `Mac` bigint(20) UNSIGNED NOT NULL COMMENT 'Mac address of the device',
  `Ip` int(10) UNSIGNED NOT NULL COMMENT 'Current ip address',
  `Type` bigint(20) UNSIGNED NOT NULL COMMENT 'The type of device',
  `LastSeen` timestamp NOT NULL COMMENT 'When the device was last seen',
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'User given name of the device'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `Devices`
--
ALTER TABLE `Devices`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Mac` (`Mac`),
  ADD UNIQUE KEY `Ip` (`Ip`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `Devices`
--
ALTER TABLE `Devices`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id to allow indexing';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
