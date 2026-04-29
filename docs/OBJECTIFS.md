# Objectifs du projet Parc-Auto PAC

Ce projet a pour objectif de faciliter la gestion des demandes de course pour le personnel du Parc Autonome de Cotonou (PAC) via une application mobile.

## Objectifs principaux

- Permettre aux agents de créer, suivre et modifier des demandes de course depuis un smartphone.
- Centraliser les demandes de course dans un backend Laravel relié à une base de données MySQL.
- Autoriser l'accès sécurisé via un système d'authentification par token.
- Offrir un workflow clair pour les courses en attente, en cours et terminées.
- Assurer la compatibilité avec les tests sur émulateur Android et les appareils physiques via Wi-Fi.

## Objectifs techniques

- Séparer le frontend Flutter et le backend Laravel pour une architecture API REST propre.
- Stocker le token d'authentification localement dans `SharedPreferences`.
- Utiliser un fichier de configuration centralisé (`lib/config/api_config.dart`) pour gérer l'URL de l'API.
- Adopter une structure de code claire et modulaire pour les appels API, la navigation et les pages.

## Public cible

- Agents et personnel du PAC qui ont besoin de créer et suivre des demandes de course.
- Administrateurs qui doivent consulter l'état des demandes, les affectations et les statistiques.
