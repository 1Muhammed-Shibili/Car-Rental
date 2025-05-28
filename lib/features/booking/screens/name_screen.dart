import 'package:car_rental/features/booking/controllers/booking_controller.dart';
import 'package:car_rental/features/booking/screens/wheels_screen.dart';
import 'package:car_rental/features/booking/widgets/custom_button.dart';
import 'package:car_rental/features/booking/widgets/custom_textfield.dart';
import 'package:car_rental/features/booking/widgets/icon_animation.dart';
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

      _firstNameController.clear();
      _lastNameController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WheelsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Name',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FloatingIconAnimation(
                  icon: Icons.person_add_alt_1_outlined,
                  size: 70,
                  duration: Duration(seconds: 2),
                  floatDistance: 15,
                ),
                SizedBox(height: 40),
                Text(
                  'Enter your first and last name',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _firstNameController,
                  decoration: CustomTextfield.getDecoration(
                    context: context,
                    hintText: "First Name",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _lastNameController,
                  decoration: CustomTextfield.getDecoration(
                    context: context,
                    hintText: "Last Name",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _goNext,
                  style: CustomButton.getPrimaryStyle(context),
                  child: const Center(child: Text('Next')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
