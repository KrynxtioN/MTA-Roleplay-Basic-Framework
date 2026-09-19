-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 14. Jan 2019 um 08:12
-- Server-Version: 10.1.32-MariaDB
-- PHP-Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `tut`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bans`
--

CREATE TABLE `bans` (
  `ID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Grund` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fahrzeuge`
--

CREATE TABLE `fahrzeuge` (
  `ID` int(11) NOT NULL,
  `Besitzer` text NOT NULL,
  `Model` int(11) NOT NULL,
  `Posx` varchar(50) NOT NULL,
  `Posy` varchar(50) NOT NULL,
  `Posz` varchar(50) NOT NULL,
  `Rotz` int(11) NOT NULL,
  `Benzin` int(11) NOT NULL DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fraktionskasse`
--

CREATE TABLE `fraktionskasse` (
  `ID` int(11) NOT NULL,
  `GeldInhalt` varchar(50) NOT NULL,
  `Waffenlager` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `fraktionskasse`
--

INSERT INTO `fraktionskasse` (`ID`, `GeldInhalt`, `Waffenlager`) VALUES
(1, '5000', 25),
(2, '5000', 25),
(3, '15000', 25);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `haussystem`
--

CREATE TABLE `haussystem` (
  `ID` int(11) NOT NULL,
  `Posx` varchar(50) NOT NULL,
  `Posy` varchar(50) NOT NULL,
  `Posz` varchar(50) NOT NULL,
  `Besitzer` text NOT NULL,
  `Preis` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `Hauskasse` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userdata`
--

CREATE TABLE `userdata` (
  `ID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Passwort` text NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Fraktion` int(11) NOT NULL DEFAULT '0',
  `Fraktionsrang` int(11) NOT NULL DEFAULT '0',
  `Adminlevel` int(11) NOT NULL DEFAULT '0',
  `Geld` varchar(50) NOT NULL DEFAULT '5000',
  `Posx` varchar(50) NOT NULL DEFAULT '1468.9000244141',
  `Posy` varchar(50) NOT NULL DEFAULT '-1771.8000488281',
  `Posz` varchar(50) NOT NULL DEFAULT '18.795755386353',
  `Rotz` varchar(50) NOT NULL DEFAULT '0',
  `Interior` int(11) NOT NULL DEFAULT '0',
  `Dimension` int(11) NOT NULL DEFAULT '0',
  `Kills` int(11) NOT NULL DEFAULT '0',
  `Tode` int(11) NOT NULL DEFAULT '0',
  `Bankgeld` int(11) NOT NULL DEFAULT '0',
  `Autoschein` int(11) NOT NULL DEFAULT '0',
  `Motorradschein` int(11) NOT NULL DEFAULT '0',
  `Lkwschein` int(11) NOT NULL DEFAULT '0',
  `Bootschein` int(11) NOT NULL DEFAULT '0',
  `Flugschein` int(11) NOT NULL DEFAULT '0',
  `Skin` int(11) NOT NULL DEFAULT '0',
  `Housekey` int(11) NOT NULL DEFAULT '0',
  `Housespawn` int(11) NOT NULL DEFAULT '0',
  `Hamburger` int(11) NOT NULL DEFAULT '0',
  `Weed` int(11) NOT NULL DEFAULT '0',
  `Benzinkanister` int(11) NOT NULL DEFAULT '0',
  `Spielstunden` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `fahrzeuge`
--
ALTER TABLE `fahrzeuge`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `fraktionskasse`
--
ALTER TABLE `fraktionskasse`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `haussystem`
--
ALTER TABLE `haussystem`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `bans`
--
ALTER TABLE `bans`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `fahrzeuge`
--
ALTER TABLE `fahrzeuge`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `haussystem`
--
ALTER TABLE `haussystem`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `userdata`
--
ALTER TABLE `userdata`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
