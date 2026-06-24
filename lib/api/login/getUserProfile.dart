import 'dart:convert';

import 'package:courses_pac/config/api_config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getUserProfile() async {
  final url = Uri.parse(ApiConfig.url(ApiConfig.userProfileRoute));

  try {
    final headers = await ApiConfig.getAuthHeaders();

    if (!headers.containsKey('Authorization')) {
      return null;
    }

    final response = await http
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'] as Map<String, dynamic>?;
      if (data != null && data['id'] != null) {
        final role = data['role']?['libelle']?.toString();
        await ApiConfig.saveUserSession(
          userId: data['id'] as int,
          role: role,
        );
      }
      return data;
    }

    return null;
  } catch (e) {
    return null;
  }
}
