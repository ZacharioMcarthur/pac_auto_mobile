import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static const String _baseUrlLocal = 'http://127.0.0.1:8000/api/';
  static const String _baseUrlEmulator = 'http://10.0.2.2:8000/api/';
  static const String _baseUrlWifi = 'http://10.35.101.88:8000/api/';

  static const bool isEmulator = true;
  static const String defaultRole = 'AGENT';

  static String get baseUrl {
    if (kIsWeb) return _baseUrlLocal;
    if (!kIsWeb && Platform.isAndroid) {
      return isEmulator ? _baseUrlEmulator : _baseUrlWifi;
    }
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
      return _baseUrlLocal;
    }
    return _baseUrlWifi;
  }

  static String url(String route) =>
      '$baseUrl${route.startsWith('/') ? route.substring(1) : route}';

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

  static Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  static Future<String> getCurrentUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role') ?? defaultRole;
  }

  static Future<void> saveUserSession({
    required int userId,
    String? role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
    if (role != null) {
      await prefs.setString('user_role', role);
    }
  }

  static const String loginRoute = 'login';
  static const String logoutRoute = 'logout';
  static const String userProfileRoute = 'auth/profile';

  static const String userAllRoute = 'user/all';
  static const String userByIdRoute = 'user/get';
  static const String userChangePasswordRoute = 'user/changePassword';

  static const String vehiculeListRoute = 'vehicule/list';
  static const String vehiculeTypesRoute = 'vehicule/type';
  static const String vehiculeByIdRoute = 'vehicule/get';

  static const String motifListRoute = 'motif/list';
  static const String motifByIdRoute = 'motif';

  static const String demandeSaveRoute = 'demande/save';
  static const String demandePourMoiRoute = 'demande/pourmoi';
  static const String demandeListRoute = 'demande/list';
  static const String demandeGetRoute = 'demande/get';
  static const String demandeStartRoute = 'demande/start';
  static const String demandeStopRoute = 'demande/close';
  static const String demandeDeleteRoute = 'demande/delete';
  static const String demandeVerifyNoteRoute = 'demande/notation-check';
  static const String demandeEnCoursRoute = 'demande/en-cours';
  static const String demandeEditRoute = 'demande/edit';

  static const String affectationListRoute = 'affectation/list';
  static const String affectationSaveRoute = 'affectation/save';
}
