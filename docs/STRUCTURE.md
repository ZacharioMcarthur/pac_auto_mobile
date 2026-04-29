# Structure du projet Parc-Auto PAC

## Arborescence principale

- `lib/` : code source Flutter de l'application mobile.
- `assets/` : ressources de l'application (images, polices, icônes).
- `android/`, `ios/`, `windows/`, `web/` : plateformes prises en charge par Flutter.
- `README.md` : documentation principale du projet.
- `docs/` : documentation technique propre au projet.

## Dossier `lib/`

### `lib/main.dart`
- Point d'entrée de l'application.
- Initialise l'application, le thème et lance la page de vérification `Verify()`.

### `lib/config/api_config.dart`
- Contient l'URL de base de l'API.
- Permet de basculer facilement entre l'émulateur et un téléphone physique.
- Définit les headers de base et les headers d'authentification.

### `lib/api/`
- Regroupe tous les appels HTTP vers l'API Laravel.
- Organisé par domaine fonctionnel : `login`, `Users`, `type_vehicule`, `moti_demande`, `Demande`, `Courses`.
- Chaque fichier contient une fonction HTTP dédiée.

### `lib/pages/`
- Contient les écrans Flutter et les widgets de navigation.
- `authVerifi.dart` : vérifie le token et redirige vers `Homepage` ou `Login`.
- `login/login.dart` : écran de connexion.
- `homePage.dart` : écran principal de l'application.
- `pages/Demande/` et `pages/Courses/` : écrans métiers.

### `lib/theme/theme.dart`
- Définition du thème clair/sombre de l'application.

## Backend Laravel

- Le backend est situé dans `C:\xampp\htdocs\Laravel\parcauto_backend`.
- Il utilise une base de données MySQL nommée `parcautomobilepac`.
- Les routes API sont définies dans `routes/api.php`.
- L'API expose des endpoints pour l'authentification, les utilisateurs, les véhicules, les demandes et les statistiques.

## Connexion entre Flutter et Laravel

- L'application Flutter envoie des requêtes HTTP à Laravel.
- Laravel gère l'authentification, les accès à la base de données et retourne les réponses JSON.
- Flutter ne se connecte jamais directement à MySQL, il passe toujours par l'API.
