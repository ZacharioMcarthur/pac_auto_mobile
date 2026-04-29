import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  // --- CONFIGURATION DES ADRESSES ---
  
  // IP de l'émulateur Android par défaut
  static const String _baseUrlEmulator = 'http://10.0.2.2:8000/api';
  
  // IP de ton PC sur le réseau WiFi (à mettre à jour via ipconfig)
  static const String _baseUrlWifi = 'http://10.35.101.88:8000/api';

  // Mets à 'true' si tu travailles sur l'émulateur, 'false' pour ton téléphone physique
  static const bool isEmulator = false;

  // --- GETTERS DYNAMIQUES ---

  static String get baseUrl => isEmulator ? _baseUrlEmulator : _baseUrlWifi;

  // Headers de base (sans authentification)
  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  /// Récupère les headers complets avec le Token Bearer si disponible
  static Future<Map<String, String>> getAuthHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    return {
      ...headers,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // --- ROUTES API (Centralisation pour éviter les erreurs de frappe) ---

  static const String loginRoute = '/login';
  static const String userProfileRoute = '/auth/profile';
  static const String vehiculeListRoute = '/vehicule/list';
  static const String chauffeurListRoute = '/chauffeur/list';
  static const String demandeAddRoute = '/demande/create';
}