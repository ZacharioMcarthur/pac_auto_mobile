import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginStatus(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('authToken', token); // Sauvegarde du jeton
}