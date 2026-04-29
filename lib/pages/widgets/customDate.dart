import 'package:courses_pac/theme/theme.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final DateFormat format;
  final Icon icon;
  final String? Function(DateTime?)? validator;

  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.format,
    this.validator,
    required this.icon,
    // required GlobalKey<FormFieldState<String>> ,
  });

  @override
  Widget build(BuildContext context) {

    Color borderColor =  Colors.black12;
    Color labelColor = Colors.black54;
    Color hintColor = Colors.black54;
    Color iconColor = Colors.black;
    Color textColor = Colors.black;

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
        final date = await showDatePicker(
          helpText: "Date",
          cancelText: "Retour",
          context: context,
          initialDate: currentValue ?? DateTime.now(), // Empêche la sélection d'une date inférieure à la date actuelle
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
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
        return date;
      },
    );
  }
}
