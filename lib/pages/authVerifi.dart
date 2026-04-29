import 'package:courses_pac/api/login/getUserProfile.dart';
import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/pages/homePage.dart';
import 'package:courses_pac/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  // bool _isLoggedIn = false;
  // bool _isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    getUserProfile();
    super.initState();
    getProfile();
    // checkLoginStatus();  // Vérifier le statut de connexion au démarrage
  }

  Map<String, dynamic>? userProfileData;

  // Function to get user profile
  Future<bool> getProfile() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/profile');

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        print("Aucun token trouvé, redirection vers la page de connexion.");
        return false;
      }

      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("User Profile: ${jsonResponse['data']}");
        userProfileData = jsonResponse['data'];
        print(" les données ${userProfileData}");
        // Mettre à jour l'état pour indiquer que l'utilisateur est connecté
        // setState(() {
        //   _isLoggedIn = true;
        //   _isLoading = false; // Indicateur de chargement
        // });
        // Après vérification, retourner à la page d'accueil
// Rediriger vers la page d'accueil après vérification du profil
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const Homepage()), // Page d'accueil
        // );
        return true;
      } else {
        print(
            "Échec de la récupération du profil. Code de statut : ${response.statusCode}");
        // setState(() {
        //   _isLoggedIn = false;
        //   _isLoading = false;
        // });
        return false;
      }
    } catch (e) {
      print("Erreur lors de la récupération du profil: $e");
      // setState(() {
      //   _isLoggedIn = false;
      //   _isLoading = false;
      // });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
// Afficher un indicateur de chargement pendant la vérification du token
    // if (_isLoading) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    // return _isLoggedIn ? const Homepage() : const Login();

    return FutureBuilder<bool>(
      future: getProfile(),
      builder: (context, snapshot) {
        // Si les données ne sont pas encore prêtes, montrer un indicateur de chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si la vérification est terminée
        if (snapshot.hasData) {
          // Rediriger vers la page d'accueil si l'utilisateur est connecté
          if (snapshot.data == true) {
            return const Homepage();
          } else {
            // Rediriger vers la page de connexion sinon
            return const Login();
          }
        }

        // En cas d'erreur de chargement, afficher une page par défaut
        return const Scaffold(
          body: Center(child: Text("Erreur de connexion")),
        );
      },
    );
  }
}
