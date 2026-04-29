# Parc-Auto PAC

## Description

Cette application Flutter permet au personnel du PAC de créer et suivre des demandes de course directement depuis leur téléphone.
L'application communique avec une API Laravel qui gère les utilisateurs, les demandes, les véhicules, les motifs et les notifications.

## Fonctionnalités principales

- Authentification par email et mot de passe
- Création de demandes de course pour soi-même ou pour un autre utilisateur
- Consultation des demandes en attente, en cours et terminées
- Modification des demandes en attente
- Gestion du profil utilisateur et du token d'authentification

## Architecture

- `lib/` : code Flutter
- `lib/api/` : appels HTTP vers l'API Laravel
- `lib/config/api_config.dart` : configuration de l'URL de l'API
- `C:\xampp\htdocs\Laravel\parcauto_backend` : backend Laravel connecté à MySQL

## Prérequis

- Flutter SDK
- Android Studio + plugins Flutter et Dart
- XAMPP avec MySQL et Apache démarrés
- Backend Laravel installé dans `C:\xampp\htdocs\Laravel\parcauto_backend`

## Configuration de l'API Laravel

1. Ouvrez le fichier `C:\xampp\htdocs\Laravel\parcauto_backend\.env`
2. Vérifiez les paramètres de base de données :

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=parcautomobilepac
DB_USERNAME=root
DB_PASSWORD=
```

3. Démarrez Laravel :

```powershell
cd C:\xampp\htdocs\Laravel\parcauto_backend
php artisan serve --host=0.0.0.0 --port=8000
```

## Configuration du client Flutter

Le client Flutter appelle l'API via `lib/config/api_config.dart`.

- `baseUrlEmulator` : utilisé pour l'émulateur Android (`10.0.2.2:8000`)
- `baseUrlWifi` : utilisé pour un téléphone physique sur le même Wi-Fi
- `isEmulator` : passe à `true` pour l'émulateur ou `false` pour un téléphone réel

### Exemple `api_config.dart`

```dart
static const bool isEmulator = false;
static const String _baseUrlWifi = 'http://10.35.101.88:8000/api';
```

## Lancer l'application Flutter

1. Récupérez les dépendances :

```powershell
flutter pub get
```

2. Vérifiez la configuration Flutter :

```powershell
flutter doctor
```

### Avec un émulateur Android

- Activez `isEmulator = true` dans `lib/config/api_config.dart`
- Lancez :

```powershell
flutter run
```

### Avec un téléphone physique en Wi-Fi

- Assurez-vous que le PC et le téléphone sont sur le même réseau Wi-Fi
- Activez le débogage Wi-Fi sur le téléphone
- Connectez le téléphone avec ADB via Wi-Fi :

```powershell
adb pair 10.35.101.190:37123
adb connect 10.35.101.190:41055
```

- Vérifiez l'appareil :

```powershell
flutter devices
```

- Lancez l'application :

```powershell
flutter run
```

## Création d'un APK

Pour générer un APK à installer manuellement :

```powershell
flutter build apk --release
```

Le fichier se trouve ensuite dans :

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Remarques

- Les tokens sont stockés localement dans `SharedPreferences` sous la clé `token`
- Assurez-vous que le backend Laravel est démarré avant d'exécuter l'application Flutter
- Si votre API ne répond pas, vérifiez l'URL dans `lib/config/api_config.dart`

## Auteur

- Initié par : [HOUENOUKPO Ulrich](https://github.com/hnk229) en 2024

- Mise à jour et développement: [NASCIMENTO Zachario](https://github.com/ZacharioMcarthur) en 2026
