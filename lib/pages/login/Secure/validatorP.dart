String? ValidatorPassword(String? value){
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer votre mot de passe';
  }

  if (value.length <= 4) {
    return 'Le mot de passe doit contenir au moins 4 caractères';
  }
  return null;
}