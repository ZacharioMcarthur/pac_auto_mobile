import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Key fieldKey;
  final TextEditingController controller;
  final Icon? icon;
  final Icon? prefixIcon;
  final String? obscuringCharacter;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String hintText;
  final String? Function(String?) validator;

  CustomTextFormField({super.key, 
    required this.fieldKey,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.validator, 
    this.icon,
    this.prefixIcon, 
    this.obscuringCharacter = "*",
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    // Récupérer le thème actuel (clair ou sombre)
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

        // Définir les couleurs en fonction du mode
    Color borderColor = isDarkMode ? Colors.white54 : Colors.black12;
    Color labelColor = isDarkMode ? Colors.white70 : Colors.black54;
    Color hintColor = isDarkMode ? Colors.white54 : Colors.black54;
    Color iconColor = isDarkMode ? Colors.white : Colors.black;
    Color textColor = isDarkMode ? Colors.white : Colors.black; // Couleur du texte saisi
    return TextFormField(
      key: fieldKey,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText!,
      obscuringCharacter: obscuringCharacter!,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon!.icon, color: iconColor) : null,
        suffixIcon: icon != null ? Icon(icon!.icon, color: iconColor) : null  ,
        labelText: hintText,
        labelStyle: TextStyle(color: labelColor),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        border: OutlineInputBorder(
          borderSide:  BorderSide(
            color: borderColor, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightColorScheme.primary), // Bordure colorée lors du focus
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
