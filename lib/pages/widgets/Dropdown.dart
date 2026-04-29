import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton2 extends StatelessWidget {
  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    this.validator, // Ajout de l'attribut validator
    super.key,
    required GlobalKey<FormFieldState<String>> aKey,
  });

  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final String? Function(String?)? validator; // Validator

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
    Color textColor =
        isDarkMode ? Colors.white : Colors.black; // Couleur du texte saisi
    return FormField<String>(
      validator: validator, // Utilisation du validator
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                style: TextStyle(
                  color: textColor,
                ),
                isExpanded: true,
                hint: Container(
                  alignment: hintAlignment,
                  child: Text(
                    hint,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
                value: value,
                items: dropdownItems
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Container(
                            alignment: valueAlignment,
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  onChanged?.call(newValue);
                  state.didChange(newValue);
                },
                selectedItemBuilder: selectedItemBuilder,
                buttonStyleData: ButtonStyleData(
                  height: buttonHeight ?? 40,
                  width: buttonWidth ?? 140,
                  padding: buttonPadding ??
                      const EdgeInsets.only(left: 14, right: 14),
                  decoration: buttonDecoration ??
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                  elevation: buttonElevation,
                ),
                iconStyleData: IconStyleData(
                  icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
                  iconSize: iconSize ?? 12,
                  iconEnabledColor: iconEnabledColor,
                  iconDisabledColor: iconDisabledColor,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: dropdownHeight ?? 200,
                  width: dropdownWidth ?? 140,
                  padding: dropdownPadding,
                  decoration: dropdownDecoration ??
                      BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                  elevation: dropdownElevation ?? 8,
                  offset: offset,
                  scrollbarTheme: ScrollbarThemeData(
                    radius: scrollbarRadius ?? const Radius.circular(40),
                    thickness: scrollbarThickness != null
                        ? WidgetStateProperty.all<double>(scrollbarThickness!)
                        : null,
                    thumbVisibility: scrollbarAlwaysShow != null
                        ? WidgetStateProperty.all<bool>(scrollbarAlwaysShow!)
                        : null,
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: itemHeight ?? 40,
                  padding:
                      itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
                ),
              ),
            ),
            // Affichage de l'erreur si la validation échoue
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
