import 'package:http/http.dart' as http;
import 'package:courses_pac/config/api_config.dart';
import 'dart:convert';

class ApiService {
  /// Effectue une requête GET
  static Future<http.Response> get(String endpoint) async {
    try {
      final headers = await ApiConfig.getAuthHeaders();
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: headers,
      ).timeout(const Duration(seconds: 30));
      
      _logResponse(endpoint, response);
      return response;
    } catch (e) {
      throw ApiException('Erreur réseau (GET): $e');
    }
  }

  /// Effectue une requête POST avec corps JSON
  static Future<http.Response> post(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await ApiConfig.getAuthHeaders();
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      
      _logResponse(endpoint, response);
      return response;
    } catch (e) {
      throw ApiException('Erreur réseau (POST): $e');
    }
  }

  /// Effectue une requête PUT avec corps JSON
  static Future<http.Response> put(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await ApiConfig.getAuthHeaders();
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      
      _logResponse(endpoint, response);
      return response;
    } catch (e) {
      throw ApiException('Erreur réseau (PUT): $e');
    }
  }

  /// Effectue une requête DELETE
  static Future<http.Response> delete(String endpoint) async {
    try {
      final headers = await ApiConfig.getAuthHeaders();
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: headers,
      ).timeout(const Duration(seconds: 30));
      
      _logResponse(endpoint, response);
      return response;
    } catch (e) {
      throw ApiException('Erreur réseau (DELETE): $e');
    }
  }

  /// Logger interne pour le suivi des échanges API en développement
  static void _logResponse(String endpoint, http.Response response) {
    print('--- API LOG ---');
    print('Endpoint: $endpoint');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
    print('---------------');
  }
}

/// Exception personnalisée pour la couche API
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  
  @override
  String toString() => message;
}