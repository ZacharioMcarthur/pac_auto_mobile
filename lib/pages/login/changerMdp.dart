import 'package:courses_pac/api/Users/changePassword.dart';
import 'package:courses_pac/pages/login/Secure/validatorP.dart';
import 'package:courses_pac/pages/widgets/TextFieldForm.dart';
import 'package:courses_pac/pages/widgets/button.dart';
import 'package:courses_pac/pages/widgets/dialogu.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';

class Changermdp extends StatefulWidget {
  const Changermdp({super.key});

  @override
  State<Changermdp> createState() => _ChangermdpState();
}

class _ChangermdpState extends State<Changermdp> {
  final TextInputType inputText = TextInputType.text;
  final _formMdp = GlobalKey<FormState>();
  final _keyMdp = GlobalKey<FormFieldState<String>>();
  final _keyNewMdp = GlobalKey<FormFieldState<String>>();
  final _keyConfirmNewMdp = GlobalKey<FormFieldState<String>>();
  // Controller du Formulaire
  final TextEditingController _mdpController = TextEditingController();
  final TextEditingController _newMdpController = TextEditingController();
  final TextEditingController _confirmNewMdpController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mdpController.addListener(() {
      _keyMdp.currentState?.validate();
    });
    _confirmNewMdpController.addListener(() {
      _keyConfirmNewMdp.currentState?.validate();
    });
    _newMdpController.addListener(() {
      _keyNewMdp.currentState?.validate();
    });
  }

  @override
  void dispose() {
    _mdpController.dispose();
    _newMdpController.dispose();
    _confirmNewMdpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: lightColorScheme.primary,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.05,
          horizontal: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
          child: Form(
              key: _formMdp,
              child: Column(
                children: [
                  CustomTextFormField(
                      fieldKey: _keyMdp,
                      controller: _mdpController,
                      keyboardType: inputText,
                      obscureText: true,
                      obscuringCharacter: "*",
                      hintText: "Mot de passe",
                      validator: ValidatorPassword,
                      prefixIcon: const Icon(Icons.lock)),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextFormField(
                      fieldKey: _keyNewMdp,
                      controller: _newMdpController,
                      keyboardType: inputText,
                      obscureText: true,
                      obscuringCharacter: "*",
                      hintText: "Nouveau Mot de passe",
                      validator: ValidatorPassword,
                      prefixIcon: const Icon(Icons.lock)),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomTextFormField(
                      fieldKey: _keyConfirmNewMdp,
                      controller: _confirmNewMdpController,
                      keyboardType: inputText,
                      obscureText: true,
                      obscuringCharacter: "*",
                      hintText: "Confirmer Mot de passe",
                      validator: ValidatorPassword,
                      prefixIcon: const Icon(Icons.lock)),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  CustomElevatedButton(
                      text: "Modifier",
                      onPressed: () {
                        if (_formMdp.currentState!.validate()) {
                          String pwd = _newMdpController.value.text;
                          String newPwd = _confirmNewMdpController.value.text;
                          if (pwd == newPwd) {
                            changePassword(pwd, newPwd, context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: "Warning",
                                  message:
                                      "Les mots de passe ne sont pas identique ",
                                  onConfirm: () {
                                    // Action à exécuter lorsqu'on confirme
                                    Navigator.of(context)
                                        .pop(); // Fermer le dialogue
                                  },
                                );
                              },
                            );
                          }
                        }
                      }),
                ],
              )),
        ),
      ),
    );
  }
}
