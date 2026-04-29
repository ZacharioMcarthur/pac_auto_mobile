import 'package:courses_pac/api/Demande/pourMoi.dart';
import 'package:courses_pac/api/login/getUserProfile.dart';
import 'package:courses_pac/api/moti_demande/getListMotif.dart';
import 'package:courses_pac/api/type_vehicule/getListVehicule.dart';
import 'package:courses_pac/pages/Demande/secure/Validate.dart';
import 'package:courses_pac/pages/widgets/Dropdown.dart';
import 'package:courses_pac/pages/widgets/TextFieldForm.dart';
import 'package:courses_pac/pages/widgets/button.dart';
import 'package:courses_pac/pages/widgets/customDate.dart';
import 'package:courses_pac/pages/widgets/customTime.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Demandecoursespourmoi extends StatefulWidget {
  const Demandecoursespourmoi({super.key});

  @override
  State<Demandecoursespourmoi> createState() => _DemandecoursespourmoiState();
}

class _DemandecoursespourmoiState extends State<Demandecoursespourmoi> {
  final _lieuDepart = GlobalKey<FormFieldState<String>>();
  final _keyMotif = GlobalKey<FormFieldState<String>>();
  final _date = GlobalKey<FormFieldState<String>>();
  final _time = GlobalKey<FormFieldState<String>>();
  final _dateA = GlobalKey<FormFieldState<String>>();
  final _timeA = GlobalKey<FormFieldState<String>>();
  final _typeVehicule = GlobalKey<FormFieldState<String>>();
  final _lieuArrive = GlobalKey<FormFieldState<String>>();
  final TextInputType inputText = TextInputType.text;

  final _formKeyDemande = GlobalKey<FormState>();
  // final _formKeyDemandeAutre = GlobalKey<FormState>();
  // Option sélectionnée
  String? _selectedOption;
  int? userIdDemande = 0;
  String? _selectedOption2;
  final DateFormat _formatDate = DateFormat("yyyy-MM-dd"); //Format date valide
  final DateFormat _formatTime = DateFormat("HH:mm:ss");
  // controller
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

  Map<String, dynamic>? userProfileData;
  int? userId = 0;

  Future<void> userProfile() async {
    final data = await getUserProfile(); //Appel de la fonction getUserProfile
    setState(() {
      userProfileData = data;
    });
    print("user daata ${userProfileData}");
    userId = userProfileData?['id'];
    print("user id : $userId");
  }

  @override
  void initState() {
    getMotif();
    userProfile();
    getVehicule();
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
  }

  @override
  void dispose() {
    super.dispose();
    _lieuDepartController.dispose();
    _lieuArriveController.dispose();
    _motifController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _dateAController.dispose();
    _timeAController.dispose();
    _typeVehiculeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    return SingleChildScrollView(
      child: Form(
        key: _formKeyDemande,
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
              hintText: "Lieu d'arrivée*",
              validator: validateLieu,
              icon: const Icon(Icons.location_pin),
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
              value:
                  _selectedOption, // Variable pour stocker la valeur sélectionnée,
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
              validator: validateLieu,
              aKey: _typeVehicule,
              buttonWidth: screenWidth,
              buttonHeight: screenHeight * 0.070,
              dropdownWidth: screenWidth * 0.9, //lageure de la liste déroulente
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
              validator: validateLieu,
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
              children: [
                Flexible(
                  flex: 2, // Donne 2 parts à ce widget
                  child: CustomDatePicker(
                    key: _date,
                    icon: const Icon(Icons.calendar_month),
                    controller: _dateController,
                    hintText: "Date départ*",
                    validator: validateDate,
                    format: _formatDate,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                ),
                Flexible(
                  flex: 1, // Donne 1 part à ce widget
                  child: CustomTimePicker(
                    key: _time,
                    validator: validateDate,
                    controller: _timeController,
                    hintText: "Heure*",
                    format: _formatTime,
                    icon: const Icon(Icons.access_time),
                  ),
                ),
              ],
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
                    key: _dateA,
                    icon: const Icon(Icons.calendar_month),
                    controller: _dateAController,
                    hintText: "Date Retour*",
                    format: _formatDate,
                    validator: validateDate,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                ),
                Flexible(
                  flex: 1,
                  child: CustomTimePicker(
                    key: _timeA,
                    controller: _timeAController,
                    hintText: "Heure",
                    validator: validateDate,
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
                text: "Envoyer Demande",
                onPressed: () {
                  if (_formKeyDemande.currentState!.validate()) {
                    DateTime timeD =
                        DateFormat('HH:mm:ss').parse(_timeController.text);
                    DateTime timeA =
                        DateFormat("HH:mm:ss").parse(_timeAController.text);
                    DateTime dateD =
                        _formatDate.parse(_dateController.text);
                    DateTime dateA =
                        _formatDate.parse(_dateAController.text);
                    if (dateA.isAfter(dateD) || timeA.isAfter(timeD) || dateA == dateD) {
                      InsertDemandePourMoi(
                          _lieuDepartController.text.trim(),
                          _lieuArriveController.text.trim(),
                          _dateController.text.trim(),
                          _dateAController.text.trim(),
                          _timeController.text.trim(),
                          _timeAController.text.trim(),
                          userId!,
                          userIdDemande,
                          int.parse(_typeVehiculeController.text.trim()),
                          int.parse(_motifController.text.trim()),
                          context);
                        _lieuArriveController.clear();
                        _lieuDepartController.clear();
                        _dateAController.clear();
                        _dateController.clear();
                        _timeAController.clear();
                        _timeController.clear();
                        setState(() {
                          _selectedOption = null;
                          _selectedOption2 = null;
                        });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Attention',
                              confirmText: 'OK',
                              message:
                                  'L\'heure d\arrivée doit-être supérieur à celle de départ',
                              onConfirm: () {
                                Navigator.of(context).pop();
                              },
                            );
                          });
                    }
                  
                  }
                }),
          ],
        ),
      ),
    );
  }
}
