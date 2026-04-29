import 'package:courses_pac/api/Demande/deleteDemande.dart';
import 'package:courses_pac/pages/Courses/modifierCourses.dart';
import 'package:courses_pac/pages/widgets/button.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailCoursesAttente extends StatefulWidget {
  final int idDemande;
  final String motif;
  final String name;
  final DateTime depart;
  final DateTime arriver;
  final String timeA;
  final String timeD;
  final String lieuA;
  final String lieuD;
  final String statut;
  final String vehicule;

  const DetailCoursesAttente(
      {super.key,
      required this.motif,
      required this.depart,
      required this.arriver,
      required this.lieuA,
      required this.lieuD,
      required this.statut,
      required this.vehicule,
      required this.name,
      required this.idDemande, required this.timeA, required this.timeD});

  @override
  State<DetailCoursesAttente> createState() => _DetailCoursesAttenteState();
}

class _DetailCoursesAttenteState extends State<DetailCoursesAttente> {
  final DateFormat _format =
      DateFormat("yyyy-MM-dd HH:mm"); //Format date valide
  @override
  Widget build(BuildContext context) {
    // Récupérer la longueur et largeur de l'ecran
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    DateTime timeD = DateFormat('HH:mm').parse(widget.timeD);
    DateTime timeA = DateFormat('HH:mm').parse(widget.timeA);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.motif.replaceAll(RegExp(r'[()\[\],]'), ''),
          style: TextStyle(color: lightColorScheme.onSecondary),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: lightColorScheme.primary,
      ),
      backgroundColor: lightColorScheme.primary,
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: lightColorScheme.onSecondary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nom :",
                          style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lieu de Départ :",
                          style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Text(
                          widget.lieuD,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lieu d'Arrivée :",
                          style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Text(
                          widget.lieuA,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Véhicule :",
                          style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Text(
                          widget.vehicule.replaceAll(RegExp(r'[()\[\],]'), ''),
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "D/H départ :",
                          style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          '${DateFormat("dd/MM/yyyy").format(widget.depart)} | ${DateFormat("hh:mm").format(timeD)}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "D/H retour :",
                          style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          '${DateFormat("dd/MM/yyyy").format(widget.arriver)} | ${DateFormat("hh:mm").format(timeA)}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Statut :",
                          style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Text(
                          widget.statut,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: CustomElevatedButton(
                        text: 'Modifier',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext content) {
                            return ModifierCourses(
                              idDemande: widget.idDemande,
                              motif: widget.motif,
                              depart: widget.depart,
                              arriver: widget.arriver,
                              lieuA: widget.lieuA,
                              lieuD: widget.lieuD,
                              vehicule: widget.vehicule, 
                              time: timeD, 
                              timeR: timeA,
                            );
                          }));
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
