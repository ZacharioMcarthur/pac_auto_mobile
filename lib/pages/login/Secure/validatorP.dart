String? ValidatorPassword(String? value){
  if (value == null || value.isEmpty) {
    return 'Veillez entrer votre mot de passe';
  }

  if (value.length <= 4) {
    return 'Le mot de passe doit contenir plus de 4 caractère';
  }
  return null;
}