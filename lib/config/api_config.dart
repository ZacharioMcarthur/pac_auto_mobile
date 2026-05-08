import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  // Adresses locales
  static const String _baseUrlLocal = 'http://127.0.0.1:8000/api';
  static const String _baseUrlEmulator = 'http://10.0.2.2:8000/api';
  static const String _baseUrlWifi = 'http://10.35.101.88:8000/api';

  // --- CONFIGURATION ACTIVE ---
  static const bool isWeb = true; 
  static const bool isEmulator = false;

  // Utilisation du mot-clé "tuka" pour basculer vers la production si besoin
  static String get baseUrl {
    if (isWeb) return _baseUrlLocal;
    return isEmulator ? _baseUrlEmulator : _baseUrlWifi;
  }

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

  // --- ROUTES (Retrait des "/" initiaux pour éviter les doubles slashes) ---
  // Authentification & Profil
  static const String loginRoute = 'login';
  static const String logoutRoute = 'logout';
  static const String userProfileRoute = 'auth/profile';

  // Utilisateurs
  static const String userAllRoute = 'user/all';
  static const String userByIdRoute = 'user/get'; 

  // Véhicules
  static const String vehiculeListRoute = 'vehicule/list';
  static const String vehiculeTypesRoute = 'vehicule/type';
  static const String vehiculeByIdRoute = 'vehicule/get';
  
  // Demandes de courses
  static const String demandeSaveRoute = 'demande/save';
  static const String demandeListRoute = 'demande/list'; 
  static const String demandeGetRoute = 'demande/get';
  static const String demandeStartRoute = 'demande/start';
  static const String demandeStopRoute = 'demande/close';
  static const String demandeDeleteRoute = 'demande/delete';
  static const String demandeVerifyNoteRoute = 'demande/notation-check';
  static const String demandeEnCoursRoute = 'demande/en-cours';

  // Affectations
  static const String affectationListRoute = 'affectation/list';
  static const String affectationSaveRoute = 'affectation/save';
}y