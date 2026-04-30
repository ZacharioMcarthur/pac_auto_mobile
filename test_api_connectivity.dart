import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:courses_pac/config/api_config.dart';
import 'package:courses_pac/services/api_service.dart';
import 'package:courses_pac/services/auth_service.dart';
import 'dart:convert';

/// Script de test pour vérifier la connectivité avec l'API locale
/// À exécuter avec: flutter test test_api_connectivity.dart

void main() async {
  // Initialiser Flutter binding pour les tests
  TestWidgetsFlutterBinding.ensureInitialized();
  print('🔍 TEST DE CONNECTIVITÉ API LOCALE');
  print('====================================');
  
  // Afficher la configuration actuelle
  print('📡 Configuration API:');
  print('   Base URL: ${ApiConfig.baseUrl}');
  print('   Mode Émulateur: ${ApiConfig.isEmulator}');
  print('   URL Émulateur: http://10.0.2.2:8000/api');
  print('   URL WiFi: http://10.35.101.88:8000/api');
  print('');
  
  // Test 1: Vérifier si le backend est accessible
  await testBackendConnection();
  
  // Test 2: Test de login
  await testLogin();
  
  // Test 3: Test récupération profil
  await testProfile();
  
  print('\n🏁 Tests terminés!');
}

Future<void> testBackendConnection() async {
  print('🌐 Test 1: Connexion au backend...');
  
  try {
    final response = await ApiService.get('/login');
    print('   ✅ Backend accessible (Status: ${response.statusCode})');
  } catch (e) {
    print('   ❌ Backend inaccessible: $e');
    print('   💡 Solutions possibles:');
    print('      - Vérifier que Laravel serve est lancé (php artisan serve)');
    print('      - Vérifier l\'IP WiFi si vous utilisez un téléphone physique');
    print('      - Mettre isEmulator = true si vous utilisez l\'émulateur');
  }
}

Future<void> testLogin() async {
  print('\n🔐 Test 2: Login...');
  
  try {
    final success = await AuthService.login('admin@pac.com', 'password123');
    if (success) {
      print('   ✅ Login réussi');
    } else {
      print('   ❌ Login échoué - vérifiez les identifiants');
    }
  } catch (e) {
    print('   ❌ Erreur login: $e');
  }
}

Future<void> testProfile() async {
  print('\n👤 Test 3: Récupération profil...');
  
  try {
    final profile = await AuthService.getProfile();
    if (profile != null) {
      print('   ✅ Profil récupéré: ${profile['name']}');
    } else {
      print('   ❌ Impossible de récupérer le profil');
    }
  } catch (e) {
    print('   ❌ Erreur profil: $e');
  }
}
