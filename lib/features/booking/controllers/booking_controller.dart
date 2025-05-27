import 'package:car_rental/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wheelsProvider = FutureProvider<List<String>>((ref) async {
  return await ApiService.fetchWheelOptions();
});

final selectedWheelsProvider = StateProvider<String?>((ref) => null);

final vehicleTypesProvider = FutureProvider<List<String>>((ref) async {
  return await ApiService.fetchVehicleTypes();
});

final selectedVehicleTypeProvider = StateProvider<String?>((ref) => null);

final selectedModelProvider = StateProvider<Map<String, dynamic>?>(
  (ref) => null,
);

final vehicleModelsProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
      final selectedType = ref.watch(selectedVehicleTypeProvider);
      if (selectedType == null) throw Exception('Vehicle type not selected');
      return await ApiService.fetchVehicleModels(selectedType);
    });
