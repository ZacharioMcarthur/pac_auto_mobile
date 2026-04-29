import 'dart:convert'; // For JSON encoding/decoding
import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // HTTP package

Future<void> InsertDemandePourMoi(
    String lieuDepart,
    String lieuArriver,
    String dateDepart,
    String dateArriver,
    String heureDepart,
    String heureArriver,
    int userId,
    int? userIdDemande,
    int typevehiculeId,
    int motifId,
    BuildContext context) async {
  final url = Uri.parse('${ApiConfig.baseUrl}/demande/pourmoi');
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("No token found, please log in.");
      return;
    }
    String status = "En Attente";
    // Formatage des dates selon le format requis
    // String dateD = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateHeureDepart);
    // String dateA = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateHeureArriver);
    print("Les entrées : $userIdDemande, $lieuDepart, $lieuArriver, $dateDepart, $dateArriver, $heureDepart, $heureArriver, $userId, $typevehiculeId, $motifId");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Assurez-vous d'inclure ce header
      },
      body: jsonEncode(<String, dynamic>{
        'lieuDepart': lieuDepart, // Vérifiez les noms des champs
        'lieuArriver': lieuArriver,
        'dateDepart': dateDepart,
        'dateArriver': dateArriver,
        'HeureDepart' :  heureDepart,
        'HeureArriver' : heureArriver,
        'status' : status,
        'user_id': userId,
        'user_id_demande': userIdDemande,
        'typeVehicule_id': typevehiculeId,
        'motif_id': motifId,
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
