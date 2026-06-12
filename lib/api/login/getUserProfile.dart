import 'dart:convert';
import 'package:courses_pac/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>?> getUserProfile() async {
  final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.userProfileRoute}');

  try {
    final headers = await ApiConfig.getAuthHeaders();
    
    // Vérification si le token existe avant d'envoyer
    if (!headers.containsKey('Authorization')) {
      print("Erreur : Aucun token trouvé dans les préférences.");
      return null;
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final userData = jsonResponse['data'] as Map<String, dynamic>?;
      
      // Sauvegarder les données utilisateur dans SharedPreferences
      if (userData != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', userData['id'] ?? 0);
        await prefs.setString('user_role', userData['role']?['libelle'] ?? 'user');
        await prefs.setString('user_name', userData['nom'] ?? '');
        await prefs.setString('user_prenom', userData['prenom'] ?? '');
      }
      
      print("Profil récupéré avec succès.");
      return userData;
    } else {
      print("Échec profil. Code: ${response.statusCode}, Message: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Erreur lors de la récupération du profil : $e");
    return null;
  }
}