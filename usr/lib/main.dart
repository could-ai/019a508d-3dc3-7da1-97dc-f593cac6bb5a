import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aviator Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B263B),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE07A5F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const PredictionScreen(),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  String _prediction = "-.--x";
  bool _isLoading = false;

  void _generatePrediction() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _prediction = "...";
    });

    // Simulate network delay or calculation time
    Future.delayed(const Duration(seconds: 2), () {
      final random = Random();
      // Generate a number between 1.00 and 10.00
      double multiplier = 1.0 + random.nextDouble() * 9.0;
      
      // Add a small chance for a higher multiplier
      if (random.nextInt(10) == 0) { // 10% chance
          multiplier += 10 + random.nextDouble() * 10;
      }

      setState(() {
        _prediction = "${multiplier.toStringAsFixed(2)}x";
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aviator Predictor'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.airplanemode_active,
              size: 100,
              color: Color(0xFFE07A5F),
            ),
            const SizedBox(height: 40),
            const Text(
              'Next Predicted Multiplier:',
              style: TextStyle(fontSize: 22, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                color: const Color(0xFF1B263B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE07A5F), width: 2),
              ),
              child: Text(
                _prediction,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE07A5F)),
                  )
                : ElevatedButton(
                    onPressed: _generatePrediction,
                    child: const Text('Predict Next'),
                  ),
          ],
        ),
      ),
    );
  }
}
