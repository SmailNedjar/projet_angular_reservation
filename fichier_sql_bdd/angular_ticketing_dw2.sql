-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 20 juin 2024 à 12:03
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `angular_ticketing_dw2`
--

-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--

DROP TABLE IF EXISTS `materiel`;
CREATE TABLE IF NOT EXISTS `materiel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_achat` date DEFAULT NULL,
  `numero_serie` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `materiel`
--

INSERT INTO `materiel` (`id`, `nom`, `date_achat`, `numero_serie`) VALUES
(1, 'ordianteur', '2023-06-12', '465191191516'),
(2, 'voiture', '2024-06-02', '1914661616516'),
(4, 'Ordinateur Portable', '2023-01-15', 'SN123456789'),
(5, 'Imprimante', '2022-12-05', 'SN234567890'),
(6, 'Scanner', '2023-02-10', 'SN345678901'),
(7, 'Projecteur', '2023-03-22', 'SN456789012'),
(8, 'Tablette', '2023-04-17', 'SN567890123'),
(9, 'Smartphone', '2023-05-30', 'SN678901234'),
(10, 'Moniteur', '2023-06-14', 'SN789012345'),
(11, 'Clavier', '2023-07-21', 'SN890123456'),
(12, 'Souris', '2023-08-09', 'SN901234567'),
(13, 'Routeur', '2023-09-05', 'SN012345678'),
(14, 'Switch', '2023-10-11', 'SN112345679'),
(15, 'Caméra de Sécurité', '2023-11-20', 'SN212345670'),
(16, 'Microphone', '2023-12-01', 'SN312345671'),
(17, 'Enceinte', '2024-01-15', 'SN412345672'),
(18, 'Casque', '2024-02-28', 'SN512345673');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_debut` date DEFAULT NULL,
  `accepte` tinyint(1) DEFAULT NULL,
  `date_fin_prevu` date DEFAULT NULL,
  `date_fin_reel` date DEFAULT NULL,
  `id_utilisateur` int DEFAULT NULL,
  `id_validateur` int NOT NULL,
  `id_materiel` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_1` (`id_utilisateur`),
  KEY `id_2` (`id_validateur`),
  KEY `id_3` (`id_materiel`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`id`, `date_debut`, `accepte`, `date_fin_prevu`, `date_fin_reel`, `id_utilisateur`, `id_validateur`, `id_materiel`) VALUES
(3, NULL, NULL, NULL, NULL, 3, 0, 3),
(4, '2000-01-01', NULL, NULL, '2200-10-10', 1, 0, 2),
(5, '2002-01-11', NULL, NULL, '2022-10-10', 1, 0, 2);

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'etudiant'),
(2, 'gestionnaire'),
(3, 'administrateur');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_role` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_1` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `email`, `password`, `firstname`, `lastname`, `id_role`) VALUES
(1, 'a@a.fr', '$2y$10$gGiDzNiiBOeBMISc0G959uGHFwUfdIvLBZxyF/Rh5LUoVbOaakH5S', 'b', 'b', 3);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
