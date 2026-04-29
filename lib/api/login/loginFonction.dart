import 'dart:convert'; // For JSON encoding/decoding
import 'package:courses_pac/pages/homePage.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:courses_pac/config/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP package
import 'package:shared_preferences/shared_preferences.dart'; // For storing token

// Function for user login
Future<void> login(String email, String password, BuildContext context) async {
  final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.loginRoute}');
  try {
    final response = await http.post(
      url,
      headers: ApiConfig.headers,
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['access_token'];

      if (token != null) {
        // Store token if it exists
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        // Redirection après la connexion réussie
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()), // Rediriger vers la page d'accueil
        );
        print("Login successful! Token: $token");
      } else {
        // Handle case where token is null
        print("Token not found in the response.");
      }

      print("Login successful! Token: $token}");
    } else {
      final jsonResponse = json.decode(response.body);
      print("Failed to login. Status code: ${response.statusCode}");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Erreur",
            message: jsonResponse['message'],
            onConfirm: () {
              // Action à exécuter lorsqu'on confirme
              Navigator.of(context).pop(); // Fermer le dialogue
            },
          );
        },
      );
    }
  } catch (e) {
    print("Error logging in: $e");
  }
}
