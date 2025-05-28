import 'package:car_rental/features/booking/controllers/booking_controller.dart';
import 'package:car_rental/features/booking/widgets/custom_button.dart';
import 'package:car_rental/features/booking/widgets/data_displaytile.dart';
import 'package:car_rental/models/local_booking_model.dart';
import 'package:car_rental/services/api_service.dart';
import 'package:car_rental/sqlite/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmissionScreen extends ConsumerWidget {
  const SubmissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingFromDbProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review & Submit',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: bookingAsync.when(
        data: (booking) {
          if (booking == null) {
            return const Center(child: Text('No booking data found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DataDisplayTile(
                  label: 'First Name',
                  value: booking.firstName ?? "-",
                ),
                DataDisplayTile(
                  label: 'Last Name',
                  value: booking.lastName ?? "-",
                ),
                DataDisplayTile(
                  label: 'Number of Wheels',
                  value: booking.wheels?.toString() ?? "-",
                ),
                DataDisplayTile(
                  label: 'Vehicle Type',
                  value: booking.vehicleTypeName ?? "-",
                ),
                DataDisplayTile(
                  label: 'Vehicle Model',
                  value: booking.vehicleModelName ?? "-",
                ),
                DataDisplayTile(
                  label: 'Rental Start Date',
                  value:
                      booking.startDate != null
                          ? booking.startDate!
                              .toLocal()
                              .toIso8601String()
                              .split("T")
                              .first
                          : "-",
                ),
                DataDisplayTile(
                  label: 'Rental End Date',
                  value:
                      booking.endDate != null
                          ? booking.endDate!
                              .toLocal()
                              .toIso8601String()
                              .split("T")
                              .first
                          : "-",
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await ApiService.submitBooking(booking);
                        await DBHelper().clearBooking();
                        ref.read(bookingProvider.notifier).state =
                            LocalBookingModel();

                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Success'),
                                  content: const Text(
                                    'Booking submitted successfully!',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                        ).pop(); // Close dialog
                                        Navigator.of(context).popUntil(
                                          (route) => route.isFirst,
                                        ); // Go to root
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Submission Failed'),
                                  content: Text('Submission failed: $e'),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                          );
                        }
                      }
                    },
                    style: CustomButton.getPrimaryStyle(context),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
