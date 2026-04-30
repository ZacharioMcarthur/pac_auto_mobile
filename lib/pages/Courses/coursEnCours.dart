import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:courses_pac/services/api_service.dart';
import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/pages/Courses/detailCourses.dart';
import 'package:courses_pac/pages/widgets/Dropdown.dart';
import 'package:courses_pac/pages/widgets/listview.dart';
import 'package:courses_pac/theme/theme.dart';

class CoursesEnCours extends StatefulWidget {
  const CoursesEnCours({super.key});

  @override
  State<CoursesEnCours> createState() => _CoursesEnCoursState();
}

class _CoursesEnCoursState extends State<CoursesEnCours> {
  final _filtre = GlobalKey<FormFieldState<String>>();
  String? _selectedFiltre;
  List<dynamic> demande = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  /// Récupère la liste de toutes les courses (En cours, Terminées, Validées)
  Future<void> getCourses() async {
    try {
      // Note: Remplacer '5/chauffeur' par les variables réelles de session
      final response = await ApiService.get("${ApiConfig.demandeListRoute}/5/chauffeur");

      if (response.statusCode == 200) {
        final List<dynamic> allData = jsonDecode(response.body)['data'];
        
        if (mounted) {
          setState(() {
            // Filtrer uniquement les statuts de cet onglet
            demande = allData.where((item) => 
              ['En cours', 'Terminer', 'Valider'].contains(item['status'])
            ).toList();
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
      print("Erreur chargement CoursesEnCours: $e");
    }
  }

  List<dynamic> getFilteredDemands() {
    if (_selectedFiltre == null || _selectedFiltre == 'Toutes') return demande;
    
    return demande.where((d) {
      switch (_selectedFiltre) {
        case 'En cours': return d['status'] == 'En cours';
        case 'Terminés': return d['status'] == 'Terminer';
        case 'Validés': return d['status'] == 'Valider';
        default: return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    List<dynamic> filteredDemands = getFilteredDemands();

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: lightColorScheme.primary));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Filtre"),
              SizedBox(
                width: screenWidth * 0.6,
                child: CustomDropdownButton2(
                  hint: 'Toutes',
                  value: _selectedFiltre ?? 'Toutes',
                  dropdownItems: const ['Toutes', 'En cours', 'Terminés', 'Validés'],
                  onChanged: (value) => setState(() => _selectedFiltre = value),
                  aKey: _filtre,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: filteredDemands.isEmpty
            ? const Center(child: Text("Aucune course trouvée"))
            : CustomListViewBuilder(
                items: filteredDemands,
                itemBuilder: (context, index) {
                  final item = filteredDemands[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => detailCourses(
                          id: item['id'],
                          name: "Utilisateur", // À dynamiser
                          motif: item['motifLibelle'] ?? 'Motif',
                          depart: DateTime.parse(item['dateDepart']),
                          arriver: DateTime.parse(item['dateArriver']),
                          timeA: item['HeureArriver'],
                          timeD: item['HeureDepart'],
                          lieuA: item['lieuArriver'],
                          lieuD: item['lieuDepart'],
                          statut: item['status'],
                          vehicule: item['vehiculeLibelle'] ?? 'Véhicule',
                        ),
                      )),
                      title: Text(item['motifLibelle'] ?? 'Sans motif',
                        style: TextStyle(color: lightColorScheme.primary, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("De: ${item['lieuDepart']}"),
                          Text("À: ${item['lieuArriver']}"),
                          Text(item['status'], style: TextStyle(color: lightColorScheme.secondary)),
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