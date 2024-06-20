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
$idReservationAsupprimer = $_GET['id'];

$requete = $connexion->prepare("DELETE FROM reservation WHERE id = :id");

$requete->bindValue('id', $idReservationAsupprimer);

$requete->execute();

echo '{"message" : "L\'utilisateur a bien été supprimé"}';