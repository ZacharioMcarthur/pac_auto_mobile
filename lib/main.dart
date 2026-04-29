import 'package:courses_pac/pages/authVerifi.dart';
import 'package:courses_pac/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Courses PAC",
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system, //Theme du système
      home: const Verify(),
    );
  }
}
