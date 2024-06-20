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

$json = file_get_contents('php://input');

$reservation = json_decode($json);

$requete = $connexion->prepare("INSERT INTO reservation
                                (id_materiel, date_debut, date_fin_reel, id_utilisateur) VALUES 
                                (:id_materiel, :date_debut, :date_fin_reel, :id_utilisateur)");

$requete->bindValue("id_materiel", $reservation->materiel->id);
$requete->bindValue("date_debut", $reservation->date_debut);
$requete->bindValue("date_fin_reel", $reservation->date_fin_reel);
$requete->bindValue("id_utilisateur", $utilisateur->id);


$requete->execute();

echo '{"message" : "inscription réussie"}';
