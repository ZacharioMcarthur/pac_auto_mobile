import 'dart:convert';
import 'package:courses_pac/config/api_config.dart';
import 'package:http/http.dart' as http; // HTTP package
import 'package:shared_preferences/shared_preferences.dart';

// Function to get user profile
Future<Map<String, dynamic>?> getUserProfile() async {
  final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.userProfileRoute}');

  try {
    final headers = await ApiConfig.getAuthHeaders();

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("User Profile: ${jsonResponse['data']}");
      // Retourner les données du profil utilisateur
      return jsonResponse['data'];
      // //  Après vérification, retourner à la page d'accueil
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomePage()), // HomePage est la page d'accueil
      //   );
    } else {
      print("Failed to get profile. Status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Error getting profile: $e");
    return null;
  }
}
