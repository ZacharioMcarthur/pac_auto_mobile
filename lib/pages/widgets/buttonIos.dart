import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomCupertinoButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onPressed,
        // padding: EdgeInsets.zero, // Supprimer le padding par défaut
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20, // Taille du texte
            fontWeight: FontWeight.bold, // Poids du texte
            color: Colors.white, // Couleur du texte
          ),
        ),
        
      );
  }
}
