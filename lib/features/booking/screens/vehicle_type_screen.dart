import 'package:car_rental/features/booking/screens/vehicle_model_screen.dart';
import 'package:car_rental/models/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/booking_controller.dart';

class VehicleTypeScreen extends ConsumerWidget {
  const VehicleTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleTypesAsync = ref.watch(vehicleTypesProvider);
    final selectedType = ref.watch(selectedVehicleTypeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Type')),
      body: vehicleTypesAsync.when(
        data:
            (types) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Select a vehicle type',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                for (final type in types)
                  RadioListTile<VehicleTypeModel>(
                    title: Text(type.title ?? 'Unknown'),
                    value: type,
                    groupValue: selectedType,
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(selectedVehicleTypeProvider.notifier).state =
                            val;
                      }
                    },
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      selectedType != null
                          ? () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const VehicleModelScreen(),
                            ),
                          )
                          : null,
                  child: const Text('Next'),
                ),
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
