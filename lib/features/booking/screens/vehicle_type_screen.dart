import 'package:car_rental/features/booking/screens/vehicle_model_screen.dart';
import 'package:car_rental/features/booking/widgets/custom_button.dart';
import 'package:car_rental/features/booking/widgets/icon_animation.dart';
import 'package:car_rental/models/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/booking_controller.dart';

class VehicleTypeScreen extends ConsumerWidget {
  const VehicleTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleTypesAsync = ref.watch(vehicleTypesProvider);
    final selectedType = ref.watch(selectedVehicleTypeProvider);
    final selectedWheels = ref.watch(bookingProvider.select((b) => b.wheels));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vehicle Type',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: vehicleTypesAsync.when(
        data: (types) {
          final filteredTypes =
              types.where((type) => type.wheels == selectedWheels).toList();

          if (filteredTypes.isEmpty) {
            return const Center(
              child: Text(
                'No vehicle types available for the selected number of wheels.',
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SizedBox(height: 40),
              FloatingIconAnimation(
                icon: Icons.car_rental_outlined,
                size: 70,
                duration: Duration(seconds: 2),
                floatDistance: 15,
              ),
              SizedBox(height: 40),
              Text(
                'Select a vehicle type',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              for (final type in filteredTypes)
                RadioListTile<VehicleTypeModel>(
                  title: Text(type.type),
                  value: type,
                  groupValue: selectedType,
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(selectedVehicleTypeProvider.notifier).state =
                          val;

                      ref.read(bookingProvider.notifier).updateVehicleType(val);
                    }
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    selectedType != null ? () => context.push('/model') : null,
                style: CustomButton.getPrimaryStyle(context),
                child: const Text('Next'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
