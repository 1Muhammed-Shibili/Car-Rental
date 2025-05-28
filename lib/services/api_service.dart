import 'dart:convert';
import 'package:car_rental/models/vehicle_type.dart';
import 'package:http/http.dart' as http;
import 'package:car_rental/models/booking_date_model.dart';

import 'package:car_rental/models/vehicle_detail_model.dart';

class ApiService {
  static const String baseUrl =
      'https://octalogic-test-frontend.vercel.app/api/v1';

  /// Fetch all vehicle types and their nested models
  static Future<List<VehicleTypeModel>> fetchVehicleTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/vehicleTypes'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load vehicle types');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => VehicleTypeModel.fromJson(json)).toList();
  }

  /// Fetch full vehicle details including image
  static Future<VehicleDetailModel> fetchVehicleDetails(
    String vehicleId,
  ) async {
    final response = await http.get(Uri.parse('$baseUrl/vehicles/$vehicleId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load vehicle details');
    }

    final Map<String, dynamic> data = jsonDecode(response.body)['data'];
    return VehicleDetailModel.fromJson(data);
  }

  /// Fetch unavailable date ranges for a vehicle
  static Future<List<BookingDateModel>> fetchUnavailableDates(
    String vehicleId,
  ) async {
    final response = await http.get(Uri.parse('$baseUrl/bookings/$vehicleId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load bookings');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => BookingDateModel.fromJson(json)).toList();
  }

  static Future<List<int>> fetchWheelOptions() async {
    final response = await http.get(Uri.parse('$baseUrl/vehicleTypes'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> list = decoded['data'];

      final wheels =
          list // <-- Use 'list' here, not 'decoded'
              .map((e) => e['wheels'])
              .whereType<int>()
              .toSet()
              .toList()
            ..sort();

      return wheels;
    } else {
      throw Exception('Failed to fetch wheel options');
    }
  }

  /// TODO: Implement POST booking once endpoint is available
  // static Future<void> submitBooking(...) async {
  //   // Implementation pending
  // }
}
