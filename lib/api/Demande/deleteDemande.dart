import 'dart:convert';
import 'package:courses_pac/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // HTTP package

// Function to get user profile
Future<bool> delectDemande(int demandeId) async {
  final url = Uri.parse('${ApiConfig.baseUrl}/demande/delete/$demandeId');

  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("No token found, please log in.");
      return false;
    }

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      }
    );

   if (response.statusCode == 200) {
      print("Demande supprimée avec succès.");
      return true; // Succès
    } else {
      print("Échec de la suppression. Code: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Erreur lors de la suppression : $e");
    return false;
  }
}
