import 'package:courses_pac/pages/Demande/demandeCoursesPourAutre.dart';
import 'package:courses_pac/pages/Demande/demandeCoursesPourMoi.dart';
import 'package:flutter/material.dart';
import 'package:courses_pac/theme/theme.dart';

class DemandeCourses extends StatefulWidget {
  const DemandeCourses({super.key});

  @override
  State<DemandeCourses> createState() => _DemandeCoursesState();
}

class _DemandeCoursesState extends State<DemandeCourses> {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
      // Récupérer le thème actuel (clair ou sombre)
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? darkColorScheme.shadow : lightColorScheme.onSecondary,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: lightColorScheme.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightColorScheme.onSecondary),
        title: const Text(
          "Demande Courses",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          // vertical: screenHeight * 0.05,
          horizontal: screenWidth * 0.05,
        ),
        child: Column(
          children: [
            SizedBox(
                    height: screenHeight * 0.02,
                  ),
            Expanded(
                child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: lightColorScheme.secondary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: lightColorScheme.onSecondary,
                      indicator: BoxDecoration(
                        color: lightColorScheme.primary,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelColor: lightColorScheme.onSecondary,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      tabs: const [
                        Tab(text: "Pour moi"),
                        Tab(
                          text: "Pour autre",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const Expanded(
                      child: TabBarView(
                    children: [
                      Demandecoursespourmoi(),
                      Demandecoursespourautre(),
                    ],
                  ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
