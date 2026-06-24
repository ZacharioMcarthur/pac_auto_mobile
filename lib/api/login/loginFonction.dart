import 'dart:convert';

import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/pages/homePage.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String email, String password, BuildContext context) async {
  final url = Uri.parse(ApiConfig.url(ApiConfig.loginRoute));

  try {
    final response = await http
        .post(
          url,
          headers: ApiConfig.headers,
          body: jsonEncode(<String, dynamic>{
            'email': email,
            'password': password,
          }),
        )
        .timeout(const Duration(seconds: 15));

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      final token = jsonResponse['data']?['access_token'];
      final user = jsonResponse['data']?['user'];

      if (token != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        if (user != null && user['id'] != null) {
          final role = user['role']?['libelle']?.toString();
          await ApiConfig.saveUserSession(
            userId: user['id'] as int,
            role: role,
          );
        }

        if (!context.mounted) return true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
        return true;
      }

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
  } catch (e) {
    if (!context.mounted) return false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Erreur de connexion",
          message:
              "Impossible de contacter le serveur. Vérifiez que le backend Laravel tourne (php artisan serve --host=0.0.0.0 --port=8000) et votre connexion réseau.",
          onConfirm: () => Navigator.of(context).pop(),
        );
      },
    );
    return false;
  }
}
