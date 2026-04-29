import 'package:courses_pac/api/Courses/getCoursesUser.dart';
import 'package:courses_pac/api/login/getUserProfile.dart';
import 'package:courses_pac/api/moti_demande/getMotifBy.dart';
import 'package:courses_pac/api/type_vehicule/getVehiculeBy.dart';
import 'package:flutter/material.dart';
import 'package:courses_pac/pages/Demande/demandeCourses.dart';
import 'package:courses_pac/theme/theme.dart';

class Dashborad extends StatefulWidget {
  const Dashborad({super.key});

  @override
  State<Dashborad> createState() => _DashboradState();
}

class _DashboradState extends State<Dashborad> {
  Map<String, dynamic>? userProfileData;
  int? userId = 0;
  Map<String, dynamic>? demande = {};

  Future<void> getLastDemande() async {
    final data = await getUserProfile();
    if (data != null && mounted) {
      setState(() {
        userProfileData = data;
        userId = userProfileData?['id'];
      });
    }
    final datas = await getCoursesUsers(userId!);
    if (datas != null && mounted) {
      List<Map<String, dynamic>> tempDemande = [];

      for (var item in datas) {
        
          try {
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
        } catch (e) {
          print("Erreur lors de la récupération des données : $e");
      }
      

      setState(() {
        demande = tempDemande.first; // Élimination des doublons
      });
      print("Dernière demande : $demande");
        }
        
    }

    // if (demandes != null && demandes.isNotEmpty) {
    //   // Sélectionner la dernière demande
    //   // final lastDemande =demandes.last; // Suppose que la liste est triée par ordre croissant
    //   setState(() {
    //     demande = demandes.last;
    //   });
    //   print("Dernière demande : $demande");
    // } else {
    //   print("Aucune demande trouvée.");
    // }
  }

  @override
  void initState() {
    getLastDemande();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer la longueur et largeur de l'ecran
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    var fontTitle = screenWidth * 0.05;
    var fontbody = screenWidth * 0.04;
    // Récupérer le thème actuel (clair ou sombre)
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.05,
      ),
      child: Column(
        children: [
          Text(
            "Demandes récentes",
            style: TextStyle(
              fontSize: fontTitle,
              color: lightColorScheme.shadow,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
              color: lightColorScheme.onSecondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Couleur de l'ombre
                  spreadRadius: 5, // Taille de la diffusion
                  blurRadius: 7, // Rayon de flou de l'ombre
                  offset: Offset(
                      0, 3), // Déplacement horizontal et vertical de l'ombre
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: demande!.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: lightColorScheme.primary,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${demande!['motifLibelle']}",
                        style: TextStyle(
                          fontSize: fontbody,
                          color: lightColorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        "Lieu Départ : ${demande!['lieuDepart']}",
                        style: TextStyle(
                          fontSize: fontbody,
                          color: lightColorScheme.shadow,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        "Lieu d'Arrivée : ${demande!['lieuArriver']}",
                        style: TextStyle(
                          fontSize: fontbody,
                          color: lightColorScheme.shadow,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Véhicule : ${demande!['vehiculeLibelle']}",
                            style: TextStyle(
                              fontSize: fontbody,
                              color: lightColorScheme.shadow,
                            ),
                          ),
                          Text(
                            "${demande!['status']}",
                            style: TextStyle(
                              fontSize: fontbody,
                              color: lightColorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(
            "Courses en attente",
            style: TextStyle(
              fontSize: fontTitle,
              color: lightColorScheme.shadow,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
              color: lightColorScheme.onSecondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Couleur de l'ombre
                  spreadRadius: 5, // Taille de la diffusion
                  blurRadius: 7, // Rayon de flou de l'ombre
                  offset: Offset(
                      0, 3), // Déplacement horizontal et vertical de l'ombre
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: demande!.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: lightColorScheme.primary,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${demande!['motifLibelle']}",
                        style: TextStyle(
                          fontSize: fontbody,
                          color: lightColorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        "Lieu Départ : ${demande!['lieuDepart']}",
                        style: TextStyle(
                          fontSize: fontbody,
                          color: lightColorScheme.shadow,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        "Lieu d'Arrivée : ${demande!['lieuArriver']}",
                        style: TextStyle(
                          fontSize: fontbody,
                          color: lightColorScheme.shadow,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Véhicule : ${demande!['vehiculeLibelle']}",
                            style: TextStyle(
                              fontSize: fontbody,
                              color: lightColorScheme.shadow,
                            ),
                          ),
                          Text(
                            "En cours",
                            style: TextStyle(
                              fontSize: fontbody,
                              color: lightColorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    backgroundColor: lightColorScheme.primary,
                    elevation: 10,
                    shape: const StadiumBorder(),
                    textStyle: TextStyle(
                      fontSize: fontbody,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const DemandeCourses();
                  }));
                },
                child: Text(
                  "Faire une demande",
                  style: TextStyle(
                    color: lightColorScheme.onSecondary,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
