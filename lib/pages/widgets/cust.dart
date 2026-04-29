import 'package:courses_pac/theme/theme.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final DateFormat format;
  final Icon icon;
  // final Icon icon;
  final String? Function(DateTime?)? validator;

  CustomDateTimePicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.format,
    this.validator,
    required this.icon,
    // required this.icon,
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
    return DateTimeField(
      controller: controller,
      format: format,
      validator: validator,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        // ignore: unnecessary_null_comparison
        suffixIcon: Icon(icon.icon, color: iconColor),
        // prefixIcon: icon!,
        labelText: hintText,
        labelStyle: TextStyle(color: labelColor),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
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
      ),
      onShowPicker: (context, currentValue) async {
        final now = DateTime.now();
        final date = await showDatePicker(
            // barrierColor: isDarkMode ? darkColorScheme.shadow : lightColorScheme.onSecondary,
            helpText: "Date",
            cancelText: "Retour",
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime
                .now(), // Empêche la sélection d'une date inférieure à la date actuelle
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: lightColorScheme
                        .primary, // Couleur de l'en-tête du sélecteur d'heure
                    onPrimary: isDarkMode
                        ? Colors.black87
                        : Colors.white, // Couleur du texte
                    surface: isDarkMode
                        ? Colors.black87
                        : Colors.white, // Couleur de fond du sélecteur d'heure
                    onSurface: isDarkMode
                        ? Colors.white54
                        : Colors.black, // Couleur du texte
                  ),
                  // dialogBackgroundColor: Colors.white
                ),
                child: child!,
              );
            });
        if (date != null) {
          final time = await showTimePicker(
              helpText: "Heure",
              cancelText: "Retour",
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: lightColorScheme
                          .primary, // Couleur de l'en-tête du sélecteur d'heure
                      onPrimary: isDarkMode
                          ? Colors.black87
                          : Colors.white, // Couleur du texte
                      surface: isDarkMode
                          ? Colors.black87
                          : Colors
                              .white, // Couleur de fond du sélecteur d'heure
                      onSurface: isDarkMode
                          ? Colors.white54
                          : Colors.black, // Couleur du texte
                    ),
                    // dialogBackgroundColor: Colors.white
                  ),
                  child: child!,
                );
              });
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }
}