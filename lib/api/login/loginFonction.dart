import 'dart:convert';
import 'package:courses_pac/pages/homePage.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:courses_pac/config/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String email, String password, BuildContext context) async {
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

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      final token = jsonResponse['data']?['access_token'];

      if (token != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        
        print("Login réussi ! Token enregistré.");

        if (!context.mounted) return true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
        return true;
      } else {
        print("Erreur : Token absent dans la clé data. Réponse: ${response.body}");
        if (!context.mounted) return false;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: "Erreur",
              message: "Token absent dans la réponse du serveur",
              onConfirm: () => Navigator.of(context).pop(),
            );
          },
        );
        return false;
      }
    } else {
      print("Échec connexion : ${response.statusCode}");
      if (!context.mounted) return false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Erreur",
            message: jsonResponse['message'] ?? "Identifiants incorrects",
            onConfirm: () => Navigator.of(context).pop(),
          );
        },
      );
      return false;
    }
  } catch (e) {
    print("Erreur réseau lors du login : $e");
    if (!context.mounted) return false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Erreur de connexion",
          message: "Impossible de contacter le serveur. Vérifiez votre connexion internet.",
          onConfirm: () => Navigator.of(context).pop(),
        );
      },
    );
    return false;
  }
}