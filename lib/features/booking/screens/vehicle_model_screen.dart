import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/booking_controller.dart';

class VehicleModelScreen extends ConsumerWidget {
  const VehicleModelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelsAsync = ref.watch(vehicleModelsProvider);
    final selectedModel = ref.watch(selectedModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Model')),
      body: modelsAsync.when(
        data:
            (models) => Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Select a specific model',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      final model = models[i];
                      final isSelected =
                          selectedModel?['name'] == model['name'];
                      return GestureDetector(
                        onTap:
                            () =>
                                ref.read(selectedModelProvider.notifier).state =
                                    model,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Colors.indigo
                                      : Colors.grey.shade300,
                              width: isSelected ? 2.5 : 1,
                            ),
                            color:
                                isSelected
                                    ? Colors.indigo.shade50
                                    : Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(model['image'], height: 100),
                              const SizedBox(height: 10),
                              Text(
                                model['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isSelected ? Colors.indigo : Colors.black,
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
                  child: ElevatedButton(
                    onPressed:
                        selectedModel != null
                            ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Placeholder(),
                              ), // Date Range
                            )
                            : null,
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading models: $e')),
      ),
    );
  }
}
