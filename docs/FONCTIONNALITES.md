# Fonctionnalités de l'application Parc-Auto PAC

## Authentification

- Connexion avec email et mot de passe.
- Stockage sécurisé du token JWT/Bearer dans `SharedPreferences`.
- Vérification de l'accès via l'API Laravel avant d'afficher la page d'accueil.

## Gestion des demandes de course

- Création de demandes pour soi-même ou pour un autre utilisateur.
- Consultation des demandes selon les statuts : en attente, en cours, terminées.
- Modification des demandes en attente.

## Profil utilisateur

- Récupération du profil via l'API `auth/profile`.
- Lecture des données utilisateur à partir d'une route protégée.

## Gestion des véhicules et motifs

- Consultation des listes de véhicules et de motifs depuis l'API.
- Récupération des détails d'un véhicule ou d'un motif par identifiant.

## Autres fonctionnalités

- Mise à jour du mot de passe via l'API.
- Navigation entre page d'accueil, demandes et notifications.
- Support des appels API sécurisés avec en-tête `Authorization: Bearer <token>`.
