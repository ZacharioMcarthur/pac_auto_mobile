import 'package:courses_pac/api/Courses/updateCourses.dart';
import 'package:courses_pac/api/moti_demande/getListMotif.dart';
import 'package:courses_pac/api/type_vehicule/getListVehicule.dart';
import 'package:courses_pac/pages/Demande/secure/Validate.dart';
import 'package:courses_pac/pages/widgets/Dropdown.dart';
import 'package:courses_pac/pages/widgets/TextFieldForm.dart';
import 'package:courses_pac/pages/widgets/button.dart';
import 'package:courses_pac/pages/widgets/customDate.dart';
import 'package:courses_pac/pages/widgets/customTime.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModifierCourses extends StatefulWidget {
  final int idDemande;
  final String motif;
  final DateTime depart;
  final DateTime arriver;
  final DateTime time;
  final DateTime timeR;
  final String lieuA;
  final String lieuD;
  final String vehicule;

  const ModifierCourses(
      {super.key,
      required this.motif,
      required this.depart,
      required this.arriver,
      required this.lieuA,
      required this.lieuD,
      required this.vehicule,
      required this.idDemande,
      required this.time,
      required this.timeR});

  @override
  State<ModifierCourses> createState() => _ModifierCoursesState();
}

class _ModifierCoursesState extends State<ModifierCourses> {
  final _lieuDepart = GlobalKey<FormFieldState<String>>();
  final _keyMotif = GlobalKey<FormFieldState<String>>();
  final _date = GlobalKey<FormFieldState<String>>();
  final _time = GlobalKey<FormFieldState<String>>();
  final _dateA = GlobalKey<FormFieldState<String>>();
  final _timeA = GlobalKey<FormFieldState<String>>();
  final _typeVehicule = GlobalKey<FormFieldState<String>>();
  final _lieuArrive = GlobalKey<FormFieldState<String>>();
  final TextInputType inputText = TextInputType.text;

  final _formKeyDemandeAutre = GlobalKey<FormState>();
  // Option sélectionnée
  String? _selectedOption;
  String? _selectedOption2;
  final DateFormat _formatDate = DateFormat("yyyy-MM-dd"); //Format date valide
  final DateFormat _formatTime = DateFormat("HH:mm:ss"); //Format date valide

  // controller
  // final TextEditingController _nomAgentController = TextEditingController();
  final TextEditingController _lieuDepartController = TextEditingController();
  final TextEditingController _lieuArriveController = TextEditingController();
  final TextEditingController _typeVehiculeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateAController = TextEditingController();
  final TextEditingController _timeAController = TextEditingController();
  final TextEditingController _motifController = TextEditingController();

  List<Map<String, dynamic>>? dataVehicule = [];

  Future<void> getVehicule() async {
    final datas = await getVehiculeList(); //Appel de la fonction getMotifList
    if (datas != null && mounted) {
      setState(() {
        dataVehicule = datas
            .map((item) => {
                  'id': item['id'],
                  'libelle': item['libelle'],
                })
            .toList();
        // Utilisation d'un Set pour éliminer les doublons
        dataVehicule = dataVehicule!.toSet().toList();
      });
    }
    print("vehicule ${dataVehicule}");
  }

  List<Map<String, dynamic>>? dataMotif = [];

  Future<void> getMotif() async {
    final data = await getListMotif(); //Appel de la fonction getMotifList
    if (data != null && mounted) {
      setState(() {
        dataMotif = data
            .map((item) => {
                  'id': item['id'],
                  'libelle': item['libelle'],
                })
            .toList();
        // Utilisation d'un Set pour éliminer les doublons
        dataMotif = dataMotif!.toSet().toList();
      });
    }
    print("Motif ${dataMotif}");
  }

  @override
  void initState() {
    getVehicule();
    getMotif();
    // Initialisez correctement les valeurs par défaut
    setState(() {
      // _selectedOption = widget.vehicule;
      // _selectedOption2 = widget.motif;

      //  // Vérification de l'existence de la valeur dans dataVehicule
      // _typeVehiculeController.text = dataVehicule!
      //     .firstWhere((vehicule) => vehicule['libelle'] == widget.vehicule, orElse: () => "",)['id']
      //     .toString();
      // _motifController.text = dataVehicule!
      //     .firstWhere((vehicule) => vehicule['libelle'] == widget.motif)['id']
      //     .toString();
    });

    // TODO: implement initState
    super.initState();
    // Ajouter un listener pour déclacher la validation automatique
    _lieuDepartController.addListener(() {
      // Si le formulaire est valide il s'actualise automatiquement
      _lieuDepart.currentState?.validate();
    });
    _lieuArriveController.addListener(() {
      _lieuArrive.currentState?.validate();
    });
    _motifController.addListener(() {
      _keyMotif.currentState?.validate();
    });
    _typeVehiculeController.addListener(() {
      _typeVehicule.currentState?.validate();
    });
    _dateController.addListener(() {
      _date.currentState?.validate();
    });
    _timeController.addListener(() {
      _time.currentState?.validate();
    });
    _dateAController.addListener(() {
      _dateA.currentState?.validate();
    });
    _timeAController.addListener(() {
      _timeA.currentState?.validate();
    });

    // Initialisation des contrôleurs avec les valeurs par défaut
    _lieuDepartController.text = widget.lieuD;
    _lieuArriveController.text = widget.lieuA;
    _dateController.text = _formatDate.format(widget.depart);
    _dateAController.text = _formatDate.format(widget.arriver);
    _timeController.text = _formatTime.format(widget.time);
//     _timeController.value = TextEditingValue(
//   text: _formatTime.format(widget.time), // Définit la valeur formatée
//   selection: TextSelection.collapsed(offset: _formatTime.format(widget.time).length),
// );
    _timeAController.text = _formatTime.format(widget.timeR);
    _motifController.text = widget.motif;
    _typeVehiculeController.text = widget.vehicule;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _lieuDepartController.dispose();
    _lieuArriveController.dispose();
    _motifController.dispose();
    _dateController.dispose();
    _dateAController.dispose();
    _typeVehiculeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;

    // Récupérer le thème actuel (clair ou sombre)
    // var brightness = Theme.of(context).brightness;
    // bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Modification",
          style: TextStyle(color: lightColorScheme.onSecondary),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: lightColorScheme.primary,
      ),
      backgroundColor: lightColorScheme.onSecondary,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.05,
            horizontal: screenWidth * 0.05,
          ),
          child: Form(
            key: _formKeyDemandeAutre,
            child: Column(
              children: [
                CustomTextFormField(
                  fieldKey: _lieuDepart,
                  controller: _lieuDepartController,
                  keyboardType: inputText,
                  hintText: "Lieu de Départ*",
                  validator: validateLieu,
                  icon: const Icon(
                    Icons.location_searching_rounded,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                CustomTextFormField(
                  fieldKey: _lieuArrive,
                  controller: _lieuArriveController,
                  keyboardType: inputText,
                  hintText: "Lieu d'Arrivée*",
                  validator: validateLieu,
                  icon: const Icon(
                    Icons.location_pin,
                    // color: isDarkMode ? Colors.grey : Colors.black12,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                CustomDropdownButton2(
                  icon: const Icon(Icons.car_rental_outlined),
                  iconSize: 30,
                  hint: "Type Véhicule*",
                  dropdownItems: dataVehicule!
                      .map((vehicule) => vehicule['libelle'] as String)
                      .toList(),
                  value: _selectedOption, // Variable pour stocker la valeur sélectionnée,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                      // Récupérer l'ID associé au libellé sélectionné
                      _typeVehiculeController.text = dataVehicule!
                          .firstWhere(
                              (vehicule) => vehicule['libelle'] == value)['id']
                          .toString();
                      // print("ID du véhicule sélectionné: $selectedVehiculeId"); // Pour tester l'ID
                    });
                  },
                  aKey: _typeVehicule,
                  buttonWidth: screenWidth,
                  buttonHeight: screenHeight * 0.070,
                  dropdownWidth:
                      screenWidth * 0.9, //lageure de la liste déroulente
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                CustomDropdownButton2(
                  hint: "Motif de demande*",
                  dropdownItems: dataMotif!
                      .map((vehicule) => vehicule['libelle'] as String)
                      .toList(),
                  value: _selectedOption2,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption2 = value;
                      // Récupérer l'ID associé au libellé sélectionné
                      _motifController.text = dataMotif!
                          .firstWhere(
                              (vehicule) => vehicule['libelle'] == value)['id']
                          .toString();
                    });
                  },
                  aKey: _keyMotif,
                  icon: const Icon(Icons.report_problem_rounded),
                  iconSize: 30,
                  buttonWidth: screenWidth,
                  buttonHeight: screenHeight * 0.070,
                  dropdownWidth:
                      screenWidth * 0.9, // lageure de la liste déroulente
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: CustomDatePicker(
                        key: _date,
                        icon: const Icon(Icons.calendar_month),
                        controller: _dateController,
                        hintText: "Date départ*",
                        format: _formatDate,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomTimePicker(
                        key: _time,
                        controller: _timeController,
                        hintText: "Heure*",
                        format: _formatTime,
                        icon: const Icon(Icons.access_time),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: CustomDatePicker(
                        key: _dateA,
                        icon: const Icon(Icons.calendar_month),
                        controller: _dateAController,
                        hintText: "Date Retour*",
                        format: _formatDate,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomTimePicker(
                        key: _timeA,
                        controller: _timeAController,
                        hintText: "Heure",
                        format: _formatTime,
                        icon: const Icon(Icons.access_time),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                CustomElevatedButton(
                    text: "Modifier Demande",
                    onPressed: () {
                      if (_formKeyDemandeAutre.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Formulaire Valide !'),
                        //   ),
                        // );
                        if(_dateAController.text != "" && _dateController.text != "" 
                        && _timeAController.text != "" && _timeController.text !=""
                        ){
                          DateTime timeD =
                          DateFormat('HH:mm').parse(_timeController.text);
                          DateTime timeA =
                          DateFormat("HH:mm").parse(_timeAController.text);
                          DateTime dateD =
                          _formatDate.parse(_dateController.text);
                          DateTime dateA =
                          _formatDate.parse(_dateAController.text);
                          if (dateA.isAfter(dateD) || timeA.isAfter(timeD) || dateA == dateD) {
                            UpdateCourses(
                                _dateAController.text,
                                _dateController.text,
                                _lieuDepartController.text.trim(),
                                _lieuArriveController.text.trim(),
                                _timeAController.text.trim(),
                                _timeController.text.trim(),
                                int.parse(_typeVehiculeController.text.trim()),
                                int.parse(_motifController.text.trim()),
                                widget.idDemande,
                                context);
                            // Retour à la page précédente
                            Navigator.pop(context);
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
