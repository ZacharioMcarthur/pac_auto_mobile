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
  final TextEditingController _confirmNewMdpController = TextEditingController();
  
  // Password visibility toggles
  bool _obscureMdp = true;
  bool _obscureNewMdp = true;
  bool _obscureConfirmMdp = true;
  bool _isLoading = false;

  @override
  void initState() {
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

  int _calculatePasswordStrength(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;
    return strength;
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    
    return Scaffold(
      backgroundColor: lightColorScheme.onSecondary,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: lightColorScheme.primary,
        elevation: 0,
        title: const Text(
          "Changer le mot de passe",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.05,
          horizontal: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_reset,
                      size: 64,
                      color: lightColorScheme.primary,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Sécurité",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: lightColorScheme.primary,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Modifiez votre mot de passe pour sécuriser votre compte",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Form
              Form(
                key: _formMdp,
                child: Column(
                  children: [
                    // Current Password
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        key: _keyMdp,
                        controller: _mdpController,
                        obscureText: _obscureMdp,
                        keyboardType: inputText,
                        decoration: InputDecoration(
                          hintText: "Mot de passe actuel",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureMdp ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureMdp = !_obscureMdp;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        validator: ValidatorPassword,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    
                    // New Password
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        key: _keyNewMdp,
                        controller: _newMdpController,
                        obscureText: _obscureNewMdp,
                        keyboardType: inputText,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: "Nouveau mot de passe",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureNewMdp ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureNewMdp = !_obscureNewMdp;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        validator: ValidatorPassword,
                      ),
                    ),
                    
                    // Password Strength Indicator
                    if (_newMdpController.text.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index) => Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: index < 4 ? 4 : 0),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: index < _calculatePasswordStrength(_newMdpController.text)
                                          ? _getStrengthColor(_calculatePasswordStrength(_newMdpController.text))
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              _getStrengthText(_calculatePasswordStrength(_newMdpController.text)),
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStrengthColor(_calculatePasswordStrength(_newMdpController.text)),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    SizedBox(height: screenHeight * 0.02),
                    
                    // Confirm Password
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        key: _keyConfirmNewMdp,
                        controller: _confirmNewMdpController,
                        obscureText: _obscureConfirmMdp,
                        keyboardType: inputText,
                        decoration: InputDecoration(
                          hintText: "Confirmer le nouveau mot de passe",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmMdp ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmMdp = !_obscureConfirmMdp;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez confirmer votre mot de passe';
                          }
                          if (value != _newMdpController.text) {
                            return 'Les mots de passe ne correspondent pas';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formMdp.currentState!.validate()) {
                                  String currentPwd = _mdpController.value.text;
                                  String newPwd = _newMdpController.value.text;
                                  String confirmPwd = _confirmNewMdpController.value.text;
                                  
                                  if (newPwd == confirmPwd) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    
                                    changePassword(currentPwd, newPwd, context).then((_) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    });
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog(
                                          title: "Attention",
                                          message: "Les mots de passe ne sont pas identiques",
                                          onConfirm: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightColorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                "Modifier le mot de passe",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    
                    // Requirements
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Exigences du mot de passe:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          ...[
                            "Au moins 8 caractères",
                            "Une lettre majuscule",
                            "Une lettre minuscule",
                            "Un chiffre",
                            "Un caractère spécial",
                          ].map((requirement) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 16,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      requirement,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 0:
        return "Très faible";
      case 1:
        return "Faible";
      case 2:
        return "Moyen";
      case 3:
        return "Bon";
      case 4:
        return "Fort";
      case 5:
        return "Très fort";
      default:
        return "";
    }
  }
}
