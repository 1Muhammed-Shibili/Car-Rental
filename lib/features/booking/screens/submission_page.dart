// import 'package:car_rental/services/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SubmissionScreen extends ConsumerWidget {
//   const SubmissionScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final bookingAsync = ref.watch(bookingFromDbProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Review & Submit')),
//       body: bookingAsync.when(
//         data: (booking) {
//           if (booking == null) {
//             return const Center(child: Text('No booking data found.'));
//           }
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'First Name: ${booking.firstName ?? "-"}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Last Name: ${booking.lastName ?? "-"}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Number of Wheels: ${booking.wheels ?? "-"}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Vehicle Type: ${booking.vehicleTypeName ?? "-"}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Vehicle Model: ${booking.vehicleModel ?? "-"}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Rental Start Date: ${booking.startDate?.toLocal().toString().split(" ").first ?? "-"}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Rental End Date: ${booking.endDate?.toLocal().toString().split(" ").first ?? "-"}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const Spacer(),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       try {
//                         await ApiService.submitBooking(booking);
//                         await BookingDatabase.clearBooking();
//                         if (context.mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Booking submitted!')),
//                           );
//                           Navigator.of(
//                             context,
//                           ).popUntil((route) => route.isFirst);
//                         }
//                       } catch (e) {
//                         if (context.mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Submission failed: $e')),
//                           );
//                         }
//                       }
//                     },
//                     child: const Text('Submit'),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, _) => Center(child: Text('Error: $err')),
//       ),
//     );
//   }
// }
