import 'dart:convert';
import 'package:courses_pac/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // HTTP package

// Function to get user profile
Future<List<dynamic>?> getAllUsers() async {
  final url = Uri.parse('${ApiConfig.baseUrl}/users/list');

  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("No token found, please log in.");
      return null;
    }

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("liste des Users: ${jsonResponse['data']}");
      // Retourner les données dans la table motif-demande
      return jsonResponse['data'];
    } else {
      print("Failed to get profile. Status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Erreur lors de la lecture des Users : $e");
    return null;
  }
}
