-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 24 Juin 2015 à 16:57
-- Version du serveur :  5.6.16
-- Version de PHP :  5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `permispiste`
--

-- --------------------------------------------------------

--
-- Structure de la table `action`
--

CREATE TABLE IF NOT EXISTS `action` (
  `NUMACTION` int(11) NOT NULL,
  `ACT_NUMACTION` int(11) DEFAULT NULL,
  `LIBACTION` char(25) DEFAULT NULL,
  `SCOREMIN` int(11) DEFAULT NULL,
  PRIMARY KEY (`NUMACTION`),
  KEY `A_POUR_SUCCESSEUR_FK` (`ACT_NUMACTION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `action`
--

INSERT INTO `action` (`NUMACTION`, `ACT_NUMACTION`, `LIBACTION`, `SCOREMIN`) VALUES
(1, NULL, 'Tirer à 2m', 10),
(2, 1, 'Tirer à 4m', 20),
(3, NULL, 'Saut 10cm', 5);

-- --------------------------------------------------------

--
-- Structure de la table `appartient`
--

CREATE TABLE IF NOT EXISTS `appartient` (
  `NUMJEU` int(11) NOT NULL,
  `NUMACTION` int(11) NOT NULL,
  PRIMARY KEY (`NUMJEU`,`NUMACTION`),
  KEY `APPARTIENT_FK` (`NUMJEU`),
  KEY `APPARTIENT2_FK` (`NUMACTION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `appartient`
--

INSERT INTO `appartient` (`NUMJEU`, `NUMACTION`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `apprenant`
--

CREATE TABLE IF NOT EXISTS `apprenant` (
  `NUMAPPRENANT` int(11) NOT NULL,
  `NOMAPPRENANT` char(25) DEFAULT NULL,
  `PRENOMAPPRENANT` char(25) DEFAULT NULL,
  PRIMARY KEY (`NUMAPPRENANT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `apprenant`
--

INSERT INTO `apprenant` (`NUMAPPRENANT`, `NOMAPPRENANT`, `PRENOMAPPRENANT`) VALUES
(1, 'Salvatore', 'Crystal'),
(2, 'Quent', 'nbnbn'),
(3, 'razrazra', 'qsdqsdqsdqsd');

-- --------------------------------------------------------

--
-- Structure de la table `calendrier`
--

CREATE TABLE IF NOT EXISTS `calendrier` (
  `DATEJOUR` date NOT NULL,
  PRIMARY KEY (`DATEJOUR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `calendrier`
--

INSERT INTO `calendrier` (`DATEJOUR`) VALUES
('2015-06-15'),
('2015-06-16');

-- --------------------------------------------------------

--
-- Structure de la table `est_associe`
--

CREATE TABLE IF NOT EXISTS `est_associe` (
  `NUMACTION` int(11) NOT NULL,
  `NUMOBJECTIF` int(11) NOT NULL,
  PRIMARY KEY (`NUMACTION`,`NUMOBJECTIF`),
  KEY `EST_ASSOCIE_FK` (`NUMACTION`),
  KEY `EST_ASSOCIE2_FK` (`NUMOBJECTIF`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `est_associe`
--

INSERT INTO `est_associe` (`NUMACTION`, `NUMOBJECTIF`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `fixe`
--

CREATE TABLE IF NOT EXISTS `fixe` (
  `NUMMISSION` int(11) NOT NULL,
  `NUMOBJECTIF` int(11) NOT NULL,
  PRIMARY KEY (`NUMMISSION`,`NUMOBJECTIF`),
  KEY `FIXE_FK` (`NUMMISSION`),
  KEY `FIXE2_FK` (`NUMOBJECTIF`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `fixe`
--

INSERT INTO `fixe` (`NUMMISSION`, `NUMOBJECTIF`) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `indicateur`
--

CREATE TABLE IF NOT EXISTS `indicateur` (
  `NUMINDIC` int(11) NOT NULL,
  `NUMACTION` int(11) NOT NULL,
  `LIBINDIC` char(20) DEFAULT NULL,
  `POIDS` int(11) DEFAULT NULL,
  PRIMARY KEY (`NUMINDIC`),
  KEY `EST_VALORISE_FK` (`NUMACTION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `indicateur`
--

INSERT INTO `indicateur` (`NUMINDIC`, `NUMACTION`, `LIBINDIC`, `POIDS`) VALUES
(1, 1, 'temps', 1);

-- --------------------------------------------------------

--
-- Structure de la table `inscrit`
--

CREATE TABLE IF NOT EXISTS `inscrit` (
  `NUMJEU` int(11) NOT NULL,
  `NUMAPPRENANT` int(11) NOT NULL,
  `DATEJOUR` date NOT NULL,
  PRIMARY KEY (`NUMJEU`,`NUMAPPRENANT`,`DATEJOUR`),
  KEY `fk_inscrit_apprenant` (`NUMAPPRENANT`),
  KEY `fk_inscrit_calendrier` (`DATEJOUR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `inscrit`
--

INSERT INTO `inscrit` (`NUMJEU`, `NUMAPPRENANT`, `DATEJOUR`) VALUES
(1, 1, '2015-06-15'),
(2, 1, '2015-06-15'),
(1, 1, '2015-06-16'),
(2, 1, '2015-06-16');

-- --------------------------------------------------------

--
-- Structure de la table `jeu`
--

CREATE TABLE IF NOT EXISTS `jeu` (
  `NUMJEU` int(11) NOT NULL,
  `LIBELLEJEU` char(25) DEFAULT NULL,
  PRIMARY KEY (`NUMJEU`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `jeu`
--

INSERT INTO `jeu` (`NUMJEU`, `LIBELLEJEU`) VALUES
(1, 'Tir au flechette'),
(2, 'Pétage de plomb');

-- --------------------------------------------------------

--
-- Structure de la table `mission`
--

CREATE TABLE IF NOT EXISTS `mission` (
  `NUMMISSION` int(11) NOT NULL,
  `NUMJEU` int(11) NOT NULL,
  `LIBMISSION` char(25) DEFAULT NULL,
  PRIMARY KEY (`NUMMISSION`),
  KEY `SE_COMPOSE_FK` (`NUMJEU`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mission`
--

INSERT INTO `mission` (`NUMMISSION`, `NUMJEU`, `LIBMISSION`) VALUES
(1, 1, 'Mission apollo'),
(2, 1, 'Mission Wazzaaaaa'),
(3, 2, 'Bof bof bof');

-- --------------------------------------------------------

--
-- Structure de la table `objectif`
--

CREATE TABLE IF NOT EXISTS `objectif` (
  `NUMOBJECTIF` int(11) NOT NULL,
  `LIBOBECTIF` char(25) DEFAULT NULL,
  PRIMARY KEY (`NUMOBJECTIF`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `objectif`
--

INSERT INTO `objectif` (`NUMOBJECTIF`, `LIBOBECTIF`) VALUES
(1, 'lune'),
(2, 'Paris'),
(3, 'Chez moi');

-- --------------------------------------------------------

--
-- Structure de la table `obtient`
--

CREATE TABLE IF NOT EXISTS `obtient` (
  `NUMAPPRENANT` int(11) NOT NULL,
  `DATEJOUR` date NOT NULL,
  `NUMACTION` int(11) NOT NULL,
  `VALEURDEBUT` int(11) DEFAULT NULL,
  `VALEURFIN` int(11) DEFAULT NULL,
  PRIMARY KEY (`NUMAPPRENANT`,`DATEJOUR`,`NUMACTION`),
  KEY `OBTIENT_FK` (`NUMAPPRENANT`),
  KEY `OBTIENT3_FK` (`DATEJOUR`),
  KEY `OBTIENT3_FK2` (`NUMACTION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `possede`
--

CREATE TABLE IF NOT EXISTS `possede` (
  `NUMACTION` int(11) NOT NULL,
  `NUMREGLE` int(11) NOT NULL,
  PRIMARY KEY (`NUMACTION`,`NUMREGLE`),
  KEY `POSSEDE_FK` (`NUMACTION`),
  KEY `POSSEDE2_FK` (`NUMREGLE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `regle`
--

CREATE TABLE IF NOT EXISTS `regle` (
  `NUMREGLE` int(11) NOT NULL,
  `LIBREGLE` char(25) DEFAULT NULL,
  `SCOREMIN` int(11) DEFAULT NULL,
  PRIMARY KEY (`NUMREGLE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `action`
--
ALTER TABLE `action`
  ADD CONSTRAINT `FK_ACTION_A_POUR_SU_ACTION` FOREIGN KEY (`ACT_NUMACTION`) REFERENCES `action` (`NUMACTION`);

--
-- Contraintes pour la table `appartient`
--
ALTER TABLE `appartient`
  ADD CONSTRAINT `FK_APPARTIE_APPARTIEN_ACTION` FOREIGN KEY (`NUMACTION`) REFERENCES `action` (`NUMACTION`),
  ADD CONSTRAINT `FK_APPARTIE_APPARTIEN_JEU` FOREIGN KEY (`NUMJEU`) REFERENCES `jeu` (`NUMJEU`);

--
-- Contraintes pour la table `est_associe`
--
ALTER TABLE `est_associe`
  ADD CONSTRAINT `FK_EST_ASSO_EST_ASSOC_ACTION` FOREIGN KEY (`NUMACTION`) REFERENCES `action` (`NUMACTION`),
  ADD CONSTRAINT `FK_EST_ASSO_EST_ASSOC_OBJECTIF` FOREIGN KEY (`NUMOBJECTIF`) REFERENCES `objectif` (`NUMOBJECTIF`);

--
-- Contraintes pour la table `fixe`
--
ALTER TABLE `fixe`
  ADD CONSTRAINT `FK_FIXE_FIXE2_OBJECTIF` FOREIGN KEY (`NUMOBJECTIF`) REFERENCES `objectif` (`NUMOBJECTIF`),
  ADD CONSTRAINT `FK_FIXE_FIXE_MISSION` FOREIGN KEY (`NUMMISSION`) REFERENCES `mission` (`NUMMISSION`);

--
-- Contraintes pour la table `indicateur`
--
ALTER TABLE `indicateur`
  ADD CONSTRAINT `FK_INDICATE_EST_VALOR_ACTION` FOREIGN KEY (`NUMACTION`) REFERENCES `action` (`NUMACTION`);

--
-- Contraintes pour la table `inscrit`
--
ALTER TABLE `inscrit`
  ADD CONSTRAINT `fk_inscrit_apprenant` FOREIGN KEY (`NUMAPPRENANT`) REFERENCES `apprenant` (`NUMAPPRENANT`),
  ADD CONSTRAINT `fk_inscrit_calendrier` FOREIGN KEY (`DATEJOUR`) REFERENCES `calendrier` (`DATEJOUR`),
  ADD CONSTRAINT `fk_inscrit_jeu` FOREIGN KEY (`NUMJEU`) REFERENCES `jeu` (`NUMJEU`);

--
-- Contraintes pour la table `mission`
--
ALTER TABLE `mission`
  ADD CONSTRAINT `FK_MISSION_SE_COMPOS_JEU` FOREIGN KEY (`NUMJEU`) REFERENCES `jeu` (`NUMJEU`);

--
-- Contraintes pour la table `obtient`
--
ALTER TABLE `obtient`
  ADD CONSTRAINT `FK_OBTIENT_OBTIENT2_CALENDRI` FOREIGN KEY (`DATEJOUR`) REFERENCES `calendrier` (`DATEJOUR`),
  ADD CONSTRAINT `FK_OBTIENT_OBTIENT3_ACTION` FOREIGN KEY (`NUMACTION`) REFERENCES `action` (`NUMACTION`),
  ADD CONSTRAINT `FK_OBTIENT_OBTIENT_APPRENAN` FOREIGN KEY (`NUMAPPRENANT`) REFERENCES `apprenant` (`NUMAPPRENANT`);

--
-- Contraintes pour la table `possede`
--
ALTER TABLE `possede`
  ADD CONSTRAINT `FK_POSSEDE_POSSEDE2_REGLE` FOREIGN KEY (`NUMREGLE`) REFERENCES `regle` (`NUMREGLE`),
  ADD CONSTRAINT `FK_POSSEDE_POSSEDE_ACTION` FOREIGN KEY (`NUMACTION`) REFERENCES `action` (`NUMACTION`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
