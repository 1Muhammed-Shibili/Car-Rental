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

  static Future<List<Map<String, dynamic>>> fetchVehicleModels(
    String type,
  ) async {
    final res = await http.get(Uri.parse('$baseUrl/vehicle-models?type=$type'));

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data
          .map(
            (e) => {
              'name': e['name'],
              'image': e['image'], // URL of the image
            },
          )
          .toList();
    } else {
      throw Exception('Failed to load vehicle models');
    }
  }

  static Future<List<DateTime>> fetchUnavailableDates(String modelName) async {
    final res = await http.get(
      Uri.parse('$baseUrl/unavailable-dates?model=$modelName'),
    );

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => DateTime.parse(e)).toList();
    } else {
      throw Exception('Failed to fetch unavailable dates');
    }
  }
}
