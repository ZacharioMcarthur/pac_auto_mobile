# Mises à jour opérées

## Mise à jour de la configuration API

- Ajout d'un fichier de configuration centralisé : `lib/config/api_config.dart`.
- Séparation des URLs pour l'émulateur (`10.0.2.2`) et le téléphone Wi-Fi (`10.35.101.88`).
- Ajout d'un mécanisme de sélection dynamique via `isEmulator`.

## Migration des appels API

- Passage de nombreuses URLs hardcodées vers `ApiConfig.baseUrl`.
- Centralisation des appels API dans `lib/api/`.
- Standardisation des headers HTTP pour les requêtes JSON.

## Authentification et token

- Confirmation que le token est stocké dans `SharedPreferences` sous la clé `token`.
- Préparation des headers d'authentification dans `ApiConfig.getAuthHeaders()`.
- Vérification du profil utilisateur via une route protégée.

## Documentation

- Mise à jour du `README.md` principal.
- Ajout de documentation technique complémentaire dans `docs/OBJECTIFS.md`, `docs/FONCTIONNALITES.md`, `docs/STRUCTURE.md` et `docs/MISES_A_JOUR.md`.

## Débogage et installation Wi-Fi

- Ajout de procédures pour connecter un appareil Android via ADB Wi-Fi.
- Support de l'installation d'un APK manuelle si l'utilisateur ne souhaite pas utiliser `flutter run`.

## Prochaines améliorations recommandées

- Ajouter des tests unitaires pour les fonctions API.
- Documenter les routes Laravel exactes utilisées par l'application.
- Ajouter une page de changelog détaillé pour chaque version.
