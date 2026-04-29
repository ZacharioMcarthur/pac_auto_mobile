import 'package:courses_pac/api/Courses/getCoursesUser.dart';
import 'package:courses_pac/api/Users/getUsersById.dart';
import 'package:courses_pac/api/login/getUserProfile.dart';
import 'package:courses_pac/api/moti_demande/getMotifBy.dart';
import 'package:courses_pac/api/type_vehicule/getVehiculeBy.dart';
import 'package:courses_pac/pages/Courses/detailCourses.dart';
import 'package:courses_pac/pages/widgets/Dropdown.dart';
import 'package:intl/intl.dart';
import 'package:courses_pac/pages/widgets/listview.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';

class CoursesEnCours extends StatefulWidget {
  const CoursesEnCours({super.key});

  @override
  State<CoursesEnCours> createState() => _CoursesEnCoursState();
}

class _CoursesEnCoursState extends State<CoursesEnCours> {
  final _filtre = GlobalKey<FormFieldState<String>>();
  final TextEditingController _filtreController = TextEditingController();
  String? _selectedFiltre;

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
          // Filtre des demandes 
          if(item['status'] == 'En cours' || item['status'] == 'Terminer' || item['status'] == 'Valider'){
            // Appels asynchrones pour récupérer les libellés
          String? motif = await getMotifBy(item['motif_id']);
          String? vehicule = await getVehiculeBy(item['typeVehicule_id']);

          print("Motif reçu pour motif_id ${item['motif_id']}: $motif");
          print(
              "Véhicule reçu pour typeVehicule_id ${item['typeVehicule_id']}: $vehicule");
          if (item['user_id_demande'] != null) {
            final int userId =
                int.tryParse(item['user_id_demande'].toString()) ?? 0;
            if (userId > 0) {
              final user = await getUserById(userId);
              print('User demande pour autre : $user');
              if (user != null) {
                setState(() {
                  userName = user[0][
                      'name']; // user est déjà une chaîne, pas besoin de déstructurer
                });
              }
            } else {
              print(
                  "Impossible de convertir l'ID utilisateur en entier : ${item['user_id_demande']}");
            }
          }
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

  List<Map<String, dynamic>> getFilteredDemands() {
    if (_selectedFiltre == null || _selectedFiltre == 'Toutes') {
      return demande!;
    }

    return demande!.where((d) {
      switch (_selectedFiltre) {
        case 'En cours':
          return d['status'] == 'En cours';
        case 'Terminés':
          return d['status'] == 'Terminer';
        case 'Validés':
          return d['status'] == 'Valider';
        default:
          return true;
      }
    }).toList();
  }

  void cc() {
    print('les demande filtré : ${getFilteredDemands()}');
  }

  @override
  void initState() {
    super.initState();
    getCourses(); // Appel de getCourses dans initState pour ne pas appeler en boucle
    cc();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeigth = screenSize.height;
    var fontbody = screenWidth * 0.04;
    var iconSize = screenWidth * 0.04;
    var spaceWidth = screenWidth * 0.02;

    // Vérification de l'état de `demande`
    if (demande!.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: lightColorScheme.primary,
        ),
      );
    }

    // Vérifiez si la liste filtrée est vide
    List<Map<String, dynamic>> filteredDemands = getFilteredDemands();
    // bool isEmpty = false;
    // if (filteredDemands.isEmpty) {
    //   return Center(
    //     child: Text(
    //       "Aucune course trouvée",
    //       style: TextStyle(
    //         fontSize: 18,
    //         color: lightColorScheme.onSurface,
    //       ),
    //     ),
    //   );
    // }

    if (demande == null) {
      return Center(
        child: Text(
          "Aucune donnée disponible",
          style: TextStyle(fontSize: 18, color: lightColorScheme.onBackground),
        ),
      );
    }

    // Si `demande` contient des données
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                "Filtre",
                style: TextStyle(
                  fontSize: fontbody,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: CustomDropdownButton2(
                hint: '',
                value: _selectedFiltre ?? 'Toutes',
                dropdownItems: const ['Toutes','En cours', 'Terminés', 'Validés'],
                onChanged: (value) {
                  setState(() {
                    _selectedFiltre = value;
                  });
                },
                aKey: _filtre,
              ),
            )
          ],
        ),
        Expanded(
          child: filteredDemands.isEmpty
            ? Center(
                child: Text(
                  "Aucune course trouvée",
                  style: TextStyle(
                    fontSize: fontbody,
                    color: lightColorScheme.onSurface,
                  ),
                ),
              )
            :CustomListViewBuilder(
            items: filteredDemands,
            itemBuilder: (BuildContext context, int index) {
              var currentIndex = filteredDemands[index];
              // Ta date au format ISO 8601
              String dateDString = currentIndex['dateDepart']!;
              String dateAString = currentIndex['dateArriver']!;
              // String timeDString = currentIndex['HeureDepart']!;
              // String timeAString = currentIndex['HeureArriver']!;
              // Convertir la chaîne en objet DateTime
              DateTime dateTimeD = DateTime.parse(dateDString);
              DateTime dateTimeA = DateTime.parse(dateAString);
              // DateTime timeD = DateFormat("HH:mm:ss").parse(timeDString);
              // DateTime timeA = DateFormat("HH:mm:ss").parse(timeAString);

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
                      return detailCourses(
                        id: currentIndex['id'],
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
                    currentIndex['motifLibelle'],
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
                        height: screenHeigth * 0.01,
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
                        height: screenHeigth * 0.01,
                      ),
                      Text(
                        currentIndex['status']!,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: lightColorScheme.secondary),
                      ),
                    ],
                  ),
                  trailing: const Text(''),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
// Demarré en Cours, Cloturé