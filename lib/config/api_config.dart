import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static const String _baseUrlEmulator = 'http://10.0.2.2:8000/api';
  static const String _baseUrlWifi = 'http://10.35.101.88:8000/api';

  static const bool isEmulator = false;

  static String get baseUrl => isEmulator ? _baseUrlEmulator : _baseUrlWifi;

  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  static Future<Map<String, String>> getAuthHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    return {
      ...headers,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // --- Authentification & Profil ---
  static const String loginRoute = '/login'; // OK
  static const String logoutRoute = '/logout'; // Corrigé (pas de préfixe auth dans ton api.php)
  static const String userProfileRoute = '/auth/profile'; // Corrigé selon ton api.php

  // --- Utilisateurs (préfixe 'user') ---
  static const String userAllRoute = '/user/all';
  static const String userByIdRoute = '/user/get'; // Utilisation: /user/get/{id}

  // --- Véhicules (préfixe 'vehicule') ---
  static const String vehiculeListRoute = '/vehicule/list';
  static const String vehiculeTypesRoute = '/vehicule/type';
  static const String vehiculeByIdRoute = '/vehicule/get';
  
  // --- Demandes de courses (préfixe 'demande') ---
  static const String demandeSaveRoute = '/demande/save';
  static const String demandeListRoute = '/demande/list'; // Utilisation : /demande/list/5/chauffeur
  static const String demandeGetRoute = '/demande/get';
  static const String demandeStartRoute = '/demande/start';
  static const String demandeStopRoute = '/demande/close';
  static const String demandeDeleteRoute = '/demande/delete';
  static const String demandeVerifyNoteRoute = '/demande/notation-check';
  static const String demandeEnCoursRoute = '/demande/en-cours';

  // --- Affectations (préfixe 'affectation') ---
  static const String affectationListRoute = '/affectation/list';
  static const String affectationSaveRoute = '/affectation/save';

  // Note : Les routes /getMotifs et /chauffeur/list n'apparaissent pas dans ton api.php.
  // Vérifie si elles sont dans un autre fichier ou si elles manquent.
}