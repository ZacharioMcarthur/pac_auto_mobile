import 'dart:convert';

import 'package:courses_pac/config/api_config.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>?> getCoursesUsers(int userId, {String? role}) async {
  final userRole = role ?? ApiConfig.defaultRole;
  final url = Uri.parse(
    ApiConfig.url('${ApiConfig.demandeListRoute}/$userId/$userRole'),
  );

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
      return jsonResponse['data'] as List<dynamic>?;
    }

    return null;
  } catch (e) {
    return null;
  }
}
