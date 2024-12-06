import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/sign_up_screen.dart'; // Import SignUpScreen
import 'screens/login_screen.dart'; // Import LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HappyCart',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // Show SplashScreen first
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust duration for fade and scale
      vsync: this,
    );

    // Fade-In Animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth fade
      ),
    );

    // Scale Animation
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut, // Bounce in
      ),
    );

    _controller.forward();
    _navigateToHome();
  }

  // Navigate to HomeScreen after delay
  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3)); // Wait 3 seconds
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // No session, go to SignUp screen
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Splash screen background color
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Replace with your logo
                Image.asset(
                  'assets/images/Happy_Cart-BGR.png', // Custom logo image
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 50); // Error icon
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'HappyCart',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Your Happiness, Delivered',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                const CircularProgressIndicator(
                    color: Colors.black), // Loading spinner
              ],
            ),
          ),
        ),
      ),
    );
  }
}
