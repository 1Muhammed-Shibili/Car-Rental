import 'package:car_rental/features/booking/controllers/booking_controller.dart';
import 'package:car_rental/features/booking/screens/wheels_screen.dart';
import 'package:car_rental/sqlite/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  void _goNext() async {
    if (_formKey.currentState!.validate()) {
      final model = ref.read(bookingProvider);
      final updated = model.copyWith(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );

      ref.read(bookingProvider.notifier).state = updated;
      await DBHelper().saveBooking(updated);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WheelsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Name')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Enter your first and last name',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter first name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator:
                    (value) => value!.isEmpty ? 'Please enter last name' : null,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _goNext,
                child: const Center(child: Text('Next')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
