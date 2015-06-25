-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 25 Juin 2015 à 17:45
-- Version du serveur :  5.6.24
-- Version de PHP :  5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `permispiste`
--

--
-- Contenu de la table `action`
--

INSERT INTO `action` (`NUMACTION`, `ACT_NUMACTION`, `LIBACTION`, `SCOREMIN`) VALUES
(1, NULL, 'Monter dans la fusée', NULL),
(2, 1, 'Démarrer la fusée', NULL),
(3, NULL, 'Poser un pied sur la lune', NULL),
(4, NULL, 'Trouver une autre planète', NULL),
(5, NULL, 'Se reposer', NULL),
(6, 3, 'Redécoller', NULL),
(7, 6, 'Poser un pied sur terre', NULL);

--
-- Contenu de la table `apprenant`
--

INSERT INTO `apprenant` (`NUMAPPRENANT`, `NOMAPPRENANT`, `PRENOMAPPRENANT`) VALUES
(1, 'Salvatore', 'Crystal'),
(2, 'Moi', 'Toi');

--
-- Contenu de la table `calendrier`
--

INSERT INTO `calendrier` (`DATEJOUR`) VALUES
('2015-06-23'),
('2015-06-25'),
('2015-06-26');

--
-- Contenu de la table `est_associe`
--

INSERT INTO `est_associe` (`NUMACTION`, `NUMOBJECTIF`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 5);

--
-- Contenu de la table `fixe`
--

INSERT INTO `fixe` (`NUMMISSION`, `NUMOBJECTIF`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(3, 5);

--
-- Contenu de la table `inscrit`
--

INSERT INTO `inscrit` (`NUMJEU`, `NUMAPPRENANT`, `DATEJOUR`) VALUES
(2, 2, '2015-06-23'),
(1, 2, '2015-06-25');

--
-- Contenu de la table `jeu`
--

INSERT INTO `jeu` (`NUMJEU`, `LIBELLEJEU`) VALUES
(1, 'Espace'),
(2, 'MonJeuNum2');

--
-- Contenu de la table `mission`
--

INSERT INTO `mission` (`NUMMISSION`, `NUMJEU`, `LIBMISSION`) VALUES
(1, 1, 'Space Mission'),
(2, 2, 'Autres'),
(3, 1, 'Retour sur terre');

--
-- Contenu de la table `objectif`
--

INSERT INTO `objectif` (`NUMOBJECTIF`, `LIBOBECTIF`) VALUES
(1, 'Espace'),
(2, 'Lune'),
(3, 'Univers'),
(4, 'Ne rien faire'),
(5, 'Atteindre la terre');

--
-- Contenu de la table `obtient`
--

INSERT INTO `obtient` (`NUMAPPRENANT`, `DATEJOUR`, `NUMACTION`, `VALEURDEBUT`, `VALEURFIN`) VALUES
(2, '2015-06-26', 5, 0, 5);

--
-- Contenu de la table `possede`
--

INSERT INTO `possede` (`NUMACTION`, `NUMREGLE`) VALUES
(1, 1),
(2, 2),
(2, 3),
(6, 4);

--
-- Contenu de la table `regle`
--

INSERT INTO `regle` (`NUMREGLE`, `LIBREGLE`, `SCOREMIN`) VALUES
(1, 'Ne pas tomber', 2),
(2, 'Bien démarrer les moteurs', 10),
(3, 'Attacher ça ceinture', 5),
(4, 'Ne rien faire exploser', 20);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
