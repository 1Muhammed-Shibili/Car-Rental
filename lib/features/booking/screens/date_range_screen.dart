import 'package:car_rental/features/booking/widgets/custom_button.dart';
import 'package:car_rental/features/booking/widgets/data_displaytile.dart';
import 'package:car_rental/features/booking/widgets/icon_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';

class DateRangeScreen extends ConsumerWidget {
  const DateRangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRange = ref.watch(selectedDateRangeProvider);
    final unavailableAsync = ref.watch(unavailableDatesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rental Dates',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: unavailableAsync.when(
        data:
            (unavailable) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  FloatingIconAnimation(
                    icon: Icons.calendar_month_outlined,
                    size: 70,
                    duration: Duration(seconds: 2),
                    floatDistance: 15,
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Pick your rental period',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 60)),
                        builder: (context, child) {
                          return Theme(data: ThemeData.light(), child: child!);
                        },
                      );

                      if (picked != null) {
                        final rangeHasUnavailableDates = unavailable.any(
                          (u) =>
                              picked.start.isBefore(u.endDate) &&
                              picked.end.isAfter(u.startDate),
                        );

                        if (rangeHasUnavailableDates) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Selected range includes unavailable dates',
                              ),
                            ),
                          );
                        } else {
                          ref.read(selectedDateRangeProvider.notifier).state =
                              picked;
                        }
                      }
                    },
                    style: CustomButton.getPrimaryStyle(context),
                    child: const Text('Select Date Range'),
                  ),
                  const SizedBox(height: 30),
                  if (selectedRange != null)
                    Column(
                      children: [
                        DataDisplayTile(
                          label: 'Start',
                          value: DateFormat.yMMMd().format(selectedRange.start),
                        ),
                        DataDisplayTile(
                          label: 'End',
                          value: DateFormat.yMMMd().format(selectedRange.end),
                        ),
                      ],
                    ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          selectedRange != null
                              ? () async {
                                await ref
                                    .read(bookingProvider.notifier)
                                    .updateRentalDateRange(
                                      selectedRange.start,
                                      selectedRange.end,
                                    );

                                context.push('/submit');
                              }
                              : null,
                      style: CustomButton.getPrimaryStyle(context),
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
