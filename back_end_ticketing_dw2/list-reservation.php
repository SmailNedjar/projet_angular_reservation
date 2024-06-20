<?php

/**
 * Pour PHP Storm
 * @var object $utilisateur
 */

include('header-init.php');
include('extraction-jwt.php');

if ($utilisateur->role != 'administrateur') {
    echo '{"message":"Vous n\'avez pas les droits nécessaires"}';
    http_response_code(403);
    exit();
}

$requete = $connexion->query('SELECT reservation.id, role.name , utilisateur.email, utilisateur.firstname, utilisateur.lastname,  materiel.nom, materiel.date_achat, reservation.date_debut, reservation.date_fin_reel
                              FROM role
                              JOIN utilisateur ON role.id = utilisateur.id_role
                              JOIN reservation ON utilisateur.id = reservation.id_utilisateur
                              JOIN materiel ON reservation.id_materiel = materiel.id');

$reservation = $requete->fetchAll();

echo json_encode($reservation);
