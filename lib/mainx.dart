import 'package:flutter/material.dart';
import 'screens/alerts/calendar_screen.dart';

void main() {
  runApp(const SaveOnixApp());
}

class SaveOnixApp extends StatelessWidget {
  const SaveOnixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaveOnix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalendarScreen(),
    );
  }
}
