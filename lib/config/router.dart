import 'package:car_rental/features/booking/screens/date_range_screen.dart';
import 'package:car_rental/features/booking/screens/name_screen.dart';
import 'package:car_rental/features/booking/screens/splash_screen.dart';
import 'package:car_rental/features/booking/screens/submission_screen.dart';
import 'package:car_rental/features/booking/screens/vehicle_model_screen.dart';
import 'package:car_rental/features/booking/screens/vehicle_type_screen.dart';
import 'package:car_rental/features/booking/screens/wheels_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/name', builder: (context, state) => NameScreen()),
    GoRoute(path: '/model', builder: (context, state) => VehicleModelScreen()),
    GoRoute(path: '/type', builder: (context, state) => VehicleTypeScreen()),
    GoRoute(path: '/wheels', builder: (context, state) => WheelsScreen()),
    GoRoute(
      path: '/dates',
      builder: (context, state) => const DateRangeScreen(),
    ),
    GoRoute(
      path: '/submit',
      builder: (context, state) => const SubmissionScreen(),
    ),
  ],
);
