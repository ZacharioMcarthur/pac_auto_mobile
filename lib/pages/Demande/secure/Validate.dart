// ignore: file_names
String? validateLieu(String? value) {
  if (value == null || value.isEmpty) {
    return 'Ce Champ ne doit pas être vide';
  }
    if (value.length <= 2) {
    return 'Ce Champ ne doit pas être vide';
  }
  // if(state.hasError){
    
  // }
  // if (int.tryParse(value[0]) != null) {
  //   return 'Invalide';
  // }
  return null;
}

String? validateDate(DateTime? value) {
  if (value == null) {
    return 'Ce Champ ne doit pas être vide';
  }

  return null;
}