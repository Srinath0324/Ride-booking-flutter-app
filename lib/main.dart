import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_booking_app/providers/auth_provider.dart';
import 'package:ride_booking_app/screens/splash_screen.dart';
import 'package:ride_booking_app/screens/auth/login_screen.dart';
import 'package:ride_booking_app/screens/auth/signup_screen.dart';
import 'package:ride_booking_app/screens/home/home_screen.dart';
import 'package:ride_booking_app/screens/booking/booking_screen.dart';
import 'package:ride_booking_app/screens/driver/driver_matching_screen.dart';
import 'package:ride_booking_app/screens/ride/ride_progress_screen.dart';
import 'package:ride_booking_app/screens/ride/ride_complete_screen.dart';
import 'package:ride_booking_app/screens/profile/profile_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Booking App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/booking': (context) => const BookingScreen(),
        '/driver-matching': (context) => const DriverMatchingScreen(),
        '/ride-progress': (context) => const RideProgressScreen(),
        '/ride-complete': (context) => const RideCompleteScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
