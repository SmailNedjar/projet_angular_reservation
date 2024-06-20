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


if (!isset($_GET['id'])) {
    http_response_code(400);
    echo '{"message" : "Il manque dans l\url l\'identifiant de l`\'utilisateur à modifier"}';
    exit();
}

//on recupère l'ancien utilisateur dans la base de données
$requete = $connexion->prepare("SELECT * 
                                FROM reservation 
                                WHERE id = :id");

$requete->bindValue("id", $_GET['id']);
$requete->execute();
$utilisateurBdd = $requete->fetch();

//si l'utilisateur n'existe pas on envoie une erreur 404
if (!$utilisateurBdd) {
    http_response_code(404);
    echo '{"message" : "La reservtion n\'existe pas / plus"}';
    exit();
}


$requete = $connexion->prepare("UPDATE reservation 
                                SET 
                                    date_debut = :date_debut,
                                    date_fin_reel=:date_fin_reel,
                                    id_materiel=:id_materiel
                                WHERE id =:id");



$requete->bindValue("date_debut", $reservation->date_debut);
$requete->bindValue("date_fin_reel", $reservation->date_fin_reel);
$requete->bindValue("id_materiel", $reservation->materiel->id);
$requete->bindValue("id", $_GET['id']);

$requete->execute();
