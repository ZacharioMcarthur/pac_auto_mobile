import 'package:courses_pac/pages/Courses/coursEnCours.dart';
import 'package:courses_pac/pages/Courses/coursesEnAttente.dart';
import 'package:courses_pac/pages/widgets/tabView.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';

class MesDemande extends StatefulWidget {
  const MesDemande({super.key});

  @override
  State<MesDemande> createState() => _MesDemandeState();
}

class _MesDemandeState extends State<MesDemande> {
  @override
  Widget build(BuildContext context) {

        // Récupérer la longueur et largeur de l'ecran
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    // Récupérer le thème actuel (clair ou sombre)
    // var brightness = Theme.of(context).brightness;
    // bool isDarkMode = brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),
          CustomTabView(
            tabViews:const [
              CoursesEnCours(),
              CoursesEnAttente()
            ], 
            tabTitles: const  ["Toutes", "En Attentes"], 
            primaryColor: lightColorScheme.primary, 
            secondaryColor: lightColorScheme.secondary, 
            labelColor: Colors.white
          ),
        ],
      ),
    );
  }
}