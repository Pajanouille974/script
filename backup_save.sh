#!/bin/bash
#Ce script a pour but de troll l'utilisateur a jouer un petit jeu 
#Auteur : Pajany ANGAMA

#=== CONFIG ===
cache="$HOME/.verrou"
perdu="$HOME/.perdu"
motdepasse="openSesame"

mkdir -p "$cache" "$perdu"

#=== DEMANDE DE FICHIER A SAUVEGARDER ===
if [ -z "$1" ]; then
	read -p "Entrer le chemin du fichier à sauvegarder : " fichier
else
	fichier="$1"
fi

#Vérif de l'existence du fichier
if [ ! -f "$fichier" ]; then
	echo "Fichier introuvable."
	exit 1
fi

filename=$(basename "$fichier")

#Faux message rassurant
echo "Sauvegarde automatique en cours..."
mv  "$fichier" "$cache/"
sleep 1

#=== BARRE DE CHARGEMENT INUTILE ===
echo -n "Chargement sécurisé : "
for i in {1..30}; do
	echo -n "#"
	sleep 0.1
done
echo :" Terminé."
sleep 1

echo "Le fichier est désormais stocké dans un espace sécurisé renforcé."
sleep 1
echo "Vérification des accès"

#Début du troll
clear
echo "Vérification de sécurité : prouve que tu peux récupérer ton fichier."

#=== étape 1 : Mot de passe ===
read -s -p "Entrez le mot de passe de récupération : " input
echo
if [ "$input" != "$motdepasse" ]; then
	echo "Mot de passe invalide."
	mv "$cache/$filename" "$perdu"
	echo "Le fichier a été déplacé pour ta sécurité... dans $perdu"
	exit 1
fi

echo "Accès autorisé ! Récupération possible..."
sleep 1
clear

#=== FAUX SCAN ANTIVIRUS ===
echo "Analyse antivirus en cours sur les fichiers sécurisés..."
echo
for ((i = 0; i<= 100; i+=5)); do 
	printf "\r Scan en cours : [%-20s] %3d%%" $(printf '#%.0s' $(seq 1 $((i / 5))))
	sleep 0.5
done
echo -e "\n Aucun virus détecté."
sleep 1
echo "Déchiffrement sécurisé en cours..."
sleep 2

#=== étape 2 : Petit Jeu ===
clear
echo "Question de sécurité : Quel est le bon chiffre entre 1 et 5 ?"
bon=$((RANDOM % 5 + 1))
read -p "Réponse : " REP

if [[ "$REP" =~ ^[0-9]+$ ]]; then
	if [ "$REP" -eq "$bon" ]; then
	echo "Bravo, restauration en cours..."
	sleep 1
	echo "Bonne réponse ! Fichier restauré avec succès."
	mv "$cache/$filename" .
else
	echo "Mauvaise réponse ! Fichier déplacé dans $perdu. Bonne chance pour le retrouvé..."
	mv "$cache/$filename" "$perdu/"
fi
else
echo "Ce n'est pas un nombre valide."
mv "$cache/$filename" "$perdu/"
echo "Fichier déplacé dans $perdu par mesure de sécurité"
fi
