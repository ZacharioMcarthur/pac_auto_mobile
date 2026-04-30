import 'package:courses_pac/services/api_service.dart';
import 'package:courses_pac/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static Future<bool> login(String email, String password) async {
    try {
      final response = await ApiService.post(
        ApiConfig.loginRoute,
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['success'] == true) {
          final token = data['data']['access_token'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          
          // Optionnel: stocker les infos utilisateur
          await prefs.setString('user', jsonEncode(data['data']['user']));
          
          print('✅ Connexion réussie');
          return true;
        }
      }
      print('❌ Échec connexion: ${response.body}');
      return false;
    } catch (e) {
      print('❌ Erreur login: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      final response = await ApiService.get(ApiConfig.userProfileRoute);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('❌ Erreur profile: $e');
      return null;
    }
  }

  static Future<bool> logout() async {
    try {
      final response = await ApiService.post(ApiConfig.logoutRoute, body: {});
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
      
      print('✅ Déconnexion réussie');
      return true;
    } catch (e) {
      print('❌ Erreur logout: $e');
      return false;
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
