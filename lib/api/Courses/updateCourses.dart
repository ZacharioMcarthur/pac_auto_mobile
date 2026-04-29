import 'dart:convert'; // For JSON encoding/decoding
import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // HTTP package

Future<void> UpdateCourses(
    String dateHeureArriver,
    String dateHeureDepart,
    String HeureArriver,
    String HeureDepart,
    String lieuDepart,
    String lieuArriver,
    int idVehicule,
    int idMotif,
    int demandeId,
    BuildContext context) async {
  final url = Uri.parse('${ApiConfig.baseUrl}/demande/update/$demandeId');
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("No token found, please log in.");
      return;
    }

     // Formatage des dates selon le format requis
    // String dateA = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateHeureArriver);
    print(
        "Les entrées : $lieuDepart,$lieuArriver, $dateHeureArriver, $demandeId, $dateHeureDepart");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Assurez-vous d'inclure ce header
      },
      body: jsonEncode(<String, dynamic>{
        'lieuDepart': lieuDepart,
        'lieuArriver': lieuArriver,
        'dateDepart': dateHeureDepart,
        'dateArriver': dateHeureArriver,
        'HeureDepart': HeureDepart,
        'HeureArriver': HeureArriver,
        'typeVehicule_id': idVehicule,
        'motif_id': idMotif,
      }),
    );

    print("Statut de la réponse : ${response.statusCode}");
    print("Corps de la réponse : ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final demandes = jsonResponse['data'];
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
      print("Demande Enregister ! $demandes");
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
    }
  } catch (e) {
    print("Erreur lors de l'envoi : $e");
  }
}
