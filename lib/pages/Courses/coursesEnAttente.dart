import 'package:courses_pac/api/Courses/getCoursesUser.dart';
import 'package:courses_pac/api/Demande/deleteDemande.dart';
import 'package:courses_pac/api/login/getUserProfile.dart';
import 'package:courses_pac/api/moti_demande/getMotifBy.dart';
import 'package:courses_pac/api/type_vehicule/getVehiculeBy.dart';
import 'package:courses_pac/pages/Courses/detailCoursesAttente.dart';
import 'package:courses_pac/pages/Courses/modifierCourses.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/theme.dart';
import '../widgets/listview.dart';

class CoursesEnAttente extends StatefulWidget {
  const CoursesEnAttente({super.key});

  @override
  State<CoursesEnAttente> createState() => _CoursesEnAttenteState();
}

class _CoursesEnAttenteState extends State<CoursesEnAttente> {
  Map<String, dynamic>? userProfileData;
  int? userId = 0;
  String? userName = "";
  List<Map<String, dynamic>>? demande = [];

  Future<void> getCourses() async {
    final data = await getUserProfile();
    if (data != null && mounted) {
      setState(() {
        userProfileData = data;
        userId = userProfileData?['id'];
        userName = userProfileData?['name'];
      });
    }

    print("Appel de getCourses avec userId : ${userProfileData?['id']}");

    final datas = await getCoursesUsers(userId!);
    if (datas != null && mounted) {
      List<Map<String, dynamic>> tempDemande = [];

      for (var item in datas) {
        try {
          // Filtrer uniquement les demandes avec le statut "en attente"
        if (item['status'] == 'En Attente') {
          // Appels asynchrones pour récupérer les libellés
          String? motif = await getMotifBy(item['motif_id']);
          String? vehicule = await getVehiculeBy(item['typeVehicule_id']);

          print("Motif reçu pour motif_id ${item['motif_id']}: $motif");
          print(
              "Véhicule reçu pour typeVehicule_id ${item['typeVehicule_id']}: $vehicule");

          setState(() {
            // Ajoute les libellés directement dans l'item
            item['motifLibelle'] = motif ?? 'Motif inconnu';
            item['vehiculeLibelle'] = vehicule ?? 'Véhicule inconnu';

            tempDemande.add(item);
          });
        }
        } catch (e) {
          print("Erreur lors de la récupération des données : $e");
        }
      }

      setState(() {
        demande = tempDemande.toSet().toList(); // Élimination des doublons
      });
    }

    print("demande $demande");
  }

  @override
  void initState() {
    getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    // var fontTitle = screenWidth * 0.06;
    var fontbody = screenWidth * 0.04;
    var iconSize = screenWidth * 0.04;
    var spaceHeight = screenHeight * 0.02;
    var spaceWidth = screenWidth * 0.02;
    // Vérification de l'état de `demande`
    if (demande!.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: lightColorScheme.primary,
        ),
      );
    }

    if (demande == null) {
      return Center(
        child: Text(
          "Aucune donnée disponible",
          style: TextStyle(fontSize: 18, color: lightColorScheme.onBackground),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: CustomListViewBuilder(
            items: demande!,
            itemBuilder: (BuildContext context, int index) {
              var currentIndex = demande![index];
              // Ta date au format ISO 8601
              String dateDString = currentIndex['dateDepart']!;
              String dateAString = currentIndex['dateArriver']!;
              String timeDString = currentIndex['HeureDepart']!;
              String timeAString = currentIndex['HeureArriver']!;
              // Convertir la chaîne en objet DateTime
              DateTime dateTimeD = DateTime.parse(dateDString);
              DateTime dateTimeA = DateTime.parse(dateAString);
              DateTime timeD = DateFormat("HH:mm:ss").parse(timeDString);
              DateTime timeA = DateFormat("HH:mm:ss").parse(timeAString);

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                color: Colors.white,
                shadowColor: Colors.black,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DetailCoursesAttente(
                        idDemande: currentIndex['id'],
                        name: userName!,
                        motif: currentIndex['motifLibelle'],
                        depart: dateTimeD,
                        arriver: dateTimeA,
                        timeA: currentIndex['HeureArriver']!,
                        timeD: currentIndex['HeureDepart']!,
                        lieuA: currentIndex['lieuArriver']!,
                        lieuD: currentIndex['lieuDepart']!,
                        statut: currentIndex['status']!,
                        vehicule: currentIndex['vehiculeLibelle'],
                      );
                    }));
                  },
                  title: Text(
                    currentIndex['motifLibelle']
                        .replaceAll(RegExp(r'[()\[\],]'), ''),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: lightColorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.043,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lieu de Départ : ${currentIndex['lieuDepart']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        'Lieu d\'Arriver : ${currentIndex['lieuArriver']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        '${currentIndex['status']}',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: lightColorScheme.secondary),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    color: lightColorScheme.onPrimary,
                    onSelected: (value) {
                      if (value == 'Modifier') {
                        // Handle view action
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext content) {
                          return ModifierCourses(
                            idDemande: currentIndex['id'],
                            motif: currentIndex['motifLibelle'],
                            depart: dateTimeD,
                            arriver: dateTimeA,
                            lieuA: currentIndex['lieuArriver']!,
                            lieuD: currentIndex['lieuDepart']!,
                            vehicule: currentIndex['vehiculeLibelle'], 
                            time: timeD, 
                            timeR: timeD,
                          );
                        }));
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          value: 'Modifier',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_document,
                                color: lightColorScheme.primary,
                              ),
                              SizedBox(width: spaceWidth),
                              Text(
                                'Modifier',
                              ),
                            ],
                          ),
                        ),
                       
                      ];
                    },
                    icon: Icon(Icons.more_vert),
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
