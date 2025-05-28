import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:car_rental/models/booking_date_model.dart';
import 'package:car_rental/models/local_booking_model.dart';
import 'package:car_rental/models/vehicle_model.dart';
import 'package:car_rental/models/vehicle_type.dart';
import 'package:car_rental/services/api_service.dart';
import 'package:car_rental/sqlite/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Selected number of wheels
final wheelsProvider = FutureProvider<List<int>>((ref) async {
  return await ApiService.fetchWheelOptions();
});

/// Fetch all vehicle types from API
final vehicleTypesProvider = FutureProvider<List<VehicleTypeModel>>((
  ref,
) async {
  return await ApiService.fetchVehicleTypes();
});

/// User-selected vehicle type
final selectedVehicleTypeProvider = StateProvider<VehicleTypeModel?>(
  (ref) => null,
);

/// Extract vehicle models based on selected vehicle type
final vehicleModelsProvider = Provider<List<VehicleModel>>((ref) {
  final selectedType = ref.watch(selectedVehicleTypeProvider);
  if (selectedType == null) return [];
  return selectedType.vehicles;
});

/// Selected vehicle model (basic info)
final selectedVehicleModelProvider = StateProvider<VehicleModel?>(
  (ref) => null,
);

/// Fetched full vehicle details (image, etc.)
final vehicleDetailProvider = FutureProvider.family<VehicleModel, String>((
  ref,
  vehicleId,
) async {
  final response = await http.get(
    Uri.parse(
      'https://octalogic-test-frontend.vercel.app/api/v1/vehicles/$vehicleId',
    ),
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['data'];
    return VehicleModel.fromJson(jsonData);
  } else {
    throw Exception('Failed to load vehicle detail');
  }
});

/// Selected rental date range
final selectedDateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

/// Unavailable date ranges for selected model
final unavailableDatesProvider =
    FutureProvider.autoDispose<List<BookingDateModel>>((ref) async {
      final model = ref.watch(selectedVehicleModelProvider);
      if (model == null) throw Exception("Model not selected");
      return await ApiService.fetchUnavailableDates(model.id);
    });

/// Booking form data
final dbHelperProvider = Provider<DBHelper>((ref) => DBHelper());

class BookingNotifier extends StateNotifier<LocalBookingModel> {
  final Ref ref;

  BookingNotifier(this.ref) : super(LocalBookingModel());
  void updateBooking(LocalBookingModel updated) {
    state = updated;
  }

  void resetBooking() {
    state = LocalBookingModel();
  }

  Future<void> loadSavedBooking() async {
    final saved = await ref.read(dbHelperProvider).getSavedBooking();
    if (saved != null) {
      state = saved;
    }
  }

  Future<void> updateName(String firstName, String lastName) async {
    state = state.copyWith(firstName: firstName, lastName: lastName);
    await _persistData();
  }

  Future<void> updateWheels(int wheels) async {
    state = state.copyWith(wheels: wheels);
    await _persistData();
  }

  Future<void> updateVehicleType(VehicleTypeModel type) async {
    state = state.copyWith(vehicleType: type.id, vehicleTypeName: type.type);
    await _persistData();
  }

  Future<void> _persistData() async {
    final existing = await ref.read(dbHelperProvider).getSavedBooking();
    final merged = existing?.copyWithFrom(state) ?? state;
    await ref.read(dbHelperProvider).saveBooking(merged);
  }

  Future<void> updateVehicleModel(VehicleModel model) async {
    state = state.copyWith(
      vehicleModel: model.id,
      vehicleModelName: model.name,
      vehicleImageUrl: model.imageUrl,
    );
    await _persistData();
  }

  Future<void> updateRentalDateRange(DateTime start, DateTime end) async {
    state = state.copyWith(startDate: start, endDate: end);
    await _persistData();
  }
}

final bookingProvider =
    StateNotifierProvider<BookingNotifier, LocalBookingModel>(
      (ref) => BookingNotifier(ref),
    );

final bookingFromDbProvider = FutureProvider<LocalBookingModel?>((ref) async {
  return await DBHelper().getSavedBooking();
});
