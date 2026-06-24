import 'package:courses_pac/api/login/getUserProfile.dart';
import 'package:courses_pac/api/login/loginFonction.dart';
import 'package:courses_pac/pages/login/Secure/validator.dart';
import 'package:courses_pac/pages/login/Secure/validatorP.dart';
import 'package:courses_pac/pages/widgets/CustomScafold.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool inLogin = false;

  final _formSignInKey = GlobalKey<FormState>();
  // clé du champ email
  final _emailkey = GlobalKey<FormFieldState<String>>();
  // clé du champ password
  final _passwordKey = GlobalKey<FormFieldState<String>>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Ajouter un listener pour déclacher la validation automatique
    _emailController.addListener(() {
      // Si le formulaire est valide il s'actualise automatiquement
      _emailkey.currentState?.validate();
    });
    _passwordController.addListener(() {
      _passwordKey.currentState?.validate();
    });
  }

  sign(String email, String password) {
    setState(() {
      inLogin = true;
      login(email, password, context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    // var screenWidth = screenSize.width;
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Image(
              image: AssetImage("assets/images/logo.png"),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          const Text(
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            "Parc-Auto",
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(
                      //   'Welcome back',
                      //   style: TextStyle(
                      //     fontSize: 30.0,
                      //     fontWeight: FontWeight.w900,
                      //     color: lightColorScheme.primary,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 40.0,
                      // ),
                      TextFormField(
                        key: _emailkey,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: validator,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          label: const Text('Email'),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      TextFormField(
                        key: _passwordKey,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: ValidatorPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          label: const Text('Mot de passe'),
                          hintText: 'Mot de passe',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusColor: lightColorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightColorScheme.primary,
                          ),
                          onPressed: () {
                            if (_formSignInKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text('Formulaire Valide !'),
                              //   ),
                              // );
                              String email = _emailController.value.text;
                              String password = _passwordController.value.text;

                              sign(email, password);
                              getUserProfile();
                            }
                          },
                          child: inLogin
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: lightColorScheme.onPrimary,
                                  ),
                                )
                              : const Text(
                                  'Connexion',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
