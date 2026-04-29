import 'dart:convert';
import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Fonction pour changer le mot de passe
Future<bool> changePassword(String currentPassword, 
String newPassword,
BuildContext context
) async {
  final url = Uri.parse('${ApiConfig.baseUrl}/users/changePassword');

  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("No token found, please log in.");
      return false;
    }

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // final password = jsonResponse['data'];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Success",
            confirmText: "Ok",
            message: jsonResponse['message'],
            onConfirm: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
      print("Mot de passe modifié avec succès.");
      return true;
    } else {
      final jsonResponse = json.decode(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Erreur",
            message: jsonResponse['message'] ?? 'Une erreur s\'est produite.',
            confirmText: "Ok",
            onConfirm: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
      print("Échec de la modification du mot de passe. Statut : ${response.statusCode}");
      print("Réponse : ${response.body}");
      return false;
    }
  } catch (e) {
    print("Erreur lors de la modification du mot de passe : $e");
    return false;
  }
}
