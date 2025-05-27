import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';

class DateRangeScreen extends ConsumerWidget {
  const DateRangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRange = ref.watch(selectedDateRangeProvider);
    final unavailableAsync = ref.watch(unavailableDatesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rental Dates')),
      body: unavailableAsync.when(
        data:
            (unavailable) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Pick your rental period',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              u.isAfter(
                                picked.start.subtract(const Duration(days: 1)),
                              ) &&
                              u.isBefore(
                                picked.end.add(const Duration(days: 1)),
                              ),
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
                    child: const Text('Select Date Range'),
                  ),
                  const SizedBox(height: 30),
                  if (selectedRange != null)
                    Column(
                      children: [
                        Text(
                          'Start: ${DateFormat.yMMMd().format(selectedRange.start)}',
                        ),
                        Text(
                          'End: ${DateFormat.yMMMd().format(selectedRange.end)}',
                        ),
                      ],
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed:
                        selectedRange != null
                            ? () {
                              // Proceed to final submission or confirmation
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Placeholder(),
                                ),
                              );
                            }
                            : null,
                    child: const Text('Next'),
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
