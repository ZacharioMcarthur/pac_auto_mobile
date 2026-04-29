import 'package:courses_pac/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(BuildContext context) async {
    // Supprimer les informations de session (par exemple, le jeton d'authentification)

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('authToken'); // Supprimer le jeton
  await prefs.clear();

  // Rediriger vers la page de connexion et enlever toutes les autres pages de la pile
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
    (Route<dynamic> route) => false,  // Supprime toutes les routes précédentes
  );
}
