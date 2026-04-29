import 'package:courses_pac/api/Demande/startCourse.dart';
import 'package:courses_pac/api/Demande/terminerCourse.dart';
import 'package:courses_pac/pages/Demande/secure/Validate.dart';
import 'package:courses_pac/pages/widgets/button.dart';
import 'package:courses_pac/pages/widgets/customTime.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class detailCourses extends StatefulWidget {
  final String motif;
  final DateTime depart;
  final DateTime arriver;
  final String timeA;
  final String timeD;
  final int id;
  final String name;
  final String lieuA;
  final String lieuD;
  final String statut;
  final String vehicule;

  const detailCourses({
    super.key,
    required this.motif,
    required this.depart,
    required this.arriver,
    required this.lieuA,
    required this.lieuD,
    required this.statut,
    required this.vehicule,
    required this.name,
    required this.id,
    required this.timeA,
    required this.timeD,
  });

  @override
  State<detailCourses> createState() => _detailCoursesState();
}

class _detailCoursesState extends State<detailCourses> {
  final _dateTime = GlobalKey<FormFieldState<String>>();
  final _formKeyDemandeAutre = GlobalKey<FormState>();
  final TextEditingController _dateTimeController = TextEditingController();
  final DateFormat _format = DateFormat("HH:mm:ss"); //Format date valide
  late String status;
  late String dateArriver = DateFormat("dd/MM/yyyy").format(widget.arriver);
  late DateTime timeD = DateFormat('HH:mm').parse(widget.timeD);
  late DateTime timeA = DateFormat('HH:mm').parse(widget.timeA);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = widget.statut;
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer la longueur et largeur de l'ecran
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;

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
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
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
                              fontSize: screenWidth * 0.04,
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
                              fontSize: screenWidth * 0.04,
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
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Text(
                          widget.vehicule,
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
                              fontSize: screenWidth * 0.04,
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
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          '$dateArriver | ${DateFormat("hh:mm").format(timeA)}',
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
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Text(
                          status,
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
                    Container(
                        child: status == "Valider"
                            ? CustomElevatedButton(
                                text: 'Démarrer',
                                onPressed: () {
                                  setState(() {
                                    status = "En cours";
                                  });
                                  startCourses(widget.id, context);
                                },
                              )
                            : status == "En cours"
                                ? Column(children: [
                                    Form(
                                      key: _formKeyDemandeAutre,
                                      child: CustomTimePicker(
                                          key: _dateTime,
                                          controller: _dateTimeController,
                                          hintText: "Heure Réel retour",
                                          format: _format,
                                          validator: validateDate,
                                          icon: const Icon(Icons.access_time)),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.05,
                                    ),
                                    CustomElevatedButton(
                                      text: 'Terminer la courses',
                                      onPressed: () async{
                                        if (_formKeyDemandeAutre.currentState!
                                            .validate()) {
                                          setState(() {
                                            status = "Terminer";
                                            timeA = DateFormat("hh:mm").parse(
                                                _dateTimeController.text);
                                          });
                                          await TerminerCourses(
                                            _dateTimeController.text,
                                            widget.id,
                                            context
                                          );
                                          // Afficher la boîte de dialogue pour la note
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Notez cette course"),
                                              content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Cliquez sur une icone pour noter :",
                                                  style: TextStyle(
                                                  fontSize: screenWidth * 0.04),
                                                ),
                                                const SizedBox(height: 20),
                                                RatingBar.builder(
                                                  initialRating: 5, // Note initiale
                                                  minRating: 1,
                                                  direction:Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemSize: screenWidth * 0.135,
                                                  itemCount: 5,
                                                  itemBuilder:(context, index) {
                                                  switch (index) {
                                                    case 0:
                                                      return const Icon(
                                                          Icons.sentiment_very_dissatisfied,
                                                          color: Colors.red,
                                                          );
                                                    case 1:
                                                      return const Icon(
                                                        Icons.sentiment_dissatisfied,
                                                        color: Colors.redAccent,
                                                        );
                                                    case 2:
                                                      return const Icon(
                                                        Icons.sentiment_neutral,
                                                        color: Colors.amber,
                                                      );
                                                    case 3:
                                                      return const Icon(
                                                        Icons.sentiment_satisfied,
                                                        color: Colors.lightGreen,
                                                      );
                                                    case 4:
                                                      return const Icon(
                                                        Icons.sentiment_very_satisfied,
                                                        color: Colors.green,
                                                      );
                                                    default:
                                                      return const Icon(
                                                        Icons.star
                                                      );
                                                  }
                                                  },
                                                  onRatingUpdate:(rating) {
                                                    // Action immédiate sur clic
                                                    print("Note donnée : $rating");
                                                    // Vous pouvez envoyer cette note au backend ici
                                                    Navigator.pop(context); // Fermer la boîte de dialogue
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                    }
                                    },
                                    ),
                                  ])
                              : const Center()),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
