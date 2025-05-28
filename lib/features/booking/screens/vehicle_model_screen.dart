import 'package:car_rental/features/booking/screens/date_range_screen.dart';
import 'package:car_rental/features/booking/widgets/custom_button.dart';
import 'package:car_rental/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/booking_controller.dart';

class VehicleModelScreen extends ConsumerWidget {
  const VehicleModelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final models = ref.watch(vehicleModelsProvider);
    final selectedModel = ref.watch(selectedVehicleModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Model',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body:
          models.isEmpty
              ? const Center(child: Text('No models available'))
              : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Select a specific model',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 3.5,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                      itemCount: models.length,
                      itemBuilder: (_, i) {
                        final VehicleModel model = models[i];
                        final bool isSelected = selectedModel?.id == model.id;

                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(selectedVehicleModelProvider.notifier)
                                .state = model;
                            ref
                                .read(bookingProvider.notifier)
                                .updateVehicleModel(model);
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? Colors.indigo : Colors.grey,
                                width: isSelected ? 2.5 : 1,
                              ),
                              color:
                                  isSelected
                                      ? Colors.indigo.shade50
                                      : Colors.grey.shade200,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                model.imageUrl != null &&
                                        model.imageUrl!.isNotEmpty
                                    ? Image.network(
                                      model.imageUrl!,
                                      height: 100,
                                      errorBuilder:
                                          (_, __, ___) => const Icon(
                                            Icons.image_not_supported,
                                          ),
                                    )
                                    : const Icon(
                                      Icons.image_not_supported,
                                      size: 100,
                                    ),
                                const SizedBox(height: 10),
                                Text(
                                  model.name ?? 'Unknown',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isSelected
                                            ? Colors.indigo
                                            : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            selectedModel != null
                                ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const DateRangeScreen(),
                                    ),
                                  );
                                }
                                : null,
                        style: CustomButton.getPrimaryStyle(context),
                        child: const Text('Next'),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
