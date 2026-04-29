import 'package:courses_pac/theme/theme.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTimePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final DateFormat format;
  final Icon icon;
  final String? Function(DateTime?)? validator;

  const CustomTimePicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.format,
    this.validator,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Détecte le mode sombre ou clair
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    Color borderColor = isDarkMode ? Colors.white54 : Colors.black12;
    Color labelColor = isDarkMode ? Colors.white70 : Colors.black54;
    Color hintColor = isDarkMode ? Colors.white54 : Colors.black54;
    Color iconColor = isDarkMode ? Colors.white : Colors.black;
    Color textColor = isDarkMode ? Colors.white : Colors.black;

    return DateTimeField(
      controller: controller,
      format: format,
      validator: validator,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        suffixIcon: Icon(icon.icon, color: iconColor),
        labelText: hintText,
        labelStyle: TextStyle(color: labelColor),
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          helpText: "Heure",
          cancelText: "Retour",
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: lightColorScheme.primary, // Couleur de l'en-tête du sélecteur d'heure
                    onPrimary:  Colors.white, // Couleur du texte
                    surface: Colors.white, // Couleur de fond du sélecteur d'heure
                    onSurface: Colors.black, // Couleur du texte
                  ),
                  // dialogBackgroundColor: Colors.white
                ),
                child: child!,
              );
            }
        );
        return time != null
            ? DateTimeField.convert(time)
            : currentValue; // Convertir `TimeOfDay` en `DateTime`
      },
    );
  }
}
