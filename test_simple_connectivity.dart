import 'package:http/http.dart' as http;

/// Test simple de connectivité API sans dépendances Flutter
/// À exécuter avec: dart run test_simple_connectivity.dart

void main() async {
  print('🔍 TEST SIMPLE DE CONNECTIVITÉ API');
  print('==================================');
  
  // URLs à tester
  const String emulatorUrl = 'http://10.0.2.2:8000/api/login';
  const String wifiUrl = 'http://10.35.101.88:8000/api/login';
  
  // Test 1: Émulateur
  await testUrl('Émulateur Android', emulatorUrl);
  
  // Test 2: WiFi (Téléphone physique)
  await testUrl('WiFi (Téléphone physique)', wifiUrl);
  
  print('\n🏁 Tests terminés!');
  print('\n💡 Prochaines étapes:');
  print('   1. Démarrez votre backend: php artisan serve --host=0.0.0.0 --port=8000');
  print('   2. Relancez ce test pour vérifier la connectivité');
  print('   3. Testez l\'application Flutter sur émulateur/téléphone');
}

Future<void> testUrl(String label, String url) async {
  print('\n🌐 Test: $label');
  print('   URL: $url');
  
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 10));
    
    print('   ✅ Serveur accessible! (Status: ${response.statusCode})');
    print('   📄 Response: ${response.body.substring(0, 100)}...');
    
  } catch (e) {
    print('   ❌ Erreur: $e');
    if (e.toString().contains('Connection refused')) {
      print('   💡 Le backend Laravel n\'est probablement pas démarré');
    } else if (e.toString().contains('Network is unreachable')) {
      print('   💡 Vérifiez votre connexion réseau ou l\'IP');
    }
  }
}
