import 'package:car_rental/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wheelsProvider = FutureProvider<List<String>>((ref) async {
  return await ApiService.fetchWheelOptions();
});

final selectedWheelsProvider = StateProvider<String?>((ref) => null);
