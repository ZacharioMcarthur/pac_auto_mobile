import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:courses_pac/services/api_service.dart';
import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/pages/Courses/detailCoursesAttente.dart';
import 'package:courses_pac/pages/Courses/modifierCourses.dart';
import 'package:courses_pac/pages/widgets/listview.dart';
import 'package:courses_pac/theme/theme.dart';

class CoursesEnAttente extends StatefulWidget {
  const CoursesEnAttente({super.key});

  @override
  State<CoursesEnAttente> createState() => _CoursesEnAttenteState();
}

class _CoursesEnAttenteState extends State<CoursesEnAttente> {
  List<dynamic> demande = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  Future<void> getCourses() async {
    try {
      final response = await ApiService.get("${ApiConfig.demandeListRoute}/5/chauffeur");

      if (response.statusCode == 200) {
        final List<dynamic> allData = jsonDecode(response.body)['data'];
        
        if (mounted) {
          setState(() {
            // Filtrer uniquement pour le statut "En Attente"
            demande = allData.where((item) => item['status'] == 'En Attente').toList();
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
      print("Erreur chargement CoursesEnAttente: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: lightColorScheme.primary));
    }

    return Column(
      children: [
        Expanded(
          child: demande.isEmpty
            ? const Center(child: Text("Aucune demande en attente"))
            : CustomListViewBuilder(
                items: demande,
                itemBuilder: (context, index) {
                  final item = demande[index];
                  final dateD = DateTime.parse(item['dateDepart']);
                  final dateA = DateTime.parse(item['dateArriver']);

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => DetailCoursesAttente(
                          idDemande: item['id'],
                          name: "Utilisateur",
                          motif: item['motifLibelle'] ?? 'Motif',
                          depart: dateD,
                          arriver: dateA,
                          timeA: item['HeureArriver'],
                          timeD: item['HeureDepart'],
                          lieuA: item['lieuArriver'],
                          lieuD: item['lieuDepart'],
                          statut: item['status'],
                          vehicule: item['vehiculeLibelle'] ?? 'Véhicule',
                        ),
                      )),
                      title: Text(item['motifLibelle'] ?? 'Demande',
                        style: TextStyle(color: lightColorScheme.primary, fontWeight: FontWeight.bold)),
                      subtitle: Text("Lieu: ${item['lieuDepart']} -> ${item['lieuArriver']}"),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Modifier') {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ModifierCourses(
                                idDemande: item['id'],
                                motif: item['motifLibelle'],
                                depart: dateD,
                                arriver: dateA,
                                lieuA: item['lieuArriver'],
                                lieuD: item['lieuDepart'],
                                vehicule: item['vehiculeLibelle'],
                                time: DateFormat("HH:mm:ss").parse(item['HeureDepart']),
                                timeR: DateFormat("HH:mm:ss").parse(item['HeureArriver']),
                              ),
                            ));
                          }
                        },
                        itemBuilder: (_) => [
                          const PopupMenuItem(value: 'Modifier', child: Text("Modifier")),
                        ],
                      ),
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}