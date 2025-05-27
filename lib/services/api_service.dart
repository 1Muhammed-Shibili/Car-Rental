import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://octalogic-test-frontend.vercel.app/api/v1/';

  static Future<List<String>> fetchWheelOptions() async {
    final res = await http.get(Uri.parse('$baseUrl/wheels'));

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load wheel options');
    }
  }

  static Future<List<String>> fetchVehicleTypes() async {
    final res = await http.get(Uri.parse('$baseUrl/vehicle-types'));

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load vehicle types');
    }
  }
}
