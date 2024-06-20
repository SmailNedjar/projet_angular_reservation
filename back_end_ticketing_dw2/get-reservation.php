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

if(!isset($_GET['id'])) {
    http_response_code(400);
    echo '{"message" : "il manque l\'identifiant dans l\'url"}';
    exit();
}

$idReservation = $_GET['id'];

$requete = $connexion->prepare('SELECT utilisateur.email, utilisateur.firstname, utilisateur.lastname, reservation.date_debut, reservation.date_fin_reel, reservation.id
                                FROM reservation 
                                JOIN utilisateur ON reservation.id_utilisateur = utilisateur.id
                                WHERE reservation.id = :id');

$requete->bindValue('id', $idReservation);

$requete->execute();

$reservation = $requete->fetch();

if (!$reservation) {
    http_response_code(404);
    echo '{"message" : "aucune reservation introuvable"}';
    exit();
}

echo json_encode($reservation);
