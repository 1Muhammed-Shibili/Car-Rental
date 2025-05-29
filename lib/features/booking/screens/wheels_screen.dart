import 'package:car_rental/features/booking/screens/vehicle_type_screen.dart';
import 'package:car_rental/features/booking/widgets/custom_button.dart';
import 'package:car_rental/features/booking/widgets/icon_animation.dart';
import 'package:car_rental/sqlite/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/booking_controller.dart';

class WheelsScreen extends ConsumerWidget {
  const WheelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wheelsAsync = ref.watch(wheelsProvider);
    final selectedWheels = ref.watch(bookingProvider.select((b) => b.wheels));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Number of Wheels',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: wheelsAsync.when(
        data:
            (wheels) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SizedBox(height: 40),
                FloatingIconAnimation(
                  icon: Icons.two_wheeler_outlined,
                  size: 70,
                  duration: Duration(seconds: 2),
                  floatDistance: 15,
                ),
                SizedBox(height: 40),
                Text(
                  'Select the number of wheels',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                for (final option in wheels)
                  RadioListTile<int>(
                    title: Text('$option Wheels'),
                    value: option,
                    groupValue: selectedWheels,
                    onChanged: (val) async {
                      if (val != null) {
                        ref.read(bookingProvider.notifier).updateWheels(val);

                        final updated = ref.read(bookingProvider);
                        await DBHelper().saveBooking(updated);
                      }
                    },
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      selectedWheels != null
                          ? () => context.push('/type')
                          : null,
                  style: CustomButton.getPrimaryStyle(context),
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
