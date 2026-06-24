import 'package:courses_pac/api/login/getUserProfile.dart';
import 'package:courses_pac/pages/Demande/dashborad.dart';
import 'package:courses_pac/pages/Demande/mesDemande.dart';
import 'package:courses_pac/pages/login/Secure/logout.dart';
import 'package:courses_pac/pages/login/changerMdp.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  // final String nom;
  // final String email;
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  int notificationCount = 5;
  bool isSelected = false;
  setCurrentPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    userProfile();
    super.initState();
  }

  Map<String, dynamic>? userProfileData;
  String name = "", email = "";

  Future<void> userProfile() async {
    final data = await getUserProfile(); //Appel de la fonction getUserProfile
    setState(() {
      userProfileData = data;
    });
    print("user ${userProfileData}");
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeigth = screenSize.height;
    var fontbody = screenWidth * 0.04;
    var iconSize = screenWidth * 0.08;
    var spaceWidth = screenWidth * 0.02;
    // Récupérer le thème actuel (clair ou sombre)
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (userProfileData != null) {
      name = userProfileData!['name'];
      email = userProfileData!['email'];
    }
    return Scaffold(
      backgroundColor: lightColorScheme.onSecondary,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: iconSize,
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: const Color(0xFF000000),
        backgroundColor: lightColorScheme.primary,
        actions: [
          Stack(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: iconSize,
                  )),
              // Badge pour afficher le nombre de notification
              if (notificationCount > 0)
                Positioned(
                  //positionner le badge au dessus de l'icon
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: lightColorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 25,
                      minHeight: 25,
                    ),
                    child: Center(
                      child: Text(
                        '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontbody,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
            ],
          )
        ],
        title: [
          const Text(
            "Accueil",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Text(
            "Mes Demandes",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ][_currentIndex],
      ),
      drawer: Drawer(
        backgroundColor: lightColorScheme.onSecondary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF3e65af),
                ),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/images/avataaars.png"),
                  backgroundColor: Colors.white,
                )),
            ListTile(
              leading: Icon(
                Icons.person,
                color: lightColorScheme.shadow,
              ),
              title: Text(
                "$name",
                style: TextStyle(color: lightColorScheme.shadow),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: lightColorScheme.shadow,
              ),
              title: Text(
                "$email",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: lightColorScheme.shadow,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: lightColorScheme.shadow,
              ),
              title: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const Changermdp();
                    }));
                  },
                  child: Text(
                    "Changer Mot de passe",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: lightColorScheme.shadow,
                    ),
                  )),
            ),
            ListTile(
              leading: Icon(
                Icons.login,
                color: lightColorScheme.shadow,
              ),
              title: TextButton(
                  onPressed: () {
                    logout(context);
                  },
                  child: Text(
                    "Déconnexion",
                    style: TextStyle(
                      color: lightColorScheme.shadow,
                    ),
                  )),
            )
          ],
        ),
      ),
      body: [
        const Dashborad(),
        const MesDemande(),
      ][_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: fontbody,
              color: lightColorScheme.shadow,
            ),
          ),
        ),
        child: NavigationBar(
          height: 70,
          animationDuration: const Duration(milliseconds: 500),
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setCurrentPage(index),
          indicatorColor: lightColorScheme.primary,
          backgroundColor: Colors.grey[100],
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                label: "Accueil"),
            NavigationDestination(
                selectedIcon: Icon(
                  Icons.list_alt_rounded,
                  color: Colors.white,
                ),
                icon: Icon(
                  Icons.list_alt_rounded,
                  color: Colors.grey,
                ),
                label: "Mes Demandes"),
          ],
        ),
      ),
    );
  }
}
