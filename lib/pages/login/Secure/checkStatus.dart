import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');  // Récupérer le jeton
  return token != null;  // Si le jeton existe, l'utilisateur est connecté
}
