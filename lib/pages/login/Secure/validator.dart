String? validator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Veillez entrer votre email';
  }
  if (value.length != value.replaceAll('  ', '').length) {
    return 'L\'email ne peux pas contenir d\'espace';
  }
  if (value.length <= 4) {
    return 'Email non valide';
  }
  if (int.tryParse(value[0]) != null) {
    return 'L\'email ne peut pas commencer par un nombre';
  }
  return null;
}
