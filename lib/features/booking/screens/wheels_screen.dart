import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/booking_controller.dart';

class WheelsScreen extends ConsumerWidget {
  const WheelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wheelsAsync = ref.watch(wheelsProvider);
    final selectedWheels = ref.watch(selectedWheelsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Number of Wheels')),
      body: wheelsAsync.when(
        data:
            (wheels) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Select the number of wheels',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                for (final option in wheels)
                  RadioListTile<String>(
                    title: Text('$option Wheels'),
                    value: option,
                    groupValue: selectedWheels,
                    onChanged:
                        (val) =>
                            ref.read(selectedWheelsProvider.notifier).state =
                                val,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      selectedWheels != null
                          ? () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Placeholder(),
                            ), // next screen
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
